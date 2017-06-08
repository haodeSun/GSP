package com.thinkgem.jeesite.modules.gsp.web.t01complsupl;

import static com.thinkgem.jeesite.common.json.JsonResponseCode.FAILED;
import static com.thinkgem.jeesite.common.json.JsonResponseCode.SUCCESS;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.druid.support.json.JSONUtils;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01salescert.T01SalesCertService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplExtService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

/**
 * 首营供货者Controller
 *
 * @author Andrea
 * @version 2016-12-20
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01complsupl/t01ComplSupl")
public class T01ComplSuplExtController extends T01ComplSuplController {

    /**
     * 销售人员授权Service
     */
    private T01SalesCertService t01SalesCertService;

    /**
     * 购货者Service
     */
    @Autowired
    private T01ComplBuyerExtService t01ComplBuyerExtService;

    @Autowired
    public T01ComplSuplExtController(
            T01ComplSuplExtService t01ComplSuplExtService,
            T01CompCertService t01CompCertService,
            T01CompInfoService t01CompInfoService,
            T01SalesCertService t01SalesCertService,
            SystemService systemService) {
        super(t01ComplSuplExtService,
                t01CompInfoService,
                t01CompCertService,
                systemService);
        Assert.notNull(t01SalesCertService);
        this.t01SalesCertService = t01SalesCertService;
    }

    /**
     * 变更详情页
     *
     * @param t01ComplSupl       entity
     * @param model              model
     * @param view               view
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:change")
    @RequestMapping(value = "formChange")
    public String formChange(T01ComplSupl t01ComplSupl, Model model, String view,
                             RedirectAttributes redirectAttributes) {

        if (StringUtils.isNotBlank(t01ComplSupl.getT01CompInfo().getCompNameCn())) {
            T01ComplSupl t01ComplSuplSearch = t01ComplSupl;
            List<T01ComplSupl> t01ComplSuplList = t01ComplSuplExtService.findList(t01ComplSuplSearch)
                    .stream().filter(item -> ApprStatus.PASS.toString().equals(item.getApprStat())
                            && item.getT01CompInfo().getCompNameCn().equals(t01ComplSuplSearch.getT01CompInfo().getCompNameCn()))
                    .collect(Collectors.toList());
            if (t01ComplSuplList != null && !t01ComplSuplList.isEmpty()) {
                try {
                    t01ComplSupl = t01ComplSuplExtService.get(t01ComplSuplList.get(0).getId());
                    t01ComplSuplHelperService.checkStatusBeforeHandle("change", t01ComplSupl);

                    //判断是否同时关联购货者
                    T01ComplBuyer t01ComplBuyerSearch = new T01ComplBuyer();
                    t01ComplBuyerSearch.setCompId(t01ComplSupl.getT01CompInfo().getId());
                    List<T01ComplBuyer> t01ComplBuyerList = t01ComplBuyerExtService.findList(t01ComplBuyerSearch);
                    if (!t01ComplBuyerList.isEmpty()) {
                        model.addAttribute("relate", true);
                    }

                } catch (BusinessException e) {
                    model.addAttribute("message", getText(e.getMessage()));
                } catch (Exception e) {
                    logger.error(e.getMessage());
                    model.addAttribute("message", getText("关联失败"));
                }
            } else {
                model.addAttribute("message", getText("关联失败，未查询到符合变更条件的相关数据"));
            }
        }
        t01ComplSupl.setCertScopList(systemService.findAllCertScop());
        model.addAttribute("t01ComplSupl", t01ComplSupl);
        return "modules/gsp/t01complsupl/t01ComplSuplForm_Change";
    }

    /**
     * 变更保存
     *
     * @param startAudit         启动审批流程标识
     * @param t01ComplSupl       entity
     * @param model              model
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:change")
    @RequestMapping(value = "saveChange")
    public String saveChange(@RequestParam(value = START_AUDIT, required = false) String startAudit,
                             T01ComplSupl t01ComplSupl, Model model, RedirectAttributes redirectAttributes) {
        if (t01ComplSupl.getSysChanInfoList() == null || t01ComplSupl.getSysChanInfoList().isEmpty()) {
            addMessage(model, i18nHelper.getText("保存失败：没有变更项"));
            return formChange(t01ComplSupl, model, null, redirectAttributes);
        }
        T01ComplSupl t01ComplSuplNew;
        try {
            t01ComplSuplNew = t01ComplSuplExtService.saveChange(t01ComplSupl);
        } catch (BusinessException e) {
            addMessage(model, i18nHelper.getText(e.getMessage()));
            return formChange(t01ComplSupl, model, null, redirectAttributes);
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(model, i18nHelper.getText("保存失败：请稍后再试"));
            return formChange(t01ComplSupl, model, null, redirectAttributes);
        }

        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01ComplSuplExtService.startProcess(t01ComplSuplNew.getId(), t01ComplSuplNew.getAct()
                        .getTaskId());
            } catch (NullPointerException | ApprStatusException e1) {
                addMessage(model, i18nHelper.getText(e1.getMessage()));
                return formChange(t01ComplSupl, model, null, redirectAttributes);
            } catch (Exception e) {
                addMessage(model, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
                return formChange(t01ComplSupl, model, null, redirectAttributes);
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/?repage";
        }

        addMessage(redirectAttributes, i18nHelper.getText("保存首营供货者成功"));
        return "redirect:" + Global.getAdminPath()
                + "/gsp/t01complsupl/t01ComplSupl/formChangeEdit?id=" + t01ComplSuplNew.getId();
    }

    /**
     * 变更修改页
     *
     * @param t01ComplSupl       entity
     * @param model              model
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:edit")
    @RequestMapping(value = "formChangeEdit")
    public String formChangeEdit(T01ComplSupl t01ComplSupl, Model model, String view,
                                 RedirectAttributes redirectAttributes) {
        try {
            t01ComplSupl = t01ComplSuplExtService.changeEdit(t01ComplSupl);
        } catch (Exception e) {
            addMessage(redirectAttributes, getText("编辑首营供货者失败"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/?repage";
        }
        model.addAttribute("t01ComplSupl", t01ComplSupl);
        model.addAttribute("changeEdit", "true");
        return "modules/gsp/t01complsupl/t01ComplSuplForm_Change";
    }

    /**
     * 保持变更修改
     *
     * @param startAudit         启动流程标识
     * @param t01ComplSupl       entity
     * @param model              model
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:edit")
    @RequestMapping(value = "saveChangeEdit")
    public String saveChangeEdit(
            @RequestParam(value = START_AUDIT, required = false) String startAudit,
            T01ComplSupl t01ComplSupl,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, t01ComplSupl, START_AUDIT.equals(startAudit) ? Submit.class
                : Submit.class)) {
            return formChange(t01ComplSupl, model, null, redirectAttributes);
        }
        T01ComplSupl t01ComplSuplNew;
        try {
            t01ComplSuplNew = t01ComplSuplExtService.saveChangeEdit(t01ComplSupl);
        } catch (Exception e) {
            if (t01ComplSupl.getIsNewRecord()) {
                t01ComplSupl.setId(null);
            }
            logger.error(e.getMessage());
            addMessage(model, i18nHelper.getText("保存失败：请稍后再试"));
            return formChange(t01ComplSupl, model, null, redirectAttributes);
        }

        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01ComplSuplExtService.startProcess(t01ComplSuplNew.getId(), t01ComplSuplNew.getAct()
                        .getTaskId());
            } catch (NullPointerException | ApprStatusException e1) {
                addMessage(model, i18nHelper.getText(e1.getMessage()));
                return formChangeEdit(t01ComplSuplNew, model, null, redirectAttributes);
            } catch (Exception e) {
                addMessage(model, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
                return formChangeEdit(t01ComplSuplNew, model, null, redirectAttributes);
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/?repage";
        }
        addMessage(redirectAttributes, i18nHelper.getText("保存首营供货者成功"));
        return "redirect:" + Global.getAdminPath()
                + "/gsp/t01complsupl/t01ComplSupl/formChangeEdit?id=" + t01ComplSuplNew.getId();
    }

    /**
     * 首营供货者详情页
     *
     * @param t01ComplSupl entity
     * @param model        model
     * @return view
     */
    @RequestMapping(value = "toDetail")
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:view")
    public String toDetail(T01ComplSupl t01ComplSupl, Model model) {
        model.addAttribute("t01ComplSupl", t01ComplSupl);
        model.addAttribute("detail", "true");
        return "modules/gsp/t01complsupl/t01ComplSuplForm";
    }

    /**
     * 首营供货者审批页
     *
     * @param conditionOrder 保存查询条件
     * @param t01ComplSupl   entity实例
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toAppr"})
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:appr")
    public String toAppr(
            @RequestParam(required = false) String conditionOrder,
            T01ComplSupl t01ComplSupl,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        t01ComplSupl.setApprStat(ApprStatus.NOAPPR.toString());
        Page<T01ComplSupl> page = t01ComplSuplExtService.findPage(new Page<>(request, response), t01ComplSupl);
        model.addAttribute("page", page);
        // 保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01complsupl/t01ComplSuplList_Appr";
    }

    /**
     * 删除列表页
     *
     * @param conditionOrder 查询条件
     * @param t01ComplSupl   entity
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toDelete"})
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:delete")
    public String toDelete(
            @RequestParam(required = false) String conditionOrder,
            T01ComplSupl t01ComplSupl,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01ComplSupl> page = t01ComplSuplExtService.findPage(new Page<>(request, response), t01ComplSupl);
        model.addAttribute("page", page);
        // 保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01complsupl/t01ComplSuplList_Delete";
    }

    /**
     * 跳转审批详情页
     *
     * @param conditionOrder conditionOrder
     * @param t01ComplSupl   entity
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toApprDetail"})
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:appr")
    public String toApprDetail(@RequestParam(required = false) String conditionOrder,
                               T01ComplSupl t01ComplSupl, HttpServletRequest request, HttpServletResponse response,
                               Model model) {

        try {
            t01ComplSuplExtService.getTaskInfo(t01ComplSupl);
        } catch (NullPointerException | BusinessException e) {
            addMessage(model, getText(e.getMessage()));
            return toAppr(conditionOrder, new T01ComplSupl(), request, response, model);
        } catch (Exception e2) {
            addMessage(model, getText("前往审批页失败，系统错误"));
            logger.error(e2.getMessage());
            return toAppr(conditionOrder, new T01ComplSupl(), request, response, model);
        }
        request.getSession().setAttribute("view", "redirect:" + adminPath + "/gsp/t01complsupl/t01ComplSupl/toAppr");
        return "forward:" + Global.getAdminPath() + "/act/task/form?"
                + "taskId="
                + t01ComplSupl.getAct().getTaskId()
                + "&taskName=" + t01ComplSupl.getAct().getTaskName()
                + "&taskDefKey=" + t01ComplSupl.getAct().getTaskDefKey()
                + "&procInsId=" + t01ComplSupl.getAct().getProcInsId()
                + "&procDefId=" + t01ComplSupl.getAct().getProcDefId()
                + "&status=todo";
    }

    /**
     * 首营供货者信息导出
     *
     * @param fromUrl            导出来源页
     * @param ids                指定的导出数据
     * @param t01ComplSupl       entity
     * @param response           response
     * @param redirectAttributes redirectAttributes
     * @return 成功：文件流；失败：来源页view
     */
    @RequestMapping(value = "export")
    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:view")
    public String exportExcel(@RequestParam(value = "fromUrl", required = false) String fromUrl,
                              @RequestParam(value = "ids", required = false) String ids, T01ComplSupl t01ComplSupl,
                              HttpServletResponse response, RedirectAttributes redirectAttributes) {

        String backUrl = "/";

        try {
            if (StringUtils.isNotBlank(fromUrl)) {
                backUrl = backUrl + fromUrl.trim();
            }

            List<T01ComplSupl> list;

            // 如果指定了id列表则导出指定数据，没有则导出筛选条件下的全部数据
            if (StringUtils.isNotBlank(ids)) {

                List<String> idList = Arrays.asList(ids.trim().split(","));

                list = t01ComplSuplExtService.findSelectedList(idList);
            } else {
                list = t01ComplSuplExtService.findList(t01ComplSupl);
            }

            String fileName = "首营供货者信息" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            List<String> headerList = new ArrayList<>();
            headerList.add("企业名称（中文）");
            headerList.add("企业名称（英文）");
            headerList.add("简称");
            headerList.add("供货者状态");
            headerList.add("企业状态");
            headerList.add("生产资质状态");
            headerList.add("经营资质状态");
            headerList.add("审批状态");
            headerList.add("最后操作时间");
            headerList.add("描述");
            headerList.add("备注");
            headerList.add("境内/境外");
            headerList.add("统一社会信用代码");
            headerList.add("注册号");
            headerList.add("组织机构代码证号");
            headerList.add("税务登记证号");
            headerList.add("企业唯一编码");
//            headerList.add("名称");
            headerList.add("经营范围");
            headerList.add("成立日期");
            headerList.add("营业期限至");
//            headerList.add("营业执照上传");
            headerList.add("经营许可证号/备案凭证号");
            headerList.add("企业名称");
            headerList.add("经营方式");
            headerList.add("经营场所");
            headerList.add("库房地址");
//            headerList.add("经营范围");
            headerList.add("发证时间");
            headerList.add("有效期至");
//            headerList.add("经营资质上传");
            headerList.add("编号");
            headerList.add("企业名称");
//            headerList.add("生产范围");
            headerList.add("发证日期");
            headerList.add("有效期至");
//            headerList.add("生产资质上传");
            headerList.add("生产能力评价");
            headerList.add("质量管理评价");
            headerList.add("仓储能力评价");
            headerList.add("交付能力评价");
            headerList.add("售后服务能力评价");
//            headerList.add("其他附件");

            ExportExcel ee = new ExportExcel("首营供货者信息", headerList);
            if (list != null && !list.isEmpty()) {
                for (T01ComplSupl item : list) {
                    Row row = ee.addRow();
                    List<Object> cellList = new ArrayList<>();
                    cellList.add(item.getT01CompInfo().getCompNameCn());
                    cellList.add(item.getT01CompInfo().getCompNameEn());
                    cellList.add(item.getT01CompInfo().getShortName());
                    cellList.add(DictUtils.getDictLabel(item.getSuplStat(), "t01_certStat", ""));
                    if ("0".equals(item.getT01CompInfo().getAbroad())) {
                        cellList.add(DictUtils.getDictLabel(item.getT01CompCert0().getCertStat(), "t01_certStat", ""));
                    }
                    if ("1".equals(item.getT01CompInfo().getAbroad())) {
                        cellList.add(DictUtils.getDictLabel(item.getT01CompCert3().getCertStat(), "t01_certStat", ""));
                    }
                    cellList.add(DictUtils.getDictLabel(item.getT01CompCert2().getCertStat(), "t01_certStat", ""));
                    cellList.add(DictUtils.getDictLabel(item.getT01CompCert1().getCertStat(), "t01_certStat", ""));
                    cellList.add(DictUtils.getDictLabel(item.getApprStat(), "t01_matr_info_appr_stat", ""));
                    cellList.add(DateUtils.formatDate(item.getUpdateDate(), "yyyy-MM-dd HH:mm:ss"));
                    cellList.add(item.getT01CompInfo().getCompDesc());
                    cellList.add(item.getT01CompInfo().getRemarks());
                    cellList.add(DictUtils.getDictLabel(item.getT01CompInfo().getAbroad(), "abroad", ""));
                    cellList.add(item.getT01CompInfo().getUniCretNbr());
                    cellList.add(item.getT01CompInfo().getRegiNbr());
                    cellList.add(item.getT01CompInfo().getOrgCertNbr());
                    cellList.add(item.getT01CompInfo().getTaxNbr());
                    cellList.add(item.getT01CompInfo().getCompUniNbr());
//                    cellList.add(item.getT01CompCert0().getCertName());
                    if ("0".equals(item.getT01CompInfo().getAbroad())) {
                        cellList.add(item.getT01CompCert0().getCertScop());
                        cellList.add(item.getT01CompCert0().getEffecDate());
                        cellList.add(item.getT01CompCert0().getValidDate());
                    }
                    if ("1".equals(item.getT01CompInfo().getAbroad())) {
                        cellList.add(item.getT01CompCert3().getCertScop());
                        cellList.add(item.getT01CompCert3().getEffecDate());
                        cellList.add(item.getT01CompCert3().getValidDate());
                    }
//                    cellList.add(item.getT01CompCert0().getAttachment());
                    cellList.add(item.getT01CompCert1().getCertNbr());
                    cellList.add(item.getT01CompCert1().getCertName());
                    cellList.add(DictUtils.getDictLabel(item.getT01CompInfo().getBusiMode(), "t01_busiMode", ""));
                    cellList.add(item.getT01CompInfo().getBusiLoca());
                    cellList.add(item.getT01CompInfo().getStorLoca());
//                    cellList.add( item.getT01CompCert1().getCertScop());
                    cellList.add(item.getT01CompCert1().getEffecDate());
                    cellList.add(item.getT01CompCert1().getValidDate());
//                    cellList.add(item.getT01CompCert1().getAttachment());
                    cellList.add(item.getT01CompCert2().getCertNbr());
                    cellList.add(item.getT01CompCert2().getCertName());
//                    cellList.add(item.getT01CompCert2().getCertScop());
                    cellList.add(item.getT01CompCert2().getEffecDate());
                    cellList.add(item.getT01CompCert2().getValidDate());
//                    cellList.add(item.getT01CompCert2().getAttachment());
                    cellList.add(item.getT01CompInfo().getProdAbliEval());
                    cellList.add(item.getT01CompInfo().getQualMgrEval());
                    cellList.add(item.getT01CompInfo().getStorAbliEval());
                    cellList.add(item.getT01CompInfo().getDeliAbliEval());
                    cellList.add(item.getT01CompInfo().getAfteSaleAbliEval());
//                    cellList.add(item.getAttachment());
                    for (int i = 0; i < cellList.size(); i++) {
                        ee.addCell(row, i, cellList.get(i));
                    }
                }
            }
            ee.write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("导出首营供货者信息失败！失败信息：" + e.getMessage()));
        }
        return "redirect:" + adminPath + "/gsp/t01complsupl/t01ComplSupl" + backUrl + "?repage";
    }


    /**
     * 获取销售人员授权列表
     *
     * @return object
     */
    @ResponseBody
    @RequestMapping(value = "salesCertList")
    public Object salesCertList(
            @RequestParam(value = "ids", required = false, defaultValue = "") String ids,
            @RequestParam(required = false, defaultValue = "") String needIds) {

        List<T01SalesCert> t01SalesCertList = new ArrayList<>();
        String code;
        String message;
        try {
            if (StringUtils.isNotBlank(needIds)) {
                List<String> idList = Arrays.asList(needIds.trim().split(","));
                for (String id : idList) {
                    t01SalesCertList.add(t01SalesCertService.get(id));
                }
            } else {
                t01SalesCertList = t01SalesCertService.findList(new T01SalesCert())
                        .stream().filter(item -> (item.getComp() == null || StringUtils.isBlank(item.getComp().getId()))
                                && !ids.contains(item.getId())).collect(Collectors.toList());
            }
            if (t01SalesCertList != null && !t01SalesCertList.isEmpty()) {
                code = "100";
                message = getText("获取数据成功");
            } else {
                code = "101";
                message = getText("暂无数据");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            code = "102";
            message = getText("获取数据失败");
        }

        return JsonResponse.create(code, message, t01SalesCertList).getResult();
    }

    /**
     * 获取所有最新的供货者记录
     *
     * @return 供货者列表
     */
    @RequestMapping(
            value = "get-all-suppliers",
            name = "get_all_compliance_suppliers",
            method = RequestMethod.GET
    )
    @ResponseBody
//    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:view")
    public List<Map<String, Object>> getAllSuppliers() {
        T01ComplSupl t01ComplSupl = new T01ComplSupl();
        t01ComplSupl.setApprStat(ApprStatus.PASS.toString());

        // 获取所有的供货者记录
        return t01ComplSuplExtService
                .findList(t01ComplSupl)
                .stream()
                .filter(b -> true) // TODO 过滤已经被变更过的记录
                .map(buyer -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", buyer.getId());
                    map.put("pId", null);
                    if (buyer.getT01CompInfo() != null) {
                        map.put("name", buyer.getT01CompInfo().getCompNameCn());
                    } else {
                        map.put("name", buyer.getT01CompInfo().getId());
                    }
                    return map;
                })
                .collect(Collectors.toList());
    }
}

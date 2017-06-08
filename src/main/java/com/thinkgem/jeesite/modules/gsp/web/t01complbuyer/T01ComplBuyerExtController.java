package com.thinkgem.jeesite.modules.gsp.web.t01complbuyer;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplExtService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.stream.Collectors;

import static com.thinkgem.jeesite.common.json.JsonResponseCode.FAILED;
import static com.thinkgem.jeesite.common.json.JsonResponseCode.SUCCESS;

/**
 * 首营购货者Controller
 *
 * @author XXS
 * @version 2016-12-14
 */
@SuppressWarnings("MVCPathVariableInspection")
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01complbuyer/t01ComplBuyer")
public class T01ComplBuyerExtController extends T01ComplBuyerController {

    @Autowired
    private T01ComplSuplExtService t01ComplSuplExtService;

    @Autowired
    public T01ComplBuyerExtController(
            T01ComplBuyerExtService t01ComplBuyerExtService,
            T01CompCertService t01CompCertService,
            T01CompInfoService t01CompInfoService,
            SystemService systemService) {
        super(t01ComplBuyerExtService, t01CompCertService, t01CompInfoService, systemService);

    }

    /**
     * 变更详情页
     *
     * @param t01ComplBuyer entity
     * @param model         model
     * @return view
     */
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:change")
    @RequestMapping(value = "formChange")
    public String formChange(
            T01ComplBuyer t01ComplBuyer,
            Model model) {

        if (StringUtils.isNotBlank(t01ComplBuyer.getT01CompInfo().getCompNameCn())) {
            T01ComplBuyer t01ComplBuyerSearch = t01ComplBuyer;
            List<T01ComplBuyer> t01ComplBuyerList = t01ComplBuyerService.findList(t01ComplBuyerSearch)
                    .stream().filter(item -> ApprStatus.PASS.toString().equals(item.getApprStat())
                            && item.getT01CompInfo().getCompNameCn().equals(t01ComplBuyerSearch.getT01CompInfo().getCompNameCn()))
                    .collect(Collectors.toList());

            if (t01ComplBuyerList != null && !t01ComplBuyerList.isEmpty()) {
                try {

                    t01ComplBuyer = t01ComplBuyerService.get(t01ComplBuyerList.get(0).getId());
                    t01ComplBuyerHelperService.checkStatusBeforeHandle("change", t01ComplBuyer);
                    //判断是否同时关联供货者
                    T01ComplSupl t01ComplSuplSearch = new T01ComplSupl();
                    t01ComplSuplSearch.setCompId(t01ComplBuyer.getT01CompInfo().getId());
                    List<T01ComplSupl> t01ComplSuplList = t01ComplSuplExtService.findList(t01ComplSuplSearch);
                    if (!t01ComplSuplList.isEmpty()) {
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

        t01ComplBuyer.setCertScopList(systemService.findAllCertScop());
        model.addAttribute("t01ComplBuyer", t01ComplBuyer);
        return "modules/gsp/t01complbuyer/t01ComplBuyerForm_Change";
    }

    /**
     * 变更保存
     *
     * @param startAudit         启动审批流程标识
     * @param t01ComplBuyer      entity
     * @param model              model
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:change")
    @RequestMapping(value = "saveChange")
    public String saveChange(
            @RequestParam(value = START_AUDIT, required = false) String startAudit,
            T01ComplBuyer t01ComplBuyer,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (t01ComplBuyer.getSysChanInfoList() == null || t01ComplBuyer.getSysChanInfoList().isEmpty()) {
            addMessage(model, i18nHelper.getText("保存失败：没有变更项"));
            return formChange(t01ComplBuyer, model);
        }

        T01ComplBuyer t01ComplBuyerNew;
        try {
            t01ComplBuyerNew = t01ComplBuyerService.saveChange(t01ComplBuyer);
        } catch (BusinessException e) {
            if (t01ComplBuyer.getIsNewRecord()) {
                t01ComplBuyer.setId(null);
            }
            addMessage(model, i18nHelper.getText(e.getMessage()));
            return formChange(t01ComplBuyer, model);
        } catch (Exception e) {
            if (t01ComplBuyer.getIsNewRecord()) {
                t01ComplBuyer.setId(null);
            }
            logger.error(e.getMessage());
            addMessage(model, i18nHelper.getText("保存失败：请稍后再试"));
            return formChange(t01ComplBuyer, model);
        }

        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01ComplBuyerService.startProcess(t01ComplBuyerNew.getId(), t01ComplBuyerNew.getAct().getTaskId());
            } catch (NullPointerException | ApprStatusException e1) {
                addMessage(model, i18nHelper.getText(e1.getMessage()));
                return formChange(t01ComplBuyer, model);
            } catch (Exception e) {
                addMessage(model, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
                return formChange(t01ComplBuyer, model);
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complbuyer/t01ComplBuyer/?repage";
        }

        addMessage(redirectAttributes, i18nHelper.getText("保存首营购货者成功"));
        return "redirect:" + Global.getAdminPath()
                + "/gsp/t01complbuyer/t01ComplBuyer/formChangeEdit?id=" + t01ComplBuyerNew.getId();
    }

    /**
     * 变更修改页
     *
     * @param t01ComplBuyer      entity
     * @param model              model
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:edit")
    @RequestMapping(value = "formChangeEdit")
    public String formChangeEdit(
            T01ComplBuyer t01ComplBuyer,
            Model model,
            RedirectAttributes redirectAttributes) {
        try {
            t01ComplBuyer = t01ComplBuyerService.changeEdit(t01ComplBuyer);
        } catch (Exception e) {
            addMessage(redirectAttributes, getText("编辑首营购货者失败"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complbuyer/t01ComplBuyer/?repage";
        }
        model.addAttribute("t01ComplBuyer", t01ComplBuyer);
        model.addAttribute("changeEdit", "true");
        return "modules/gsp/t01complbuyer/t01ComplBuyerForm_Change";
    }

    /**
     * 保持变更修改
     *
     * @param startAudit         启动流程标识
     * @param t01ComplBuyer      entity
     * @param model              model
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:edit")
    @RequestMapping(value = "saveChangeEdit")
    public String saveChangeEdit(
            @RequestParam(value = START_AUDIT, required = false) String startAudit,
            T01ComplBuyer t01ComplBuyer,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, t01ComplBuyer, START_AUDIT.equals(startAudit) ?
                Submit.class :
                Submit.class)) {
            return formChange(t01ComplBuyer, model);
        }
        T01ComplBuyer t01ComplBuyerNew;
        try {
            t01ComplBuyerNew = t01ComplBuyerService.saveChangeEdit(t01ComplBuyer);
        } catch (Exception e) {
            if (t01ComplBuyer.getIsNewRecord()) {
                t01ComplBuyer.setId(null);
            }
            logger.error(e.getMessage());
            addMessage(model, i18nHelper.getText("保存失败：请稍后再试"));
            return formChange(t01ComplBuyer, model);
        }

        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01ComplBuyerService.startProcess(t01ComplBuyerNew.getId(), t01ComplBuyerNew.getAct().getTaskId());
            } catch (NullPointerException | ApprStatusException e1) {
                addMessage(model, i18nHelper.getText(e1.getMessage()));
                return formChangeEdit(t01ComplBuyerNew, model, redirectAttributes);
            } catch (Exception e) {
                addMessage(model, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
                return formChangeEdit(t01ComplBuyerNew, model, redirectAttributes);
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complbuyer/t01ComplBuyer/?repage";
        }
        addMessage(redirectAttributes, i18nHelper.getText("保存首营购货者成功"));
        return "redirect:" + Global.getAdminPath()
                + "/gsp/t01complbuyer/t01ComplBuyer/formChangeEdit?id=" + t01ComplBuyerNew.getId();
    }

    /**
     * 首营购货者详情页
     *
     * @param t01ComplBuyer entity
     * @param model         model
     * @return view
     */
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:view")
    @RequestMapping(value = "toDetail")
    public String toDetail(T01ComplBuyer t01ComplBuyer, Model model) {
        model.addAttribute("t01ComplBuyer", t01ComplBuyer);
        model.addAttribute("detail", "true");
        return "modules/gsp/t01complbuyer/t01ComplBuyerForm";
    }

    /**
     * 首营购货者审批页
     *
     * @param conditionOrder 保存查询条件
     * @param t01ComplBuyer  entity实例
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toAppr"})
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:appr")
    public String toAppr(
            @RequestParam(required = false) String conditionOrder,
            T01ComplBuyer t01ComplBuyer,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        t01ComplBuyer.setApprStat(ApprStatus.NOAPPR.toString());
        Page<T01ComplBuyer> page = t01ComplBuyerService.findPage(new Page<>(request, response), t01ComplBuyer);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01complbuyer/t01ComplBuyerList_Appr";
    }

    /**
     * 删除列表页
     *
     * @param conditionOrder 查询条件
     * @param t01ComplBuyer  entity
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toDelete"})
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:delete")
    public String toDelete(
            @RequestParam(required = false) String conditionOrder,
            T01ComplBuyer t01ComplBuyer,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01ComplBuyer> page = t01ComplBuyerService.findPage(new Page<>(request, response), t01ComplBuyer);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01complbuyer/t01ComplBuyerList_Delete";
    }

    /**
     * 跳转审批详情页
     *
     * @param conditionOrder conditionOrder
     * @param t01ComplBuyer  entity
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toApprDetail"})
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:appr")
    public String toApprDetail(
            @RequestParam(required = false) String conditionOrder,
            T01ComplBuyer t01ComplBuyer,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {

        try {
            t01ComplBuyerService.getTaskInfo(t01ComplBuyer);
        } catch (NullPointerException | BusinessException e) {
            addMessage(model, getText(e.getMessage()));
            return toAppr(conditionOrder, new T01ComplBuyer(), request, response, model);
        } catch (Exception e2) {
            addMessage(model, getText("前往审批页失败，系统错误"));
            logger.error(e2.getMessage());
            return toAppr(conditionOrder, new T01ComplBuyer(), request, response, model);
        }
        request.getSession().setAttribute("view", "redirect:" + adminPath + "/gsp/t01complbuyer/t01ComplBuyer/toAppr");
        return "forward:" + Global.getAdminPath() + "/act/task/form?"
                + "taskId=" + t01ComplBuyer.getAct().getTaskId()
                + "&taskName=" + t01ComplBuyer.getAct().getTaskName()
                + "&taskDefKey=" + t01ComplBuyer.getAct().getTaskDefKey()
                + "&procInsId=" + t01ComplBuyer.getAct().getProcInsId()
                + "&procDefId=" + t01ComplBuyer.getAct().getProcDefId()
                + "&status=todo";
    }

    /**
     * 首营购货者信息导出
     *
     * @param fromUrl            导出来源页
     * @param ids                指定的导出数据
     * @param t01ComplBuyer      entity
     * @param response           response
     * @param redirectAttributes redirectAttributes
     * @return 成功：文件流；失败：来源页view
     */
    @RequestMapping(value = "export")
    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:view")
    public String exportExcel(
            @RequestParam(value = "fromUrl", required = false) String fromUrl,
            @RequestParam(value = "ids", required = false) String ids,
            T01ComplBuyer t01ComplBuyer,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {

        String backUrl = "/";

        try {
            if (StringUtils.isNotBlank(fromUrl)) {
                backUrl = backUrl + fromUrl.trim();
            }

            List<T01ComplBuyer> list;

            // 如果指定了id列表则导出指定数据，没有则导出筛选条件下的全部数据
            if (StringUtils.isNotBlank(ids)) {

                List<String> idList = Arrays.asList(ids.trim().split(","));

                list = t01ComplBuyerService.findSelectedList(idList);
            } else {
                list = t01ComplBuyerService.findList(t01ComplBuyer);
            }

            String fileName = "首营购货者信息" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            List<String> headerList = new ArrayList<>();
            headerList.add("企业名称（中文）");
            headerList.add("企业名称（英文）");
            headerList.add("简称");
            headerList.add("购货者状态");
            headerList.add("企业状态");
            headerList.add("医疗机构执业许可状态");
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
            headerList.add("经营资质发证时间");
            headerList.add("经营资质有效期至");
//            headerList.add("经营资质上传");
            headerList.add("登记号");
            headerList.add("机构名称");
            headerList.add("诊疗科目");
            headerList.add("医疗机构执业许可发证日期");
            headerList.add("医疗机构执业许可有效期至");
//            headerList.add("医疗机构执业许可上传");
//            headerList.add("其他附件");

            ExportExcel ee = new ExportExcel("首营购货者信息", headerList);
            if (list != null && !list.isEmpty()) {
                for (T01ComplBuyer item : list) {
                    Row row = ee.addRow();
                    List<Object> cellList = new ArrayList<>();
                    cellList.add(item.getT01CompInfo().getCompNameCn());
                    cellList.add(item.getT01CompInfo().getCompNameEn());
                    cellList.add(item.getT01CompInfo().getShortName());
                    cellList.add(DictUtils.getDictLabel(item.getBuyerStat(), "t01_certStat", ""));
                    if ("0".equals(item.getT01CompInfo().getAbroad())) {
                        cellList.add(DictUtils.getDictLabel(item.getT01CompCert0().getCertStat(), "t01_certStat", ""));
                    }
                    if ("1".equals(item.getT01CompInfo().getAbroad())) {
                        cellList.add(DictUtils.getDictLabel(item.getT01CompCert3().getCertStat(), "t01_certStat", ""));
                    }
                    cellList.add(DictUtils.getDictLabel(item.getT01CompCert4().getCertStat(), "t01_certStat", ""));
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
                    cellList.add(item.getT01CompCert4().getCertNbr());
                    cellList.add(item.getT01CompCert4().getCertName());
                    cellList.add(item.getT01CompCert4().getCertScop());
                    cellList.add(item.getT01CompCert4().getEffecDate());
                    cellList.add(item.getT01CompCert4().getValidDate());
//                    cellList.add(item.getT01CompCert4().getAttachment());
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
            addMessage(redirectAttributes, i18nHelper.getText("导出首营购货者信息失败！失败信息：" + e.getMessage()));
        }
        return "redirect:" + adminPath + "/gsp/t01complbuyer/t01ComplBuyer" + backUrl + "?repage";
    }

    /**
     * 获取所有最新的购货者记录
     *
     * @return 购货者列表
     */
    @RequestMapping(
            value = "get-all-buyers",
            name = "get_all_compliance_buyers",
            method = RequestMethod.GET
    )
    @ResponseBody
//    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:view")
    public List<Map<String, Object>> getAllBuyers() {
        T01ComplBuyer t01ComplBuyer = new T01ComplBuyer();
        t01ComplBuyer.setApprStat(ApprStatus.PASS.toString());

        // 获取所有的购货者记录
        return t01ComplBuyerService
                .findList(t01ComplBuyer)
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

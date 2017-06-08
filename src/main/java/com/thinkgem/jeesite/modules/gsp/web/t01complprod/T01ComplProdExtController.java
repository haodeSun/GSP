/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01complprod;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01complprod.T01ComplProdExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertService;
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
import com.thinkgem.jeesite.modules.sys.service.SysConfigService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import org.activiti.engine.ActivitiObjectNotFoundException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 首营产品Controller
 *
 * @author XXS
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01complprod/t01ComplProd")
public class T01ComplProdExtController extends T01ComplProdController {
    private static final String CONFIG_COMPANY_KEY="config_company_id";
    /**
     * 物料service
     */
    private final T01MatrInfoExtService t01MatrInfoExtService;
    /**
     * 资质service
     */
    private final T01ProdCertExtService t01ProdCertExtService;
    private final T01ProdCertService t01ProdCertService;

    @Autowired
    private SysConfigService sysConfigService;
    @Autowired
    private T01CompCertService t01CompCertService;
    @Autowired
    public T01ComplProdExtController(
            T01ComplProdExtService t01ComplProdExtService,
            T01MatrInfoExtService t01MatrInfoExtService,
            T01ProdCertExtService t01ProdCertExtService,
            T01ProdCertService t01ProdCertService) {
        super(t01ComplProdExtService);
        Assert.notNull(t01MatrInfoExtService);
        Assert.notNull(t01ProdCertExtService);
        Assert.notNull(t01ProdCertService);
        this.t01MatrInfoExtService = t01MatrInfoExtService;
        this.t01ProdCertExtService = t01ProdCertExtService;
        this.t01ProdCertService = t01ProdCertService;
    }

    /**
     * 删除产品
     * @param t01ComplProd entity
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequestMapping("deleteComplProd")
    @RequiresPermissions("gsp:t01complprod:t01ComplProd:delete")
    public String deleteComplProd(
            T01ComplProd t01ComplProd,
            RedirectAttributes redirectAttributes) {
        String result;
        try{
            result=t01ComplProdExtService.deleteComplProd(t01ComplProd);
        }catch (BusinessException |NullPointerException e1){
            addMessage(redirectAttributes, getText(e1.getMessage()));
            return "redirect:"+Global.getAdminPath()+"/gsp/t01complprod/t01ComplProd/toDelete?repage";
        }catch (Exception e2){
            addMessage(redirectAttributes, "删除失败,系统错误");
            return "redirect:"+Global.getAdminPath()+"/gsp/t01complprod/t01ComplProd/toDelete?repage";
        }
        addMessage(redirectAttributes, getText(result));
        return "redirect:"+Global.getAdminPath()+"/gsp/t01complprod/t01ComplProd/toDelete?repage";
    }

    /**
     * 首营产品删除页
     *
     * @param conditionOrder 保存查询条件
     * @param t01ComplProd   entity实例
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toDelete"})
    @RequiresPermissions("gsp:t01complprod:t01ComplProd:delete")
    public String toDelete(
            @RequestParam(required = false) String conditionOrder,
            T01ComplProd t01ComplProd,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        try {
            Page<T01ComplProd> page = t01ComplProdExtService.findPage(new Page<>(request, response), t01ComplProd);
            model.addAttribute("page", page);
            //保存上次查询条件
            model.addAttribute("conditionOrder", conditionOrder);
        } catch (Exception e) {
            logger.error("查询发生错误" + e.getMessage());
            model.addAttribute("message", getText("查询失败，请输入正确查询条件"));
        }
        return "modules/gsp/t01complprod/t01ComplProdList_Delete";
    }

    /**
     * 首营产品审批页
     *
     * @param conditionOrder 保存查询条件
     * @param t01ComplProd   entity实例
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequestMapping(value = {"toAppr"})
    @RequiresPermissions("gsp:t01complprod:t01ComplProd:appr")
    public String toAppr(
            @RequestParam(required = false) String conditionOrder,
            T01ComplProd t01ComplProd,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        try {
            t01ComplProd.setApprStat(ApprStatus.NOAPPR.toString());
            Page<T01ComplProd> page = t01ComplProdExtService.findPage(new Page<>(request, response), t01ComplProd);
            model.addAttribute("page", page);
            //保存上次查询条件
            model.addAttribute("conditionOrder", conditionOrder);
        } catch (Exception e) {
            logger.error("查询发生错误" + e.getMessage());
            model.addAttribute("message", getText("查询失败，请输入正确查询条件"));
        }
        return "modules/gsp/t01complprod/t01ComplProdList_Appr";
    }

    /**
     * 首营产品详情页
     *
     * @param t01ComplProd entity
     * @param model        model
     * @return view
     */
    @RequestMapping(value = "toDetail")
    @RequiresPermissions("gsp:t01complprod:t01ComplProd:view")
    public String toDetail(T01ComplProd t01ComplProd, Model model) {
        model.addAttribute("t01ComplProd", t01ComplProd);
        return "modules/gsp/t01complprod/t01ComplProdForm_Detail";
    }

    /**
     * 首营产品审批详情页
     *
     * @param t01ComplProd entity
     * @param model        model
     * @return view
     */
    @RequiresPermissions("gsp:t01complprod:t01ComplProd:appr")
    @RequestMapping(value = "toApprDetail")
    public String toApprDetail(
            T01ComplProd t01ComplProd,
            Model model,
            RedirectAttributes redirectAttributes) {

        try {
            if (ApprStatus.NOPASS.toString().equals(t01ComplProd.getApprStat()) ||
                    ApprStatus.PASS.toString().equals(t01ComplProd.getApprStat())) {
                addMessage(redirectAttributes, i18nHelper.getText("跳转审批页失败，该条信息完成审批操作"));
                return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/toAppr?repage";
            }

            if (ApprStatus.NOSUBMIT.toString().equals(t01ComplProd.getApprStat())) {
                addMessage(redirectAttributes, i18nHelper.getText("跳转审批页失败，该条信息未提交审批"));
                return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/toAppr?repage";
            }
            if (ApprStatus.NOAPPR.toString().equals(t01ComplProd.getApprStat())) {
                t01ComplProdExtService.CheckPermissionToTask(t01ComplProd);
                model.addAttribute("t01ComplProd", t01ComplProd);
                return "modules/gsp/t01complprod/t01ComplProdForm_ApprDetail";
            } else {
                throw new Exception("跳转审批页失败，该条信息审批状态发生错误");
            }
        } catch (Exception e) {
            addMessage(redirectAttributes, i18nHelper.getText(e.getMessage()));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/toAppr?repage";
        }
    }

    /**
     * 审批处理逻辑
     * @param t01ComplProd entity
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequestMapping(value = "apprLogic")
    @RequiresPermissions("gsp:t01complprod:t01ComplProd:appr")
    public String apprLogic(
            T01ComplProd t01ComplProd,
            RedirectAttributes redirectAttributes) {
        if (StringUtils.isBlank(t01ComplProd.getAct().getFlag())
                || StringUtils.isBlank(t01ComplProd.getAct().getComment())){
            addMessage(redirectAttributes, i18nHelper.getText("请填写审核意见！"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/toApprDetail?id="+t01ComplProd.getId();
        }
        try {
            t01ComplProdExtService.approve(t01ComplProd);
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, e.getMessage());
        }
        return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/toAppr?repage";
    }

    /**
     *
     *
     * @param matrNbr 物料号
     * @return 物料json关联物料信息对象
     */
    @RequestMapping("/getMatrInfo")
    @ResponseBody
    public Object getMatrInfo(@RequestParam(value = "matrNbr") String matrNbr) {

        T01MatrInfo t01MatrInfo = null;
        try {
            if (!StringUtils.isBlank(matrNbr)) {
                List<T01MatrInfo> list = t01MatrInfoExtService.findByMatrNbr(matrNbr);
                if (!list.isEmpty()) {
                    t01MatrInfo = list.get(0);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return t01MatrInfo;
    }

    /**
     * 获取产品资质信息
     *
     * @param ids         资质id字符串，分隔符 ','
     * @param t01ProdCert entity
     * @param model       model
     * @return view
     */
    @RequestMapping(value = {"prodList"})
    public String prodList(
            @RequestParam(value = "ids", required = false) String ids,
            @RequestParam(value = "detailView", required = false) String detailView,
            T01ProdCert t01ProdCert,
            Model model) {
        List<T01ProdCert> listT01ProCert = new ArrayList<>();

        if (StringUtils.isNotBlank(detailView)) {
            model.addAttribute("detailView", true);
        }
        if (StringUtils.isNotBlank(ids)) {
            List<String> idList = Arrays.asList(ids.split(","));
            for (String id : idList) {
                listT01ProCert.add(t01ProdCertService.get(id));
            }
            model.addAttribute("edit", true);
        } else if (StringUtils.isNotBlank(t01ProdCert.getRegiCertNbr())) {
            listT01ProCert = t01ProdCertExtService.getHistory(t01ProdCert);
        }

        SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigName(CONFIG_COMPANY_KEY);

        List<SysConfig> sysConfigList = sysConfigService.findList(sysConfig);

        String certScop=null;

        if (sysConfigList != null && !sysConfigList.isEmpty()) {
            String compId = sysConfigList.get(0).getConfigValue();

            T01CompCert t01CompCert = new T01CompCert();
            t01CompCert.setCompId(compId);
            t01CompCert.setCertType("1");

            List<T01CompCert> t01CompCertList = t01CompCertService.findList(t01CompCert);
            if (!t01CompCertList.isEmpty()) {
                certScop = t01CompCertList.get(0).getCertScop();
            }

        }
        //只有审批通过的才可以关联物料
        listT01ProCert=listT01ProCert.stream()
                .filter(item->ApprStatus.PASS.toString().equals(item.getApprStat()))
                .collect(Collectors.toList());

        boolean hasNotInCertScopData = false;
        List<String> certScopList = null;
        if (StringUtils.isNotBlank(certScop)) {
            certScopList = Arrays.asList(certScop.split(","));
        }
        if (certScopList != null && !certScopList.isEmpty()) {

            for (int i = 0; i < listT01ProCert.size(); i++) {

                boolean inCertScopData = false;

                for (int j = 0; j < certScopList.size(); j++) {
                    if (certScopList.get(j).equals(listT01ProCert.get(i).getRiskClass() + "-" + listT01ProCert.get(i).getTechCateCd())) {
                        inCertScopData = true;
                    }
                }
                if (!inCertScopData) {
                    listT01ProCert.remove(i);
                    i--;
                    hasNotInCertScopData = true;
                }
            }
        }

        model.addAttribute("hasNotInCertScopData", hasNotInCertScopData);

        model.addAttribute("list", listT01ProCert);
        return "modules/gsp/t01complprod/Part_Form_ProdList";
    }

    /**
     * 启动审批流程
     * @param id entity id
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequestMapping(value = "/startAudit")
    public String startAudit(
            @RequestParam(value = "id") String id,
            RedirectAttributes redirectAttributes) {
        try {
            t01ComplProdExtService.startProcess(id.trim(), "");
            addMessage(redirectAttributes, i18nHelper.getText("审批提交成功！"));
        } catch (ConstraintViolationException cvExc) {//捕获验证异常
            List<String> list = new ArrayList<>();
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                list.add(violation.getMessage());
            }
            list.add(0, "数据验证失败，提交审批前请完善信息：");
            addMessage(redirectAttributes, list.toArray(new String[]{}));
        } catch (NullPointerException | ApprStatusException e1) {
            addMessage(redirectAttributes, i18nHelper.getText(e1.getMessage()));
        }catch (ActivitiObjectNotFoundException actExc) {
            addMessage(redirectAttributes, i18nHelper.getText("审批提交失败，请完善审批流程再试！"));
        } catch (Exception e2) {
            logger.error(e2.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("审批提交失败，请稍后再试！"));
        }
        return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/toAppr/?repage";
    }

    /**
     * 首营产品信息导出
     *
     * @param fromUrl            导出来源页
     * @param ids                指定的导出数据
     * @param t01ComplProd       entity
     * @param response           response
     * @param redirectAttributes redirectAttributes
     * @return 成功：文件流；失败：来源页view
     */
    @RequestMapping(value = "export")
    @RequiresPermissions("gsp:t01complprod:t01ComplProd:view")
    public String exportExcel(
            @RequestParam(value = "fromUrl", required = false) String fromUrl,
            @RequestParam(value = "ids", required = false) String ids,
            T01ComplProd t01ComplProd,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {

        String backUrl = "/";

        try {
            if (StringUtils.isNotBlank(fromUrl)) {
                backUrl = backUrl + fromUrl.trim();
            }

            List<T01ComplProd> list;

            // 如果指定了id列表则导出指定数据，没有则导出筛选条件下的全部数据
            if (StringUtils.isNotBlank(ids)) {

                List<String> idList = Arrays.asList(ids.trim().split(","));

                list = t01ComplProdExtService.findSelectedList(idList);
            } else {
                list = t01ComplProdExtService.findList(t01ComplProd);
            }

            String fileName = "首营产品信息" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            List<String> headerList = new ArrayList<>();
            headerList.add("注册证/备案凭证编号");
            headerList.add("原注册证/备案凭证编号");
            headerList.add("风险分类");
            headerList.add("技术分类-名称");
            headerList.add("生效日期");
            headerList.add("有效期至");
            headerList.add("资质状态");
            headerList.add("资质类型");
            headerList.add("物料号");
            headerList.add("物料名称（中文）");
            headerList.add("物料名称（英文）");
            headerList.add("描述");
            headerList.add("物料分类");
            headerList.add("存储条件_温度");
            headerList.add("存储条件_湿度");
            headerList.add("运输条件_温度");
            headerList.add("运输条件_湿度");
            headerList.add("物料单位");
            headerList.add("货币单位");
            headerList.add("物料单价");
            headerList.add("物料规格");
            headerList.add("产品有效期（月）");
            headerList.add("备注");
            headerList.add("首营产品状态");
            headerList.add("审批状态");
            headerList.add("更新时间");

            ExportExcel ee = new ExportExcel("首营购货者信息", headerList);
            if (list != null && !list.isEmpty()) {
                for (T01ComplProd item : list) {
                    Row row = ee.addRow();
                    ee.addCell(row, 0, item.getRegiCertNbr());
                    ee.addCell(row, 1, item.getOrigRegiCertNbr());
                    ee.addCell(row, 2, DictUtils.getDictLabel(item.getRiskClass(), "t01_riskClass", ""));
                    ee.addCell(row, 3, DictUtils.getDictLabel(item.getTechCateCd(), "t01_tech_cate_cd", ""));
                    ee.addCell(row, 4, item.getEffeDate());
                    ee.addCell(row, 5, item.getValidPeri());
                    ee.addCell(row, 6, DictUtils.getDictLabel(item.getCertStat(), "t01_certStat", ""));
                    ee.addCell(row, 7, DictUtils.getDictLabel(item.getCertType(), "t01_certType", ""));
                    ee.addCell(row, 8, item.getMatrNbr());
                    ee.addCell(row, 9, item.getMatrNmCn());
                    ee.addCell(row, 10, item.getMatrNmEn());
                    ee.addCell(row, 11, item.getMatrDesc());
                    ee.addCell(row, 12, DictUtils.getDictLabel(item.getMatrType(), "t01_matr_info_matr_type", ""));
                    ee.addCell(row, 13, item.getStorTemp()+"-"+item.getStorTemp2());
                    ee.addCell(row, 14, item.getStorWet()+"-"+item.getStorWet2());
                    ee.addCell(row, 15, item.getTranTemp()+"-"+item.getTranTemp2());
                    ee.addCell(row, 16, item.getTranWet()+"-"+item.getTranWet2());
                    ee.addCell(row, 17, item.getMartUnit());
                    ee.addCell(row, 18, item.getPriceUnit());
                    ee.addCell(row, 19, item.getMatrPrice());
                    ee.addCell(row, 20, item.getSpecType());
                    ee.addCell(row, 21, item.getValidMonths());
                    ee.addCell(row, 22, item.getRemarks());

                    if("1".equals(item.getFreezeFlag())) {
                        ee.addCell(row, 23, "冻结");
                    }else {
                        ee.addCell(row, 24, DictUtils.getDictLabel(item.getCertStat(), "t01_certStat", ""));
                    }
                    ee.addCell(row, 24, DictUtils.getDictLabel(item.getApprStat(), "t01_matr_info_appr_stat", ""));
                    ee.addCell(row, 25, item.getUpdateDate());
                }
            }
            ee.write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("导出用户失败！失败信息：" + e.getMessage()));
        }
        return "redirect:" + adminPath + "/gsp/t01complprod/t01ComplProd" + backUrl + "?repage";
    }
}
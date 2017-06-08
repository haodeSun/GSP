/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01complsupl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.beanvalidator.*;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplCertType;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplHelperService;
import com.thinkgem.jeesite.modules.gsp.service.t01salescert.T01SalesCertService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplExtService;

/**
 * 首营供货者Controller
 *
 * @author Andrea
 * @version 2016-12-20
 */
public class T01ComplSuplController extends BaseController {

    /**
     * 启动审批流程标识
     */
    protected final String START_AUDIT = "startAudit";

    @SuppressWarnings("WeakerAccess")
    T01ComplSuplExtService t01ComplSuplExtService;

    /**
     * 企业信息service
     */
    protected T01CompInfoService t01CompInfoService;

    /**
     * 企业资质service
     */
    protected T01CompCertService t01CompCertService;

    protected SystemService systemService;

    @Autowired
    protected T01ComplSuplHelperService t01ComplSuplHelperService;
    @Autowired
    protected T01SalesCertService t01SalesCertService;

    @Autowired
    public T01ComplSuplController(
            T01ComplSuplExtService t01ComplSuplExtService,
            T01CompInfoService t01CompInfoService,
            T01CompCertService t01CompCertService,
            SystemService systemService) {
        Assert.notNull(t01ComplSuplExtService);
        Assert.notNull(t01CompInfoService);
        Assert.notNull(t01CompCertService);
        Assert.notNull(systemService);
        this.t01ComplSuplExtService = t01ComplSuplExtService;
        this.t01CompInfoService = t01CompInfoService;
        this.t01CompCertService = t01CompCertService;
        this.systemService = systemService;
    }

    @ModelAttribute
    public T01ComplSupl get(
            @RequestParam(required = false) String id,
            @RequestParam(required = false) String noChangeList) {
        T01ComplSupl entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = t01ComplSuplExtService.get(id);
            if (StringUtils.isNotBlank(noChangeList)) {
                entity.setSysChanInfoList(null);
            }
        }
        if (entity == null) {
            entity = new T01ComplSupl();
        }
        return entity;
    }

    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:view")
    @RequestMapping(value = {"list", ""})
    public String list(@RequestParam(required = false) String conditionOrder,
                       T01ComplSupl t01ComplSupl, HttpServletRequest request, HttpServletResponse response,
                       Model model) {
        Page<T01ComplSupl> page =
                t01ComplSuplExtService.findPage(new Page<>(request, response), t01ComplSupl);
        model.addAttribute("page", page);
        // 保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        if (page.getList() == null || page.getList().isEmpty()) {
            addMessage(model, getText("很抱歉，未查出符合查询条件的数据。"));
        }
        return "modules/gsp/t01complsupl/t01ComplSuplList";
    }

    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:edit")
    @RequestMapping(value = "form")
    public String form(T01ComplSupl t01ComplSupl, Model model, String view,
                       RedirectAttributes redirectAttributes) {
        //设置经营范围数据列表
        t01ComplSupl.setCertScopList(systemService.findAllCertScop());
        model.addAttribute("t01ComplSupl", t01ComplSupl);
        if (view != null && !view.isEmpty()) {
            return view;
        }
        if (StringUtils.isBlank(t01ComplSupl.getId())
                || ApprStatus.NOSUBMIT.toString().equals(t01ComplSupl.getApprStat())
                || ApprStatus.NOPASS.toString().equals(t01ComplSupl.getApprStat())) {

            if (t01ComplSupl.getSysChanInfoList() != null && !t01ComplSupl.getSysChanInfoList().isEmpty()) {
                // 如果为变更，则跳转变更修改页
                return "redirect:" + Global.getAdminPath()
                        + "/gsp/t01complsupl/t01ComplSupl/formChangeEdit?id=" + t01ComplSupl.getId();
            } else {
                return "modules/gsp/t01complsupl/t01ComplSuplForm";
            }
        } else {
            addMessage(redirectAttributes, i18nHelper.getText("只有未提交、审批未通过状态可进行修改，未审批及审批通过状态无法修改"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/toDetail?id="
                    + t01ComplSupl.getId();
        }
    }

    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:edit")
    @RequestMapping(value = "save")
    public String save(@RequestParam(value = START_AUDIT, required = false) String startAudit,
                       T01ComplSupl t01ComplSupl, Model model, RedirectAttributes redirectAttributes) {
        boolean isNew = false;
        if (StringUtils.isBlank(t01ComplSupl.getId())) {
            isNew = true;
        }

        try {
            //企业信息 -直接取系统中已经录入的信息

            if (StringUtils.isNotBlank(t01ComplSupl.getT01CompInfo().getId())) {

                //当国内企业选择了经营资质则可以修改 1经营方式 busiMode 2经营场所 busiLoca 3库房地址 storLoca
                if (ComplSuplCertType.BusinessPermit.equals(t01ComplSupl.getCertType())
                        || ComplSuplCertType.BusinessAndProduction.equals(t01ComplSupl.getCertType())) {

                    String busiMode,busiLoca,storLoca;

                    busiMode=t01ComplSupl.getT01CompInfo().getBusiMode();
                    busiLoca=t01ComplSupl.getT01CompInfo().getBusiLoca();
                    storLoca=t01ComplSupl.getT01CompInfo().getStorLoca();

                    t01ComplSupl.setT01CompInfo(t01CompInfoService.get(t01ComplSupl.getT01CompInfo().getId()));

                    //国内企业
                    if("0".equals(t01ComplSupl.getT01CompInfo().getAbroad())) {
                        if (ApprStatus.NOSUBMIT.toString().equals(t01ComplSupl.getT01CompInfo().getApprStat())
                                || ApprStatus.NOPASS.toString().equals(t01ComplSupl.getT01CompInfo().getApprStat())) {
                            t01ComplSupl.getT01CompInfo().setBusiMode(busiMode);
                            t01ComplSupl.getT01CompInfo().setBusiLoca(busiLoca);
                            t01ComplSupl.getT01CompInfo().setStorLoca(storLoca);
                        }
                    }
                }else {
                    t01ComplSupl.setT01CompInfo(t01CompInfoService.get(t01ComplSupl.getT01CompInfo().getId()));
                }
            }
            //企业资质境内 -直接取系统中已经录入的信息
            if (StringUtils.isNotBlank(t01ComplSupl.getT01CompCert0().getId())) {
                t01ComplSupl.setT01CompCert0(t01CompCertService.get(t01ComplSupl.getT01CompCert0().getId()));
            }
            //企业资质境外 -直接取系统中已经录入的信息
            if (StringUtils.isNotBlank(t01ComplSupl.getT01CompCert3().getId())) {
                t01ComplSupl.setT01CompCert3(t01CompCertService.get(t01ComplSupl.getT01CompCert3().getId()));
            }
            //销售人员授权书 -直接取系统中已经录入的信息
            if (StringUtils.isNotBlank(t01ComplSupl.getT01CompInfo().getId())) {
                T01SalesCert t01SalesCert = new T01SalesCert();
                t01SalesCert.setComp(t01ComplSupl.getT01CompInfo());

                t01ComplSupl.setT01SalesCertList(t01SalesCertService.findList(t01SalesCert));
            }
            //资质录入时可根据资质号进行关联 关联出的审批通过、提交未审批的资质无法修改
            if (t01ComplSupl.getT01CompCert1() != null &&
                    StringUtils.isNotBlank(t01ComplSupl.getT01CompCert1().getId()) &&
                    (ApprStatus.NOAPPR.toString().equals(t01ComplSupl.getT01CompCert1().getApprStat()) ||
                            ApprStatus.PASS.toString().equals(t01ComplSupl.getT01CompCert1().getApprStat()))) {
                t01ComplSupl.setT01CompCert1(t01CompCertService.get(t01ComplSupl.getT01CompCert1().getId()));
            }
            if (t01ComplSupl.getT01CompCert2() != null &&
                    StringUtils.isNotBlank(t01ComplSupl.getT01CompCert2().getId()) &&
                    (ApprStatus.NOAPPR.toString().equals(t01ComplSupl.getT01CompCert2().getApprStat()) ||
                            ApprStatus.PASS.toString().equals(t01ComplSupl.getT01CompCert2().getApprStat()))) {
                t01ComplSupl.setT01CompCert2(t01CompCertService.get(t01ComplSupl.getT01CompCert2().getId()));
            }

            t01ComplSupl.setApprStat(ApprStatus.NOSUBMIT.toString());
            t01ComplSupl.setNeedCheck(true);
            t01ComplSuplExtService.save(t01ComplSupl);
        } catch (BusinessException e) {
            if(isNew){
                t01ComplSupl.setId(StringUtils.EMPTY);
            }
            addMessage(model, i18nHelper.getText(e.getMessage()));
            return form(t01ComplSupl, model, null, redirectAttributes);
        } catch (Exception e) {
            if(isNew){
                t01ComplSupl.setId(StringUtils.EMPTY);
            }
            logger.error(e.getMessage());
            addMessage(model, i18nHelper.getText("保存失败：请稍后再试"));
            return form(t01ComplSupl, model, null, redirectAttributes);
        }

        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01ComplSuplExtService.startProcess(t01ComplSupl.getId(), t01ComplSupl.getAct().getTaskId());
            } catch (NullPointerException | ApprStatusException e1) {
                addMessage(redirectAttributes, i18nHelper.getText(e1.getMessage()));
                return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/form?id=" + t01ComplSupl.getId();
            } catch (Exception e) {
                addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
                return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/form?id=" + t01ComplSupl.getId();
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/?repage";
        }

        addMessage(redirectAttributes, "保存首营供货者成功");
        return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/form?id=" + t01ComplSupl.getId();
    }

    @RequiresPermissions("gsp:t01complsupl:t01ComplSupl:delete")
    @RequestMapping(value = "delete")
    public String delete(T01ComplSupl t01ComplSupl, RedirectAttributes redirectAttributes) {
        String result;
        try {
            result = t01ComplSuplExtService.deleteBuyer(t01ComplSupl);
        } catch (BusinessException | NullPointerException e1) {
            addMessage(redirectAttributes, getText(e1.getMessage()));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/?repage";
        } catch (Exception e2) {
            addMessage(redirectAttributes, "删除失败,系统错误");
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/?repage";
        }
        addMessage(redirectAttributes, getText(result));
        return "redirect:" + Global.getAdminPath() + "/gsp/t01complsupl/t01ComplSupl/?repage";
    }

    @ResponseBody
    @RequestMapping(value = "checkStatusBeforeHandle")
    public Object checkStatusBeforeHandle(
            @RequestParam String handle,
            T01ComplSupl t01ComplSupl) {

        String code;
        String message;
        int data = 0;
        try {
            t01ComplSuplHelperService.checkStatusBeforeHandle(handle, t01ComplSupl);
            code = "100";
            message = "可以操作";
        } catch (BusinessException e) {
            code = "101";
            message = e.getMessage();
        } catch (Exception e) {
            logger.error("处理前的状态检查发生错误" + e.getMessage());
            code = "102";
            message = "检查错误";
        }
        return JsonResponse.create(code, message, data).getResult();
    }

}

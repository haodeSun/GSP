/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01complbuyer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.*;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.ComplBuyerCertType;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerHelperService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerService;

import java.util.ArrayList;
import java.util.List;

/**
 * 首营购货者Controller
 *
 * @author XXS
 * @version 2016-12-13
 */
public class T01ComplBuyerController extends BaseController {

    /**
     * 启动审批流程标识
     */
    static final String START_AUDIT = "startAudit";

    @SuppressWarnings("WeakerAccess")
    T01ComplBuyerExtService t01ComplBuyerService;

    /**
     * 企业资质Service
     */
    protected T01CompCertService t01CompCertService;
    /**
     * 企业信息Service
     */
    protected T01CompInfoService t01CompInfoService;

    protected SystemService systemService;

    @Autowired
    protected T01ComplBuyerHelperService t01ComplBuyerHelperService;

    @Autowired
    public T01ComplBuyerController(
            T01ComplBuyerExtService t01ComplBuyerService,
            T01CompCertService t01CompCertService,
            T01CompInfoService t01CompInfoService,
            SystemService systemService) {
        assert t01ComplBuyerService != null;
        assert t01CompCertService != null;
        assert t01CompInfoService != null;
        assert systemService != null;
        this.t01CompCertService = t01CompCertService;
        this.t01CompInfoService = t01CompInfoService;
        this.t01ComplBuyerService = t01ComplBuyerService;
        this.systemService = systemService;
    }

    @ModelAttribute
    public T01ComplBuyer get(
            @RequestParam(required = false) String id,
            @RequestParam(required = false) String noChangeList) {
        T01ComplBuyer entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = t01ComplBuyerService.get(id);
            if (StringUtils.isNotBlank(noChangeList)) {
                entity.setSysChanInfoList(null);
            }
        }
        if (entity == null) {
            entity = new T01ComplBuyer();
        }
        return entity;
    }

    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:view")
    @RequestMapping(value = {"list", ""})
    public String list(
            @RequestParam(required = false) String conditionOrder,
            T01ComplBuyer t01ComplBuyer,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01ComplBuyer> page = t01ComplBuyerService.findPage(new Page<>(request, response), t01ComplBuyer);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);

        if (page.getList() == null || page.getList().isEmpty()) {
            addMessage(model, getText("很抱歉，未查出符合查询条件的数据。"));
        }

        return "modules/gsp/t01complbuyer/t01ComplBuyerList";
    }

    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:edit")
    @RequestMapping(value = "form")
    public String form(
            T01ComplBuyer t01ComplBuyer,
            Model model,
            String view,
            RedirectAttributes redirectAttributes) {
        //设置经营范围数据列表
        t01ComplBuyer.setCertScopList(systemService.findAllCertScop());
        model.addAttribute("t01ComplBuyer", t01ComplBuyer);
        if (view != null && !view.isEmpty()) {
            return view;
        }
        if (StringUtils.isBlank(t01ComplBuyer.getId())
                || ApprStatus.NOSUBMIT.toString().equals(t01ComplBuyer.getApprStat())
                || ApprStatus.NOPASS.toString().equals(t01ComplBuyer.getApprStat())) {

            if (t01ComplBuyer.getSysChanInfoList() != null && !t01ComplBuyer.getSysChanInfoList().isEmpty()) {
                //如果为变更，则跳转变更修改页
                return "redirect:" + Global.getAdminPath()
                        + "/gsp/t01complbuyer/t01ComplBuyer/formChangeEdit?id=" + t01ComplBuyer.getId();
            } else {
                return "modules/gsp/t01complbuyer/t01ComplBuyerForm";
            }
        } else {
            addMessage(redirectAttributes, i18nHelper.getText("只有未提交、审批未通过状态可进行修改，未审批及审批通过状态无法修改"));
            return "redirect:" + Global.getAdminPath()
                    + "/gsp/t01complbuyer/t01ComplBuyer/toDetail?id="
                    + t01ComplBuyer.getId();
        }
    }

    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:edit")
    @RequestMapping(value = "save")
    public String save(
            @RequestParam(value = START_AUDIT, required = false) String startAudit,
            T01ComplBuyer t01ComplBuyer,
            Model model,
            RedirectAttributes redirectAttributes) {
        boolean isNew = false;
        if (StringUtils.isBlank(t01ComplBuyer.getId())) {
            isNew = true;
        }

        try {
            //企业信息 -直接取系统中已经录入的信息
            if (StringUtils.isNotBlank(t01ComplBuyer.getT01CompInfo().getId())) {
                //当国内企业选择了经营资质则可以修改 1经营方式 busiMode 2经营场所 busiLoca 3库房地址 storLoca
                if (ComplBuyerCertType.BusinessPermit.equals(t01ComplBuyer.getCertType())) {

                    String busiMode,busiLoca,storLoca;

                    busiMode=t01ComplBuyer.getT01CompInfo().getBusiMode();
                    busiLoca=t01ComplBuyer.getT01CompInfo().getBusiLoca();
                    storLoca=t01ComplBuyer.getT01CompInfo().getStorLoca();

                    t01ComplBuyer.setT01CompInfo(t01CompInfoService.get(t01ComplBuyer.getT01CompInfo().getId()));

                    //国内企业
                    if("0".equals(t01ComplBuyer.getT01CompInfo().getAbroad())) {
                        if (ApprStatus.NOSUBMIT.toString().equals(t01ComplBuyer.getT01CompInfo().getApprStat())
                                || ApprStatus.NOPASS.toString().equals(t01ComplBuyer.getT01CompInfo().getApprStat())) {
                            t01ComplBuyer.getT01CompInfo().setBusiMode(busiMode);
                            t01ComplBuyer.getT01CompInfo().setBusiLoca(busiLoca);
                            t01ComplBuyer.getT01CompInfo().setStorLoca(storLoca);
                        }
                    }
                }else {
                    t01ComplBuyer.setT01CompInfo(t01CompInfoService.get(t01ComplBuyer.getT01CompInfo().getId()));
                }
            }
            //企业资质境内 -直接取系统中已经录入的信息
            if (StringUtils.isNotBlank(t01ComplBuyer.getT01CompCert0().getId())) {
                t01ComplBuyer.setT01CompCert0(t01CompCertService.get(t01ComplBuyer.getT01CompCert0().getId()));
            }
            //企业资质境外 -直接取系统中已经录入的信息
            if (StringUtils.isNotBlank(t01ComplBuyer.getT01CompCert3().getId())) {
                t01ComplBuyer.setT01CompCert3(t01CompCertService.get(t01ComplBuyer.getT01CompCert3().getId()));
            }

            //资质录入时可根据资质号进行关联 关联出的审批通过、提交未审批的资质无法修改
            if (t01ComplBuyer.getT01CompCert1() != null &&
                    StringUtils.isNotBlank(t01ComplBuyer.getT01CompCert1().getId()) &&
                    (ApprStatus.NOAPPR.toString().equals(t01ComplBuyer.getT01CompCert1().getApprStat()) ||
                            ApprStatus.PASS.toString().equals(t01ComplBuyer.getT01CompCert1().getApprStat()))) {
                t01ComplBuyer.setT01CompCert1(t01CompCertService.get(t01ComplBuyer.getT01CompCert1().getId()));
            }
            if (t01ComplBuyer.getT01CompCert4() != null &&
                    StringUtils.isNotBlank(t01ComplBuyer.getT01CompCert4().getId()) &&
                    (ApprStatus.NOAPPR.toString().equals(t01ComplBuyer.getT01CompCert4().getApprStat()) ||
                            ApprStatus.PASS.toString().equals(t01ComplBuyer.getT01CompCert4().getApprStat()))) {
                t01ComplBuyer.setT01CompCert4(t01CompCertService.get(t01ComplBuyer.getT01CompCert4().getId()));
            }


            t01ComplBuyer.setApprStat(ApprStatus.NOSUBMIT.toString());
            t01ComplBuyer.setNeedCheck(true);
            t01ComplBuyerService.save(t01ComplBuyer);
        } catch (BusinessException e) {
            if (isNew) {
                t01ComplBuyer.setId(StringUtils.EMPTY);
            }
            addMessage(model, i18nHelper.getText(e.getMessage()));
            return form(t01ComplBuyer, model, null, redirectAttributes);
        } catch (Exception e) {
            if (isNew) {
                t01ComplBuyer.setId(StringUtils.EMPTY);
            }
            logger.error(e.getMessage());
            addMessage(model, i18nHelper.getText("保存失败：请稍后再试"));
            return form(t01ComplBuyer, model, null, redirectAttributes);
        }

        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01ComplBuyerService.startProcess(t01ComplBuyer.getId(), t01ComplBuyer.getAct().getTaskId());
            } catch (NullPointerException | ApprStatusException e1) {
                addMessage(model, i18nHelper.getText(e1.getMessage()));
                return form(t01ComplBuyer, model, null, redirectAttributes);
            } catch (Exception e) {
                addMessage(model, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
                return form(t01ComplBuyer, model, null, redirectAttributes);
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complbuyer/t01ComplBuyer/?repage";
        }

        addMessage(model, "保存首营购货者成功");
        return form(t01ComplBuyer, model, null, redirectAttributes);
    }

    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:delete")
    @RequestMapping(value = "delete")
    public String delete(
            T01ComplBuyer t01ComplBuyer,
            RedirectAttributes redirectAttributes) {
        String result;
        try {
            result = t01ComplBuyerService.deleteBuyer(t01ComplBuyer);
        } catch (BusinessException | NullPointerException e1) {
            addMessage(redirectAttributes, getText(e1.getMessage()));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complbuyer/t01ComplBuyer/?repage";
        } catch (Exception e2) {
            addMessage(redirectAttributes, "删除失败,系统错误");
            return "redirect:" + Global.getAdminPath() + "/gsp/t01complbuyer/t01ComplBuyer/?repage";
        }
        addMessage(redirectAttributes, getText(result));
        return "redirect:" + Global.getAdminPath() + "/gsp/t01complbuyer/t01ComplBuyer/?repage";
    }

    @ResponseBody
    @RequestMapping(value = "checkStatusBeforeHandle")
    public Object checkStatusBeforeHandle(
            @RequestParam String handle,
            T01ComplBuyer t01ComplBuyer) {

        String code;
        String message;
        int data = 0;
        try {
            t01ComplBuyerHelperService.checkStatusBeforeHandle(handle, t01ComplBuyer);
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
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01matrinfo;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

/**
 * 物料信息Controller
 *
 * @author xuxiaoshuo
 * @version 2016-11-23
 */
public class T01MatrInfoController extends BaseController {
    private final String START_AUDIT = "startAudit";

    @SuppressWarnings("WeakerAccess")
    T01MatrInfoService t01MatrInfoService;

    private final T01MatrInfoExtService t01MatrInfoExtService;

    @Autowired
    public T01MatrInfoController(
            T01MatrInfoService t01MatrInfoService,
            T01MatrInfoExtService t01MatrInfoExtService) {
        Assert.notNull(t01MatrInfoService);
        Assert.notNull(t01MatrInfoExtService);
        this.t01MatrInfoService = t01MatrInfoService;
        this.t01MatrInfoExtService = t01MatrInfoExtService;
    }

    @ModelAttribute
    public T01MatrInfo get(@RequestParam(required = false) String id) {
        T01MatrInfo entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = t01MatrInfoService.get(id);
        }
        if (entity == null) {
            entity = new T01MatrInfo();
        }
        return entity;
    }

    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(
            @RequestParam(required = false) String conditionOrder,
            T01MatrInfo t01MatrInfo,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        //保存上次查询条件
        try {
            model.addAttribute("conditionOrder", conditionOrder);

            Page<T01MatrInfo> page = t01MatrInfoService.findPage(new Page<>(request, response), t01MatrInfo);
            model.addAttribute("page", page);
        } catch (Exception e) {
            logger.error("查询发生错误" + e.getMessage());
            model.addAttribute("message", getText("查询失败，请输入正确查询条件"));
        }
        return "modules/gsp/t01matrinfo/t01MatrInfoList";
    }

    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:edit")
    @RequestMapping(value = "form")
    public String form(
            T01MatrInfo t01MatrInfo,
            Model model,
            String view,
            RedirectAttributes redirectAttributes) {
        model.addAttribute("t01MatrInfo", t01MatrInfo);
        if (view != null && !view.isEmpty()) {
            return view;
        }
        if (StringUtils.isBlank(t01MatrInfo.getId())
                || ApprStatus.NOSUBMIT.toString().equals(t01MatrInfo.getApprStat())
                || ApprStatus.NOPASS.toString().equals(t01MatrInfo.getApprStat())) {
            return "modules/gsp/t01matrinfo/t01MatrInfoForm";
        } else {
            addMessage(redirectAttributes, i18nHelper.getText("只有未提交、审批未通过状态可进行修改，未审批及审批通过状态无法修改"));
            return "redirect:" + Global.getAdminPath()
                    + "/gsp/t01matrinfo/t01MatrInfo/toDetail?repage&id="
                    +t01MatrInfo.getId();
        }
    }

    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:edit")
    @RequestMapping(value = "save")
    public String save(
            @RequestParam(value = START_AUDIT, required = false) String startAudit,
            T01MatrInfo t01MatrInfo,
            Model model,
            RedirectAttributes redirectAttributes) {
        //当启动审批流程时进行Submit验证，未启动则进行Save验证
        if (!beanValidator(
                model,
                t01MatrInfo,
                START_AUDIT.equals(startAudit) ?
                        Submit.class :
                        Submit.class)) {
            return form(t01MatrInfo, model, null, redirectAttributes);
        }
        try {
            t01MatrInfo.setApprStat(ApprStatus.NOSUBMIT.toString());
            t01MatrInfoService.save(t01MatrInfo);
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(model, e.getMessage());
            if (t01MatrInfo.getIsNewRecord()) {
                t01MatrInfo.setId(null);
            }
            return form(t01MatrInfo, model, null, redirectAttributes);
        }
        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01MatrInfoExtService.startProcess(t01MatrInfo.getId(), t01MatrInfo.getAct().getTaskId());
            } catch (ConstraintViolationException cvExc) {//捕获验证异常
                String message = "";
                for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                    message +=violation.getMessage();
                }
                addMessage(model,getText("数据校验失败:"+message));
                return form(t01MatrInfo, model, null, redirectAttributes);
            } catch (Exception e) {
                addMessage(model, i18nHelper.getText("保存物料信息成功,但启动审批流程失败，请尝试重新提交！"));
                return form(t01MatrInfo, model, null, redirectAttributes);
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存物料信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/?repage";
        }
        addMessage(model, i18nHelper.getText("保存物料信息成功"));
        return form(t01MatrInfo, model, null, redirectAttributes);
    }

    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:edit")
    @RequestMapping(value = "delete")
    public String delete(T01MatrInfo t01MatrInfo, RedirectAttributes redirectAttributes) {
        try {
            t01MatrInfoService.delete(t01MatrInfo);
        } catch (BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, i18nHelper.getText("删除物料信息成功"));
        return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/?repage";
    }

}
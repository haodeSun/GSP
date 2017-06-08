/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01compaggr;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compaggr.T01CompAggrExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01compaggr.T01CompAggrHelperService;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplExtService;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

/**
 * 企业相关协议信息Controller
 *
 * @author XXS
 * @version 2016-12-05
 */
public class T01CompAggrController extends BaseController {
    /**
     * 启动审批流程标识
     */
    protected final String START_AUDIT = "startAudit";

    @SuppressWarnings("WeakerAccess")
    T01CompAggrExtService t01CompAggrService;

    @Autowired
    protected T01CompAggrHelperService t01CompAggrHelperService;

    /**
     * 购货者service
     */
    protected T01ComplBuyerExtService t01ComplBuyerExtService;
    /**
     * 供货者service
     */
    protected T01ComplSuplExtService t01ComplSuplExtService;
    @Autowired
    protected SystemService systemService;
    @Autowired
    public T01CompAggrController(
            T01CompAggrExtService t01CompAggrService,
            T01ComplBuyerExtService t01ComplBuyerExtService,
            T01ComplSuplExtService t01ComplSuplExtService) {
        Assert.notNull(t01CompAggrService);
        Assert.notNull(t01ComplBuyerExtService);
        Assert.notNull(t01ComplSuplExtService);
        this.t01CompAggrService = t01CompAggrService;
        this.t01ComplBuyerExtService = t01ComplBuyerExtService;
        this.t01ComplSuplExtService = t01ComplSuplExtService;
    }

    @ModelAttribute
    public T01CompAggr get(@RequestParam(required = false) String id) {
        T01CompAggr entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = t01CompAggrService.get(id);
        }
        if (entity == null) {
            entity = new T01CompAggr();
        }
        return entity;
    }

    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:view")
    @RequestMapping(value = {"list", ""})
    public String list(
            @RequestParam(required = false) String conditionOrder,
            T01CompAggr t01CompAggr,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01CompAggr> page = t01CompAggrService.findPage(new Page<>(request, response), t01CompAggr);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01compaggr/t01CompAggrList";
    }

    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:edit")
    @RequestMapping(value = "form")
    public String form(
            T01CompAggr t01CompAggr,
            Model model,
            String view,
            RedirectAttributes redirectAttributes) {

        model.addAttribute("certScopList",systemService.findAllCertScop());
        model.addAttribute("t01CompAggr", t01CompAggr);
        if (view != null && !view.isEmpty()) {
            return view;
        }
        if (StringUtils.isBlank(t01CompAggr.getId())
                || ApprStatus.NOSUBMIT.toString().equals(t01CompAggr.getApprStat())
                || ApprStatus.NOPASS.toString().equals(t01CompAggr.getApprStat())) {
            return "modules/gsp/t01compaggr/t01CompAggrForm";
        } else {
            addMessage(redirectAttributes, i18nHelper.getText("只有未提交、审批未通过状态可进行修改，未审批及审批通过状态无法修改"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/toDetail?id="
                    + t01CompAggr.getId();
        }
    }

    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:edit")
    @RequestMapping(value = "save")
    public String save(
            @RequestParam(value = START_AUDIT, required = false) String startAudit,
            T01CompAggr t01CompAggr,
            Model model,
            RedirectAttributes redirectAttributes) {
        boolean isNew = false;
        if (StringUtils.isBlank(t01CompAggr.getId())) {
            isNew = true;
        }

        try {
            BeanValidators.validateWithException(validator, t01CompAggr);
            t01CompAggr.setApprStat(ApprStatus.NOSUBMIT.toString());
            t01CompAggrService.save(t01CompAggr);
        } catch (BusinessException be) {
            model.addAttribute("message", be.getMessage());
            if(isNew){
                t01CompAggr.setId(StringUtils.EMPTY);
            }
            return form(t01CompAggr, model, null, redirectAttributes);
        } catch (ConstraintViolationException cvExc) {//捕获验证异常
            if(isNew){
                t01CompAggr.setId(StringUtils.EMPTY);
            }
            String message = "";
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                message += violation.getMessage() + "</br>";
            }
            addMessage(model, getText("数据校验失败:" + message));
            return form(t01CompAggr, model, null, redirectAttributes);
        } catch (Exception e) {
            if(isNew){
                t01CompAggr.setId(StringUtils.EMPTY);
            }
            logger.error(e.getMessage());
            addMessage(model,getText("保存失败，系统错误"));
            return form(t01CompAggr, model, null, redirectAttributes);
        }

        // 如果需要启动流程，则保持成功后再启动审批流程
        if (START_AUDIT.equals(startAudit)) {
            try {
                t01CompAggrService.startProcess(t01CompAggr.getId(), t01CompAggr.getAct().getTaskId());
            } catch (NullPointerException | ApprStatusException e1) {
                addMessage(redirectAttributes, i18nHelper.getText(e1.getMessage()));
                return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/form?id=" + t01CompAggr.getId();
            } catch (Exception e) {
                addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
                return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/form?id=" + t01CompAggr.getId();
            }
            addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/?repage";
        }

        addMessage(redirectAttributes, "保存企业相关协议信息成功");
        return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/form?id=" + t01CompAggr.getId();
    }

    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:delete")
    @RequestMapping(value = "delete")
    public String delete(
            T01CompAggr t01CompAggr,
            RedirectAttributes redirectAttributes) {
        String result;
        try {
            result = t01CompAggrService.deleteCompAggr(t01CompAggr);
        } catch (BusinessException | NullPointerException e1) {
            addMessage(redirectAttributes, getText(e1.getMessage()));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/toDelete?repage";
        } catch (Exception e2) {
            addMessage(redirectAttributes, "删除失败,系统错误");
            return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/toDelete?repage";
        }
        addMessage(redirectAttributes, getText(result));
        return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/toDelete?repage";
    }
    @ResponseBody
    @RequestMapping(value = "checkStatusBeforeHandle")
    public Object checkStatusBeforeHandle(
            @RequestParam String handle,
            T01CompAggr t01CompAggr) {

        String code;
        String message;
        int data = 0;
        try {
            t01CompAggrHelperService.checkStatusBeforeHandle(handle, t01CompAggr);
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
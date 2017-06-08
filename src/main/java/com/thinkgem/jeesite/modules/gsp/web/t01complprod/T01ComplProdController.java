/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01complprod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01complprod.T01ComplProdExtService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 首营产品Controller
 * @author XXS
 * @version 2016-12-06
 */
public class T01ComplProdController extends BaseController {
    /** 启动审批流程标识 */
	private final String START_AUDIT = "startAudit";

	@SuppressWarnings("WeakerAccess")
	T01ComplProdExtService t01ComplProdExtService;

	@Autowired
	public T01ComplProdController(T01ComplProdExtService t01ComplProdExtService) {
	    Assert.notNull(t01ComplProdExtService);
	    this.t01ComplProdExtService = t01ComplProdExtService;
	}
	
	@ModelAttribute
	public T01ComplProd get(@RequestParam(required=false) String id) {
		T01ComplProd entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01ComplProdExtService.get(id);
		}
		if (entity == null){
			entity = new T01ComplProd();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01complprod:t01ComplProd:view")
	@RequestMapping(value = {"list", ""})
	public String list(
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
		return "modules/gsp/t01complprod/t01ComplProdList";
	}

	@RequiresPermissions("gsp:t01complprod:t01ComplProd:edit")
	@RequestMapping(value = "form")
	public String form(
			T01ComplProd t01ComplProd,
			Model model,
			String view,
			RedirectAttributes redirectAttributes) {
		model.addAttribute("t01ComplProd", t01ComplProd);
		if(view != null && !view.isEmpty()){
			return view;
		}
		if (StringUtils.isBlank(t01ComplProd.getId())
				|| ApprStatus.NOSUBMIT.toString().equals(t01ComplProd.getApprStat())
				|| ApprStatus.NOPASS.toString().equals(t01ComplProd.getApprStat())) {
			return "modules/gsp/t01complprod/t01ComplProdForm";
		} else {
			addMessage(redirectAttributes, i18nHelper.getText("只有未提交、审批未通过状态可进行修改，未审批及审批通过状态无法修改"));
			return "redirect:" + Global.getAdminPath()
					+ "/gsp/t01complprod/t01ComplProd/toDetail?id="
					+t01ComplProd.getId();
		}
	}

	@RequiresPermissions("gsp:t01complprod:t01ComplProd:edit")
	@RequestMapping(value = "save")
	public String save(
			@RequestParam(value = START_AUDIT, required = false) String startAudit,
			@RequestParam(required = false) String prodCertIds,
            T01ComplProd t01ComplProd,
            Model model,
            RedirectAttributes redirectAttributes) {
		boolean isNew = false;
		if (StringUtils.isBlank(t01ComplProd.getId())) {
			isNew = true;
		}

		if (!beanValidator(model, t01ComplProd)) {
			return form(t01ComplProd, model, null, redirectAttributes);
		}
		//设置关联的资质id列表
		if (StringUtils.isNotBlank(prodCertIds)) {
			t01ComplProd.setProdCertIdList(Arrays.asList(prodCertIds.split(",")));
		}

		try{
			t01ComplProd.setApprStat(ApprStatus.NOSUBMIT.toString());
			t01ComplProdExtService.save(t01ComplProd);
		}catch (BusinessException busExp){
			if(isNew){
				t01ComplProd.setId(StringUtils.EMPTY);
			}
			addMessage(model,  i18nHelper.getText(busExp.getMessage()));
			return form(t01ComplProd, model, null,redirectAttributes);
		}catch (Exception e) {
			if(isNew){
				t01ComplProd.setId(StringUtils.EMPTY);
			}
			logger.error(e.getMessage());
			addMessage(model,  i18nHelper.getText("保存失败：请稍后再试"));
			return form(t01ComplProd, model, null,redirectAttributes);
		}

		// 如果需要启动流程，则保持成功后再启动审批流程
		if (START_AUDIT.equals(startAudit)) {
			try {
				t01ComplProdExtService.startProcess(t01ComplProd.getId(), t01ComplProd.getAct().getTaskId());
			} catch (ConstraintViolationException cvExc) {//捕获验证异常
				List<String> list = new ArrayList<>();
				for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
					list.add(violation.getMessage());
				}
				list.add(0, "保存信息成功,但启动审批流程失败，提交审批前请完善必填信息：");
				addMessage(model, list.toArray(new String[]{}));
				return form(t01ComplProd, model, null, redirectAttributes);
			} catch (NullPointerException | ApprStatusException e1) {
				addMessage(model, i18nHelper.getText(e1.getMessage()));
				return form(t01ComplProd, model, null, redirectAttributes);
			} catch (Exception e) {
				addMessage(model, i18nHelper.getText("保存信息成功,但启动审批流程失败，请尝试重新提交！"));
				return form(t01ComplProd, model, null, redirectAttributes);
			}
			addMessage(redirectAttributes, i18nHelper.getText("保存信息成功,并成功启动审批流程"));
			return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/?repage";
		}
		addMessage(redirectAttributes, i18nHelper.getText("保存首营产品成功"));
		return "redirect:" + Global.getAdminPath() + "/gsp/t01complprod/t01ComplProd/form?id="+t01ComplProd.getId();
	}
	
	@RequiresPermissions("gsp:t01complprod:t01ComplProd:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T01ComplProd t01ComplProd,
            RedirectAttributes redirectAttributes) {
		try {
			t01ComplProdExtService.delete(t01ComplProd);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes,  i18nHelper.getText("删除首营产品成功"));
		return "redirect:"+Global.getAdminPath()+"/gsp/t01complprod/t01ComplProd/?repage";
	}

}
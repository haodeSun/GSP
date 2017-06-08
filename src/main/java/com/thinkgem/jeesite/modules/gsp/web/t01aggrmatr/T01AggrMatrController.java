/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01aggrmatr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;
import com.thinkgem.jeesite.modules.gsp.service.t01aggrmatr.T01AggrMatrService;

/**
 * 协议与物料的关联信息Controller
 * @author XXS
 * @version 2016-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01aggrmatr/t01AggrMatr")
public class T01AggrMatrController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T01AggrMatrService t01AggrMatrService;

	@Autowired
	public T01AggrMatrController(T01AggrMatrService t01AggrMatrService) {
	    Assert.notNull(t01AggrMatrService);
	    this.t01AggrMatrService = t01AggrMatrService;
	}
	
	@ModelAttribute
	public T01AggrMatr get(@RequestParam(required=false) String id) {
		T01AggrMatr entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01AggrMatrService.get(id);
		}
		if (entity == null){
			entity = new T01AggrMatr();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01aggrmatr:t01AggrMatr:view")
	@RequestMapping(value = {"list", ""})
	public String list(
		@RequestParam(required = false) String conditionOrder,
		T01AggrMatr t01AggrMatr,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model) {
		Page<T01AggrMatr> page = t01AggrMatrService.findPage(new Page<>(request, response), t01AggrMatr);
		model.addAttribute("page", page);
		//保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
		return "modules/gsp/t01aggrmatr/t01AggrMatrList";
	}

	@RequiresPermissions("gsp:t01aggrmatr:t01AggrMatr:view")
	@RequestMapping(value = "form")
	public String form(T01AggrMatr t01AggrMatr, Model model, String view) {
		model.addAttribute("t01AggrMatr", t01AggrMatr);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t01aggrmatr/t01AggrMatrForm";
	}

	@RequiresPermissions("gsp:t01aggrmatr:t01AggrMatr:edit")
	@RequestMapping(value = "save")
	public String save(
            T01AggrMatr t01AggrMatr,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01AggrMatr)){
			return form(t01AggrMatr, model, null);
		}
		try{
		    t01AggrMatrService.save(t01AggrMatr);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t01AggrMatr, model, null);
		}
		addMessage(redirectAttributes, "保存协议与物料的关联信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01aggrmatr/t01AggrMatr/?repage";
	}
	
	@RequiresPermissions("gsp:t01aggrmatr:t01AggrMatr:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T01AggrMatr t01AggrMatr,
            RedirectAttributes redirectAttributes) {
		try {
			t01AggrMatrService.delete(t01AggrMatr);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除协议与物料的关联信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01aggrmatr/t01AggrMatr/?repage";
	}

}
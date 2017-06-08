/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02sales;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02sales.T02Sales;
import com.thinkgem.jeesite.modules.gsp.service.t02sales.T02SalesService;

/**
 * 售出信息Controller
 * @author yohu
 * @version 2016-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02sales/t02Sales")
public class T02SalesController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T02SalesService t02SalesService;

	@Autowired
	public T02SalesController(T02SalesService t02SalesService) {
	    Assert.notNull(t02SalesService);
	    this.t02SalesService = t02SalesService;
	}
	
	@ModelAttribute
	public T02Sales get(@RequestParam(required=false) String id) {
		T02Sales entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02SalesService.get(id);
		}
		if (entity == null){
			entity = new T02Sales();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02sales:t02Sales:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Sales t02Sales, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Sales> page = t02SalesService.findPage(new Page<>(request, response), t02Sales);
		model.addAttribute("page", page);
		return "modules/gsp/t02sales/t02SalesList";
	}

	@RequiresPermissions("gsp:t02sales:t02Sales:view")
	@RequestMapping(value = "form")
	public String form(T02Sales t02Sales, Model model, String view) {
		model.addAttribute("t02Sales", t02Sales);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t02sales/t02SalesForm";
	}

//	@RequiresPermissions("gsp:t02sales:t02Sales:edit")
	@RequestMapping(value = "save")
	public String save(
            T02Sales t02Sales,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Sales)){
			return form(t02Sales, model, null);
		}
		try{
		    t02SalesService.save(t02Sales);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t02Sales, model, null);
		}
		addMessage(redirectAttributes, "保存售出信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02sales/t02Sales/?repage";
	}
	
	@RequiresPermissions("gsp:t02sales:t02Sales:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T02Sales t02Sales,
            RedirectAttributes redirectAttributes) {
		try {
			t02SalesService.delete(t02Sales);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除售出信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02sales/t02Sales/?repage";
	}

}
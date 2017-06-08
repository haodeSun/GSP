/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02stockin;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;
import com.thinkgem.jeesite.modules.gsp.service.t02stockin.T02StockinService;

/**
 * 入库Controller
 * @author yohu
 * @version 2016-11-24
 */
public class T02StockinController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T02StockinService t02StockinService;

	@Autowired
	public T02StockinController(T02StockinService t02StockinService) {
	    Assert.notNull(t02StockinService);
	    this.t02StockinService = t02StockinService;
	}
	
	@ModelAttribute
	public T02Stockin get(@RequestParam(required=false) String id) {
		T02Stockin entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02StockinService.get(id);
		}
		if (entity == null){
			entity = new T02Stockin();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02stockin:t02Stockin:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Stockin t02Stockin, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Stockin> page = t02StockinService.findPage(new Page<>(request, response), t02Stockin);
		model.addAttribute("page", page);
		return "modules/gsp/t02stockin/t02StockinList";
	}

	@RequiresPermissions("gsp:t02stockin:t02Stockin:view")
	@RequestMapping(value = "form")
	public String form(T02Stockin t02Stockin, Model model, String view) {
		model.addAttribute("t02Stockin", t02Stockin);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t02stockin/t02StockinForm";
	}

//	@RequiresPermissions("gsp:t02stockin:t02Stockin:edit")
	@RequestMapping(value = "save")
	public String save(
            T02Stockin t02Stockin,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Stockin)){
			return form(t02Stockin, model, null);
		}
		try{
		    t02StockinService.save(t02Stockin);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t02Stockin, model, null);
		}
		addMessage(redirectAttributes, "保存入库信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stockin/t02Stockin/?repage";
	}
	
	@RequiresPermissions("gsp:t02stockin:t02Stockin:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T02Stockin t02Stockin,
            RedirectAttributes redirectAttributes) {
		try {
			t02StockinService.delete(t02Stockin);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除入库信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stockin/t02Stockin/?repage";
	}

}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02stockout;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02stockout.T02Stockout;
import com.thinkgem.jeesite.modules.gsp.service.t02stockout.T02StockoutService;

/**
 * 出库信息Controller
 * @author yohu
 * @version 2016-11-25
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02stockout/t02Stockout")
public class T02StockoutController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T02StockoutService t02StockoutService;

	@Autowired
	public T02StockoutController(T02StockoutService t02StockoutService) {
	    Assert.notNull(t02StockoutService);
	    this.t02StockoutService = t02StockoutService;
	}
	
	@ModelAttribute
	public T02Stockout get(@RequestParam(required=false) String id) {
		T02Stockout entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02StockoutService.get(id);
		}
		if (entity == null){
			entity = new T02Stockout();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02stockout:t02Stockout:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Stockout t02Stockout, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Stockout> page = t02StockoutService.findPage(new Page<>(request, response), t02Stockout);
		model.addAttribute("page", page);
		return "modules/gsp/t02stockout/t02StockoutList";
	}

	@RequiresPermissions("gsp:t02stockout:t02Stockout:view")
	@RequestMapping(value = "form")
	public String form(T02Stockout t02Stockout, Model model, String view) {
		model.addAttribute("t02Stockout", t02Stockout);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t02stockout/t02StockoutForm";
	}

//	@RequiresPermissions("gsp:t02stockout:t02Stockout:edit")
	@RequestMapping(value = "save")
	public String save(
            T02Stockout t02Stockout,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Stockout)){
			return form(t02Stockout, model, null);
		}
		try{
		    t02StockoutService.save(t02Stockout);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t02Stockout, model, null);
		}
		addMessage(redirectAttributes, "保存出库信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stockout/t02Stockout/?repage";
	}
	
	@RequiresPermissions("gsp:t02stockout:t02Stockout:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T02Stockout t02Stockout,
            RedirectAttributes redirectAttributes) {
		t02StockoutService.delete(t02Stockout);
		addMessage(redirectAttributes, "删除出库信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stockout/t02Stockout/?repage";
	}

}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gsp.entity.t02purchase.T02Purchase;
import com.thinkgem.jeesite.modules.gsp.service.t02purchase.T02PurchaseService;

/**
 * 采购Controller
 * @author yohu
 * @version 2016-11-16
 */
public class T02PurchaseController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T02PurchaseService t02PurchaseService;

	@Autowired
	public T02PurchaseController(T02PurchaseService t02PurchaseService) {
	    Assert.notNull(t02PurchaseService);
	    this.t02PurchaseService = t02PurchaseService;
	}
	
	@ModelAttribute
	public T02Purchase get(@RequestParam(required=false) String id) {
		T02Purchase entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02PurchaseService.get(id);
		}
		if (entity == null){
			entity = new T02Purchase();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02purchase:t02Purchase:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Purchase t02Purchase, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Purchase> page = t02PurchaseService.findPage(new Page<>(request, response), t02Purchase);
		model.addAttribute("page", page);
		return "modules/gsp/t02purchase/t02PurchaseList";
	}

	@RequiresPermissions("gsp:t02purchase:t02Purchase:view")
	@RequestMapping(value = "form")
	public String form(T02Purchase t02Purchase, Model model, String view) {
		model.addAttribute("t02Purchase", t02Purchase);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t02purchase/t02PurchaseForm";
	}

//	@RequiresPermissions("gsp:t02purchase:t02Purchase:edit")
	@RequestMapping(value = "save")
	public String save(
            T02Purchase t02Purchase,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Purchase)){
			return form(t02Purchase, model, null);
		}
		try{
		    t02PurchaseService.save(t02Purchase);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t02Purchase, model, null);
		}
		addMessage(redirectAttributes, "保存采购信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02purchase/t02Purchase/?repage";
	}
	
	@RequiresPermissions("gsp:t02purchase:t02Purchase:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T02Purchase t02Purchase,
            RedirectAttributes redirectAttributes) {
		try {
			t02PurchaseService.delete(t02Purchase);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除采购信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02purchase/t02Purchase/?repage";
	}

}
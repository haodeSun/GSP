/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01compinfo;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
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

/**
 * 企业信息Controller
 * @author XXS
 * @version 2016-12-05
 */
public class T01CompInfoController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T01CompInfoService t01CompInfoService;

	@Autowired
	public T01CompInfoController(T01CompInfoService t01CompInfoService) {
	    Assert.notNull(t01CompInfoService);
	    this.t01CompInfoService = t01CompInfoService;
	}
	
	@ModelAttribute
	public T01CompInfo get(@RequestParam(required=false) String id) {
		T01CompInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01CompInfoService.get(id);
		}
		if (entity == null){
			entity = new T01CompInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01compinfo:t01CompInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(
		@RequestParam(required = false) String conditionOrder,
		T01CompInfo t01CompInfo,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model) {
		Page<T01CompInfo> page = t01CompInfoService.findPage(new Page<>(request, response), t01CompInfo);
		model.addAttribute("page", page);
		//保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
		return "modules/gsp/t01compinfo/t01CompInfoList";
	}

	@RequiresPermissions("gsp:t01compinfo:t01CompInfo:view")
	@RequestMapping(value = "form")
	public String form(T01CompInfo t01CompInfo, Model model, String view) {
		model.addAttribute("t01CompInfo", t01CompInfo);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t01compinfo/t01CompInfoForm";
	}

	@RequiresPermissions("gsp:t01compinfo:t01CompInfo:edit")
	@RequestMapping(value = "save")
	public String save(
            T01CompInfo t01CompInfo,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01CompInfo)){
			return form(t01CompInfo, model, null);
		}
		try{
		    t01CompInfoService.save(t01CompInfo);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t01CompInfo, model, null);
		}
		addMessage(redirectAttributes, "保存企业信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01compinfo/t01CompInfo/?repage";
	}
	
	@RequiresPermissions("gsp:t01compinfo:t01CompInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T01CompInfo t01CompInfo,
            RedirectAttributes redirectAttributes) {
		t01CompInfoService.delete(t01CompInfo);
		addMessage(redirectAttributes, "删除企业信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01compinfo/t01CompInfo/?repage";
	}

}
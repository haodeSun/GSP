/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

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
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
import com.thinkgem.jeesite.modules.sys.service.SysConfigService;

/**
 * 保存系统配置Controller
 * @author yohu
 * @version 2016-12-16
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysConfig")
public class SysConfigController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	SysConfigService sysConfigService;

	@Autowired
	public SysConfigController(SysConfigService sysConfigService) {
	    Assert.notNull(sysConfigService);
	    this.sysConfigService = sysConfigService;
	}
	
	@ModelAttribute
	public SysConfig get(@RequestParam(required=false) String id) {
		SysConfig entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysConfigService.get(id);
		}
		if (entity == null){
			entity = new SysConfig();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysConfig:view")
	@RequestMapping(value = {"list", ""})
	public String list(
		@RequestParam(required = false) String conditionOrder,
		SysConfig sysConfig,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model) {
		Page<SysConfig> page = sysConfigService.findPage(new Page<>(request, response), sysConfig);
		model.addAttribute("page", page);
		//保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
		return "modules/sys/sysConfigList";
	}

	@RequiresPermissions("sys:sysConfig:view")
	@RequestMapping(value = "form")
	public String form(SysConfig sysConfig, Model model, String view) {
		model.addAttribute("sysConfig", sysConfig);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/sys/sysConfigForm";
	}

	@RequiresPermissions("sys:sysConfig:edit")
	@RequestMapping(value = "save")
	public String save(
            SysConfig sysConfig,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysConfig)){
			return form(sysConfig, model, null);
		}
		try{
		    sysConfigService.save(sysConfig);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(sysConfig, model, null);
		}
		addMessage(redirectAttributes, "保存系统配置表成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysConfig/?repage";
	}
	
	@RequiresPermissions("sys:sysConfig:edit")
	@RequestMapping(value = "delete")
	public String delete(
            SysConfig sysConfig,
            RedirectAttributes redirectAttributes) {
		try {
			sysConfigService.delete(sysConfig);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除系统配置表成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysConfig/?repage";
	}

}
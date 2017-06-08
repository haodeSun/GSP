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
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmFilterService;

/**
 * 预警过滤配置Controller
 * @author yohu
 * @version 2016-12-26
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysAlarmFilter")
public class SysAlarmFilterController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	SysAlarmFilterService sysAlarmFilterService;

	@Autowired
	public SysAlarmFilterController(SysAlarmFilterService sysAlarmFilterService) {
	    Assert.notNull(sysAlarmFilterService);
	    this.sysAlarmFilterService = sysAlarmFilterService;
	}
	
	@ModelAttribute
	public SysAlarmFilter get(@RequestParam(required=false) String id) {
		SysAlarmFilter entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysAlarmFilterService.get(id);
		}
		if (entity == null){
			entity = new SysAlarmFilter();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysAlarmFilter:view")
	@RequestMapping(value = {"list", ""})
	public String list(
		@RequestParam(required = false) String conditionOrder,
		SysAlarmFilter sysAlarmFilter,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model) {
		Page<SysAlarmFilter> page = sysAlarmFilterService.findPage(new Page<>(request, response), sysAlarmFilter);
		model.addAttribute("page", page);
		//保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
		return "modules/sys/sysAlarmFilterList";
	}

	@RequiresPermissions("sys:sysAlarmFilter:view")
	@RequestMapping(value = "form")
	public String form(SysAlarmFilter sysAlarmFilter, Model model, String view) {
		model.addAttribute("sysAlarmFilter", sysAlarmFilter);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/sys/sysAlarmFilterForm";
	}

	@RequiresPermissions("sys:sysAlarmFilter:edit")
	@RequestMapping(value = "save")
	public String save(
            SysAlarmFilter sysAlarmFilter,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysAlarmFilter)){
			return form(sysAlarmFilter, model, null);
		}
		try{
		    sysAlarmFilterService.save(sysAlarmFilter);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(sysAlarmFilter, model, null);
		}
		addMessage(redirectAttributes, "保存预警过滤配置成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysAlarmFilter/?repage";
	}
	
	@RequiresPermissions("sys:sysAlarmFilter:edit")
	@RequestMapping(value = "delete")
	public String delete(
            SysAlarmFilter sysAlarmFilter,
            RedirectAttributes redirectAttributes) {
		try {
			sysAlarmFilterService.delete(sysAlarmFilter);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除预警过滤配置成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysAlarmFilter/?repage";
	}

}
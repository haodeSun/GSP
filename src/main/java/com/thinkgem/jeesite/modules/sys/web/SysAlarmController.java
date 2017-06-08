/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

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
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmFilterService;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmService;

/**
 * 预警配置表Controller
 * @author yohu
 * @version 2016-12-21
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysAlarm")
public class SysAlarmController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	SysAlarmService sysAlarmService;

	@Autowired
	SysAlarmFilterService sysAlarmFilterService;
	@Autowired
	public SysAlarmController(SysAlarmService sysAlarmService) {
	    Assert.notNull(sysAlarmService);
	    this.sysAlarmService = sysAlarmService;
	}
	
	@ModelAttribute
	public SysAlarm get(@RequestParam(required=false) String id) {
		SysAlarm entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysAlarmService.get(id);
		}
		if (entity == null){
			entity = new SysAlarm();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysAlarm:view")
	@RequestMapping(value = {"list", ""})
	public String list(
		@RequestParam(required = false) String conditionOrder,
		SysAlarm sysAlarm,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model) {
		Page<SysAlarm> page = sysAlarmService.findPage(new Page<>(request, response), sysAlarm);
		model.addAttribute("page", page);
		//保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
		return "modules/sys/sysAlarmList";
	}

	@RequiresPermissions("sys:sysAlarm:view")
	@RequestMapping(value = "form")
	public String form(SysAlarm sysAlarm, Model model, String view) {
		model.addAttribute("sysAlarm", sysAlarm);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/sys/sysAlarmForm";
	}

	@RequiresPermissions("sys:sysAlarm:edit")
	@RequestMapping(value = "save")
	public String save(
            SysAlarm sysAlarm,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysAlarm)){
			return form(sysAlarm, model, null);
		}
		try{
		    sysAlarmService.save(sysAlarm);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(sysAlarm, model, null);
		}
		addMessage(redirectAttributes, "保存预警信息成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysAlarm/?repage";
	}
	
	@RequiresPermissions("sys:sysAlarm:edit")
	@RequestMapping(value = "delete")
	public String delete(
            SysAlarm sysAlarm,
            RedirectAttributes redirectAttributes) {
		try {
			sysAlarmService.delete(sysAlarm);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除预警信息成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysAlarm/?repage";
	}
	@RequiresPermissions("sys:sysAlarm:edit")
	@RequestMapping(value = "reject")
	public String reject(
            SysAlarm sysAlarm,
            Model model,
            RedirectAttributes redirectAttributes) throws BusinessException {
		try{
			SysAlarmFilter sysAlarmFilter = new SysAlarmFilter();
			sysAlarmFilter.setRole("sysAlarm:"+sysAlarm.getId());
			sysAlarmFilter.setIncluded(false);
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
			return form(sysAlarm, model, null);
		}
		addMessage(redirectAttributes, "更新预警状态成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysAlarm/?repage";
	}
}
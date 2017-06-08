/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02reviewhistory;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02reviewhistory.T02ReviewHistory;
import com.thinkgem.jeesite.modules.gsp.service.t02reviewhistory.T02ReviewHistoryService;

/**
 * 审核记录Controller
 * @author yohu
 * @version 2016-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02reviewhistory/t02ReviewHistory")
public class T02ReviewHistoryController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T02ReviewHistoryService t02ReviewHistoryService;

	@Autowired
	public T02ReviewHistoryController(T02ReviewHistoryService t02ReviewHistoryService) {
	    Assert.notNull(t02ReviewHistoryService);
	    this.t02ReviewHistoryService = t02ReviewHistoryService;
	}
	
	@ModelAttribute
	public T02ReviewHistory get(@RequestParam(required=false) String id) {
		T02ReviewHistory entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02ReviewHistoryService.get(id);
		}
		if (entity == null){
			entity = new T02ReviewHistory();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02reviewhistory:t02ReviewHistory:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02ReviewHistory t02ReviewHistory, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02ReviewHistory> page = t02ReviewHistoryService.findPage(new Page<>(request, response), t02ReviewHistory);
		model.addAttribute("page", page);
		return "modules/gsp/t02reviewhistory/t02ReviewHistoryList";
	}

	@RequiresPermissions("gsp:t02reviewhistory:t02ReviewHistory:view")
	@RequestMapping(value = "form")
	public String form(T02ReviewHistory t02ReviewHistory, Model model, String view) {
		model.addAttribute("t02ReviewHistory", t02ReviewHistory);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t02reviewhistory/t02ReviewHistoryForm";
	}

	@RequiresPermissions("gsp:t02reviewhistory:t02ReviewHistory:edit")
	@RequestMapping(value = "save")
	public String save(
            T02ReviewHistory t02ReviewHistory,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02ReviewHistory)){
			return form(t02ReviewHistory, model, null);
		}
		try{
		    t02ReviewHistoryService.save(t02ReviewHistory);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t02ReviewHistory, model, null);
		}
		addMessage(redirectAttributes, "保存审核记录成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02reviewhistory/t02ReviewHistory/?repage";
	}
	
	@RequiresPermissions("gsp:t02reviewhistory:t02ReviewHistory:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T02ReviewHistory t02ReviewHistory,
            RedirectAttributes redirectAttributes) {
		try {
			t02ReviewHistoryService.delete(t02ReviewHistory);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除审核记录成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02reviewhistory/t02ReviewHistory/?repage";
	}

}
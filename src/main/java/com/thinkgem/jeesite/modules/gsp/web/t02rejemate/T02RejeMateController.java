/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02rejemate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.entity.t02rejemate.T02RejeMate;
import com.thinkgem.jeesite.modules.gsp.service.t02rejemate.T02RejeMateService;

/**
 * 退回-物料信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02rejemate/t02RejeMate")
public class T02RejeMateController extends BaseController {

	@Autowired
	private T02RejeMateService t02RejeMateService;
	
	@ModelAttribute
	public T02RejeMate get(@RequestParam(required=false) String id) {
		T02RejeMate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02RejeMateService.get(id);
		}
		if (entity == null){
			entity = new T02RejeMate();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02rejemate:t02RejeMate:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02RejeMate t02RejeMate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02RejeMate> page = t02RejeMateService.findPage(new Page<>(request, response), t02RejeMate);
		model.addAttribute("page", page);
		return "modules/gsp/t02rejemate/t02RejeMateList";
	}

	@RequiresPermissions("gsp:t02rejemate:t02RejeMate:view")
	@RequestMapping(value = "form")
	public String form(T02RejeMate t02RejeMate, Model model) {
		model.addAttribute("t02RejeMate", t02RejeMate);
		return "modules/gsp/t02rejemate/t02RejeMateForm";
	}

	@RequiresPermissions("gsp:t02rejemate:t02RejeMate:edit")
	@RequestMapping(value = "save")
	public String save(T02RejeMate t02RejeMate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02RejeMate)){
			return form(t02RejeMate, model);
		}
        try {
            t02RejeMateService.save(t02RejeMate);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存退回-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02rejemate/t02RejeMate/?repage";
	}
	
	@RequiresPermissions("gsp:t02rejemate:t02RejeMate:edit")
	@RequestMapping(value = "delete")
	public String delete(T02RejeMate t02RejeMate, RedirectAttributes redirectAttributes) {
		try {
			t02RejeMateService.delete(t02RejeMate);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除退回-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02rejemate/t02RejeMate/?repage";
	}

}
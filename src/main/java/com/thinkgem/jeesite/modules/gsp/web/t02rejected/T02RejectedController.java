/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02rejected;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02rejected.T02Rejected;
import com.thinkgem.jeesite.modules.gsp.service.t02rejected.T02RejectedService;

/**
 * 退回信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02rejected/t02Rejected")
public class T02RejectedController extends BaseController {

	@Autowired
	private T02RejectedService t02RejectedService;
	
	@ModelAttribute
	public T02Rejected get(@RequestParam(required=false) String id) {
		T02Rejected entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02RejectedService.get(id);
		}
		if (entity == null){
			entity = new T02Rejected();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02rejected:t02Rejected:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Rejected t02Rejected, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Rejected> page = t02RejectedService.findPage(new Page<>(request, response), t02Rejected);
		model.addAttribute("page", page);
		return "modules/gsp/t02rejected/t02RejectedList";
	}

	@RequiresPermissions("gsp:t02rejected:t02Rejected:view")
	@RequestMapping(value = "form")
	public String form(T02Rejected t02Rejected, Model model) {
		model.addAttribute("t02Rejected", t02Rejected);
		return "modules/gsp/t02rejected/t02RejectedForm";
	}

	@RequiresPermissions("gsp:t02rejected:t02Rejected:edit")
	@RequestMapping(value = "save")
	public String save(T02Rejected t02Rejected, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Rejected)){
			return form(t02Rejected, model);
		}
        try {
            t02RejectedService.save(t02Rejected);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存退回信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02rejected/t02Rejected/?repage";
	}
	
	@RequiresPermissions("gsp:t02rejected:t02Rejected:edit")
	@RequestMapping(value = "delete")
	public String delete(T02Rejected t02Rejected, RedirectAttributes redirectAttributes) {
		try {
			t02RejectedService.delete(t02Rejected);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除退回信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02rejected/t02Rejected/?repage";
	}

}
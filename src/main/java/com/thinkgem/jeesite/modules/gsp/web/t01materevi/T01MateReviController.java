/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01materevi;

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
import com.thinkgem.jeesite.modules.gsp.entity.t01materevi.T01MateRevi;
import com.thinkgem.jeesite.modules.gsp.service.t01materevi.T01MateReviService;

/**
 * 首营审核Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01materevi/t01MateRevi")
public class T01MateReviController extends BaseController {

	@Autowired
	private T01MateReviService t01MateReviService;
	
	@ModelAttribute
	public T01MateRevi get(@RequestParam(required=false) String id) {
		T01MateRevi entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01MateReviService.get(id);
		}
		if (entity == null){
			entity = new T01MateRevi();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01materevi:t01MateRevi:view")
	@RequestMapping(value = {"list", ""})
	public String list(T01MateRevi t01MateRevi, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T01MateRevi> page = t01MateReviService.findPage(new Page<>(request, response), t01MateRevi);
		model.addAttribute("page", page);
		return "modules/gsp/t01materevi/t01MateReviList";
	}

	@RequiresPermissions("gsp:t01materevi:t01MateRevi:view")
	@RequestMapping(value = "form")
	public String form(T01MateRevi t01MateRevi, Model model) {
		model.addAttribute("t01MateRevi", t01MateRevi);
		return "modules/gsp/t01materevi/t01MateReviForm";
	}

	@RequiresPermissions("gsp:t01materevi:t01MateRevi:edit")
	@RequestMapping(value = "save")
	public String save(T01MateRevi t01MateRevi, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01MateRevi)){
			return form(t01MateRevi, model);
		}
        try {
            t01MateReviService.save(t01MateRevi);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存首营审核成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01materevi/t01MateRevi/?repage";
	}
	
	@RequiresPermissions("gsp:t01materevi:t01MateRevi:edit")
	@RequestMapping(value = "delete")
	public String delete(T01MateRevi t01MateRevi, RedirectAttributes redirectAttributes) {
		try {
			t01MateReviService.delete(t01MateRevi);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除首营审核成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01materevi/t01MateRevi/?repage";
	}

}
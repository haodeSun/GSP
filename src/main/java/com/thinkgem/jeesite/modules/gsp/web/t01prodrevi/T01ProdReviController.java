/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01prodrevi;

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
import com.thinkgem.jeesite.modules.gsp.entity.t01prodrevi.T01ProdRevi;
import com.thinkgem.jeesite.modules.gsp.service.t01prodrevi.T01ProdReviService;

/**
 * 产品审核Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01prodrevi/t01ProdRevi")
public class T01ProdReviController extends BaseController {

	@Autowired
	private T01ProdReviService t01ProdReviService;
	
	@ModelAttribute
	public T01ProdRevi get(@RequestParam(required=false) String id) {
		T01ProdRevi entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01ProdReviService.get(id);
		}
		if (entity == null){
			entity = new T01ProdRevi();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01prodrevi:t01ProdRevi:view")
	@RequestMapping(value = {"list", ""})
	public String list(T01ProdRevi t01ProdRevi, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T01ProdRevi> page = t01ProdReviService.findPage(new Page<>(request, response), t01ProdRevi);
		model.addAttribute("page", page);
		return "modules/gsp/t01prodrevi/t01ProdReviList";
	}

	@RequiresPermissions("gsp:t01prodrevi:t01ProdRevi:view")
	@RequestMapping(value = "form")
	public String form(T01ProdRevi t01ProdRevi, Model model) {
		model.addAttribute("t01ProdRevi", t01ProdRevi);
		return "modules/gsp/t01prodrevi/t01ProdReviForm";
	}

	@RequiresPermissions("gsp:t01prodrevi:t01ProdRevi:edit")
	@RequestMapping(value = "save")
	public String save(T01ProdRevi t01ProdRevi, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01ProdRevi)){
			return form(t01ProdRevi, model);
		}
        try {
            t01ProdReviService.save(t01ProdRevi);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存产品审核成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01prodrevi/t01ProdRevi/?repage";
	}
	
	@RequiresPermissions("gsp:t01prodrevi:t01ProdRevi:edit")
	@RequestMapping(value = "delete")
	public String delete(T01ProdRevi t01ProdRevi, RedirectAttributes redirectAttributes) {
		try {
			t01ProdReviService.delete(t01ProdRevi);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除产品审核成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01prodrevi/t01ProdRevi/?repage";
	}

}
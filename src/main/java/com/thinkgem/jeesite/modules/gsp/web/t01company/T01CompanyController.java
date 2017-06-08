/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01company;

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
import com.thinkgem.jeesite.modules.gsp.entity.t01company.T01Company;
import com.thinkgem.jeesite.modules.gsp.service.t01company.T01CompanyService;

/**
 * 企业信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01company/t01Company")
public class T01CompanyController extends BaseController {

	@Autowired
	private T01CompanyService t01CompanyService;
	
	@ModelAttribute
	public T01Company get(@RequestParam(required=false) String id) {
		T01Company entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01CompanyService.get(id);
		}
		if (entity == null){
			entity = new T01Company();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01company:t01Company:view")
	@RequestMapping(value = {"list", ""})
	public String list(T01Company t01Company, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T01Company> page = t01CompanyService.findPage(new Page<>(request, response), t01Company);
		model.addAttribute("page", page);
		return "modules/gsp/t01company/t01CompanyList";
	}

	@RequiresPermissions("gsp:t01company:t01Company:view")
	@RequestMapping(value = "form")
	public String form(T01Company t01Company, Model model) {
		model.addAttribute("t01Company", t01Company);
		return "modules/gsp/t01company/t01CompanyForm";
	}

	@RequiresPermissions("gsp:t01company:t01Company:edit")
	@RequestMapping(value = "save")
	public String save(T01Company t01Company, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01Company)){
			return form(t01Company, model);
		}
        try {
            t01CompanyService.save(t01Company);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存企业信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01company/t01Company/?repage";
	}
	
	@RequiresPermissions("gsp:t01company:t01Company:edit")
	@RequestMapping(value = "delete")
	public String delete(T01Company t01Company, RedirectAttributes redirectAttributes) {
		try {
			t01CompanyService.delete(t01Company);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除企业信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01company/t01Company/?repage";
	}

}
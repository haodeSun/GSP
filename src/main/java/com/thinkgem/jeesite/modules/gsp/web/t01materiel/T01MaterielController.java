/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01materiel;

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
import com.thinkgem.jeesite.modules.gsp.entity.t01materiel.T01Materiel;
import com.thinkgem.jeesite.modules.gsp.service.t01materiel.T01MaterielService;

/**
 * 物料信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01materiel/t01Materiel")
public class T01MaterielController extends BaseController {

	@Autowired
	private T01MaterielService t01MaterielService;
	
	@ModelAttribute
	public T01Materiel get(@RequestParam(required=false) String id) {
		T01Materiel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01MaterielService.get(id);
		}
		if (entity == null){
			entity = new T01Materiel();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01materiel:t01Materiel:view")
	@RequestMapping(value = {"list", ""})
	public String list(T01Materiel t01Materiel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T01Materiel> page = t01MaterielService.findPage(new Page<>(request, response), t01Materiel);
		model.addAttribute("page", page);
		return "modules/gsp/t01materiel/t01MaterielList";
	}

	@RequiresPermissions("gsp:t01materiel:t01Materiel:view")
	@RequestMapping(value = "form")
	public String form(T01Materiel t01Materiel, Model model) {
		model.addAttribute("t01Materiel", t01Materiel);
		return "modules/gsp/t01materiel/t01MaterielForm";
	}

	@RequiresPermissions("gsp:t01materiel:t01Materiel:edit")
	@RequestMapping(value = "save")
	public String save(T01Materiel t01Materiel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01Materiel)){
			return form(t01Materiel, model);
		}
        try {
            t01MaterielService.save(t01Materiel);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01materiel/t01Materiel/?repage";
	}
	
	@RequiresPermissions("gsp:t01materiel:t01Materiel:edit")
	@RequestMapping(value = "delete")
	public String delete(T01Materiel t01Materiel, RedirectAttributes redirectAttributes) {
		try {
			t01MaterielService.delete(t01Materiel);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01materiel/t01Materiel/?repage";
	}

}
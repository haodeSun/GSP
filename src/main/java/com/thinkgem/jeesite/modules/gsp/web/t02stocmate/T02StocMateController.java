/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02stocmate;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02stocmate.T02StocMate;
import com.thinkgem.jeesite.modules.gsp.service.t02stocmate.T02StocMateService;

/**
 * 盘点-物料信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02stocmate/t02StocMate")
public class T02StocMateController extends BaseController {

	@Autowired
	private T02StocMateService t02StocMateService;
	
	@ModelAttribute
	public T02StocMate get(@RequestParam(required=false) String id) {
		T02StocMate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02StocMateService.get(id);
		}
		if (entity == null){
			entity = new T02StocMate();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02stocmate:t02StocMate:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02StocMate t02StocMate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02StocMate> page = t02StocMateService.findPage(new Page<>(request, response), t02StocMate);
		model.addAttribute("page", page);
		return "modules/gsp/t02stocmate/t02StocMateList";
	}

	@RequiresPermissions("gsp:t02stocmate:t02StocMate:view")
	@RequestMapping(value = "form")
	public String form(T02StocMate t02StocMate, Model model) {
		model.addAttribute("t02StocMate", t02StocMate);
		return "modules/gsp/t02stocmate/t02StocMateForm";
	}

	@RequiresPermissions("gsp:t02stocmate:t02StocMate:edit")
	@RequestMapping(value = "save")
	public String save(T02StocMate t02StocMate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02StocMate)){
			return form(t02StocMate, model);
		}
        try {
            t02StocMateService.save(t02StocMate);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存盘点-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stocmate/t02StocMate/?repage";
	}
	
	@RequiresPermissions("gsp:t02stocmate:t02StocMate:edit")
	@RequestMapping(value = "delete")
	public String delete(T02StocMate t02StocMate, RedirectAttributes redirectAttributes) {
		try {
			t02StocMateService.delete(t02StocMate);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除盘点-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stocmate/t02StocMate/?repage";
	}

}
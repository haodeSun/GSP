/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02check;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02check.T02Check;
import com.thinkgem.jeesite.modules.gsp.service.t02check.T02CheckService;

/**
 * 检查信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02check/t02Check")
public class T02CheckController extends BaseController {

	@Autowired
	private T02CheckService t02CheckService;
	
	@ModelAttribute
	public T02Check get(@RequestParam(required=false) String id) {
		T02Check entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02CheckService.get(id);
		}
		if (entity == null){
			entity = new T02Check();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02check:t02Check:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Check t02Check, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Check> page = t02CheckService.findPage(new Page<>(request, response), t02Check);
		model.addAttribute("page", page);
		return "modules/gsp/t02check/t02CheckList";
	}

	@RequiresPermissions("gsp:t02check:t02Check:view")
	@RequestMapping(value = "form")
	public String form(T02Check t02Check, Model model) {
		model.addAttribute("t02Check", t02Check);
		return "modules/gsp/t02check/t02CheckForm";
	}

	@RequiresPermissions("gsp:t02check:t02Check:edit")
	@RequestMapping(value = "save")
	public String save(T02Check t02Check, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Check)){
			return form(t02Check, model);
		}
        try {
            t02CheckService.save(t02Check);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存检查信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02check/t02Check/?repage";
	}
	
	@RequiresPermissions("gsp:t02check:t02Check:edit")
	@RequestMapping(value = "delete")
	public String delete(T02Check t02Check, RedirectAttributes redirectAttributes) {
		try {
			t02CheckService.delete(t02Check);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除检查信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02check/t02Check/?repage";
	}

}
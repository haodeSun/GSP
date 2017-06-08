/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02acceptmate;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02acceptmate.T02AcceptMate;
import com.thinkgem.jeesite.modules.gsp.service.t02acceptmate.T02AcceptMateService;

/**
 * 验收-物料信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02acceptmate/t02AcceptMate")
public class T02AcceptMateController extends BaseController {

	@Autowired
	private T02AcceptMateService t02AcceptMateService;
	
	@ModelAttribute
	public T02AcceptMate get(@RequestParam(required=false) String id) {
		T02AcceptMate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02AcceptMateService.get(id);
		}
		if (entity == null){
			entity = new T02AcceptMate();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02acceptmate:t02AcceptMate:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02AcceptMate t02AcceptMate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02AcceptMate> page = t02AcceptMateService.findPage(new Page<>(request, response), t02AcceptMate);
		model.addAttribute("page", page);
		return "modules/gsp/t02acceptmate/t02AcceptMateList";
	}

	@RequiresPermissions("gsp:t02acceptmate:t02AcceptMate:view")
	@RequestMapping(value = "form")
	public String form(T02AcceptMate t02AcceptMate, Model model) {
		model.addAttribute("t02AcceptMate", t02AcceptMate);
		return "modules/gsp/t02acceptmate/t02AcceptMateForm";
	}

	@RequiresPermissions("gsp:t02acceptmate:t02AcceptMate:edit")
	@RequestMapping(value = "save")
	public String save(T02AcceptMate t02AcceptMate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02AcceptMate)){
			return form(t02AcceptMate, model);
		}
        try {
            t02AcceptMateService.save(t02AcceptMate);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存验收-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02acceptmate/t02AcceptMate/?repage";
	}
	
	@RequiresPermissions("gsp:t02acceptmate:t02AcceptMate:edit")
	@RequestMapping(value = "delete")
	public String delete(T02AcceptMate t02AcceptMate, RedirectAttributes redirectAttributes) {
		try {
			t02AcceptMateService.delete(t02AcceptMate);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除验收-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02acceptmate/t02AcceptMate/?repage";
	}

}
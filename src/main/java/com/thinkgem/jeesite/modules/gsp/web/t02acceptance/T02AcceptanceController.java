/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02acceptance;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02acceptance.T02Acceptance;
import com.thinkgem.jeesite.modules.gsp.service.t02acceptance.T02AcceptanceService;

/**
 * 验收信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02acceptance/t02Acceptance")
public class T02AcceptanceController extends BaseController {

	@Autowired
	private T02AcceptanceService t02AcceptanceService;
	
	@ModelAttribute
	public T02Acceptance get(@RequestParam(required=false) String id) {
		T02Acceptance entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02AcceptanceService.get(id);
		}
		if (entity == null){
			entity = new T02Acceptance();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02acceptance:t02Acceptance:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Acceptance t02Acceptance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Acceptance> page = t02AcceptanceService.findPage(new Page<>(request, response), t02Acceptance);
		model.addAttribute("page", page);
		return "modules/gsp/t02acceptance/t02AcceptanceList";
	}

	@RequiresPermissions("gsp:t02acceptance:t02Acceptance:view")
	@RequestMapping(value = "form")
	public String form(T02Acceptance t02Acceptance, Model model) {
		model.addAttribute("t02Acceptance", t02Acceptance);
		return "modules/gsp/t02acceptance/t02AcceptanceForm";
	}

	@RequiresPermissions("gsp:t02acceptance:t02Acceptance:edit")
	@RequestMapping(value = "save")
	public String save(T02Acceptance t02Acceptance, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Acceptance)){
			return form(t02Acceptance, model);
		}
        try {
            t02AcceptanceService.save(t02Acceptance);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存验收信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02acceptance/t02Acceptance/?repage";
	}
	
	@RequiresPermissions("gsp:t02acceptance:t02Acceptance:edit")
	@RequestMapping(value = "delete")
	public String delete(T02Acceptance t02Acceptance, RedirectAttributes redirectAttributes) {
		try {
			t02AcceptanceService.delete(t02Acceptance);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除验收信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02acceptance/t02Acceptance/?repage";
	}

}
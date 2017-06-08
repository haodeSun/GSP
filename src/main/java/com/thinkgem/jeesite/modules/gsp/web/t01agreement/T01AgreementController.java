/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01agreement;

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
import com.thinkgem.jeesite.modules.gsp.entity.t01agreement.T01Agreement;
import com.thinkgem.jeesite.modules.gsp.service.t01agreement.T01AgreementService;

/**
 * 协议模块Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01agreement/t01Agreement")
public class T01AgreementController extends BaseController {

	@Autowired
	private T01AgreementService t01AgreementService;
	
	@ModelAttribute
	public T01Agreement get(@RequestParam(required=false) String id) {
		T01Agreement entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01AgreementService.get(id);
		}
		if (entity == null){
			entity = new T01Agreement();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01agreement:t01Agreement:view")
	@RequestMapping(value = {"list", ""})
	public String list(T01Agreement t01Agreement, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T01Agreement> page = t01AgreementService.findPage(new Page<>(request, response), t01Agreement);
		model.addAttribute("page", page);
		return "modules/gsp/t01agreement/t01AgreementList";
	}

	@RequiresPermissions("gsp:t01agreement:t01Agreement:view")
	@RequestMapping(value = "form")
	public String form(T01Agreement t01Agreement, Model model) {
		model.addAttribute("t01Agreement", t01Agreement);
		return "modules/gsp/t01agreement/t01AgreementForm";
	}

	@RequiresPermissions("gsp:t01agreement:t01Agreement:edit")
	@RequestMapping(value = "save")
	public String save(T01Agreement t01Agreement, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01Agreement)){
			return form(t01Agreement, model);
		}
        try {
            t01AgreementService.save(t01Agreement);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存协议信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01agreement/t01Agreement/?repage";
	}
	
	@RequiresPermissions("gsp:t01agreement:t01Agreement:edit")
	@RequestMapping(value = "delete")
	public String delete(T01Agreement t01Agreement, RedirectAttributes redirectAttributes) {
		try {
			t01AgreementService.delete(t01Agreement);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除协议信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01agreement/t01Agreement/?repage";
	}

}
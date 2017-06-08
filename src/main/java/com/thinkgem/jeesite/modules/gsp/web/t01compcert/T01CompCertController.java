/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01compcert;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;

/**
 * 企业资质Controller
 * @author XXS
 * @version 2016-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01compcert/t01CompCert")
public class T01CompCertController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T01CompCertService t01CompCertService;

	@Autowired
	public T01CompCertController(T01CompCertService t01CompCertService) {
	    Assert.notNull(t01CompCertService);
	    this.t01CompCertService = t01CompCertService;
	}
	
	@ModelAttribute
	public T01CompCert get(@RequestParam(required=false) String id) {
		T01CompCert entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01CompCertService.get(id);
		}
		if (entity == null){
			entity = new T01CompCert();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01compcert:t01CompCert:view")
	@RequestMapping(value = {"list", ""})
	public String list(
		@RequestParam(required = false) String conditionOrder,
		T01CompCert t01CompCert,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model) {
		Page<T01CompCert> page = t01CompCertService.findPage(new Page<>(request, response), t01CompCert);
		model.addAttribute("page", page);
		//保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
		return "modules/gsp/t01compcert/t01CompCertList";
	}

	@RequiresPermissions("gsp:t01compcert:t01CompCert:view")
	@RequestMapping(value = "form")
	public String form(T01CompCert t01CompCert, Model model, String view) {
		model.addAttribute("t01CompCert", t01CompCert);
		if(view != null && !view.isEmpty()){
			return view;
		}
		return "modules/gsp/t01compcert/t01CompCertForm";
	}

	@RequiresPermissions("gsp:t01compcert:t01CompCert:edit")
	@RequestMapping(value = "save")
	public String save(
            T01CompCert t01CompCert,
            Model model,
            RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t01CompCert)){
			return form(t01CompCert, model, null);
		}
		try{
		    t01CompCertService.save(t01CompCert);
		} catch (Exception e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
			return form(t01CompCert, model, null);
		}
		addMessage(redirectAttributes, "保存企业资质成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01compcert/t01CompCert/?repage";
	}
	
	@RequiresPermissions("gsp:t01compcert:t01CompCert:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T01CompCert t01CompCert,
            RedirectAttributes redirectAttributes) {
		try {
			t01CompCertService.delete(t01CompCert);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除企业资质成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01compcert/t01CompCert/?repage";
	}

}
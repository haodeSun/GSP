/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02recemart;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02recemart.T02ReceMart;
import com.thinkgem.jeesite.modules.gsp.service.t02recemart.T02ReceMartService;

/**
 * 收货-物料信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02recemart/t02ReceMart")
public class T02ReceMartController extends BaseController {

	@Autowired
	private T02ReceMartService t02ReceMartService;
	
	@ModelAttribute
	public T02ReceMart get(@RequestParam(required=false) String id) {
		T02ReceMart entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02ReceMartService.get(id);
		}
		if (entity == null){
			entity = new T02ReceMart();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02recemart:t02ReceMart:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02ReceMart t02ReceMart, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02ReceMart> page = t02ReceMartService.findPage(new Page<>(request, response), t02ReceMart);
		model.addAttribute("page", page);
		return "modules/gsp/t02recemart/t02ReceMartList";
	}

	@RequiresPermissions("gsp:t02recemart:t02ReceMart:view")
	@RequestMapping(value = "form")
	public String form(T02ReceMart t02ReceMart, Model model) {
		model.addAttribute("t02ReceMart", t02ReceMart);
		return "modules/gsp/t02recemart/t02ReceMartForm";
	}

	@RequiresPermissions("gsp:t02recemart:t02ReceMart:edit")
	@RequestMapping(value = "save")
	public String save(T02ReceMart t02ReceMart, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02ReceMart)){
			return form(t02ReceMart, model);
		}
        try {
            t02ReceMartService.save(t02ReceMart);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存收货-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02recemart/t02ReceMart/?repage";
	}
	
	@RequiresPermissions("gsp:t02recemart:t02ReceMart:edit")
	@RequestMapping(value = "delete")
	public String delete(T02ReceMart t02ReceMart, RedirectAttributes redirectAttributes) {
		try {
			t02ReceMartService.delete(t02ReceMart);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除收货-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02recemart/t02ReceMart/?repage";
	}

}
/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02ship;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02ship.T02Ship;
import com.thinkgem.jeesite.modules.gsp.service.t02ship.T02ShipService;

/**
 * 发货信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02ship/t02Ship")
public class T02ShipController extends BaseController {

	@Autowired
	private T02ShipService t02ShipService;
	
	@ModelAttribute
	public T02Ship get(@RequestParam(required=false) String id) {
		T02Ship entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02ShipService.get(id);
		}
		if (entity == null){
			entity = new T02Ship();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02ship:t02Ship:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Ship t02Ship, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Ship> page = t02ShipService.findPage(new Page<>(request, response), t02Ship);
		model.addAttribute("page", page);
		return "modules/gsp/t02ship/t02ShipList";
	}

	@RequiresPermissions("gsp:t02ship:t02Ship:view")
	@RequestMapping(value = "form")
	public String form(T02Ship t02Ship, Model model) {
		model.addAttribute("t02Ship", t02Ship);
		return "modules/gsp/t02ship/t02ShipForm";
	}

	@RequiresPermissions("gsp:t02ship:t02Ship:edit")
	@RequestMapping(value = "save")
	public String save(T02Ship t02Ship, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Ship)){
			return form(t02Ship, model);
		}
        try {
            t02ShipService.save(t02Ship);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存发货信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02ship/t02Ship/?repage";
	}
	
	@RequiresPermissions("gsp:t02ship:t02Ship:edit")
	@RequestMapping(value = "delete")
	public String delete(T02Ship t02Ship, RedirectAttributes redirectAttributes) {
		try {
			t02ShipService.delete(t02Ship);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除发货信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02ship/t02Ship/?repage";
	}

}
/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02shipmate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02shipmate.T02ShipMate;
import com.thinkgem.jeesite.modules.gsp.service.t02shipmate.T02ShipMateService;

/**
 * 发货-物料信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02shipmate/t02ShipMate")
public class T02ShipMateController extends BaseController {

	@Autowired
	private T02ShipMateService t02ShipMateService;
	
	@ModelAttribute
	public T02ShipMate get(@RequestParam(required=false) String id) {
		T02ShipMate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02ShipMateService.get(id);
		}
		if (entity == null){
			entity = new T02ShipMate();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02shipmate:t02ShipMate:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02ShipMate t02ShipMate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02ShipMate> page = t02ShipMateService.findPage(new Page<>(request, response), t02ShipMate);
		model.addAttribute("page", page);
		return "modules/gsp/t02shipmate/t02ShipMateList";
	}

	@RequiresPermissions("gsp:t02shipmate:t02ShipMate:view")
	@RequestMapping(value = "form")
	public String form(T02ShipMate t02ShipMate, Model model) {
		model.addAttribute("t02ShipMate", t02ShipMate);
		return "modules/gsp/t02shipmate/t02ShipMateForm";
	}

	@RequiresPermissions("gsp:t02shipmate:t02ShipMate:edit")
	@RequestMapping(value = "save")
	public String save(T02ShipMate t02ShipMate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02ShipMate)){
			return form(t02ShipMate, model);
		}
        try {
            t02ShipMateService.save(t02ShipMate);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存发货-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02shipmate/t02ShipMate/?repage";
	}
	
	@RequiresPermissions("gsp:t02shipmate:t02ShipMate:edit")
	@RequestMapping(value = "delete")
	public String delete(T02ShipMate t02ShipMate, RedirectAttributes redirectAttributes) {
		t02ShipMateService.delete(t02ShipMate);
		addMessage(redirectAttributes, "删除发货-物料信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02shipmate/t02ShipMate/?repage";
	}

}
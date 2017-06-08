/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02stocktaking;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02stocktaking.T02Stocktaking;
import com.thinkgem.jeesite.modules.gsp.service.t02stocktaking.T02StocktakingService;

/**
 * 盘点信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02stocktaking/t02Stocktaking")
public class T02StocktakingController extends BaseController {

	@Autowired
	private T02StocktakingService t02StocktakingService;
	
	@ModelAttribute
	public T02Stocktaking get(@RequestParam(required=false) String id) {
		T02Stocktaking entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02StocktakingService.get(id);
		}
		if (entity == null){
			entity = new T02Stocktaking();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02stocktaking:t02Stocktaking:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Stocktaking t02Stocktaking, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Stocktaking> page = t02StocktakingService.findPage(new Page<>(request, response), t02Stocktaking);
		model.addAttribute("page", page);
		return "modules/gsp/t02stocktaking/t02StocktakingList";
	}

	@RequiresPermissions("gsp:t02stocktaking:t02Stocktaking:view")
	@RequestMapping(value = "form")
	public String form(T02Stocktaking t02Stocktaking, Model model) {
		model.addAttribute("t02Stocktaking", t02Stocktaking);
		return "modules/gsp/t02stocktaking/t02StocktakingForm";
	}

	@RequiresPermissions("gsp:t02stocktaking:t02Stocktaking:edit")
	@RequestMapping(value = "save")
	public String save(T02Stocktaking t02Stocktaking, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Stocktaking)){
			return form(t02Stocktaking, model);
		}
        try {
            t02StocktakingService.save(t02Stocktaking);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存盘点信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stocktaking/t02Stocktaking/?repage";
	}
	
	@RequiresPermissions("gsp:t02stocktaking:t02Stocktaking:edit")
	@RequestMapping(value = "delete")
	public String delete(T02Stocktaking t02Stocktaking, RedirectAttributes redirectAttributes) {
		try {
			t02StocktakingService.delete(t02Stocktaking);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除盘点信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stocktaking/t02Stocktaking/?repage";
	}

}
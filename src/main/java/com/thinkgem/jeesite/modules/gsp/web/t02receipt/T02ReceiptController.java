/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02receipt;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02receipt.T02Receipt;
import com.thinkgem.jeesite.modules.gsp.service.t02receipt.T02ReceiptService;

/**
 * 收货信息Controller
 * @author gyq
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02receipt/t02Receipt")
public class T02ReceiptController extends BaseController {

	@Autowired
	private T02ReceiptService t02ReceiptService;
	
	@ModelAttribute
	public T02Receipt get(@RequestParam(required=false) String id) {
		T02Receipt entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t02ReceiptService.get(id);
		}
		if (entity == null){
			entity = new T02Receipt();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t02receipt:t02Receipt:view")
	@RequestMapping(value = {"list", ""})
	public String list(T02Receipt t02Receipt, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<T02Receipt> page = t02ReceiptService.findPage(new Page<>(request, response), t02Receipt);
		model.addAttribute("page", page);
		return "modules/gsp/t02receipt/t02ReceiptList";
	}

	@RequiresPermissions("gsp:t02receipt:t02Receipt:view")
	@RequestMapping(value = "form")
	public String form(T02Receipt t02Receipt, Model model) {
		model.addAttribute("t02Receipt", t02Receipt);
		return "modules/gsp/t02receipt/t02ReceiptForm";
	}

	@RequiresPermissions("gsp:t02receipt:t02Receipt:edit")
	@RequestMapping(value = "save")
	public String save(T02Receipt t02Receipt, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, t02Receipt)){
			return form(t02Receipt, model);
		}
        try {
            t02ReceiptService.save(t02Receipt);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存收货信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02receipt/t02Receipt/?repage";
	}
	
	@RequiresPermissions("gsp:t02receipt:t02Receipt:edit")
	@RequestMapping(value = "delete")
	public String delete(T02Receipt t02Receipt, RedirectAttributes redirectAttributes) {
		try {
			t02ReceiptService.delete(t02Receipt);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除收货信息成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02receipt/t02Receipt/?repage";
	}

}
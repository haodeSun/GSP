/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.sysusernotice;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gsp.entity.sysusernotice.SysUserNotice;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.sysusernotice.SysUserNoticeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 用户notice表Controller
 * @author gyq
 * @version 2016-10-29
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/sysusernotice/sysUserNotice")
public class SysUserNoticeController extends BaseController {

	@Autowired
	private SysUserNoticeService sysUserNoticeService;
	
	@ModelAttribute
	public SysUserNotice get(@RequestParam(required=false) String id) {
		SysUserNotice entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysUserNoticeService.get(id);
		}
		if (entity == null){
			entity = new SysUserNotice();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:sysusernotice:sysUserNotice:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysUserNotice sysUserNotice, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysUserNotice> page = sysUserNoticeService.findPage(new Page<>(request, response), sysUserNotice);
		model.addAttribute("page", page);
		return "modules/gsp/sysusernotice/sysUserNoticeList";
	}

	@RequiresPermissions("gsp:sysusernotice:sysUserNotice:view")
	@RequestMapping(value = "form")
	public String form(SysUserNotice sysUserNotice, Model model) {
		model.addAttribute("sysUserNotice", sysUserNotice);
		return "modules/gsp/sysusernotice/sysUserNoticeForm";
	}

	@RequiresPermissions("gsp:sysusernotice:sysUserNotice:edit")
	@RequestMapping(value = "save")
	public String save(SysUserNotice sysUserNotice, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysUserNotice)){
			return form(sysUserNotice, model);
		}
        try {
            sysUserNoticeService.save(sysUserNotice);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "保存用户notice表成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/sysusernotice/sysUserNotice/?repage";
	}
	
	@RequiresPermissions("gsp:sysusernotice:sysUserNotice:edit")
	@RequestMapping(value = "delete")
	public String delete(SysUserNotice sysUserNotice, RedirectAttributes redirectAttributes) {
		try {
			sysUserNoticeService.delete(sysUserNotice);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除用户notice表成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/sysusernotice/sysUserNotice/?repage";
	}

}
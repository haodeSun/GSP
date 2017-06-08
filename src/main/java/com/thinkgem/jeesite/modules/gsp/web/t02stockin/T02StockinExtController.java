/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02stockin;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;
import com.thinkgem.jeesite.modules.gsp.service.t02stockin.T02StockinExtService;
import com.thinkgem.jeesite.modules.gsp.service.t02stockin.T02StockinService;

/**
 * 采购Controller
 * @author yohu
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02stockin/t02Stockin")

public class T02StockinExtController extends T02StockinController {

	@Autowired
	public T02StockinExtController(T02StockinService t02StockinService) {
		super(t02StockinService);
	}

	@Resource(name="t02StockinService")
	private T02StockinExtService t02StockinExtService;
	
//	@RequiresPermissions("gsp:t02stockin:t02Stockin:view")
	@RequestMapping(value = "t02StockinShowForm")
	public  String t02StockinShowForm(String t02stockinId){
		T02Stockin stockin= t02StockinExtService.get(t02stockinId); 
		
		return "modules/gsp/t02stockin/t02StockinShowForm";
	}
    @RequestMapping(value = "/startAudit")
    public String startAudit(@RequestParam() String stockinId,ModelMap map, RedirectAttributes redirectAttributes) {
		
		
		T02Stockin stockin= t02StockinExtService.startProcess(stockinId); 
        
        addMessage(redirectAttributes, "审批提交成功！");
//        map.put("stockin", stockin);
        return "redirect:"+Global.getAdminPath()+"/act/task/todo";
    }
	@RequestMapping(value = "processTask")
	public  String processTask(T02Stockin t02stockin,RedirectAttributes redirectAttributes){
		t02StockinExtService.completeTask(t02stockin);
		addMessage(redirectAttributes, "完成审批！");
		return "redirect:"+Global.getAdminPath()+"/gsp/t02stockin/t02Stockin/list";
	}
}
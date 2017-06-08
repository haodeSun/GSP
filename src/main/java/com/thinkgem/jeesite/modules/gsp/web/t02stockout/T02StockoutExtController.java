/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02stockout;

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
import com.thinkgem.jeesite.modules.gsp.service.t02stockout.T02StockoutExtService;
import com.thinkgem.jeesite.modules.gsp.service.t02stockout.T02StockoutService;

/**
 * 出库extController
 * @author yohu
 * @version 2016-11-16
 */

public class T02StockoutExtController extends T02StockoutController {

	
	@Autowired
	public T02StockoutExtController(T02StockoutService t02StockoutService) {
		super(t02StockoutService);
		// TODO Auto-generated constructor stub
	}
	@Resource(name="t02StockoutService")
	private T02StockoutExtService t02StockoutExtService;
	
}
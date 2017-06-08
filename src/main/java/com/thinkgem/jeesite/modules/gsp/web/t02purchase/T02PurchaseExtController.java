/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t02purchase;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.json.JsonResponseCode;
import com.thinkgem.jeesite.modules.gsp.entity.t02purchase.T02PurcMate;
import com.thinkgem.jeesite.modules.gsp.entity.t02purchase.T02Purchase;
import com.thinkgem.jeesite.modules.gsp.service.t02purchase.T02PurchaseExtService;
import com.thinkgem.jeesite.modules.gsp.service.t02purchase.T02PurchaseService;
import com.thinkgem.jeesite.modules.sys.service.KettleUtilService;

/**
 * 采购Controller
 * @author yohu
 * @version 2016-11-16
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t02purchase/t02Purchase")
public class T02PurchaseExtController extends T02PurchaseController {

	

	@Autowired
	@SuppressWarnings("WeakerAccess")
	T02PurchaseExtService t02PurchaseExtService;
	@Autowired
	public T02PurchaseExtController(T02PurchaseExtService t02PurchaseExtService) {
		super(t02PurchaseExtService);
	}
	
	@RequestMapping(value = "savePurchase")
	public @ResponseBody String savePurchase(
            T02Purchase t02Purchase,
            Model model) {
		if (!beanValidator(model, t02Purchase)){
			return JsonResponseCode.FAILED;
		}
		try{
			t02PurchaseExtService.save(t02Purchase);
		} catch (Exception e) {
			e.printStackTrace();
			return JsonResponseCode.FAILED;
		}
		return JsonResponseCode.SUCCESS;
	}
}
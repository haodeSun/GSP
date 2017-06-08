/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02stockout;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinMateDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockout.T02StockoutDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockout.T02StockoutMateDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockout.T02Stockout;

/**
 * 入库Service
 * @author yohu
 * @version 2016-11-17
 */

public class T02StockoutExtService extends T02StockoutService {

	@Autowired
	public T02StockoutExtService(T02StockoutDao dao,
			T02StockoutMateDao T02StockoutMateDao) {
		super(dao, T02StockoutMateDao);
		// TODO Auto-generated constructor stub
	}

	@Autowired
	private ActTaskService actTaskService;
	@Autowired
	private T02StockoutDao t02StockoutDao;
	

	
}
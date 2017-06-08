/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02stockin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinMateDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;

/**
 * 入库Service
 * @author yohu
 * @version 2016-11-17
 */
@Service(value="t02StockinService")
@Transactional(readOnly = false)
public class T02StockinExtService extends T02StockinService {

	@Autowired
	private ActTaskService actTaskService;
	@Autowired
	private T02StockinDao t02StockinDao;
	
	@Autowired
	public T02StockinExtService(T02StockinDao dao,
			T02StockinMateDao T02StockinMateDao) {
		super(dao, T02StockinMateDao);
	}
	
	public T02Stockin startProcess(String stockInId){
		T02Stockin t02Stockin = t02StockinDao.get(stockInId);
		Map<String, Object> vars = new HashMap<>();
		vars.put("entityName", "T02Stockin");
		vars.put("businessId", stockInId);
		
		actTaskService.startProcess("stockInAudit", "t02_stockin", stockInId,t02Stockin.getStocNo(),vars);
		
		return t02Stockin;
	}

	public void completeTask(T02Stockin t02stockin) {
		Map<String, Object> vars = Maps.newHashMap();
//		vars.put("pass", "yes".equals(t02stockin.getAct().getFlag())? "1" : "0");
//		actTaskService.complete(t02stockin.getAct().getTaskId(), t02stockin.getAct().getProcInsId(), t02stockin.getAct().getComment(), vars);
	}
	
	public T02Stockin findStockinByProcInsId(T02Stockin t02stockin) {
		
		t02stockin = t02StockinDao.findStockinByProcInsId(t02stockin.getProcInsId());
		
		return t02stockin;
	}
}
package com.thinkgem.jeesite.modules.gsp.service.t02stockout;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockout.T02StockoutDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockout.T02Stockout;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.NoSuchTypeException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Field;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional
public class T02StockoutBusinessService extends GenericBusinessService<T02Stockout>{


	private  T02StockoutDao t02StockoutDao;

    @Autowired
    private ActTaskService actTaskService;
    @Autowired
	public T02StockoutBusinessService(T02StockoutDao t02StockoutDao) {
		this.t02StockoutDao = t02StockoutDao;
	}
	
	@Override
	public ServiceFlag postInsert(T02Stockout entity) throws BusinessException {
		startProcess(entity.getId());
		return super.postInsert(entity);
	}

	public T02Stockout startProcess(String stockoutId){
		T02Stockout t02Stockout = t02StockoutDao.get(stockoutId);
		Map<String, Object> vars = new HashMap<>();
		vars.put("entityName", "T02Stockout");
		vars.put("businessId", stockoutId);
		
		String businessTable = "t02_stockout";
		vars.put("businessTable", businessTable);
		actTaskService.startProcess("stockoutAudit", businessTable, stockoutId,t02Stockout.getStocNumb(),vars);
		
		return t02Stockout;
	}
	
	
}

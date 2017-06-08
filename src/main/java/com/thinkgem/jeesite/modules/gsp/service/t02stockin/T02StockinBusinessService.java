package com.thinkgem.jeesite.modules.gsp.service.t02stockin;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;
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
public class T02StockinBusinessService extends GenericBusinessService<T02Stockin>{


	private final T02StockinDao t02StockinDao;

    @Autowired
    private ActTaskService actTaskService;

    @Autowired
	public T02StockinBusinessService(T02StockinDao t02StockinDao) {
		this.t02StockinDao = t02StockinDao;
	}

	@Override
	public ServiceFlag postInsert(T02Stockin entity) throws BusinessException {
		startProcess(entity.getId());
		return super.preInsert(entity);
	}
	public void startProcess(String stockInId){
		T02Stockin t02Stockin = t02StockinDao.get(stockInId);
		Map<String, Object> vars = new HashMap<>();
		vars.put("entityName", "T02Stockin");
		vars.put("businessId", stockInId);
		String businessTable = "t02_stockin";
		vars.put("businessTable", businessTable);
		actTaskService.startProcess("stockInAudit", businessTable, stockInId,t02Stockin.getStocNo(),vars);
		
	}
	
	
}

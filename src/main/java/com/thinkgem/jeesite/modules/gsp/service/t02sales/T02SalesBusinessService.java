package com.thinkgem.jeesite.modules.gsp.service.t02sales;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02purchase.T02PurchaseDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02sales.T02SalesDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t02purchase.T02Purchase;
import com.thinkgem.jeesite.modules.gsp.entity.t02sales.T02Sales;
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
public class T02SalesBusinessService extends GenericBusinessService<T02Sales>{


	private final T02SalesDao t02SalesDao;

    @Autowired
    private ActTaskService actTaskService;

    @Autowired
	public T02SalesBusinessService(T02SalesDao t02SalesDao) {
		this.t02SalesDao = t02SalesDao;
	}

	@Override
	public ServiceFlag postInsert(T02Sales entity) throws BusinessException {
		startProcess(entity.getId());
		return super.preInsert(entity);
	}
	public void startProcess(String salesId){
		T02Sales t02Sales = t02SalesDao.get(salesId);
		Map<String, Object> vars = new HashMap<>();
		vars.put("entityName", "T02Sales");
		vars.put("businessId", salesId);
		String businessTable = "t02_sales";
		vars.put("businessTable", businessTable);
		actTaskService.startProcess("salesAudit",businessTable , salesId,t02Sales.getId(),vars);
		
	}
	
	
}

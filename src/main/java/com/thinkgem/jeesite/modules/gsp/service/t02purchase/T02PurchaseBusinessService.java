package com.thinkgem.jeesite.modules.gsp.service.t02purchase;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02purchase.T02PurchaseDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t02purchase.T02Purchase;
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
public class T02PurchaseBusinessService extends GenericBusinessService<T02Purchase>{


	private final T02PurchaseDao t02PurchaseDao;

    @Autowired
    private ActTaskService actTaskService;

    @Autowired
	public T02PurchaseBusinessService(T02PurchaseDao t02PurchaseDao) {
		this.t02PurchaseDao = t02PurchaseDao;
	}

	@Override
	public ServiceFlag postInsert(T02Purchase entity) throws BusinessException {
		startProcess(entity.getId());
		return super.postInsert(entity);
	}
	public void startProcess(String purchaseId){
		T02Purchase t02Purchase = t02PurchaseDao.get(purchaseId);
		Map<String, Object> vars = new HashMap<>();
		vars.put("entityName", "T02Purchase");
		vars.put("businessId", purchaseId);
		
		String businessTable = "t02_purchase";
		vars.put("businessTable", businessTable);
		actTaskService.startProcess("purchaseAudit", businessTable, purchaseId,t02Purchase.getId(),vars);
		
	}
	
	
}

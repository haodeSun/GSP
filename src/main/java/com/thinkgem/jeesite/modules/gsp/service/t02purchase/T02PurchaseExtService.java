/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02purchase;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.modules.gsp.dao.t02purchase.T02PurcMateDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02purchase.T02PurchaseDao;

/**
 * 采购Ext Service
 * @author yohu
 * @version 2016-11-16
 */
@Service
@Transactional(readOnly = true)
public class T02PurchaseExtService extends T02PurchaseService {

	@Autowired
	public T02PurchaseExtService(T02PurchaseDao dao,
			T02PurcMateDao T02PurcMateDao) {
		super(dao, T02PurcMateDao);
	}

}
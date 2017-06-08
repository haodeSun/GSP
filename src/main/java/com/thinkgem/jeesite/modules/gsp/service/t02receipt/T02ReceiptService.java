/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02receipt;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02receipt.T02ReceiptDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02receipt.T02Receipt;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 收货信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02ReceiptService extends ExtCrudService<T02ReceiptDao, T02Receipt> {

	@Autowired
	public T02ReceiptService(T02ReceiptDao dao) {
		super(dao);
	}

	public T02Receipt get(String id) {
		return super.get(id);
	}
	
	public List<T02Receipt> findList(T02Receipt t02Receipt) {
		return super.findList(t02Receipt);
	}
	
	public Page<T02Receipt> findPage(Page<T02Receipt> page, T02Receipt t02Receipt) {
		return super.findPage(page, t02Receipt);
	}
	
	@Transactional(readOnly = false)
	public void save(T02Receipt t02Receipt) throws BusinessException {
		super.save(t02Receipt);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02Receipt t02Receipt) throws BusinessException{
		super.delete(t02Receipt);
	}
	
}
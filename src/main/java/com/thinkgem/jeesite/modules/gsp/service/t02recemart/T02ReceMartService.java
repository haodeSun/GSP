/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02recemart;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02recemart.T02ReceMartDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02recemart.T02ReceMart;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 收货-物料信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02ReceMartService extends ExtCrudService<T02ReceMartDao, T02ReceMart> {

	@Autowired
	public T02ReceMartService(T02ReceMartDao dao) {
		super(dao);
	}

	public T02ReceMart get(String id) {
		return super.get(id);
	}
	
	public List<T02ReceMart> findList(T02ReceMart t02ReceMart) {
		return super.findList(t02ReceMart);
	}
	
	public Page<T02ReceMart> findPage(Page<T02ReceMart> page, T02ReceMart t02ReceMart) {
		return super.findPage(page, t02ReceMart);
	}
	
	@Transactional(readOnly = false)
	public void save(T02ReceMart t02ReceMart) throws BusinessException {
		super.save(t02ReceMart);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02ReceMart t02ReceMart) throws BusinessException{
		super.delete(t02ReceMart);
	}
	
}
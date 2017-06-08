/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02shipmate;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02shipmate.T02ShipMateDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02shipmate.T02ShipMate;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 发货-物料信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02ShipMateService extends ExtCrudService<T02ShipMateDao, T02ShipMate> {

	@Autowired
	public T02ShipMateService(T02ShipMateDao dao) {
		super(dao);
	}

	public T02ShipMate get(String id) {
		return super.get(id);
	}
	
	public List<T02ShipMate> findList(T02ShipMate t02ShipMate) {
		return super.findList(t02ShipMate);
	}
	
	public Page<T02ShipMate> findPage(Page<T02ShipMate> page, T02ShipMate t02ShipMate) {
		return super.findPage(page, t02ShipMate);
	}
	
	@Transactional(readOnly = false)
	public void save(T02ShipMate t02ShipMate) throws BusinessException {
		super.save(t02ShipMate);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02ShipMate t02ShipMate) {
		try {
			super.delete(t02ShipMate);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
	}
	
}
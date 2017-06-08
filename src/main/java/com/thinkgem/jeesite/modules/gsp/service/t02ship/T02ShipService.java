/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02ship;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02ship.T02ShipDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02ship.T02Ship;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 发货信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02ShipService extends ExtCrudService<T02ShipDao, T02Ship> {

	@Autowired
	public T02ShipService(T02ShipDao dao) {
		super(dao);
	}

	public T02Ship get(String id) {
		return super.get(id);
	}
	
	public List<T02Ship> findList(T02Ship t02Ship) {
		return super.findList(t02Ship);
	}
	
	public Page<T02Ship> findPage(Page<T02Ship> page, T02Ship t02Ship) {
		return super.findPage(page, t02Ship);
	}
	
	@Transactional(readOnly = false)
    public void save(T02Ship t02Ship) throws BusinessException {
        super.save(t02Ship);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02Ship t02Ship) throws BusinessException{
		super.delete(t02Ship);
	}
	
}
/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02stocktaking;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02stocktaking.T02StocktakingDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stocktaking.T02Stocktaking;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 盘点信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02StocktakingService extends ExtCrudService<T02StocktakingDao, T02Stocktaking> {

	@Autowired
	public T02StocktakingService(T02StocktakingDao dao) {
		super(dao);
	}

	public T02Stocktaking get(String id) {
		return super.get(id);
	}
	
	public List<T02Stocktaking> findList(T02Stocktaking t02Stocktaking) {
		return super.findList(t02Stocktaking);
	}
	
	public Page<T02Stocktaking> findPage(Page<T02Stocktaking> page, T02Stocktaking t02Stocktaking) {
		return super.findPage(page, t02Stocktaking);
	}
	
	@Transactional(readOnly = false)
	public void save(T02Stocktaking t02Stocktaking) throws BusinessException {
		super.save(t02Stocktaking);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02Stocktaking t02Stocktaking) throws BusinessException{
		super.delete(t02Stocktaking);
	}
	
}
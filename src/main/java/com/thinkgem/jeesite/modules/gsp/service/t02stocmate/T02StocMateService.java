/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02stocmate;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02stocmate.T02StocMateDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stocmate.T02StocMate;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 盘点-物料信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02StocMateService extends ExtCrudService<T02StocMateDao, T02StocMate> {

	@Autowired
	public T02StocMateService(T02StocMateDao dao) {
		super(dao);
	}

	public T02StocMate get(String id) {
		return super.get(id);
	}
	
	public List<T02StocMate> findList(T02StocMate t02StocMate) {
		return super.findList(t02StocMate);
	}
	
	public Page<T02StocMate> findPage(Page<T02StocMate> page, T02StocMate t02StocMate) {
		return super.findPage(page, t02StocMate);
	}
	
	@Transactional(readOnly = false)
	public void save(T02StocMate t02StocMate) throws BusinessException {
		super.save(t02StocMate);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02StocMate t02StocMate) throws BusinessException{
		super.delete(t02StocMate);
	}
	
}
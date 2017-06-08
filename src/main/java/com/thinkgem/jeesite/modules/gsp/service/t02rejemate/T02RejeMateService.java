/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02rejemate;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02rejemate.T02RejeMateDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02rejemate.T02RejeMate;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 退回-物料信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02RejeMateService extends ExtCrudService<T02RejeMateDao, T02RejeMate> {

	@Autowired
	public T02RejeMateService(T02RejeMateDao dao) {
		super(dao);
	}

	public T02RejeMate get(String id) {
		return super.get(id);
	}
	
	public List<T02RejeMate> findList(T02RejeMate t02RejeMate) {
		return super.findList(t02RejeMate);
	}
	
	public Page<T02RejeMate> findPage(Page<T02RejeMate> page, T02RejeMate t02RejeMate) {
		return super.findPage(page, t02RejeMate);
	}
	
	@Transactional(readOnly = false)
	public void save(T02RejeMate t02RejeMate) throws BusinessException {
		super.save(t02RejeMate);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02RejeMate t02RejeMate) throws BusinessException{
		super.delete(t02RejeMate);
	}
	
}
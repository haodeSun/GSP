/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02acceptmate;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02acceptmate.T02AcceptMateDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02acceptmate.T02AcceptMate;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 验收-物料信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02AcceptMateService extends ExtCrudService<T02AcceptMateDao, T02AcceptMate> {

	@Autowired
	public T02AcceptMateService(T02AcceptMateDao dao) {
		super(dao);
	}

	public T02AcceptMate get(String id) {
		return super.get(id);
	}
	
	public List<T02AcceptMate> findList(T02AcceptMate t02AcceptMate) {
		return super.findList(t02AcceptMate);
	}
	
	public Page<T02AcceptMate> findPage(Page<T02AcceptMate> page, T02AcceptMate t02AcceptMate) {
		return super.findPage(page, t02AcceptMate);
	}
	
	@Transactional(readOnly = false)
	public void save(T02AcceptMate t02AcceptMate) throws BusinessException {
		super.save(t02AcceptMate);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02AcceptMate t02AcceptMate) throws BusinessException{
		super.delete(t02AcceptMate);
	}
	
}
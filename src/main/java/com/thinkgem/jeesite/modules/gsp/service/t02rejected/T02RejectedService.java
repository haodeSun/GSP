/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02rejected;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02rejected.T02RejectedDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02rejected.T02Rejected;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 退回信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02RejectedService extends ExtCrudService<T02RejectedDao, T02Rejected> {

	@Autowired
	public T02RejectedService(T02RejectedDao dao) {
		super(dao);
	}

	public T02Rejected get(String id) {
		return super.get(id);
	}
	
	public List<T02Rejected> findList(T02Rejected t02Rejected) {
		return super.findList(t02Rejected);
	}
	
	public Page<T02Rejected> findPage(Page<T02Rejected> page, T02Rejected t02Rejected) {
		return super.findPage(page, t02Rejected);
	}
	
	@Transactional(readOnly = false)
	public void save(T02Rejected t02Rejected) throws BusinessException {
		super.save(t02Rejected);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02Rejected t02Rejected) throws BusinessException{
		super.delete(t02Rejected);
	}
	
}
/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01materevi;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01materevi.T01MateReviDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01materevi.T01MateRevi;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 首营审核Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T01MateReviService extends ExtCrudService<T01MateReviDao, T01MateRevi> {

	@Autowired
	public T01MateReviService(T01MateReviDao dao) {
		super(dao);
	}

	public T01MateRevi get(String id) {
		return super.get(id);
	}
	
	public List<T01MateRevi> findList(T01MateRevi t01MateRevi) {
		return super.findList(t01MateRevi);
	}
	
	public Page<T01MateRevi> findPage(Page<T01MateRevi> page, T01MateRevi t01MateRevi) {
		return super.findPage(page, t01MateRevi);
	}
	
	@Transactional(readOnly = false)
	public void save(T01MateRevi t01MateRevi) throws BusinessException {
		super.save(t01MateRevi);
	}
	
	@Transactional(readOnly = false)
	public void delete(T01MateRevi t01MateRevi) throws BusinessException{
		super.delete(t01MateRevi);
	}
	
}
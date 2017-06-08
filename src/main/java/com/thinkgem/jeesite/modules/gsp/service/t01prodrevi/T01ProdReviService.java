/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01prodrevi;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodrevi.T01ProdReviDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodrevi.T01ProdRevi;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 产品审核Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T01ProdReviService extends ExtCrudService<T01ProdReviDao, T01ProdRevi> {

	@Autowired
	public T01ProdReviService(T01ProdReviDao dao) {
		super(dao);
	}

	public T01ProdRevi get(String id) {
		return super.get(id);
	}
	
	public List<T01ProdRevi> findList(T01ProdRevi t01ProdRevi) {
		return super.findList(t01ProdRevi);
	}
	
	public Page<T01ProdRevi> findPage(Page<T01ProdRevi> page, T01ProdRevi t01ProdRevi) {
		return super.findPage(page, t01ProdRevi);
	}
	
	@Transactional(readOnly = false)
	public void save(T01ProdRevi t01ProdRevi) throws BusinessException {
		super.save(t01ProdRevi);
	}
	
	@Transactional(readOnly = false)
	public void delete(T01ProdRevi t01ProdRevi) throws BusinessException{
		super.delete(t01ProdRevi);
	}
	
}
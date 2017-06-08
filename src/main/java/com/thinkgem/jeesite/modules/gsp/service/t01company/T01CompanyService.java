/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01company;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01company.T01CompanyDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01company.T01Company;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 企业信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T01CompanyService extends ExtCrudService<T01CompanyDao, T01Company> {

	@Autowired
	public T01CompanyService(T01CompanyDao dao) {
		super(dao);
	}

	public T01Company get(String id) {
		return super.get(id);
	}
	
	public List<T01Company> findList(T01Company t01Company) {
		return super.findList(t01Company);
	}
	
	public Page<T01Company> findPage(Page<T01Company> page, T01Company t01Company) {
		return super.findPage(page, t01Company);
	}
	
	@Transactional(readOnly = false)
	public void save(T01Company t01Company) throws BusinessException {
		super.save(t01Company);
	}
	
	@Transactional(readOnly = false)
	public void delete(T01Company t01Company) throws BusinessException{
		super.delete(t01Company);
	}
	
}
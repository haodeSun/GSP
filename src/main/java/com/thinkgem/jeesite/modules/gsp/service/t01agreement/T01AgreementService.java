/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01agreement;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01agreement.T01AgreementDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01agreement.T01Agreement;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 协议模块Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T01AgreementService extends ExtCrudService<T01AgreementDao, T01Agreement> {

	@Autowired
	public T01AgreementService(T01AgreementDao dao) {
		super(dao);
	}

	public T01Agreement get(String id) {
		return super.get(id);
	}
	
	public List<T01Agreement> findList(T01Agreement t01Agreement) {
		return super.findList(t01Agreement);
	}
	
	public Page<T01Agreement> findPage(Page<T01Agreement> page, T01Agreement t01Agreement) {
		return super.findPage(page, t01Agreement);
	}
	
	@Transactional(readOnly = false)
	public void save(T01Agreement t01Agreement) throws BusinessException {
		super.save(t01Agreement);
	}
	
	@Transactional(readOnly = false)
	public void delete(T01Agreement t01Agreement) throws BusinessException{
		super.delete(t01Agreement);
	}
	
}
/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02acceptance;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02acceptance.T02AcceptanceDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02acceptance.T02Acceptance;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 验收信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02AcceptanceService extends ExtCrudService<T02AcceptanceDao, T02Acceptance> {

	@Autowired
	public T02AcceptanceService(T02AcceptanceDao dao) {
		super(dao);
	}

	public T02Acceptance get(String id) {
		return super.get(id);
	}
	
	public List<T02Acceptance> findList(T02Acceptance t02Acceptance) {
		return super.findList(t02Acceptance);
	}
	
	public Page<T02Acceptance> findPage(Page<T02Acceptance> page, T02Acceptance t02Acceptance) {
		return super.findPage(page, t02Acceptance);
	}
	
	@Transactional(readOnly = false)
	public void save(T02Acceptance t02Acceptance) throws BusinessException {
		super.save(t02Acceptance);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02Acceptance t02Acceptance) throws BusinessException{
		super.delete(t02Acceptance);
	}
	
}
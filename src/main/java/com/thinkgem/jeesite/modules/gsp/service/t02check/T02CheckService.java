/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02check;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t02check.T02CheckDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02check.T02Check;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 检查信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T02CheckService extends ExtCrudService<T02CheckDao, T02Check> {

	@Autowired
	public T02CheckService(T02CheckDao dao) {
		super(dao);
	}

	public T02Check get(String id) {
		return super.get(id);
	}
	
	public List<T02Check> findList(T02Check t02Check) {
		return super.findList(t02Check);
	}
	
	public Page<T02Check> findPage(Page<T02Check> page, T02Check t02Check) {
		return super.findPage(page, t02Check);
	}
	
	@Transactional(readOnly = false)
	public void save(T02Check t02Check) throws BusinessException {
		super.save(t02Check);
	}
	
	@Transactional(readOnly = false)
	public void delete(T02Check t02Check) throws BusinessException{
		super.delete(t02Check);
	}
	
}
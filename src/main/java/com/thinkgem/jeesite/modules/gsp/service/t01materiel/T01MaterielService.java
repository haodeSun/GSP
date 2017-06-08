/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01materiel;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01materiel.T01MaterielDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01materiel.T01Materiel;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 物料信息Service
 * @author gyq
 * @version 2016-10-26
 */
@Service
@Transactional(readOnly = true)
public class T01MaterielService extends ExtCrudService<T01MaterielDao, T01Materiel> {

	@Autowired
	public T01MaterielService(T01MaterielDao dao) {
		super(dao);
	}

	public T01Materiel get(String id) {
		return super.get(id);
	}
	
	public List<T01Materiel> findList(T01Materiel t01Materiel) {
		return super.findList(t01Materiel);
	}
	
	public Page<T01Materiel> findPage(Page<T01Materiel> page, T01Materiel t01Materiel) {
		return super.findPage(page, t01Materiel);
	}
	
	@Transactional(readOnly = false)
	public void save(T01Materiel t01Materiel) throws BusinessException {
		super.save(t01Materiel);
	}
	
	@Transactional(readOnly = false)
	public void delete(T01Materiel t01Materiel) throws BusinessException{
		super.delete(t01Materiel);
	}
	
}
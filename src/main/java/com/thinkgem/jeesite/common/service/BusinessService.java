package com.thinkgem.jeesite.common.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.stereotype.Service;

@Service
public interface BusinessService<T> {
	
	ServiceFlag preFetch(String id);
	
	ServiceFlag preInsert(T entity) throws BusinessException;

	ServiceFlag preUpdate(T entity) throws BusinessException;

	ServiceFlag prePaging(Page<T> page, T entity);

	ServiceFlag preDelete(T entity);
	
	ServiceFlag preChange(T entity);

	ServiceFlag preContinue(T entity);

	ServiceFlag postFetch(T entity);
	
	ServiceFlag postInsert(T entity) throws BusinessException;
	
	ServiceFlag postUpdate(T entity) throws BusinessException;
	
	ServiceFlag postPaging(Page<T> page);
	
	ServiceFlag postDelete(T entity);
	
	ServiceFlag postChange(T entity);
	
	ServiceFlag postContinue(T entity);
}

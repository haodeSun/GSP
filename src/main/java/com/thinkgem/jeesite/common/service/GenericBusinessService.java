package com.thinkgem.jeesite.common.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class GenericBusinessService<T> implements BusinessService<T> {

	protected final Logger logger = LoggerFactory.getLogger(GenericBusinessService.class);

	@Override
	public ServiceFlag preInsert(T entity) throws BusinessException{
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag postInsert(T entity) throws BusinessException{
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag preUpdate(T entity) throws BusinessException {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag postUpdate(T entity) throws BusinessException {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag prePaging(Page<T> page, T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag postPaging(Page<T> page) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag preDelete(T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag postDelete(T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag preChange(T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag postChange(T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag preContinue(T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag postContinue(T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag postFetch(T entity) {
		return ServiceFlag.SUCCESS;
	}

	@Override
	public ServiceFlag preFetch(String id) {
		return ServiceFlag.SUCCESS;
	}

	protected String getText(String text){return text;}
}

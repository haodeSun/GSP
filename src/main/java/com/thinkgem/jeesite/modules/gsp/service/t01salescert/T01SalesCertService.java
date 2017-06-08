/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01salescert;

import java.util.ArrayList;
import java.util.List;

import com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew.T01CompInfoNew;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.dao.t01salescert.T01SalesCertDao;

/**
 * 管理销售人员授权Service
 * @author greg.song
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class T01SalesCertService extends ExtCrudService<T01SalesCertDao, T01SalesCert> {

	@Autowired
	private T01SalesCertHelperService t01SalesCertHelperService;

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T01SalesCert>> businessServices = new ArrayList<>();

    @Autowired
    public T01SalesCertService(
            T01SalesCertDao dao) {
        super(dao);
    }

	public T01SalesCert get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01SalesCert t01SalesCert = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			 businessService.postFetch(t01SalesCert);
		}

		return t01SalesCert;
	}
	
	public List<T01SalesCert> findList(T01SalesCert t01SalesCert) {
		return super.findList(t01SalesCert);
	}
	
	public Page<T01SalesCert> findPage(Page<T01SalesCert> page, T01SalesCert t01SalesCert) {
		//执行保存前的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			 businessService.prePaging(page,t01SalesCert);
		}
		Page<T01SalesCert> paginator = super.findPage(page, t01SalesCert);
		//执行保存后的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01SalesCert t01SalesCert) throws BusinessException {
		boolean isNewRecord = t01SalesCert.getIsNewRecord();
		if(!isNewRecord){
			t01SalesCertHelperService.checkStatusBeforeHandle("edit", t01SalesCert);
		}

 		t01SalesCert.setCertStat(checkCertStat(t01SalesCert.getEffecDate(),t01SalesCert.getValidDate()));

		//执行保存前的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01SalesCert);
			}else{
				businessService.preInsert(t01SalesCert);
			}
		}
		//执行保存操作
		super.save(t01SalesCert);
		//执行保存后的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01SalesCert);
			}else{
				businessService.postInsert(t01SalesCert);
			}
		}
	}
	
	@Transactional
	public void delete(T01SalesCert t01SalesCert) throws BusinessException{
		t01SalesCertHelperService.checkStatusBeforeHandle("delete", t01SalesCert);

		//执行保存前的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			businessService.preDelete(t01SalesCert);
		}
		//删除
		super.delete(t01SalesCert);
		//执行保存前的业务代码
		for(BusinessService<T01SalesCert> businessService : businessServices){
			businessService.postDelete(t01SalesCert);
		}
	}
	public List<T01SalesCert> findSelectedList(List<String> ids) {
		return dao.findSelectedList(ids);
	}
	
}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01complprod;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01complprod.T01ComplProdDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;

/**
 * 首营产品Service
 * @author XXS
 * @version 2016-12-06
 */
@Transactional(readOnly = true)
public class T01ComplProdService extends ExtCrudService<T01ComplProdDao, T01ComplProd> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T01ComplProd>> businessServices = new ArrayList<>();

    @Autowired
    public T01ComplProdService(
            T01ComplProdDao dao) {
        super(dao);
    }

	public T01ComplProd get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01ComplProd t01ComplProd = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			 businessService.postFetch(t01ComplProd);
		}

		return t01ComplProd;
	}
	
	public List<T01ComplProd> findList(T01ComplProd t01ComplProd) {
		return super.findList(t01ComplProd);
	}
	
	public Page<T01ComplProd> findPage(Page<T01ComplProd> page, T01ComplProd t01ComplProd) {
		//执行保存前的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			 businessService.prePaging(page,t01ComplProd);
		}
		Page<T01ComplProd> paginator = super.findPage(page, t01ComplProd);
		//执行保存后的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01ComplProd t01ComplProd) throws BusinessException {
		boolean isNewRecord = t01ComplProd.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01ComplProd);
			}else{
				businessService.preInsert(t01ComplProd);
			}
		}
		//执行保存操作
		super.save(t01ComplProd);
		//执行保存后的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01ComplProd);
			}else{
				businessService.postInsert(t01ComplProd);
			}
		}
	}
	
	@Transactional
	public void delete(T01ComplProd t01ComplProd) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			businessService.preDelete(t01ComplProd);
		}
		//删除
		super.delete(t01ComplProd);
		//执行保存前的业务代码
		for(BusinessService<T01ComplProd> businessService : businessServices){
			businessService.postDelete(t01ComplProd);
		}
	}
	
}
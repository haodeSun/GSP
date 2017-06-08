/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01complprodcert;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprodcert.T01ComplProdCert;
import com.thinkgem.jeesite.modules.gsp.dao.t01complprodcert.T01ComplProdCertDao;

/**
 * 首营产品关联资质Service
 * @author XXS
 * @version 2016-12-06
 */
@Service
@Transactional(readOnly = true)
public class T01ComplProdCertService extends ExtCrudService<T01ComplProdCertDao, T01ComplProdCert> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T01ComplProdCert>> businessServices = new ArrayList<>();

    @Autowired
    public T01ComplProdCertService(
            T01ComplProdCertDao dao) {
        super(dao);
    }

	public T01ComplProdCert get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01ComplProdCert t01ComplProdCert = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			 businessService.postFetch(t01ComplProdCert);
		}

		return t01ComplProdCert;
	}
	
	public List<T01ComplProdCert> findList(T01ComplProdCert t01ComplProdCert) {
		return super.findList(t01ComplProdCert);
	}
	
	public Page<T01ComplProdCert> findPage(Page<T01ComplProdCert> page, T01ComplProdCert t01ComplProdCert) {
		//执行保存前的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			 businessService.prePaging(page,t01ComplProdCert);
		}
		Page<T01ComplProdCert> paginator = super.findPage(page, t01ComplProdCert);
		//执行保存后的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01ComplProdCert t01ComplProdCert) throws BusinessException {
		boolean isNewRecord = t01ComplProdCert.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01ComplProdCert);
			}else{
				businessService.preInsert(t01ComplProdCert);
			}
		}
		//执行保存操作
		super.save(t01ComplProdCert);
		//执行保存后的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01ComplProdCert);
			}else{
				businessService.postInsert(t01ComplProdCert);
			}
		}
	}
	
	@Transactional
	public void delete(T01ComplProdCert t01ComplProdCert) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			businessService.preDelete(t01ComplProdCert);
		}
		//删除
		super.delete(t01ComplProdCert);
		//执行保存前的业务代码
		for(BusinessService<T01ComplProdCert> businessService : businessServices){
			businessService.postDelete(t01ComplProdCert);
		}
	}
	
}
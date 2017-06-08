/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01aggrmatr;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;
import com.thinkgem.jeesite.modules.gsp.dao.t01aggrmatr.T01AggrMatrDao;

/**
 * 协议与物料的关联信息Service
 * @author XXS
 * @version 2016-12-05
 */
@Service
@Transactional(readOnly = true)
public class T01AggrMatrService extends ExtCrudService<T01AggrMatrDao, T01AggrMatr> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T01AggrMatr>> businessServices = new ArrayList<>();

    @Autowired
    public T01AggrMatrService(
            T01AggrMatrDao dao) {
        super(dao);
    }

	public T01AggrMatr get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01AggrMatr t01AggrMatr = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			 businessService.postFetch(t01AggrMatr);
		}

		return t01AggrMatr;
	}
	
	public List<T01AggrMatr> findList(T01AggrMatr t01AggrMatr) {
		return super.findList(t01AggrMatr);
	}
	
	public Page<T01AggrMatr> findPage(Page<T01AggrMatr> page, T01AggrMatr t01AggrMatr) {
		//执行保存前的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			 businessService.prePaging(page,t01AggrMatr);
		}
		Page<T01AggrMatr> paginator = super.findPage(page, t01AggrMatr);
		//执行保存后的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01AggrMatr t01AggrMatr) throws BusinessException {
		boolean isNewRecord = t01AggrMatr.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01AggrMatr);
			}else{
				businessService.preInsert(t01AggrMatr);
			}
		}
		//执行保存操作
		super.save(t01AggrMatr);
		//执行保存后的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01AggrMatr);
			}else{
				businessService.postInsert(t01AggrMatr);
			}
		}
	}
	
	@Transactional
	public void delete(T01AggrMatr t01AggrMatr) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			businessService.preDelete(t01AggrMatr);
		}
		//删除
		super.delete(t01AggrMatr);
		//执行保存前的业务代码
		for(BusinessService<T01AggrMatr> businessService : businessServices){
			businessService.postDelete(t01AggrMatr);
		}
	}
	
}
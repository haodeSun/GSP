/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01matrsync;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrsync.T01MatrSync;
import com.thinkgem.jeesite.modules.gsp.dao.t01matrsync.T01MatrSyncDao;

/**
 * 物料信息同步Service
 * @author xxs
 * @version 2016-11-30
 */
@Service
@Transactional(readOnly = true)
public class T01MatrSyncService extends ExtCrudService<T01MatrSyncDao, T01MatrSync> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T01MatrSync>> businessServices = new ArrayList<>();

    @Autowired
    public T01MatrSyncService(
            T01MatrSyncDao dao) {
        super(dao);
    }

	public T01MatrSync get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01MatrSync t01MatrSync = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			 businessService.postFetch(t01MatrSync);
		}

		return t01MatrSync;
	}
	
	public List<T01MatrSync> findList(T01MatrSync t01MatrSync) {
		return super.findList(t01MatrSync);
	}
	
	public Page<T01MatrSync> findPage(Page<T01MatrSync> page, T01MatrSync t01MatrSync) {
		//执行保存前的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			 businessService.prePaging(page,t01MatrSync);
		}
		Page<T01MatrSync> paginator = super.findPage(page, t01MatrSync);
		//执行保存后的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01MatrSync t01MatrSync) throws BusinessException {
		boolean isNewRecord = t01MatrSync.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01MatrSync);
			}else{
				businessService.preInsert(t01MatrSync);
			}
		}
		//执行保存操作
		super.save(t01MatrSync);
		//执行保存后的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01MatrSync);
			}else{
				businessService.postInsert(t01MatrSync);
			}
		}
	}
	
	@Transactional
	public void delete(T01MatrSync t01MatrSync) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			businessService.preDelete(t01MatrSync);
		}
		//删除
		super.delete(t01MatrSync);
		//执行保存前的业务代码
		for(BusinessService<T01MatrSync> businessService : businessServices){
			businessService.postDelete(t01MatrSync);
		}
	}
	
}
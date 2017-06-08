/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01compinfo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.dao.t01compinfo.T01CompInfoDao;

/**
 * 企业信息Service
 * @author XXS
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class T01CompInfoService extends ExtCrudService<T01CompInfoDao, T01CompInfo> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T01CompInfo>> businessServices = new ArrayList<>();

    @Autowired
    public T01CompInfoService(
            T01CompInfoDao dao) {
        super(dao);
    }

	public T01CompInfo get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01CompInfo t01CompInfo = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			 businessService.postFetch(t01CompInfo);
		}

		return t01CompInfo;
	}
	
	public List<T01CompInfo> findList(T01CompInfo t01CompInfo) {
		return super.findList(t01CompInfo);
	}
	
	public Page<T01CompInfo> findPage(Page<T01CompInfo> page, T01CompInfo t01CompInfo) {
		//执行保存前的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			 businessService.prePaging(page,t01CompInfo);
		}
		Page<T01CompInfo> paginator = super.findPage(page, t01CompInfo);
		//执行保存后的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01CompInfo t01CompInfo) throws BusinessException {
		boolean isNewRecord = t01CompInfo.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01CompInfo);
			}else{
				businessService.preInsert(t01CompInfo);
			}
		}
		//执行保存操作
		super.save(t01CompInfo);
		//执行保存后的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01CompInfo);
			}else{
				businessService.postInsert(t01CompInfo);
			}
		}
	}
	
	@Transactional
	public void delete(T01CompInfo t01CompInfo) {
		//执行保存前的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			businessService.preDelete(t01CompInfo);
		}
		//删除
		try {
			super.delete(t01CompInfo);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		//执行保存前的业务代码
		for(BusinessService<T01CompInfo> businessService : businessServices){
			businessService.postDelete(t01CompInfo);
		}
	}
	
}
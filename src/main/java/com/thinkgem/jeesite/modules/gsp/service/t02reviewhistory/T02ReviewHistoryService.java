/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02reviewhistory;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t02reviewhistory.T02ReviewHistory;
import com.thinkgem.jeesite.modules.gsp.dao.t02reviewhistory.T02ReviewHistoryDao;

/**
 * 审核记录Service
 * @author yohu
 * @version 2016-11-17
 */
@Service
@Transactional(readOnly = true)
public class T02ReviewHistoryService extends ExtCrudService<T02ReviewHistoryDao, T02ReviewHistory> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T02ReviewHistory>> businessServices = new ArrayList<>();

    @Autowired
    public T02ReviewHistoryService(
            T02ReviewHistoryDao dao) {
        super(dao);
    }

	public T02ReviewHistory get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			businessService.preFetch(id);
		}
		T02ReviewHistory t02ReviewHistory = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			 businessService.postFetch(t02ReviewHistory);
		}

		return t02ReviewHistory;
	}
	
	public List<T02ReviewHistory> findList(T02ReviewHistory t02ReviewHistory) {
		return super.findList(t02ReviewHistory);
	}
	
	public Page<T02ReviewHistory> findPage(Page<T02ReviewHistory> page, T02ReviewHistory t02ReviewHistory) {
		//执行保存前的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			 businessService.prePaging(page,t02ReviewHistory);
		}
		Page<T02ReviewHistory> paginator = super.findPage(page, t02ReviewHistory);
		//执行保存后的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T02ReviewHistory t02ReviewHistory) throws BusinessException {
		boolean isNewRecord = t02ReviewHistory.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t02ReviewHistory);
			}else{
				businessService.preInsert(t02ReviewHistory);
			}
		}
		//执行保存操作
		super.save(t02ReviewHistory);
		//执行保存后的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t02ReviewHistory);
			}else{
				businessService.postInsert(t02ReviewHistory);
			}
		}
	}
	
	@Transactional
	public void delete(T02ReviewHistory t02ReviewHistory) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			businessService.preDelete(t02ReviewHistory);
		}
		//删除
		super.delete(t02ReviewHistory);
		//执行保存前的业务代码
		for(BusinessService<T02ReviewHistory> businessService : businessServices){
			businessService.postDelete(t02ReviewHistory);
		}
	}
	
}
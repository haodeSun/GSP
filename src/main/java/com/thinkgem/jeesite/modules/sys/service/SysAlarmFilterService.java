/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;
import com.thinkgem.jeesite.modules.sys.dao.SysAlarmFilterDao;

/**
 * 预警过滤配置Service
 * @author yohu
 * @version 2016-12-26
 */
@Service
@Transactional(readOnly = true)
public class SysAlarmFilterService extends ExtCrudService<SysAlarmFilterDao, SysAlarmFilter> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<SysAlarmFilter>> businessServices = new ArrayList<>();
	
    @Autowired
    public SysAlarmFilterService(
            SysAlarmFilterDao dao) {
        super(dao);
    }

	public SysAlarmFilter get(String id) {
		//执行保存前的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			businessService.preFetch(id);
		}
		SysAlarmFilter sysAlarmFilter = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			 businessService.postFetch(sysAlarmFilter);
		}

		return sysAlarmFilter;
	}
	
	public List<SysAlarmFilter> findList(SysAlarmFilter sysAlarmFilter) {
		return super.findList(sysAlarmFilter);
	}
	
	public Page<SysAlarmFilter> findPage(Page<SysAlarmFilter> page, SysAlarmFilter sysAlarmFilter) {
		//执行保存前的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			 businessService.prePaging(page,sysAlarmFilter);
		}
		Page<SysAlarmFilter> paginator = super.findPage(page, sysAlarmFilter);
		//执行保存后的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(SysAlarmFilter sysAlarmFilter) throws BusinessException {
		boolean isNewRecord = sysAlarmFilter.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(sysAlarmFilter);
			}else{
				businessService.preInsert(sysAlarmFilter);
			}
		}
		//执行保存操作
		super.save(sysAlarmFilter);
		//执行保存后的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(sysAlarmFilter);
			}else{
				businessService.postInsert(sysAlarmFilter);
			}
		}
	}
	
	@Transactional
	public void delete(SysAlarmFilter sysAlarmFilter) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			businessService.preDelete(sysAlarmFilter);
		}
		//删除
		super.delete(sysAlarmFilter);
		//执行保存前的业务代码
		for(BusinessService<SysAlarmFilter> businessService : businessServices){
			businessService.postDelete(sysAlarmFilter);
		}
	}
}
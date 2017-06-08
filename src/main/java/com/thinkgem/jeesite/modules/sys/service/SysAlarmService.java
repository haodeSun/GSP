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
import com.thinkgem.jeesite.modules.sys.dao.SysAlarmDao;

/**
 * 预警配置表Service
 * @author yohu
 * @version 2016-12-21
 */
@Service
@Transactional(readOnly = true)
public class SysAlarmService extends ExtCrudService<SysAlarmDao, SysAlarm> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<SysAlarm>> businessServices = new ArrayList<>();

	
    @Autowired
    public SysAlarmService(
            SysAlarmDao dao) {
        super(dao);
    }

	public SysAlarm get(String id) {
		//执行保存前的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			businessService.preFetch(id);
		}
		SysAlarm sysAlarm = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			 businessService.postFetch(sysAlarm);
		}

		return sysAlarm;
	}
	
	public List<SysAlarm> findList(SysAlarm sysAlarm) {
		return super.findList(sysAlarm);
	}
	
	public Page<SysAlarm> findPage(Page<SysAlarm> page, SysAlarm sysAlarm) {
		//执行保存前的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			 businessService.prePaging(page,sysAlarm);
		}
		Page<SysAlarm> paginator = super.findPage(page, sysAlarm);
		//执行保存后的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(SysAlarm sysAlarm) throws BusinessException {
		boolean isNewRecord = sysAlarm.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(sysAlarm);
			}else{
				businessService.preInsert(sysAlarm);
			}
		}
		//执行保存操作
		super.save(sysAlarm);
		//执行保存后的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(sysAlarm);
			}else{
				businessService.postInsert(sysAlarm);
			}
		}
	}
	
	@Transactional
	public void delete(SysAlarm sysAlarm) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			businessService.preDelete(sysAlarm);
		}
		//删除
		super.delete(sysAlarm);
		//执行保存前的业务代码
		for(BusinessService<SysAlarm> businessService : businessServices){
			businessService.postDelete(sysAlarm);
		}
	}
}
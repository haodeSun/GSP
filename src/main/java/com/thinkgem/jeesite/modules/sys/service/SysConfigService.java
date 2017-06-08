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
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
import com.thinkgem.jeesite.modules.sys.dao.SysConfigDao;

/**
 * 保存系统配置Service
 * @author yohu
 * @version 2016-12-16
 */
public class SysConfigService extends ExtCrudService<SysConfigDao, SysConfig> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<SysConfig>> businessServices = new ArrayList<>();

    @Autowired
    public SysConfigService(
            SysConfigDao dao) {
        super(dao);
    }

	public SysConfig get(String id) {
		//执行保存前的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			businessService.preFetch(id);
		}
		SysConfig sysConfig = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			 businessService.postFetch(sysConfig);
		}

		return sysConfig;
	}
	
	public List<SysConfig> findList(SysConfig sysConfig) {
		return super.findList(sysConfig);
	}
	
	public Page<SysConfig> findPage(Page<SysConfig> page, SysConfig sysConfig) {
		//执行保存前的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			 businessService.prePaging(page,sysConfig);
		}
		Page<SysConfig> paginator = super.findPage(page, sysConfig);
		//执行保存后的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(SysConfig sysConfig) throws BusinessException {
		boolean isNewRecord = sysConfig.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(sysConfig);
			}else{
				businessService.preInsert(sysConfig);
			}
		}
		//执行保存操作
		super.save(sysConfig);
		//执行保存后的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(sysConfig);
			}else{
				businessService.postInsert(sysConfig);
			}
		}
	}
	
	@Transactional
	public void delete(SysConfig sysConfig) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			businessService.preDelete(sysConfig);
		}
		//删除
		super.delete(sysConfig);
		//执行保存前的业务代码
		for(BusinessService<SysConfig> businessService : businessServices){
			businessService.postDelete(sysConfig);
		}
	}
	
}
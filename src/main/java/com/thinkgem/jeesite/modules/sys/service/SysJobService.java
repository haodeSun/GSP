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
import com.thinkgem.jeesite.modules.sys.entity.SysJob;
import com.thinkgem.jeesite.modules.sys.dao.SysJobDao;

/**
 * 保存job信息Service
 * @author yohu
 * @version 2016-12-04
 */
@Service
@Transactional(readOnly = true)
public class SysJobService extends ExtCrudService<SysJobDao, SysJob> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<SysJob>> businessServices = new ArrayList<>();

    @Autowired
    public SysJobService(
            SysJobDao dao) {
        super(dao);
    }

	public SysJob get(String id) {
		//执行保存前的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			businessService.preFetch(id);
		}
		SysJob sysJob = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			 businessService.postFetch(sysJob);
		}

		return sysJob;
	}
	
	public List<SysJob> findList(SysJob sysJob) {
		return super.findList(sysJob);
	}
	
	public Page<SysJob> findPage(Page<SysJob> page, SysJob sysJob) {
		//执行保存前的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			 businessService.prePaging(page,sysJob);
		}
		Page<SysJob> paginator = super.findPage(page, sysJob);
		//执行保存后的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(SysJob sysJob) throws BusinessException {
		boolean isNewRecord = sysJob.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(sysJob);
			}else{
				businessService.preInsert(sysJob);
			}
		}
		//执行保存操作
		super.save(sysJob);
		//执行保存后的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(sysJob);
			}else{
				businessService.postInsert(sysJob);
			}
		}
	}
	
	@Transactional
	public void delete(SysJob sysJob) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			businessService.preDelete(sysJob);
		}
		//删除
		super.delete(sysJob);
		//执行保存前的业务代码
		for(BusinessService<SysJob> businessService : businessServices){
			businessService.postDelete(sysJob);
		}
	}
	
}
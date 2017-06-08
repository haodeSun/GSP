/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.sysusernotice;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.sysusernotice.SysUserNoticeDao;
import com.thinkgem.jeesite.modules.gsp.entity.sysusernotice.SysUserNotice;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户notice表Service
 * @author gyq
 * @version 2016-10-29
 */
@Service
@Transactional(readOnly = true)
public class SysUserNoticeService extends ExtCrudService<SysUserNoticeDao, SysUserNotice> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required = false)
	private List<BusinessService<SysUserNotice>> businessServices = new ArrayList<>();

	@Autowired
	public SysUserNoticeService(SysUserNoticeDao dao){
		super(dao);
	}

	public SysUserNotice get(String id) {
		//执行保存前的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				businessService.preFetch(id);
			}
		}
		SysUserNotice sysUserNotice = super.get(id);
		
		//执行保存后的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				 businessService.postFetch(sysUserNotice);
			}
		}
		
		return sysUserNotice;
	}
	
	public List<SysUserNotice> findList(SysUserNotice sysUserNotice) {
		return super.findList(sysUserNotice);
	}
	
	public Page<SysUserNotice> findPage(Page<SysUserNotice> page, SysUserNotice sysUserNotice) {
		//执行保存前的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				 businessService.prePaging(page,sysUserNotice);
			}
		}
		Page<SysUserNotice> paginator = super.findPage(page, sysUserNotice);
		//执行保存后的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				businessService.postPaging(paginator);
			}
		}
		return paginator;
	}
	
	@Transactional
	public void save(SysUserNotice sysUserNotice) throws BusinessException {
		boolean isNewRecord = sysUserNotice.getIsNewRecord();
		//执行保存前的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				if(!isNewRecord){
					businessService.preUpdate(sysUserNotice);
				}else{
					businessService.preInsert(sysUserNotice);
				}
			}
		}
		//执行保存操作
		super.save(sysUserNotice);
		//执行保存后的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				if(!isNewRecord){
					businessService.postUpdate(sysUserNotice);
				}else{
					businessService.postInsert(sysUserNotice);
				}
			}
		}
	}
	
	@Transactional
	public void delete(SysUserNotice sysUserNotice) throws BusinessException{
		//执行保存前的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				businessService.preDelete(sysUserNotice);
			}
		}
		//删除
		super.delete(sysUserNotice);
		//执行保存前的业务代码
		if(businessServices != null && businessServices.size()>0){
			for(BusinessService<SysUserNotice> businessService : businessServices){
				businessService.postDelete(sysUserNotice);
			}
		}
	}
	
}
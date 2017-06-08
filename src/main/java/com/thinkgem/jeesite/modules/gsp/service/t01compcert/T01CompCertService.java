/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01compcert;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.QualificationService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.dao.t01compcert.T01CompCertDao;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmFilterService;

/**
 * 企业资质Service
 * @author XXS
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class T01CompCertService extends QualificationService<T01CompCertDao, T01CompCert> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required=false)
	private List<BusinessService<T01CompCert>> businessServices = new ArrayList<>();

	@Autowired
	private SysAlarmFilterService sysalarmFilterService;
    @Autowired
    public T01CompCertService(
            T01CompCertDao dao) {
        super(dao);
    }

	public T01CompCert get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01CompCert t01CompCert = super.get(id);
		
		//执行保存后的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			 businessService.postFetch(t01CompCert);
		}

		return t01CompCert;
	}
	
	public List<T01CompCert> findList(T01CompCert t01CompCert) {
		return super.findList(t01CompCert);
	}
	
	public Page<T01CompCert> findPage(Page<T01CompCert> page, T01CompCert t01CompCert) {
		//执行保存前的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			 businessService.prePaging(page,t01CompCert);
		}
		Page<T01CompCert> paginator = super.findPage(page, t01CompCert);
		//执行保存后的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01CompCert t01CompCert) throws BusinessException {
		boolean isNewRecord = t01CompCert.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01CompCert);
			}else{
				businessService.preInsert(t01CompCert);
			}
		}
		//执行保存操作
		super.save(t01CompCert);
		//执行保存后的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01CompCert);
			}else{
				businessService.postInsert(t01CompCert);
			}
		}
	}
	
	@Transactional
	public void delete(T01CompCert t01CompCert) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			businessService.preDelete(t01CompCert);
		}
		//删除
		super.delete(t01CompCert);
		//执行保存前的业务代码
		for(BusinessService<T01CompCert> businessService : businessServices){
			businessService.postDelete(t01CompCert);
		}
	}

	@Override
	public List<Map<String, String>> retrieveAlarmNameList(SysAlarm sysAlarm) {
		T01CompCert compCert = new T01CompCert();
		compCert.setCertType(sysAlarm.getQualifyType());
		List<SysAlarmFilter> filters = sysalarmFilterService.findList(new SysAlarmFilter());
		List<T01CompCert> compCertList = this.findList(compCert);
		List<Map<String, String>> alarmList = new ArrayList<Map<String, String>>();
		for (T01CompCert t01CompCert:compCertList) {
			Boolean flag = false;
			for (SysAlarmFilter filter : filters) {
				if (filter.getRole().equals("sysAlarm:"+t01CompCert.getId())) {
					if (filter.getIncluded()) {
						Date validPeriDate = t01CompCert.getValidDate();
						//判断是否需要预警
						if (checkAlarm(validPeriDate, sysAlarm)) {
							Map<String, String> map = new HashMap<String,String>();
							map.put("name", t01CompCert.getCertName());
							map.put("id", t01CompCert.getId());
							alarmList.add(map);
							logger.debug("预警提醒："+t01CompCert.getCertName());
						}	
					}
				}
				if (!filter.getIncluded()) {
					if (filter.getRole().equals("sysAlarm:"+t01CompCert.getId())) {
						flag=true;
						break;
					}
				}
			
			}
			if (!flag) {
				Date validPeriDate = t01CompCert.getValidDate();
				//判断是否需要预警
				if (checkAlarm(validPeriDate, sysAlarm)) {
					Map<String, String> map = new HashMap<String,String>();
					map.put("name", t01CompCert.getCertName());
					map.put("id", t01CompCert.getId());
					alarmList.add(map);
					logger.debug("预警提醒："+t01CompCert.getCertName());
				}
			}
		}
		return alarmList;
	}
	
}
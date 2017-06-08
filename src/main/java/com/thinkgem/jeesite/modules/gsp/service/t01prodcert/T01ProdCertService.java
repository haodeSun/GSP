/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01prodcert;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.SysChanInfoDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplStat;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.QualificationService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmFilterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 产品资质Service
 * @author gyq
 * @version 2016-11-28
 */
@Transactional(readOnly = false)
public class T01ProdCertService extends QualificationService<T01ProdCertDao, T01ProdCert> {
    private int defaultEffectiveMonths = 6;

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required = false)
	private List<BusinessService<T01ProdCert>> businessServices = new ArrayList<>();

	@Autowired
	private SysAlarmFilterService sysalarmFilterService;
	private SysChanInfoDao sysChanInfoDao;

    @Autowired
    public T01ProdCertService(
            T01ProdCertDao dao ,
            SysChanInfoDao SysChanInfoDao
            ) {
    		super(dao);
            this.sysChanInfoDao = SysChanInfoDao;
    }

	public T01ProdCert get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			businessService.preFetch(id);
		}
		T01ProdCert t01ProdCert = super.get(id);

		//执行保存后的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			 businessService.postFetch(t01ProdCert);
		}
		return t01ProdCert;
	}

	public List<T01ProdCert> findList(T01ProdCert t01ProdCert) {
		return super.findList(t01ProdCert);
	}

	public Page<T01ProdCert> findPage(Page<T01ProdCert> page, T01ProdCert t01ProdCert) {
		//执行保存前的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			 businessService.prePaging(page,t01ProdCert);
		}
		Page<T01ProdCert> paginator = super.findPage(page, t01ProdCert);
		//执行保存后的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}

	@Transactional
	public void save(T01ProdCert t01ProdCert) throws BusinessException {
		boolean isNewRecord = t01ProdCert.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t01ProdCert);
			}else{
				businessService.preInsert(t01ProdCert);
			}
		}
		super.save(t01ProdCert);
		t01ProdCert.getSysChanInfoList()
		            .stream()
		            .filter( sysChanInfo -> sysChanInfo.getId() != null )
		            .forEach( sysChanInfo -> {
			            if (SysChanInfo.DEL_FLAG_NORMAL.equals(sysChanInfo.getDelFlag())){
				            if (StringUtils.isBlank(sysChanInfo.getId())){
				                sysChanInfo.setChanId(t01ProdCert);
	                            sysChanInfo.preInsert();
					            sysChanInfoDao.insert(sysChanInfo);
				            }else{
					            sysChanInfo.preUpdate();
					            sysChanInfoDao.update(sysChanInfo);
				            }
			            } else {
				                sysChanInfoDao.delete(sysChanInfo);
			            }
		            });
		//执行保存后的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t01ProdCert);
			}else{
				businessService.postInsert(t01ProdCert);
			}
		}
	}

	@Transactional
	public void delete(T01ProdCert t01ProdCert) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			businessService.preDelete(t01ProdCert);
		}
		//删除
		super.delete(t01ProdCert);
		sysChanInfoDao.delete(new SysChanInfo(t01ProdCert));
		//执行保存前的业务代码
		for(BusinessService<T01ProdCert> businessService : businessServices){
			businessService.postDelete(t01ProdCert);
		}
	}
    /**
     * 自动设置资质状态
     * @param entity 资质数据
     */
    private void calcAndsetCertStat(T01ProdCert entity) {
        //先判断系统配置中是否配置了，有效期（月），如果没有，则去默认值
        int effeArea = defaultEffectiveMonths;
        Calendar calendar = Calendar.getInstance();
        //计算出近效期时间点
        calendar.setTime(entity.getValidPeri());
        calendar.add(Calendar.MONTH, 0 - effeArea);
        Date willInvalDate = calendar.getTime();
        //只处理提交了  生效日期  和  有效期至 的
        if(
                entity != null
                        && entity.getEffeDate() != null
                        && entity.getValidPeri() != null) {
            //.失效：      now > vaildPeri ||   now < effeDate
            Date currentDate = DateUtils.parseDate(DateUtils.getDate());
            calendar.setTime(currentDate);
            if (DateUtils.toCalendar(entity.getEffeDate())
                    .before(DateUtils.toCalendar(entity.getValidPeri()))) {
                if (DateUtils.toCalendar(entity.getValidPeri()).before(calendar)
                        || DateUtils.toCalendar(entity.getEffeDate()).after(calendar)) {
                    //只要是失效的，就都为失效状态，不管到没到近效期
                    entity.setCertStat(ProdCertStatus.CertStatus.INVALID.toString());
                    //生效：now >= effeDate
                } else if (calendar.after(DateUtils.toCalendar(entity.getEffeDate()))
                        || calendar.equals(DateUtils.toCalendar(entity.getEffeDate()))) {
                    //到近效期  近效期      now＞ vaildPeri - 近效期（月） 　&&　now <= vaildPeri
                    if (calendar.after(DateUtils.toCalendar(willInvalDate))
                            && (calendar.before(DateUtils.toCalendar(entity.getValidPeri()))
                            || calendar.equals(DateUtils.toCalendar(entity.getValidPeri())))) {
                        //资质状态为   近效期
                        entity.setCertStat(ProdCertStatus.CertStatus.WILLINVALID.toString());
                        //未到近效期     now < vaildPeri - 近效期（月） && now>=effeDate
                    } else if (calendar.before(DateUtils.toCalendar(entity.getValidPeri()))
                            && (calendar.after(DateUtils.toCalendar(entity.getEffeDate()))
                            || calendar.equals(DateUtils.toCalendar(entity.getEffeDate())))) {
                        //资质状态为  生效
                        entity.setCertStat(ProdCertStatus.CertStatus.EFFECTIVE.toString());
                    } else {
                        //其他情况默认为空
                        entity.setCertStat(null);
                    }
                } else {
                    entity.setCertStat(null);
                }
            } else {
                entity.setCertStat(null);
            }
        }else{
            entity.setCertStat(null);
        }
    }
    private void updateAlarmState(T01ProdCert entity) throws BusinessException {
        T01ProdCert t01ProdCert = get(entity.getId());
        calcAndsetCertStat(t01ProdCert);
        dao.update(t01ProdCert);
    }

	@Override
	public List<Map<String, String>> retrieveAlarmNameList(SysAlarm sysAlarm) throws BusinessException {
		T01ProdCert prodCert = new T01ProdCert();

		List<T01ProdCert> prodCertList = this.findList(prodCert);
		//2：冻结的数据没有近效期提醒
		if (!prodCertList.isEmpty()) {
			prodCertList = prodCertList.stream()
					.filter(item -> !ComplSuplStat.FREEZE.equals(item.getCertStat()))
					.collect(Collectors.toList());
		}
		//所有状态都要改
		for (T01ProdCert item : prodCertList) {
			updateAlarmState(item);
		}
		if (!prodCertList.isEmpty()) {
			//只有审批通过的有提醒
			prodCertList = prodCertList.stream()
					.filter(item -> ApprStatus.PASS.toString().equals(item.getApprStat()))
					.collect(Collectors.toList());
		}
		List<SysAlarmFilter> filters = sysalarmFilterService.findList(new SysAlarmFilter());

		List<Map<String, String>> alarmList = new ArrayList<Map<String, String>>();
		for (T01ProdCert item:prodCertList) {
			Boolean needAlarm = true;
			for (SysAlarmFilter filter : filters) {
				//4:如果是包含规则
				if (filter.getIncluded()) {
					if (filter.getRole().equals("sysAlarm:t01ProdCert:" + item.getId())) {
						needAlarm = false;
					}
				} else {
					//4:如果是非包含规则
					if (!filter.getRole().equals("sysAlarm:t01ProdCert:" + item.getId())) {
						needAlarm = false;
					}
				}

			}
			if (needAlarm) {
				Date validPeriDate = item.getValidPeri();
				//判断是否需要预警
				if (checkAlarm(validPeriDate, sysAlarm)) {
					Map<String, String> map = new HashMap<String,String>();
                    map.put("type", "产品资质有效期预警");
					map.put("name", item.getProdNameCn());
					map.put("id", item.getId());
					alarmList.add(map);
				}
			}
		}

		return alarmList;
	}
}

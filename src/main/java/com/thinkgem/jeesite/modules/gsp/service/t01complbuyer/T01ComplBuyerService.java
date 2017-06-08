/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01complbuyer;

import java.util.*;
import java.util.stream.Collectors;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer.SysChangeInfoDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.ComplBuyerCertType;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.SysChangeInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplStat;
import com.thinkgem.jeesite.modules.gsp.service.QualificationService;
import com.thinkgem.jeesite.modules.gsp.service.exception.EntityExistedException;
import com.thinkgem.jeesite.modules.gsp.service.exception.SetValueException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer.T01ComplBuyerDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;

/**
 * 首营购货者Service
 *
 * @author XXS
 * @version 2016-12-13
 */
@Transactional(readOnly = true)
public class T01ComplBuyerService extends QualificationService<T01ComplBuyerDao, T01ComplBuyer> {

    /**
     * 业务表表名
     */
    protected static final String BUSINESS_TABLE = "t01_compl_buyer";
    protected static final String BUSINESS_MODULE = "t01ComplBuyer";

    /**
     * 变更信息表dao
     */
    @Autowired
    protected SysChangeInfoDao sysChangeInfoDao;
    @Autowired
    protected SystemService systemService;
    /**
     * 企业信息service
     */
    @Autowired
    protected T01CompInfoService t01CompInfoService;
    /**
     * 企业资质service
     */
    @Autowired
    protected T01CompCertService t01CompCertService;

    @Autowired
    protected T01ComplBuyerHelperService t01ComplBuyerHelperService;

    @Autowired
    public T01ComplBuyerService(
            T01ComplBuyerDao dao) {
        super(dao);
    }

    public T01ComplBuyer get(String id) {
        T01ComplBuyer entity = super.get(id);

        //设置经营范围数据列表
        entity.setCertScopList(systemService.findAllCertScop());

        //设置变更记录
        SysChangeInfo sysChangeInfo = new SysChangeInfo();
        sysChangeInfo.setChanTbl(BUSINESS_TABLE);
        sysChangeInfo.setChanId(entity);
        entity.setSysChanInfoList(sysChangeInfoDao.findList(sysChangeInfo));

        return entity;
    }

    public List<T01ComplBuyer> findList(T01ComplBuyer t01ComplBuyer) {
        return super.findList(t01ComplBuyer);
    }

    public Page<T01ComplBuyer> findPage(Page<T01ComplBuyer> page, T01ComplBuyer t01ComplBuyer) {

        Page<T01ComplBuyer> paginator = super.findPage(page, t01ComplBuyer);

        return paginator;
    }

    /**
     * 获取企业id并赋值到购货者entity的企业id字段
     *
     * @param entity 购货者entity
     */
    private void saveCompInfo(T01ComplBuyer entity) throws BusinessException {
        T01CompInfo t01CompInfo = entity.getT01CompInfo();
        t01CompInfoService.save(t01CompInfo);
        entity.setT01CompInfo(t01CompInfo);
        entity.setCompId(entity.getT01CompInfo().getId());
    }

    @Transactional
    public void save(T01ComplBuyer t01ComplBuyer) throws BusinessException {

        t01ComplBuyerHelperService.checkStatusBeforeHandle("save", t01ComplBuyer);

        saveCompInfo(t01ComplBuyer);

        saveCompCert(t01ComplBuyer);

        setBuyerStat(t01ComplBuyer);
        //执行保存操作
        super.save(t01ComplBuyer);

    }

    /**
     * 保存企业资质相关的数据
     *
     * @param entity entity
     * @throws BusinessException exception
     */
    private void saveCompCert(T01ComplBuyer entity) throws BusinessException {

        T01CompCert t01CompCert; //企业资质entity

        if (entity.getT01CompCert0() != null) {
            t01CompCert = entity.getT01CompCert0();
            if("0".equals(entity.getT01CompInfo().getAbroad())) {
                t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
            }else {
                t01CompCert=new T01CompCert();
                t01CompCert.setId(entity.getT01CompCert0().getId());
            }
            t01CompCert.setCompId(entity.getT01CompInfo().getId());
            //企业信息的统一社会信用代码或注册号为企业营业执照资质的编号
            if (StringUtils.isNotBlank(entity.getT01CompInfo().getUniCretNbr())) {
                t01CompCert.setCertNbr(entity.getT01CompInfo().getUniCretNbr());
            } else {
                t01CompCert.setCertNbr(entity.getT01CompInfo().getRegiNbr());
            }
            t01CompCert.setCertType("0");//企业资质（国内）

            t01CompCertService.save(t01CompCert);
        }

        if (entity.getT01CompCert3() != null) {
            t01CompCert = entity.getT01CompCert3();
            if("1".equals(entity.getT01CompInfo().getAbroad())) {
                t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
            }else {
                t01CompCert=new T01CompCert();
                t01CompCert.setId(entity.getT01CompCert3().getId());
            }
            t01CompCert.setCompId(entity.getT01CompInfo().getId());
            t01CompCert.setCertNbr(entity.getT01CompInfo().getCompUniNbr());
            t01CompCert.setCertType("3");//企业资质（国外）

            t01CompCertService.save(t01CompCert);
        }

        //当保存经营资质和医疗机构执业许可  资质的id要根据企业的id来设置
        //保证一个企业id不同资质类型只有一条记录
        if (entity.getT01CompCert1() != null) {

            if(ComplBuyerCertType.BusinessPermit.equals(entity.getCertType())) {
                t01CompCert = entity.getT01CompCert1();
                //只有国内企业才设置资质状态 国外企业没有资质状态
                if("0".equals(entity.getT01CompInfo().getAbroad())) {
                    t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
                }
            }else {
                T01CompCert search = new T01CompCert();
                search.setCompId(entity.getT01CompInfo().getId());
                search.setCertType("1");
                List<T01CompCert> list1 = t01CompCertService.findList(search);
                if (list1 != null && !list1.isEmpty()) {
                    t01CompCert=list1.get(0);
                } else {
                    t01CompCert = new T01CompCert();
                }
            }

            t01CompCert.setCompId(entity.getT01CompInfo().getId());
            t01CompCert.setCertType("1");//经营资质

            T01CompCert search1=new T01CompCert();
            search1.setCompId(entity.getT01CompInfo().getId());
            search1.setCertType("1");
            List<T01CompCert> list1=t01CompCertService.findList(search1);
            if(list1!=null&&!list1.isEmpty()){
                t01CompCert.setId(list1.get(0).getId());
            }else {
                t01CompCert.setId(null);
            }
            t01CompCertService.save(t01CompCert);
        }
        if (entity.getT01CompCert4() != null) {

            if(ComplBuyerCertType.MedicalPracticeLicense.equals(entity.getCertType())) {
                t01CompCert = entity.getT01CompCert4();
                //只有国内企业才设置资质状态 国外企业没有资质状态
                if("0".equals(entity.getT01CompInfo().getAbroad())) {
                    t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
                }
            }else {
                t01CompCert=new T01CompCert();
            }

            t01CompCert.setCompId(entity.getT01CompInfo().getId());
            t01CompCert.setCertType("4");//医疗机构执业许可

            T01CompCert search4=new T01CompCert();
            search4.setCompId(entity.getT01CompInfo().getId());
            search4.setCertType("4");
            List<T01CompCert> list4=t01CompCertService.findList(search4);
            if(list4!=null&&!list4.isEmpty()){
                t01CompCert.setId(list4.get(0).getId());
            }else {
                t01CompCert.setId(null);
            }

            t01CompCertService.save(t01CompCert);
        }
    }

    /**
     * 设置购货者状态
     *
     * @param entity entity
     */
    private void setBuyerStat(T01ComplBuyer entity) throws BusinessException {
        if (entity != null) {
            try {
                String stat0, stat1;

                //国内 0
                if("0".equals(entity.getT01CompInfo().getAbroad())) {
                    stat0 = checkBuyerStat(entity.getT01CompCert0().getEffecDate(), entity.getT01CompCert0().getValidDate());
                    if (ComplBuyerCertType.BusinessPermit.equals(entity.getCertType())) {
                        stat1 = checkBuyerStat(entity.getT01CompCert1().getEffecDate(), entity.getT01CompCert1().getValidDate());
                    } else {
                        stat1 = checkBuyerStat(entity.getT01CompCert4().getEffecDate(), entity.getT01CompCert4().getValidDate());
                    }
                    if (ComplSuplStat.NOT_EFFECTIVE.equals(stat0) || ComplSuplStat.NOT_EFFECTIVE.equals(stat1)) {
                        entity.setBuyerStat(ComplSuplStat.NOT_EFFECTIVE);
                    } else if (ComplSuplStat.NEAR_EFFECTIVE.equals(stat0) || ComplSuplStat.NEAR_EFFECTIVE.equals(stat1)) {
                        entity.setBuyerStat(ComplSuplStat.NEAR_EFFECTIVE);
                    } else {
                        entity.setBuyerStat(ComplSuplStat.EFFECTIVE);
                    }

                }else {
                    //国外 1
                    stat0 = checkBuyerStat(entity.getT01CompCert3().getEffecDate(), entity.getT01CompCert3().getValidDate());
                    entity.setBuyerStat(stat0);

                }

            } catch (Exception e) {
                throw new SetValueException("设置购货者状态失败", "");
            }
        }
    }

    @Transactional
    public void delete(T01ComplBuyer t01ComplBuyer) throws BusinessException {

        //删除
        super.delete(t01ComplBuyer);

    }

    /**
     * 通过开始时间和结束时间判断状态
     *
     * @param beginDate 开始时间
     * @param endDate   结束时间
     * @return 状态
     */
    private String checkBuyerStat(Date beginDate, Date endDate) {
        String stat = ComplSuplStat.EFFECTIVE;
        Date now = new Date();
        if (DateUtils.getDistanceDayOfTwoDate(now, beginDate) > 0 ||
                DateUtils.getDistanceDayOfTwoDate(endDate, now) > 0) {
            stat = ComplSuplStat.NOT_EFFECTIVE;
        } else if (DateUtils.getDistanceDayOfTwoDate(now, endDate) <= 6 * 30) {
            stat = ComplSuplStat.NEAR_EFFECTIVE;
        }
        return stat;
    }

    private void updateAlarmState(T01ComplBuyer entity) throws BusinessException {
        T01ComplBuyer t01ComplBuyer = get(entity.getId());
        setBuyerStat(t01ComplBuyer);
        dao.update(t01ComplBuyer);
    }

    @Override
    public List<Map<String, String>> retrieveAlarmNameList(SysAlarm sysAlarm) throws BusinessException {

        List<Map<String, String>> alarmList = new ArrayList<Map<String, String>>();

        //1：只有审批通过的数据才有近效期提醒
        T01ComplBuyer t01ComplBuyer = new T01ComplBuyer();

        List<T01ComplBuyer> t01ComplBuyerList = this.findList(t01ComplBuyer);

        //2：冻结的数据没有近效期提醒
        if (!t01ComplBuyerList.isEmpty()) {
            t01ComplBuyerList = t01ComplBuyerList.stream()
                    .filter(item -> !ComplSuplStat.FREEZE.equals(item.getBuyerStat()))
                    .collect(Collectors.toList());
        }
        //所有状态都要改
        for (T01ComplBuyer item : t01ComplBuyerList) {
            updateAlarmState(item);
        }
        if (!t01ComplBuyerList.isEmpty()) {
            //只有审批通过的有提醒
            t01ComplBuyerList = t01ComplBuyerList.stream()
                    .filter(item -> ApprStatus.PASS.toString().equals(item.getBuyerStat()))
                    .collect(Collectors.toList());
        }

        //3：过滤了的数据不再近效期提醒
        List<SysAlarmFilter> filters = sysalarmFilterService.findList(new SysAlarmFilter());


        for (T01ComplBuyer item : t01ComplBuyerList) {

            Boolean needAlarm = true;
            for (SysAlarmFilter filter : filters) {
                //4:如果是包含规则
                if (filter.getIncluded()) {
                    if (filter.getRole().equals("sysAlarm:t01ComplBuyer:" + item.getId())) {
                        needAlarm = false;
                    }
                } else {
                    //4:如果是非包含规则
                    if (!filter.getRole().equals("sysAlarm:t01ComplBuyer:" + item.getId())) {
                        needAlarm = false;
                    }
                }
            }
            if (needAlarm) {
                Date validPeriDate = getValidPeriDate(item);
                //判断是否需要预警
                if (checkAlarm(validPeriDate, sysAlarm)) {
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("type", "购货者有效期预警");
                    map.put("name", item.getT01CompInfo().getCompNameCn());
                    map.put("id", item.getId());
                    alarmList.add(map);
                }
            }
        }

        return alarmList;
    }

    private Date getValidPeriDate(T01ComplBuyer entity) {
        Date validPeriDate = null;

        T01ComplBuyer t01ComplBuyer = get(entity.getId());

        validPeriDate = t01ComplBuyer.getT01CompCert0().getValidDate();
        Date date0 = null;
        if (ComplBuyerCertType.BusinessPermit.equals(t01ComplBuyer.getCertType())) {
            date0 = t01ComplBuyer.getT01CompCert1().getValidDate();
        }
        if (ComplBuyerCertType.MedicalPracticeLicense.equals(t01ComplBuyer.getCertType())) {
            date0 = t01ComplBuyer.getT01CompCert4().getValidDate();
        }
        if (date0 != null && date0.getTime() < validPeriDate.getTime()) {
            validPeriDate = date0;
        }
        return validPeriDate;
    }

}

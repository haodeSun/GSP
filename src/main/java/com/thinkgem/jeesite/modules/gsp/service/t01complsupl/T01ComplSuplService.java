/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01complsupl;

import java.util.*;
import java.util.stream.Collectors;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01complsupl.SysChangeInfoForT01ComplSuplDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01salescert.T01SalesCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplCertType;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplStat;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.SysChangeInfoForT01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.QualificationService;
import com.thinkgem.jeesite.modules.gsp.service.exception.SetValueException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01salescert.T01SalesCertService;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.dao.t01complsupl.T01ComplSuplDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;

/**
 * 首营供货者Service
 *
 * @author Andrea
 * @version 2016-12-20
 */
@Transactional(readOnly = true)
public class T01ComplSuplService extends QualificationService<T01ComplSuplDao, T01ComplSupl> {

    /**
     * 业务表表名
     */
    protected static final String BUSINESS_TABLE = "t01_compl_supl";
    protected static final String BUSINESS_MODULE = "t01ComplSupl";
    @Autowired
    protected SystemService systemService;
    @Autowired
    protected T01SalesCertDao t01SalesCertDao;

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
    protected T01ComplSuplHelperService t01ComplSuplHelperService;

    /**
     * 变更信息表dao
     */
    @Autowired
    private SysChangeInfoForT01ComplSuplDao sysChangeInfoDao;

    @Autowired
    public T01ComplSuplService(T01ComplSuplDao dao) {
        super(dao);
    }

    public T01ComplSupl get(String id) {

        T01ComplSupl entity = super.get(id);

        //设置经营范围数据列表
        entity.setCertScopList(systemService.findAllCertScop());

        //设置变更历史记录信息
        SysChangeInfoForT01ComplSupl sysChangeInfo = new SysChangeInfoForT01ComplSupl();
        sysChangeInfo.setChanTbl(BUSINESS_TABLE);
        sysChangeInfo.setChanId(entity);
        entity.setSysChanInfoList(sysChangeInfoDao.findList(sysChangeInfo));

        //设置销售人员授权信息
        T01SalesCert t01SalesCert = new T01SalesCert();
        t01SalesCert.setComp(entity.getT01CompInfo());

        entity.setT01SalesCertList(t01SalesCertDao.findList(t01SalesCert));

        return entity;
    }

    public List<T01ComplSupl> findList(T01ComplSupl t01ComplSupl) {
        return super.findList(t01ComplSupl);
    }

    public Page<T01ComplSupl> findPage(Page<T01ComplSupl> page, T01ComplSupl t01ComplSupl) {
        Page<T01ComplSupl> paginator = super.findPage(page, t01ComplSupl);
        return paginator;
    }

    /**
     * 获取企业id并赋值到购货者entity的企业id字段
     *
     * @param entity 购货者entity
     */
    private void saveCompInfo(T01ComplSupl entity) throws BusinessException {
        T01CompInfo t01CompInfo = entity.getT01CompInfo();
        t01CompInfoService.save(t01CompInfo);
        entity.setT01CompInfo(t01CompInfo);
        entity.setCompId(entity.getT01CompInfo().getId());

    }

    /**
     * 保存企业资质相关的数据
     *
     * @param entity entity
     * @throws BusinessException exception
     */
    private void saveCompCert(T01ComplSupl entity) throws BusinessException {

        T01CompCert t01CompCert; //企业资质entity

        if (entity.getT01CompCert0() != null) {
            t01CompCert = entity.getT01CompCert0();

            if ("0".equals(entity.getT01CompInfo().getAbroad())) {
                t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
            } else {
                //如果不是国内企业 则清空国内资质的信息
                t01CompCert = new T01CompCert();
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
            if ("1".equals(entity.getT01CompInfo().getAbroad())) {
                t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
            } else {
                //如果不是国外企业 则清空国外资质的信息
                t01CompCert = new T01CompCert();
                t01CompCert.setId(entity.getT01CompCert3().getId());
            }
            t01CompCert.setCompId(entity.getT01CompInfo().getId());
            t01CompCert.setCertNbr(entity.getT01CompInfo().getCompUniNbr());
            t01CompCert.setCertType("3");//企业资质（国外）

            t01CompCertService.save(t01CompCert);
        }

        //当保存经营资质和生产资质  资质的id要根据企业的id来设置
        //保证一个企业id不同资质类型只有一条记录
        if (entity.getT01CompCert1() != null) {

            if (ComplSuplCertType.BusinessPermit.equals(entity.getCertType())
                    || ComplSuplCertType.BusinessAndProduction.equals(entity.getCertType())) {
                t01CompCert = entity.getT01CompCert1();
                //只有国内企业才设置资质状态 国外企业没有资质状态
                if ("0".equals(entity.getT01CompInfo().getAbroad())) {
                    t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
                }
            } else {
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

            T01CompCert search1 = new T01CompCert();
            search1.setCompId(entity.getT01CompInfo().getId());
            search1.setCertType("1");
            List<T01CompCert> list1 = t01CompCertService.findList(search1);
            if (list1 != null && !list1.isEmpty()) {
                t01CompCert.setId(list1.get(0).getId());
            } else {
                t01CompCert.setId(null);
            }
            t01CompCertService.save(t01CompCert);
        }
        if (entity.getT01CompCert2() != null) {

            if (ComplSuplCertType.ProductionQualification.equals(entity.getCertType())
                    || ComplSuplCertType.BusinessAndProduction.equals(entity.getCertType())) {
                t01CompCert = entity.getT01CompCert2();
                //只有国内企业才设置资质状态 国外企业没有资质状态
                if ("0".equals(entity.getT01CompInfo().getAbroad())) {
                    t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
                }
            } else {
                t01CompCert = new T01CompCert();
            }

            t01CompCert.setCompId(entity.getT01CompInfo().getId());
            t01CompCert.setCertType("2");// 生产资质

            T01CompCert search2 = new T01CompCert();
            search2.setCompId(entity.getT01CompInfo().getId());
            search2.setCertType("2");
            List<T01CompCert> list2 = t01CompCertService.findList(search2);
            if (list2 != null && !list2.isEmpty()) {
                t01CompCert.setId(list2.get(0).getId());
            } else {
                t01CompCert.setId(null);
            }

            t01CompCertService.save(t01CompCert);
        }
    }

    /**
     * 绑定销售人员协议
     *
     * @param entity entity
     * @throws BusinessException exception
     */
    private void saveSalesCert(T01ComplSupl entity) throws BusinessException {

        List<T01SalesCert> t01SalesCertList = entity.getT01SalesCertList();
        for (T01SalesCert item : t01SalesCertList) {
            item.setComp(entity.getT01CompInfo());
            if (item.getIsNewRecord()){
                item.preInsert();
                t01SalesCertDao.insert(item);
            }else{
                item.preUpdate();
                t01SalesCertDao.update(item);
            }
        }
    }

    @Transactional
    public void save(T01ComplSupl t01ComplSupl) throws BusinessException {

        saveCompInfo(t01ComplSupl);

        saveCompCert(t01ComplSupl);

        saveSalesCert(t01ComplSupl);

        setSuplStat(t01ComplSupl);
        // 执行保存操作
        super.save(t01ComplSupl);

    }

    @Transactional
    public void delete(T01ComplSupl t01ComplSupl) throws BusinessException {

        // 删除
        super.delete(t01ComplSupl);

    }

    /**
     * 设置购货者状态
     *
     * @param entity entity
     */
    protected void setSuplStat(T01ComplSupl entity) throws BusinessException {
        if (entity != null) {
            try {
                List<String> stateList = new ArrayList<>();
                //如果为国内企业 0
                if ("0".equals(entity.getT01CompInfo().getAbroad())) {
                    //检查国内企业资质
                    stateList.add(checkSuplStat(entity.getT01CompCert0().getEffecDate(), entity.getT01CompCert0().getValidDate()));

                    //如果添加了经营资质
                    if (ComplSuplCertType.BusinessPermit.equals(entity.getCertType())) {
                        stateList.add(checkSuplStat(entity.getT01CompCert1().getEffecDate(), entity.getT01CompCert1().getValidDate()));
                    }
                    //如果添加了生产资质
                    if (ComplSuplCertType.ProductionQualification.equals(entity.getCertType())) {
                        stateList.add(checkSuplStat(entity.getT01CompCert2().getEffecDate(), entity.getT01CompCert2().getValidDate()));
                    }
                    //如果添加了经营资质和生产资质
                    if (ComplSuplCertType.BusinessAndProduction.equals(entity.getCertType())) {
                        stateList.add(checkSuplStat(entity.getT01CompCert1().getEffecDate(), entity.getT01CompCert1().getValidDate()));
                        stateList.add(checkSuplStat(entity.getT01CompCert2().getEffecDate(), entity.getT01CompCert2().getValidDate()));
                    }
                    //设置销售人员授权的资质状态
                    if (getSalesCertState(entity.getT01SalesCertList()) != null) {
                        stateList.add(getSalesCertState(entity.getT01SalesCertList()));
                    }
                } else {
                    //如果为国外企业：1
                    // 检查国外企业资质
                    stateList.add(checkSuplStat(entity.getT01CompCert3().getEffecDate(), entity.getT01CompCert3().getValidDate()));
                }

                String entityState = "";

                for (String state : stateList) {
                    //如果有一个资质失效则供货者状态失效
                    if (ComplSuplStat.NOT_EFFECTIVE.equals(state)) {
                        entityState = ComplSuplStat.NOT_EFFECTIVE;
                        break;
                    }
                }
                if (StringUtils.isBlank(entityState)) {
                    for (String state : stateList) {
                        //如果有一个资质失效则供货者状态失效
                        if (ComplSuplStat.NEAR_EFFECTIVE.equals(state)) {
                            entityState = ComplSuplStat.NEAR_EFFECTIVE;
                            break;
                        }
                    }
                }
                if (StringUtils.isBlank(entityState)) {
                    for (String state : stateList) {
                        //如果有一个资质近效期则供货者状态近效期
                        if (ComplSuplStat.NEAR_EFFECTIVE.equals(state)) {
                            entityState = ComplSuplStat.NEAR_EFFECTIVE;
                            break;
                        }
                    }
                }
                if (StringUtils.isBlank(entityState)) {
                    entityState = ComplSuplStat.EFFECTIVE;
                }

                entity.setSuplStat(entityState);

            } catch (Exception e) {
                throw new SetValueException("设置供货者状态失败", "");
            }
        }
    }

    /**
     * 检查销售人员授权的资质状态 当有一个生效则生效
     *
     * @param t01SalesCertList 销售人员授权的资质列表
     * @return 资质状态 销售人员授权的资质列表为空时返回null
     */
    private String getSalesCertState(List<T01SalesCert> t01SalesCertList) {
        if (t01SalesCertList == null || t01SalesCertList.isEmpty()) {
            return null;
        }

        String salesCertState;
        List<String> statList = new ArrayList<>();

        for (T01SalesCert item : t01SalesCertList) {
            statList.add(checkSuplStat(item.getEffecDate(), item.getValidDate()));
        }

        salesCertState = ComplSuplStat.NOT_EFFECTIVE;
        for (String item : statList) {
            if (ComplSuplStat.NEAR_EFFECTIVE.equals(item)) {
                salesCertState = ComplSuplStat.NEAR_EFFECTIVE;
            }
            if (ComplSuplStat.EFFECTIVE.equals(item)) {
                salesCertState = ComplSuplStat.EFFECTIVE;
                break;
            }
        }
        return salesCertState;
    }

    /**
     * 通过开始时间和结束时间判断状态
     *
     * @param beginDate 开始时间
     * @param endDate   结束时间
     * @return 状态
     */
    private String checkSuplStat(Date beginDate, Date endDate) {
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

    private void updateAlarmState(T01ComplSupl entity) throws BusinessException {
        T01ComplSupl t01ComplSupl = get(entity.getId());
        setSuplStat(t01ComplSupl);
        dao.update(t01ComplSupl);
    }

    @Override
    public List<Map<String, String>> retrieveAlarmNameList(SysAlarm sysAlarm) throws BusinessException {

        List<Map<String, String>> alarmList = new ArrayList<Map<String, String>>();

        //1：只有审批通过的数据才有近效期提醒
        T01ComplSupl t01ComplSupl = new T01ComplSupl();

        List<T01ComplSupl> t01ComplSuplList = this.findList(t01ComplSupl);

        //2：冻结的数据没有近效期提醒
        if (!t01ComplSuplList.isEmpty()) {
            t01ComplSuplList = t01ComplSuplList.stream()
                    .filter(item -> !ComplSuplStat.FREEZE.equals(item.getSuplStat()))
                    .collect(Collectors.toList());
        }
        //所有状态都要改
        for (T01ComplSupl item : t01ComplSuplList) {
            updateAlarmState(item);
        }
        if (!t01ComplSuplList.isEmpty()) {
            //只有审批通过的有提醒
            t01ComplSuplList = t01ComplSuplList.stream()
                    .filter(item -> ApprStatus.PASS.toString().equals(item.getSuplStat()))
                    .collect(Collectors.toList());
        }

        //3：过滤了的数据不再近效期提醒
        List<SysAlarmFilter> filters = sysalarmFilterService.findList(new SysAlarmFilter());


        for (T01ComplSupl item : t01ComplSuplList) {

            Boolean needAlarm = true;
            for (SysAlarmFilter filter : filters) {
                //4:如果是包含规则
                if (filter.getIncluded()) {
                    if (filter.getRole().equals("sysAlarm:t01ComplSupl:" + item.getId())) {
                        needAlarm = false;
                    }
                } else {
                    //4:如果是非包含规则
                    if (!filter.getRole().equals("sysAlarm:t01ComplSupl:" + item.getId())) {
                        needAlarm = false;
                    }
                }
            }
            if (needAlarm) {
                Date validPeriDate = getValidPeriDate(item);
                //判断是否需要预警
                if (checkAlarm(validPeriDate, sysAlarm)) {
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("type", "供货者有效期预警");
                    map.put("name", item.getT01CompInfo().getCompNameCn());
                    map.put("id", item.getId());
                    alarmList.add(map);
                }
            }
        }

        return alarmList;
    }

    private Date getValidPeriDate(T01ComplSupl entity) {
        Date validPeriDate = null;

        T01ComplSupl t01ComplSupl = get(entity.getId());

        validPeriDate = t01ComplSupl.getT01CompCert0().getValidDate();
        Date date0 = null;
        if (ComplSuplCertType.BusinessPermit.equals(t01ComplSupl.getCertType())) {
            date0 = t01ComplSupl.getT01CompCert1().getValidDate();
        }
        if (ComplSuplCertType.ProductionQualification.equals(t01ComplSupl.getCertType())) {
            date0 = t01ComplSupl.getT01CompCert2().getValidDate();
        }
        if (date0 != null && date0.getTime() < validPeriDate.getTime()) {
            validPeriDate = date0;
        }
        Date date1 = null;
        if (t01ComplSupl.getT01SalesCertList() != null && !t01ComplSupl.getT01SalesCertList().isEmpty()) {

            date1 = t01ComplSupl.getT01SalesCertList().get(0).getValidDate();
            for (T01SalesCert t01SalesCert : t01ComplSupl.getT01SalesCertList()) {
                if (t01SalesCert.getValidDate().getTime() > date1.getTime()) {
                    date1 = t01SalesCert.getValidDate();
                }
            }
        }
        if (date1 != null && date1.getTime() < validPeriDate.getTime()) {
            validPeriDate = date1;
        }

        return validPeriDate;
    }

}

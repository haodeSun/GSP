package com.thinkgem.jeesite.modules.gsp.service.t01complsupl;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.act.ActActionInvoke;
import com.thinkgem.jeesite.modules.gsp.dao.common.CommonDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01aggrmatr.T01AggrMatrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compaggr.T01CompAggrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compcert.T01CompCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compinfo.T01CompInfoDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer.T01ComplBuyerDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complsupl.SysChangeInfoForT01ComplSuplDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01salescert.T01SalesCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplCertType;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplStat;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.SysChangeInfoForT01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.EntityExistedException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t01complsupl.T01ComplSuplDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.SetValueException;
import com.thinkgem.jeesite.modules.gsp.service.t01compaggr.T01CompAggrService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 首营供货者Service
 *
 * @author Andrea
 * @version 2016-12-22
 */
@Service(value = "t01ComplSuplService")
public class T01ComplSuplExtService extends T01ComplSuplService implements ActActionInvoke {
    /**
     * 销售人员ids
     */
    private static final String SALES_CERT_IDS = "t01SalesCertIDs";
    /**
     * 流程定义KEY
     */
    private static final String PROCDEF_KEY = "t01ComplSuplAppr";

    /**
     * 业务entityName
     */
    private static final String ENTITY_NAME = "T01ComplSupl";
    /**
     * 被变更标志
     */
    private static final String IS_CHANGED = "1";
    /**
     * 工作流Service
     */
    private final TaskService taskService;
    private final ActTaskService actTaskService;
    /**
     * 变更信息表dao
     */
    private SysChangeInfoForT01ComplSuplDao sysChangeInfoDao;
    /**
     * 企业协议Service
     */
    private T01CompAggrDao t01CompAggrDao;
    /**
     * 企业信息service
     */
    private T01CompInfoService t01CompInfoService;

    /**
     * 企业资质service
     */
    private T01CompCertService t01CompCertService;

    /**
     * 协议与物料关联Dao
     */
    private T01AggrMatrDao t01AggrMatrDao;
    /**
     * 公共Dao
     */
    private final CommonDao commonDao;

    /**
     * 销售人员授权Dao
     */
    @Autowired
    private T01SalesCertDao t01SalesCertDao;

    /**
     * 首营购货者DAO接口
     */
    @Autowired
    private T01ComplBuyerDao t01ComplBuyerDao;
    /**
     * 企业资质DAO接口
     */
    @Autowired
    private T01CompCertDao t01CompCertDao;

    /**
     * 企业信息DAO接口
     */
    @Autowired
    private T01CompInfoDao t01CompInfoDao;

    @Autowired
    public T01ComplSuplExtService(
            T01ComplSuplDao dao,
            SysChangeInfoForT01ComplSuplDao sysChangeInfoDao,
            TaskService taskService,
            ActTaskService actTaskService,
            T01CompAggrDao t01CompAggrDao,
            T01CompInfoService t01CompInfoService,
            T01CompCertService t01CompCertService,
            T01AggrMatrDao t01AggrMatrDao,
            CommonDao commonDao) {
        super(dao);
        Assert.notNull(taskService);
        Assert.notNull(actTaskService);
        Assert.notNull(t01CompAggrDao);
        Assert.notNull(t01CompInfoService);
        Assert.notNull(t01CompCertService);
        Assert.notNull(t01AggrMatrDao);
        Assert.notNull(commonDao);
        this.taskService = taskService;
        this.actTaskService = actTaskService;
        this.sysChangeInfoDao = sysChangeInfoDao;
        this.t01CompAggrDao = t01CompAggrDao;
        this.t01CompInfoService = t01CompInfoService;
        this.t01CompCertService = t01CompCertService;
        this.t01AggrMatrDao = t01AggrMatrDao;
        this.commonDao = commonDao;
    }

    /**
     * 删除操作
     *
     * @param T01ComplSupl
     */
    @Override
    public void delete(T01ComplSupl T01ComplSupl) throws BusinessException {
        super.delete(T01ComplSupl);
    }

    /**
     * 删除单个供货者逻辑
     *
     * @param entity entity
     * @return 删除结果
     */
    @Transactional
    public String deleteBuyer(T01ComplSupl entity) throws BusinessException {

        t01ComplSuplHelperService.checkStatusBeforeHandle("delete",entity);

        String result = "";

        if (entity != null & StringUtils.isNotBlank(entity.getId())) {

            T01CompAggr t01CompAggr = new T01CompAggr();
            t01CompAggr.getSupplier().setId(entity.getId());

            List<T01CompAggr> t01CompCertList = t01CompAggrDao.findList(t01CompAggr);

            // 判断是否关联企业协议
            if (t01CompCertList != null && !t01CompCertList.isEmpty()) {

                List<String> matrIdList = new ArrayList<>();
                //协议关联物料的逻辑处理部分
                for (T01CompAggr item : t01CompCertList) {
                    T01AggrMatr t01AggrMatrSearch = new T01AggrMatr();
                    t01AggrMatrSearch.setAggrId(item.getId());

                    List<T01AggrMatr> t01AggrMatrList = t01AggrMatrDao.findList(t01AggrMatrSearch);
                    if (t01AggrMatrList != null && !t01AggrMatrList.isEmpty()) {
                        for (T01AggrMatr t01AggrMatr : t01AggrMatrList) {
                            matrIdList.add(t01AggrMatr.getMatr().getId());
                        }
                    }
                }

                //物料关联进销存的逻辑处理部分
                if (commonDao.getRelateInvoicingNum(matrIdList) > 0) {
                    entity.setSuplStat(ComplSuplStat.FREEZE);
                    save(entity);

                    result = "删除成功-首营供货者冻结";
                }


                if (StringUtils.isBlank(result)) {
                    // 不关联进销存，仅关联协议的需要在解除协议关联（由协议相关人员执行该操作）后才可删除
                    result = "删除失败,请先解除协议关联，否则无法删除";
                }
            } else {

                //设置【变更状态】未处于变更流程中
                if (StringUtils.isNotBlank(entity.getCompId())) {
                    T01CompInfo t01CompInfo = t01CompInfoService.get(entity.getCompId());
                    t01CompInfo.setChangeStat("0");
                    t01CompInfoService.save(t01CompInfo);
                }
                // 没有企业协议直接删除
                delete(entity);
                SysChangeInfoForT01ComplSupl sysChanInfo = new SysChangeInfoForT01ComplSupl();

                //删除该条记录的变更历史
                sysChanInfo.setChanTbl(BUSINESS_TABLE);
                sysChanInfo.setChanId(entity);

                List<SysChangeInfoForT01ComplSupl> sysChanInfoList = sysChangeInfoDao.findList(sysChanInfo);
                for (SysChangeInfoForT01ComplSupl item : sysChanInfoList) {
                    sysChangeInfoDao.delete(item);
                }
                result = "删除成功";
            }
        } else {
            throw new NullPointerException("删除失败，未找到对应数据");
        }

        return result;
    }

    /**
     * 保存变更记录
     *
     * @param oldT01ComplSupl entity
     * @throws BusinessException exception
     */
    @Transactional
    public T01ComplSupl saveChange(T01ComplSupl oldT01ComplSupl) throws BusinessException {

        //判断是否有过变更历史
        t01ComplSuplHelperService.checkStatusBeforeHandle("change", oldT01ComplSupl);

        // 获取变更字段的信息列表
        List<SysChangeInfoForT01ComplSupl> sysChangeInfoList = oldT01ComplSupl.getSysChanInfoList();

        // 将旧数据赋给新数据
        T01ComplSupl newT01ComplSupl = oldT01ComplSupl;

        for (SysChangeInfoForT01ComplSupl item : sysChangeInfoList) {

            item.setChanOrigId(oldT01ComplSupl.getId());
            item.setChanTbl(BUSINESS_TABLE);

            //设置变更字段旧值
            try {
                item.setOrgiValue(Reflections.invokeGetter(
                        oldT01ComplSupl,
                        item.getChanCol()
                ).toString());
            } catch (NullPointerException e) {
                item.setOrgiValue("");
            }
            // 设置变更字段新值
            Object value = item.getChanValue();
            try {
                try {
                    Reflections.invokeSetter(newT01ComplSupl, item.getChanCol(), value);
                } catch (IllegalArgumentException e) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    // 如果日期类型提交了值得，就转换为固定格式的Date对象，否则设置为null
                    if (StringUtils.isNotBlank(item.getChanValue())) {
                        value = sdf.parse(item.getChanValue());
                    } else {
                        value = null;
                    }
                    Reflections.invokeSetter(newT01ComplSupl, item.getChanCol(), value);
                }
            } catch (Exception e) {
                logger.error("Failed to set parent value", e);
                throw new SetValueException("设置变更值失败！", null);
            }
        }

        // 置空id 将新数据保存
        newT01ComplSupl.setId(null);
        newT01ComplSupl.getT01CompInfo().setId(null);
        newT01ComplSupl.getT01CompCert0().setId(null);
        newT01ComplSupl.getT01CompCert3().setId(null);
        newT01ComplSupl.getT01CompCert1().setId(null);
        newT01ComplSupl.getT01CompCert2().setId(null);
        for (T01SalesCert t01SalesCert : newT01ComplSupl.getT01SalesCertList()) {
            t01SalesCert.setId(null);
        }

        //设置变更状态处于供货者变更流程中
        newT01ComplSupl.getT01CompInfo().setChangeStat("1");
        //先保存企业信息
        t01CompInfoService.save(newT01ComplSupl.getT01CompInfo());

        //变更时将新生成的数据设置为未审批并清空审批流id
        newT01ComplSupl.setApprStat(ApprStatus.NOSUBMIT.toString());
        newT01ComplSupl.setProcInsId(null);

        save(newT01ComplSupl);

        // 获取新数据的id保存到变更记录信息中
        for (SysChangeInfoForT01ComplSupl item : sysChangeInfoList) {
            item.setChanId(newT01ComplSupl);
            item.preInsert();
            sysChangeInfoDao.insert(item);
        }

        return newT01ComplSupl;
    }


    /**
     * 当销售人员授权修改时，触发供货者状态更新
     *
     * @param entity entity
     * @throws BusinessException exception
     */
    public void setSuplStatFromSalesCert(T01ComplSupl entity) throws BusinessException {
        setSuplStat(entity);
        dao.update(entity);
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

    /**
     * 获取到审批所需的task信息
     *
     * @param t01ComplSupl entity
     * @throws BusinessException exception
     */
    @Transactional
    public void getTaskInfo(T01ComplSupl t01ComplSupl) throws BusinessException {

        t01ComplSuplHelperService.checkStatusBeforeHandle("appr",t01ComplSupl);

        String userId = UserUtils.getUser().getLoginName();
        String procInsId = t01ComplSupl.getProcInsId();

        // 判断用户在当前审批流程是否有待签收任务
        TaskQuery toClaimQuery =
                taskService.createTaskQuery().taskCandidateUser(userId).processInstanceId(procInsId)
                        .includeProcessVariables().active().orderByTaskCreateTime().desc();
        List<Task> toClaimList = toClaimQuery.list();
        // 用户在当前审批流程有代签收任务，则自动签收
        if (toClaimList != null && !toClaimList.isEmpty()) {
            actTaskService.claim(toClaimList.get(0).getId(), userId);
        }
        // 判断用户在当前审批流程是否有待办任务
        TaskQuery todoTaskQuery =
                taskService.createTaskQuery().taskAssignee(userId).processInstanceId(procInsId).active()
                        .includeProcessVariables().orderByTaskCreateTime().desc();
        List<Task> todoList = todoTaskQuery.list();
        // 用户在当前审批流程有代办任务，则设置任务的taskId和procInsId
        if (todoList != null && !todoList.isEmpty()) {
            t01ComplSupl.getAct().setTaskId(todoList.get(0).getId());
            t01ComplSupl.getAct().setTaskName(todoList.get(0).getName());
            t01ComplSupl.getAct().setTaskDefKey(todoList.get(0).getTaskDefinitionKey());
            t01ComplSupl.getAct().setProcInsId(todoList.get(0).getProcessInstanceId());
            t01ComplSupl.getAct().setProcDefId(todoList.get(0).getProcessDefinitionId());
        } else {
            throw new ApprStatusException("前往审批页失败，当前用户没有审批权限", "");
        }
    }

    /**
     * 启动审批流程
     *
     * @param id     entityId
     * @param taskId 任务id
     * @throws Exception exception
     */
    @Transactional
    public void startProcess(String id, String taskId) throws Exception {

        T01ComplSupl t01ComplSupl = get(id);

        //检查供货者是否能提交审批流程
        checkCommitCondition(t01ComplSupl);

        // 寻找taskid
        if (StringUtils.isBlank(taskId) && StringUtils.isNotBlank(t01ComplSupl.getProcInsId())) {
            String userId = UserUtils.getUser().getLoginName();
            TaskQuery todoTaskQuery =
                    taskService.createTaskQuery().taskAssignee(userId)
                            .processInstanceId(t01ComplSupl.getProcInsId()).active().includeProcessVariables()
                            .orderByTaskCreateTime().desc();
            List<Task> todoList = todoTaskQuery.list();

            if (todoList != null && !todoList.isEmpty()) {
                taskId = todoList.get(0).getId();
            }
        }
        if (t01ComplSupl == null || !StringUtils.isNotBlank(t01ComplSupl.getId())) {
            throw new NullPointerException("提交失败，没有对应的信息，无法启动流程");
        }
        if (ApprStatus.NOAPPR.toString().equals(t01ComplSupl.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息已提交审核，请耐心等待审批结果", "");
        }
        if (ApprStatus.PASS.toString().equals(t01ComplSupl.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息已审核通过", "");
        }
        if (StringUtils.isBlank(taskId)
                && ApprStatus.NOPASS.toString().equals(t01ComplSupl.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息审核未通过，重新编辑后才能提交", "");
        }

        // 更新审批状态为未审批
        t01ComplSupl.setApprStat(ApprStatus.NOAPPR.toString());
        dao.update(t01ComplSupl);

        changeCompInfoApprStat(t01ComplSupl.getT01CompInfo(), ApprStatus.NOAPPR.toString());

        if (t01ComplSupl.getT01CompCert0() != null && StringUtils.isNotBlank(t01ComplSupl.getT01CompCert0().getId())) {
            changeCompCertApprStat(t01ComplSupl.getT01CompCert0(), ApprStatus.NOAPPR.toString());
        }
        if (t01ComplSupl.getT01CompCert1() != null && StringUtils.isNotBlank(t01ComplSupl.getT01CompCert1().getId())) {
            //如果使用了经营资质则更新经营资质状态
            if ("1".equals(t01ComplSupl.getCertType())) {
                changeCompCertApprStat(t01ComplSupl.getT01CompCert1(), ApprStatus.NOAPPR.toString());
            }
        }
        if (t01ComplSupl.getT01CompCert2() != null && StringUtils.isNotBlank(t01ComplSupl.getT01CompCert2().getId())) {
            changeCompCertApprStat(t01ComplSupl.getT01CompCert2(), ApprStatus.NOAPPR.toString());
        }

        Map<String, Object> vars = new HashMap<>();

        // 当taskID不为空时，操作为完成任务;为空时为提交任务
        if (StringUtils.isNotBlank(taskId)) {
            vars.put("pass", 1);
            actTaskService.complete(taskId, "", "", vars);
        } else {
            vars.put("entityName", ENTITY_NAME);
            vars.put("businessId", id);
            actTaskService.startProcess(PROCDEF_KEY, BUSINESS_TABLE, t01ComplSupl.getId(),
                    t01ComplSupl.getId(), vars);
        }

        //插入操作历史
        insertOperateHist(BUSINESS_MODULE,id,"2");
    }

    /**
     * 检查供货者是否能提交审批流程
     *
     * @param entity entity
     */
    private void checkCommitCondition(T01ComplSupl entity) throws BusinessException {
        if (entity == null) {
            throw new NullPointerException("提交失败，没有对应的信息，无法启动流程");
        }
        //1：判断是否为变更数据
        SysChangeInfoForT01ComplSupl sysChangeInfo = new SysChangeInfoForT01ComplSupl();
        sysChangeInfo.setChanId(entity);
        List<SysChangeInfoForT01ComplSupl> sysChangeInfoList = sysChangeInfoDao.findList(sysChangeInfo);
        if (sysChangeInfoList != null && !sysChangeInfoList.isEmpty()) {
            //2：找到变更前的旧数据id
            String oldId = sysChangeInfoList.get(0).getChanOrigId();
            if (StringUtils.isBlank(oldId)) {
                throw new NullPointerException("提交失败，变更信息没有对应的原始信息，无法启动流程");
            }
            //3：找到旧数据id所有变更的新数据id集合
            Set<String> newIdSet = new HashSet<>();

            SysChangeInfoForT01ComplSupl sysChangeInfo2 = new SysChangeInfoForT01ComplSupl();
            sysChangeInfo2.setChanOrigId(oldId);
            List<SysChangeInfoForT01ComplSupl> sysChangeInfoList2 = sysChangeInfoDao.findList(sysChangeInfo2);
            for (SysChangeInfoForT01ComplSupl item : sysChangeInfoList2) {
                newIdSet.add(item.getChanId().getId());
            }
            //4：判断所有变更的新数据是否有处于未审批或审批通过状态
            for (String newId : newIdSet) {
                T01ComplSupl t01ComplSupl = null;
                t01ComplSupl = get(newId);
                if (t01ComplSupl == null) {
                    throw new NullPointerException("提交失败，数据关联错误，无法启动流程");
                }
                if (ApprStatus.NOAPPR.toString().equals(t01ComplSupl.getApprStat()) ||
                        ApprStatus.PASS.toString().equals(t01ComplSupl.getApprStat())) {
                    throw new ApprStatusException("提交失败，相关变更数据有处于未审批或审批通过状态，无法启动流程", "");
                }
            }
        }
    }

    /**
     * 更改企业信息的审批状态
     *
     * @param t01CompInfo entity
     * @param apprStat    审批状态
     * @throws BusinessException exception
     */
    private void changeCompInfoApprStat(T01CompInfo t01CompInfo, String apprStat) throws BusinessException {

        t01CompInfo.setApprStat(apprStat);
        t01CompInfoService.save(t01CompInfo);
    }

    /**
     * 更改企业资质的审批状态
     *
     * @param t01CompCert entity
     * @param apprStat    审批状态
     * @throws BusinessException exception
     */
    private void changeCompCertApprStat(T01CompCert t01CompCert, String apprStat) throws BusinessException {

        t01CompCert.setApprStat(apprStat);
        t01CompCertService.save(t01CompCert);
    }

    /**
     * 通过id列表获取数据
     *
     * @param idList idList
     * @return entityList
     */
    public List<T01ComplSupl> findSelectedList(List<String> idList) {
        return dao.findSelectedList(idList);
    }

    public T01ComplSupl changeEdit(T01ComplSupl entity) {
        // 保存变更记录信息
        List<SysChangeInfoForT01ComplSupl> sysChangeInfoList = entity.getSysChanInfoList();

        // 获取entity对应变更前数据的id
        String oldId = entity.getSysChanInfoList().get(0).getChanOrigId();

        // 获取变更前的entity数据并赋值给entity对象和变更记录信息
        T01ComplSupl t01ComplSuplOld = get(oldId);
        entity = t01ComplSuplOld;
        entity.setSysChanInfoList(sysChangeInfoList);

        return entity;
    }

    /**
     * 保存变更编辑
     *
     * @param oldT01ComplSupl entity
     * @return entity
     * @throws BusinessException exception
     */
    @Transactional
    public T01ComplSupl saveChangeEdit(T01ComplSupl oldT01ComplSupl) throws BusinessException {

        // 获取变更字段的信息列表
        List<SysChangeInfoForT01ComplSupl> sysChangeInfoListNew = oldT01ComplSupl.getSysChanInfoList();

        // 获取旧数据
        oldT01ComplSupl = get(oldT01ComplSupl.getId());

        // 找到新数据id
        SysChangeInfoForT01ComplSupl sysChangeInfo = new SysChangeInfoForT01ComplSupl();
        sysChangeInfo.setChanOrigId(oldT01ComplSupl.getId());
        String newId = sysChangeInfoDao.findList(sysChangeInfo).get(0).getChanId().getId();

        // 获取新数据
        T01ComplSupl newT01ComplSupl = get(newId);

        List<SysChangeInfoForT01ComplSupl> sysChangeInfoListOld = newT01ComplSupl.getSysChanInfoList();

        for (SysChangeInfoForT01ComplSupl item : sysChangeInfoListNew) {
            item.setChanOrigId(oldT01ComplSupl.getId());
            item.setChanTbl(BUSINESS_TABLE);

            // 设置变更字段旧值
            try {
                item.setOrgiValue(Reflections.invokeGetter(
                        oldT01ComplSupl,
                        item.getChanCol()
                ).toString());
            } catch (NullPointerException e) {
                item.setOrgiValue("");
            }
            // 设置变更字段新值
            Object value = item.getChanValue();
            try {
                try {
                    Reflections.invokeSetter(newT01ComplSupl, item.getChanCol(), value);
                } catch (IllegalArgumentException e) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    // 如果日期类型提交了值得，就转换为固定格式的Date对象，否则设置为null
                    if (StringUtils.isNotBlank(item.getChanValue())) {
                        value = sdf.parse(item.getChanValue());
                    } else {
                        value = null;
                    }
                    Reflections.invokeSetter(newT01ComplSupl, item.getChanCol(), value);
                }
            } catch (Exception e) {
                logger.error("Failed to set parent value", e);
                throw new SetValueException("设置变更值失败！", null);
            }
        }

        save(newT01ComplSupl);

        // 删除原有变更记录信息
        for (SysChangeInfoForT01ComplSupl item : sysChangeInfoListOld) {
            sysChangeInfoDao.delete(item);
        }
        // 获取新数据的id保存到变更记录信息中
        for (SysChangeInfoForT01ComplSupl item : sysChangeInfoListNew) {
            item.setChanId(newT01ComplSupl);
            item.preInsert();
            sysChangeInfoDao.insert(item);
        }
        return newT01ComplSupl;
    }

    /**
     * 在审批通过时调用
     *
     * @param businessId 业务表ID
     */
    @Override
    public void actPassInvoke(String businessId) throws Exception {

        T01ComplSupl t01ComplSupl = get(businessId);

        T01ComplSupl search = new T01ComplSupl();
        search.setId(businessId);
        SysChangeInfoForT01ComplSupl sysChangeInfo = new SysChangeInfoForT01ComplSupl();
        sysChangeInfo.setChanId(search);

        List<SysChangeInfoForT01ComplSupl> sysChangeInfoResultList = sysChangeInfoDao.findList(sysChangeInfo);

        if (sysChangeInfoResultList != null && !sysChangeInfoResultList.isEmpty()) {
            String origId = sysChangeInfoResultList.get(0).getChanOrigId();

            //获取变更前的数据
            T01ComplSupl origT01ComplSupl = get(origId);
            origT01ComplSupl.setIsChanged(IS_CHANGED);

            //删除变更前的企业信息
            t01CompInfoDao.delete(origT01ComplSupl.getT01CompInfo());

            //删除变更前的企业资质
            String origCompId=origT01ComplSupl.getT01CompInfo().getId();
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"0");
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"3");
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"1");
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"2");

            //更新购货者企业id
            t01ComplBuyerDao.updateCompIdWhenChangePass(t01ComplSupl.getCompId(), origT01ComplSupl.getCompId());

            //更新企业资质表的企业【购货者的医疗机构执业许可】
            t01CompCertDao.replaceCompIdByCertType(t01ComplSupl.getCompId(), origT01ComplSupl.getCompId(), "4");

            dao.update(origT01ComplSupl);
            dao.delete(origT01ComplSupl);
        }
        //设置【变更状态】：未处于变更流程中
        t01ComplSupl.getT01CompInfo().setChangeStat("0");

        //更新与供货者相关信息的审批状态
        changeRelateApprStat(t01ComplSupl,ApprStatus.PASS.toString());
    }

    /**
     * 在审批未通过时调用
     *
     * @param businessId 业务表ID
     */
    @Override
    public void actNoPassInvoke(String businessId) throws Exception {
        T01ComplSupl t01ComplSupl = get(businessId);

        //更新与供货者相关信息的审批状态
        changeRelateApprStat(t01ComplSupl,ApprStatus.NOPASS.toString());
    }

    /**
     * 更新与供货者相关信息的审批状态
     * @param entity entity
     * @param apprStat 审批状态
     * @throws BusinessException exception
     */
    private void changeRelateApprStat(T01ComplSupl entity, String apprStat) throws BusinessException {

        //更新企业信息的状态
        changeCompInfoApprStat(entity.getT01CompInfo(), apprStat);

        //更新国内企业资质的状态
        if ("0".equals(entity.getT01CompInfo().getAbroad())) {
            changeCompCertApprStat(entity.getT01CompCert0(), apprStat);
        }
        //更新国外企业资质的状态
        if ("1".equals(entity.getT01CompInfo().getAbroad())) {
            changeCompCertApprStat(entity.getT01CompCert3(), apprStat);
        }
        //如果使用了经营资质则更新经营资质状态
        if (ComplSuplCertType.BusinessPermit.equals(entity.getCertType())) {
            changeCompCertApprStat(entity.getT01CompCert1(), ApprStatus.PASS.toString());
        }
        //如果使用了生产资质则更新生产资质状态
        if (ComplSuplCertType.ProductionQualification.equals(entity.getCertType())) {
            changeCompCertApprStat(entity.getT01CompCert2(), ApprStatus.PASS.toString());
        }
        //如果使用了经营资质和生产资质则更新经营资质和生产资质状态
        if (ComplSuplCertType.BusinessAndProduction.equals(entity.getCertType())) {
            changeCompCertApprStat(entity.getT01CompCert1(), ApprStatus.PASS.toString());
            changeCompCertApprStat(entity.getT01CompCert2(), ApprStatus.PASS.toString());
        }
    }
}

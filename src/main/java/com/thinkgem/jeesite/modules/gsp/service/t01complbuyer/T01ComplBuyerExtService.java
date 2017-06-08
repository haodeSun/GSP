package com.thinkgem.jeesite.modules.gsp.service.t01complbuyer;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.ActActionInvoke;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.common.CommonDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01aggrmatr.T01AggrMatrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compaggr.T01CompAggrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compcert.T01CompCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compinfo.T01CompInfoDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer.SysChangeInfoDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer.T01ComplBuyerDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complsupl.T01ComplSuplDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01salescert.T01SalesCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.ComplBuyerCertType;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.SysChangeInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplStat;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.EntityExistedException;
import com.thinkgem.jeesite.modules.gsp.service.exception.SetValueException;
import com.thinkgem.jeesite.modules.gsp.service.t01compaggr.T01CompAggrService;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 首营购货者Service
 *
 * @author XXS
 * @since 2016/12/23
 */
@SuppressWarnings("unused")
@Service(value = "t01ComplBuyerService")
public class T01ComplBuyerExtService extends T01ComplBuyerService implements ActActionInvoke {
    /**
     * 流程定义KEY
     */
    private static final String PROCDEF_KEY = "t01ComplBuyerAppr";

    /**
     * 业务entityName
     */
    private static final String ENTITY_NAME = "T01ComplBuyer";
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
    private SysChangeInfoDao sysChangeInfoDao;

    /**
     * 企业协议Dao
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
     * 首营供货者DAO接口
     */
    @Autowired
    private T01ComplSuplDao t01ComplSuplDao;
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
    private T01SalesCertDao t01SalesCertDao;

    @Autowired
    public T01ComplBuyerExtService(
            T01ComplBuyerDao dao,
            SysChangeInfoDao sysChangeInfoDao,
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
     * @param t01ComplBuyer entity
     */
    @Override
    public void delete(T01ComplBuyer t01ComplBuyer) throws BusinessException {
        super.delete(t01ComplBuyer);
    }

    /**
     * 删除单个购货者逻辑
     *
     * @param entity entity
     * @return 删除结果
     */
    @Transactional
    public String deleteBuyer(T01ComplBuyer entity) throws BusinessException {

        t01ComplBuyerHelperService.checkStatusBeforeHandle("delete",entity);

        String result = "";

        if (entity != null && StringUtils.isNotBlank(entity.getId())) {

            T01CompAggr t01CompAggr = new T01CompAggr();
            t01CompAggr.getBuyer().setId(entity.getId());

            List<T01CompAggr> t01CompCertList = t01CompAggrDao.findList(t01CompAggr);

            //判断是否关联企业协议
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
                    entity.setBuyerStat(ComplSuplStat.FREEZE);
                    save(entity);

                    result = "删除成功-首营购货者冻结";
                }

                if (StringUtils.isBlank(result)) {
                    //不关联进销存，仅关联协议的需要在解除协议关联（由协议相关人员执行该操作）后才可删除
                    result = "删除失败,请先解除协议关联，否则无法删除";
                }
            } else {

                //设置【变更状态】未处于变更流程中
                if (StringUtils.isNotBlank(entity.getCompId())) {
                    T01CompInfo t01CompInfo = t01CompInfoService.get(entity.getCompId());
                    t01CompInfo.setChangeStat("0");
                    t01CompInfoService.save(t01CompInfo);
                }

                //没有企业协议直接删除
                delete(entity);
                SysChangeInfo sysChanInfo = new SysChangeInfo();

                //删除该条记录的变更历史
                sysChanInfo.setChanTbl(BUSINESS_TABLE);
                sysChanInfo.setChanId(entity);

                List<SysChangeInfo> sysChanInfoList = sysChangeInfoDao.findList(sysChanInfo);
                for (SysChangeInfo item : sysChanInfoList) {
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
     * @param oldT01ComplBuyer entity
     * @throws BusinessException exception
     */
    @Transactional
    public T01ComplBuyer saveChange(T01ComplBuyer oldT01ComplBuyer) throws BusinessException {

        //判断是否有过变更历史
        t01ComplBuyerHelperService.checkStatusBeforeHandle("change", oldT01ComplBuyer);

        //获取变更字段的信息列表
        List<SysChangeInfo> sysChangeInfoList = oldT01ComplBuyer.getSysChanInfoList();

        //将旧数据赋给新数据
        T01ComplBuyer newT01ComplBuyer = oldT01ComplBuyer;


        for (SysChangeInfo item : sysChangeInfoList) {

            item.setChanOrigId(oldT01ComplBuyer.getId());
            item.setChanTbl(BUSINESS_TABLE);
            //设置变更字段旧值
            try {
                item.setOrgiValue(Reflections.invokeGetter(
                        oldT01ComplBuyer,
                        item.getChanCol()
                ).toString());
            } catch (NullPointerException e) {
                item.setOrgiValue("");
            }
            //设置变更字段新值
            Object value = item.getChanValue();
            try {
//                Field field = Reflections.getAccessibleField(oldT01ComplBuyer,item.getChanCol());
//                Class<?> type = field != null ? field.getType() : null;
//                // 如果变更类型为日期的话，将提交上来的字符串按照固定格式转为日期
//                if (type == Date.class) {
//                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//                    // 如果日期类型提交了值得，就转换为固定格式的Date对象，否则设置为null
//                    if(StringUtils.isNotBlank(item.getChanValue())) {
//                        value = sdf.parse(item.getChanValue());
//                    }else{
//                        value = null;
//                    }
//                }
                try {
                    Reflections.invokeSetter(newT01ComplBuyer, item.getChanCol(), value);
                } catch (IllegalArgumentException e) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    // 如果日期类型提交了值得，就转换为固定格式的Date对象，否则设置为null
                    if (StringUtils.isNotBlank(item.getChanValue())) {
                        value = sdf.parse(item.getChanValue());
                    } else {
                        value = null;
                    }
                    Reflections.invokeSetter(newT01ComplBuyer, item.getChanCol(), value);
                }
            } catch (Exception e) {
                logger.error("设置变更值失败", e);
                throw new SetValueException("设置变更值失败！", null);
            }
        }

        //置空id 将新数据保存
        newT01ComplBuyer.setId(null);
        newT01ComplBuyer.getT01CompInfo().setId(null);
        newT01ComplBuyer.getT01CompCert0().setId(null);
        newT01ComplBuyer.getT01CompCert3().setId(null);
        newT01ComplBuyer.getT01CompCert1().setId(null);
        newT01ComplBuyer.getT01CompCert4().setId(null);

        //设置变更状态处于购货者变更流程中
        newT01ComplBuyer.getT01CompInfo().setChangeStat("2");

        //先保存企业信息
        t01CompInfoService.save(newT01ComplBuyer.getT01CompInfo());


        //变更时将新生成的数据设置为未审批并清空审批流id
        newT01ComplBuyer.setApprStat(ApprStatus.NOSUBMIT.toString());
        newT01ComplBuyer.setProcInsId(null);

        save(newT01ComplBuyer);

        //获取新数据的id保存到变更记录信息中
        for (SysChangeInfo item : sysChangeInfoList) {
            item.setChanId(newT01ComplBuyer);
            item.preInsert();
            sysChangeInfoDao.insert(item);
        }

        return newT01ComplBuyer;
    }

    /**
     * 获取到审批所需的task信息
     *
     * @param t01ComplBuyer entity
     * @throws BusinessException exception
     */
    @Transactional
    public void getTaskInfo(T01ComplBuyer t01ComplBuyer) throws BusinessException {

        t01ComplBuyerHelperService.checkStatusBeforeHandle("appr", t01ComplBuyer);

        String userId = UserUtils.getUser().getLoginName();
        String procInsId = t01ComplBuyer.getProcInsId();

        //判断用户在当前审批流程是否有待签收任务
        TaskQuery toClaimQuery = taskService.createTaskQuery()
                .taskCandidateUser(userId)
                .processInstanceId(procInsId)
                .includeProcessVariables()
                .active()
                .orderByTaskCreateTime()
                .desc();
        List<Task> toClaimList = toClaimQuery.list();
        //用户在当前审批流程有代签收任务，则自动签收
        if (toClaimList != null && !toClaimList.isEmpty()) {
            actTaskService.claim(toClaimList.get(0).getId(), userId);
        }
        //判断用户在当前审批流程是否有待办任务
        TaskQuery todoTaskQuery = taskService.createTaskQuery()
                .taskAssignee(userId)
                .processInstanceId(procInsId)
                .active()
                .includeProcessVariables()
                .orderByTaskCreateTime()
                .desc();
        List<Task> todoList = todoTaskQuery.list();
        //用户在当前审批流程有代办任务，则设置任务的taskId和procInsId
        if (todoList != null && !todoList.isEmpty()) {
            t01ComplBuyer.getAct().setTaskId(todoList.get(0).getId());
            t01ComplBuyer.getAct().setTaskName(todoList.get(0).getName());
            t01ComplBuyer.getAct().setTaskDefKey(todoList.get(0).getTaskDefinitionKey());
            t01ComplBuyer.getAct().setProcInsId(todoList.get(0).getProcessInstanceId());
            t01ComplBuyer.getAct().setProcDefId(todoList.get(0).getProcessDefinitionId());
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

        T01ComplBuyer t01ComplBuyer = get(id);

        //检查够货者是否能提交审批流程
        checkCommitCondition(t01ComplBuyer);

        //寻找taskid
        if (StringUtils.isBlank(taskId) && StringUtils.isNotBlank(t01ComplBuyer.getProcInsId())) {
            String userId = UserUtils.getUser().getLoginName();
            TaskQuery todoTaskQuery = taskService.createTaskQuery()
                    .taskAssignee(userId)
                    .processInstanceId(t01ComplBuyer.getProcInsId())
                    .active()
                    .includeProcessVariables()
                    .orderByTaskCreateTime()
                    .desc();
            List<Task> todoList = todoTaskQuery.list();

            if (todoList != null && !todoList.isEmpty()) {
                taskId = todoList.get(0).getId();
            }
        }
        if (t01ComplBuyer == null || !StringUtils.isNotBlank(t01ComplBuyer.getId())) {
            throw new NullPointerException("提交失败，没有对应的信息，无法启动流程");
        }
        if (ApprStatus.NOAPPR.toString().equals(t01ComplBuyer.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息已提交审核，请耐心等待审批结果", "");
        }
        if (ApprStatus.PASS.toString().equals(t01ComplBuyer.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息已审核通过", "");
        }
        if (StringUtils.isBlank(taskId) && ApprStatus.NOPASS.toString().equals(t01ComplBuyer.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息审核未通过，重新编辑后才能提交", "");
        }

        //更新审批状态为未审批
        t01ComplBuyer.setApprStat(ApprStatus.NOAPPR.toString());
        dao.update(t01ComplBuyer);

        changeCompInfoApprStat(t01ComplBuyer.getT01CompInfo(), ApprStatus.NOAPPR.toString());

        if (t01ComplBuyer.getT01CompCert0() != null && StringUtils.isNotBlank(t01ComplBuyer.getT01CompCert0().getId())) {
            changeCompCertApprStat(t01ComplBuyer.getT01CompCert0(), ApprStatus.NOAPPR.toString());
        }
        if (t01ComplBuyer.getT01CompCert1() != null && StringUtils.isNotBlank(t01ComplBuyer.getT01CompCert1().getId())) {
            //如果使用了经营资质则更新经营资质状态
            if ("1".equals(t01ComplBuyer.getCertType())) {
                changeCompCertApprStat(t01ComplBuyer.getT01CompCert1(), ApprStatus.NOAPPR.toString());
            }
        }
        if (t01ComplBuyer.getT01CompCert4() != null && StringUtils.isNotBlank(t01ComplBuyer.getT01CompCert4().getId())) {
            changeCompCertApprStat(t01ComplBuyer.getT01CompCert4(), ApprStatus.NOAPPR.toString());
        }

        Map<String, Object> vars = new HashMap<>();

        //当taskID不为空时，操作为完成任务;为空时为提交任务
        if (StringUtils.isNotBlank(taskId)) {
            vars.put("pass", 1);
            actTaskService.complete(taskId, "", "", vars);
        } else {
            vars.put("entityName", ENTITY_NAME);
            vars.put("businessId", id);
            actTaskService.startProcess(PROCDEF_KEY, BUSINESS_TABLE, t01ComplBuyer.getId(), t01ComplBuyer.getId(), vars);
        }

        //插入操作历史
        insertOperateHist(BUSINESS_MODULE, id, "2");
    }

    /**
     * 检查够货者是否能提交审批流程
     *
     * @param entity entity
     */
    private void checkCommitCondition(T01ComplBuyer entity) throws BusinessException {
        if (entity == null) {
            throw new NullPointerException("提交失败，没有对应的信息，无法启动流程");
        }
        //1：判断是否为变更数据
        SysChangeInfo sysChangeInfo = new SysChangeInfo();
        sysChangeInfo.setChanId(entity);
        List<SysChangeInfo> sysChangeInfoList = sysChangeInfoDao.findList(sysChangeInfo);
        if (sysChangeInfoList != null && !sysChangeInfoList.isEmpty()) {
            //2：找到变更前的旧数据id
            String oldId = sysChangeInfoList.get(0).getChanOrigId();
            if (StringUtils.isBlank(oldId)) {
                throw new NullPointerException("提交失败，变更信息没有对应的原始信息，无法启动流程");
            }
            //3：找到旧数据id所有变更的新数据id集合
            Set<String> newIdSet = new HashSet<>();

            SysChangeInfo sysChangeInfo2 = new SysChangeInfo();
            sysChangeInfo2.setChanOrigId(oldId);
            List<SysChangeInfo> sysChangeInfoList2 = sysChangeInfoDao.findList(sysChangeInfo2);
            for (SysChangeInfo item : sysChangeInfoList2) {
                newIdSet.add(item.getChanId().getId());
            }
            //4：判断所有变更的新数据是否有处于未审批或审批通过状态
            for (String newId : newIdSet) {
                T01ComplBuyer t01ComplBuyer = null;
                t01ComplBuyer = get(newId);
                if (t01ComplBuyer == null) {
                    throw new NullPointerException("提交失败，数据关联错误，无法启动流程");
                }
                if (ApprStatus.NOAPPR.toString().equals(t01ComplBuyer.getApprStat()) ||
                        ApprStatus.PASS.toString().equals(t01ComplBuyer.getApprStat())) {
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
     * @param ids ids
     * @return entityList
     */
    public List<T01ComplBuyer> findSelectedList(List<String> ids) {
        return dao.findSelectedList(ids);
    }

    /**
     * 根据购货者编号获取最新记录
     *
     * @param buyer 购货者
     * @return 最新的购货者记录
     */
    public T01ComplBuyer getLatestValidBuyer(T01ComplBuyer buyer) {
        return dao.getLatestValidBuyer(buyer);
    }

    /**
     * 变更编辑页数据初始化
     *
     * @param entity entity
     * @return entity
     */
    public T01ComplBuyer changeEdit(T01ComplBuyer entity) {
        //保存变更记录信息
        List<SysChangeInfo> sysChangeInfoList = entity.getSysChanInfoList();

        //获取entity对应变更前数据的id
        String oldId = entity.getSysChanInfoList().get(0).getChanOrigId();

        //获取变更前的entity数据并赋值给entity对象和变更记录信息
        entity = get(oldId);
        entity.setSysChanInfoList(sysChangeInfoList);

        return entity;
    }

    /**
     * 保存变更编辑
     *
     * @param oldT01ComplBuyer entity
     * @return entity
     * @throws BusinessException exception
     */
    @Transactional
    public T01ComplBuyer saveChangeEdit(T01ComplBuyer oldT01ComplBuyer) throws BusinessException {

        //获取变更字段的信息列表
        List<SysChangeInfo> sysChangeInfoListNew = oldT01ComplBuyer.getSysChanInfoList();

        //获取旧数据
        oldT01ComplBuyer = get(oldT01ComplBuyer.getId());

        //找到新数据id
        SysChangeInfo sysChangeInfo = new SysChangeInfo();
        sysChangeInfo.setChanOrigId(oldT01ComplBuyer.getId());
        String newId = sysChangeInfoDao.findList(sysChangeInfo).get(0).getChanId().getId();
        //获取新数据
        T01ComplBuyer newT01ComplBuyer = get(newId);

        List<SysChangeInfo> sysChangeInfoListOld = newT01ComplBuyer.getSysChanInfoList();

        for (SysChangeInfo item : sysChangeInfoListNew) {
            item.setChanOrigId(oldT01ComplBuyer.getId());
            item.setChanTbl(BUSINESS_TABLE);
            try {
                item.setOrgiValue(Reflections.invokeGetter(
                        oldT01ComplBuyer,
                        item.getChanCol()
                ).toString());
            } catch (NullPointerException e) {
                item.setOrgiValue("");
            }
            //设置变更字段新值
            Object value = item.getChanValue();
            try {
                try {
                    Reflections.invokeSetter(newT01ComplBuyer, item.getChanCol(), value);
                } catch (IllegalArgumentException e) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    // 如果日期类型提交了值得，就转换为固定格式的Date对象，否则设置为null
                    if (StringUtils.isNotBlank(item.getChanValue())) {
                        value = sdf.parse(item.getChanValue());
                    } else {
                        value = null;
                    }
                    Reflections.invokeSetter(newT01ComplBuyer, item.getChanCol(), value);
                }
            } catch (Exception e) {
                logger.error("Failed to set parent value", e);
                throw new SetValueException("设置变更值失败！", null);
            }
        }

        save(newT01ComplBuyer);

        //删除原有变更记录信息
        for (SysChangeInfo item : sysChangeInfoListOld) {
            sysChangeInfoDao.delete(item);
        }
        //获取新数据的id保存到变更记录信息中
        for (SysChangeInfo item : sysChangeInfoListNew) {
            item.setChanId(newT01ComplBuyer);
            item.preInsert();
            sysChangeInfoDao.insert(item);
        }
        return newT01ComplBuyer;
    }

    /**
     * 在审批通过时调用
     *
     * @param businessId 业务表ID
     */
    @Override
    public void actPassInvoke(String businessId) throws BusinessException {

        T01ComplBuyer t01ComplBuyer = get(businessId);

        T01ComplBuyer search = new T01ComplBuyer();
        search.setId(businessId);
        SysChangeInfo sysChangeInfo = new SysChangeInfo();
        sysChangeInfo.setChanId(search);

        List<SysChangeInfo> sysChangeInfoResultList = sysChangeInfoDao.findList(sysChangeInfo);

        if (sysChangeInfoResultList != null && !sysChangeInfoResultList.isEmpty()) {
            String origId = sysChangeInfoResultList.get(0).getChanOrigId();

            //获取变更前的数据
            T01ComplBuyer origT01ComplBuyer = get(origId);
            origT01ComplBuyer.setIsChanged(IS_CHANGED);

            //删除变更前的企业信息
            t01CompInfoDao.delete(origT01ComplBuyer.getT01CompInfo());

            //删除变更前的企业资质
            String origCompId=origT01ComplBuyer.getT01CompInfo().getId();
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"0");
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"3");
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"1");
            t01CompCertDao.deleteByCompIdAndCertType(origCompId,"4");

            //更新供货者企业id
            t01ComplSuplDao.updateCompIdWhenChangePass(t01ComplBuyer.getCompId(), origT01ComplBuyer.getCompId());

            //更新企业资质表的企业 【供货者的生产资质】
            t01CompCertDao.replaceCompIdByCertType(t01ComplBuyer.getCompId(), origT01ComplBuyer.getCompId(), "2");

            //更新供货者销售人员
            t01SalesCertDao.replaceCompId(t01ComplBuyer.getT01CompInfo().getId(),origCompId);

            dao.update(origT01ComplBuyer);
            dao.delete(origT01ComplBuyer);
        }
        //设置【变更状态】未处于变更流程中
        t01ComplBuyer.getT01CompInfo().setChangeStat("0");

        //更新与购货者相关信息的审批状态
        changeRelateApprStat(t01ComplBuyer,ApprStatus.PASS.toString());
    }

    /**
     * 在审批未通过时调用
     *
     * @param businessId 业务表ID
     */
    @Override
    public void actNoPassInvoke(String businessId) throws BusinessException {
        T01ComplBuyer t01ComplBuyer = get(businessId);

        //更新与购货者相关信息的审批状态
        changeRelateApprStat(t01ComplBuyer,ApprStatus.NOPASS.toString());
    }

    /**
     * 更新与购货者相关信息的审批状态
     * @param entity entity
     * @param apprStat 审批状态
     * @throws BusinessException exception
     */
    private void changeRelateApprStat(T01ComplBuyer entity, String apprStat) throws BusinessException {

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
        if (ComplBuyerCertType.BusinessPermit.equals(entity.getCertType())) {
            changeCompCertApprStat(entity.getT01CompCert1(), apprStat);
        }
        //如果使用了医疗资质则更新医疗资质状态
        if (ComplBuyerCertType.MedicalPracticeLicense.equals(entity.getCertType())) {
            changeCompCertApprStat(entity.getT01CompCert4(), apprStat);
        }
    }
}

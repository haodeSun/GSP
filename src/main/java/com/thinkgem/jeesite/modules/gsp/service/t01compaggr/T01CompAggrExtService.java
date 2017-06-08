package com.thinkgem.jeesite.modules.gsp.service.t01compaggr;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.common.CommonDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01aggrmatr.T01AggrMatrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compaggr.T01CompAggrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compcert.T01CompCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer.T01ComplBuyerDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complsupl.T01ComplSuplDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01salescert.T01SalesCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.CompAggrStates;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggrRelateMatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompInfoSB;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.ComplBuyerCertType;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.MatrType;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.DataNotExistException;
import com.thinkgem.jeesite.modules.gsp.service.exception.EntityExistedException;
import com.thinkgem.jeesite.modules.gsp.service.t01complprod.T01ComplProdExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoService;
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Greg Song
 * @since 20/12/2016
 */
@Service(value = "t01CompAggrService")
@Transactional(readOnly = true)
public class T01CompAggrExtService extends T01CompAggrService {

    /**
     * 流程定义KEY
     */
    private static final String PROCDEF_KEY = "t01CompAggrAppr";
    /**
     * 业务表表名
     */
    private static final String BUSINESS_TABLE = "t01_comp_aggr";
    /**
     * 业务entityName
     */
    private static final String ENTITY_NAME = "T01CompAggr";
    /**
     * 物料service
     */
    private T01MatrInfoService t01MatrInfoService;
    /**
     * 首营产品Service
     */
    private T01ComplProdExtService t01ComplProdExtService;

    /**
     * 工作流Service
     */
    private TaskService taskService;
    private ActTaskService actTaskService;
    /**
     * 公共Dao
     */
    private final CommonDao commonDao;
    /**
     * 协议关联物料Dao
     */
    private T01AggrMatrDao t01AggrMatrDao;
    /**
     * 首营购货者DAO接口
     */
    private T01ComplBuyerDao t01ComplBuyerDao;
    /**
     * 首营供货者DAO接口
     */
    private T01ComplSuplDao t01ComplSuplDao;

    @Autowired
    private T01CompCertDao t01CompCertDao;
    @Autowired
    private SystemService systemService;
    @Autowired
    private T01SalesCertDao t01SalesCertDao;

    @Autowired
    public T01CompAggrExtService(
            T01CompAggrDao dao,
            T01MatrInfoService t01MatrInfoService,
            T01ComplProdExtService t01ComplProdExtService,
            TaskService taskService,
            ActTaskService actTaskService,
            CommonDao commonDao,
            T01AggrMatrDao t01AggrMatrDao,
            T01ComplBuyerDao t01ComplBuyerDao,
            T01ComplSuplDao t01ComplSuplDao) {
        super(dao);
        assert t01MatrInfoService != null;
        assert t01ComplProdExtService != null;
        assert taskService != null;
        assert actTaskService != null;
        assert commonDao != null;
        assert t01AggrMatrDao != null;
        assert t01ComplBuyerDao != null;
        assert t01ComplSuplDao != null;

        this.t01MatrInfoService = t01MatrInfoService;
        this.t01ComplProdExtService = t01ComplProdExtService;
        this.taskService = taskService;
        this.actTaskService = actTaskService;
        this.commonDao = commonDao;
        this.t01AggrMatrDao = t01AggrMatrDao;
        this.t01ComplBuyerDao = t01ComplBuyerDao;
        this.t01ComplSuplDao = t01ComplSuplDao;
    }

    /**
     * 获取产品资质关联物料的列表
     *
     * @return 产品资质关联物料的列表
     */
    public List<T01CompAggrRelateMatrInfo> getCompAggrRelateMatrInfoList() {

        List<T01CompAggrRelateMatrInfo> t01CompAggrRelateMatrInfoList = new ArrayList<>();

        //1;先找到非医疗器械的物料信息
        T01MatrInfo t01MatrInfo = new T01MatrInfo();
        t01MatrInfo.setMatrType(MatrType.NOT_MEDICAL.toString());
        t01MatrInfo.setApprStat(ApprStatus.PASS.toString());

        List<T01MatrInfo> t01MatrInfoList = t01MatrInfoService.findList(t01MatrInfo);

        if (t01MatrInfoList != null && !t01MatrInfoList.isEmpty()) {
            for (T01MatrInfo item : t01MatrInfoList) {
                T01CompAggrRelateMatrInfo t01CompAggrRelateMatrInfo = new T01CompAggrRelateMatrInfo();
                t01CompAggrRelateMatrInfo.setId(item.getId());
                t01CompAggrRelateMatrInfo.setMatrNbr(item.getMatrNbr());
                t01CompAggrRelateMatrInfo.setMatrNmCn(item.getMatrNmCn());
                t01CompAggrRelateMatrInfoList.add(t01CompAggrRelateMatrInfo);
            }
        }

        //2：找到首营产品
        T01ComplProd t01ComplProd = new T01ComplProd();
        t01ComplProd.setApprStat(ApprStatus.PASS.toString());

        List<T01ComplProd> t01ComplProdList = t01ComplProdExtService.findList(t01ComplProd);

        if (t01ComplProdList != null && !t01ComplProdList.isEmpty()) {
            for (T01ComplProd item : t01ComplProdList) {

                //标识是否是新的物料信息
                boolean isNewMatr = true;

                for (T01CompAggrRelateMatrInfo item2 : t01CompAggrRelateMatrInfoList) {
                    //如果物料信息已存在，则追加注册证/备案凭证编号和规格型号 用,隔开
                    if (item2.getId().equals(item.getMatrId())) {
                        item2.setRegiCertNbr(item2.getRegiCertNbr() + "," + item.getRegiCertNbr());
                        item2.setSpecType(item2.getSpecType() + "," + item.getSpecType());
                        isNewMatr = false;
                    }
                }
                if (isNewMatr) {
                    T01CompAggrRelateMatrInfo t01CompAggrRelateMatrInfo = new T01CompAggrRelateMatrInfo();
                    t01CompAggrRelateMatrInfo.setId(item.getMatrId());
                    t01CompAggrRelateMatrInfo.setMatrNbr(item.getMatrNbr());
                    t01CompAggrRelateMatrInfo.setMatrNmCn(item.getMatrNmCn());
                    t01CompAggrRelateMatrInfo.setRegiCertNbr(item.getRegiCertNbr());
                    t01CompAggrRelateMatrInfo.setSpecType(item.getSpecType());
                    t01CompAggrRelateMatrInfoList.add(t01CompAggrRelateMatrInfo);
                }
            }
        }


        return t01CompAggrRelateMatrInfoList;
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

        T01CompAggr t01CompAggr = dao.get(id);

        // 寻找taskid
        if (StringUtils.isBlank(taskId) && StringUtils.isNotBlank(t01CompAggr.getProcInsId())) {
            String userId = UserUtils.getUser().getLoginName();
            TaskQuery todoTaskQuery =
                    taskService.createTaskQuery().taskAssignee(userId)
                            .processInstanceId(t01CompAggr.getProcInsId()).active().includeProcessVariables()
                            .orderByTaskCreateTime().desc();
            List<Task> todoList = todoTaskQuery.list();

            if (todoList != null && !todoList.isEmpty()) {
                taskId = todoList.get(0).getId();
            }
        }
        if (t01CompAggr == null || !StringUtils.isNotBlank(t01CompAggr.getId())) {
            throw new NullPointerException("提交失败，没有对应的信息，无法启动流程");
        }
        if (ApprStatus.NOAPPR.toString().equals(t01CompAggr.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息已提交审核，请耐心等待审批结果", "");
        }
        if (ApprStatus.PASS.toString().equals(t01CompAggr.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息已审核通过", "");
        }
        if (StringUtils.isBlank(taskId)
                && ApprStatus.NOPASS.toString().equals(t01CompAggr.getApprStat())) {
            throw new ApprStatusException("提交失败，该条信息审核未通过，重新编辑后才能提交", "");
        }

        // 更新审批状态为未审批
        t01CompAggr.setApprStat(ApprStatus.NOAPPR.toString());
        dao.update(t01CompAggr);

        Map<String, Object> vars = new HashMap<>();

        // 当taskID不为空时，操作为完成任务;为空时为提交任务
        if (StringUtils.isNotBlank(taskId)) {
            vars.put("pass", 1);
            actTaskService.complete(taskId, "", "", vars);
        } else {
            vars.put("entityName", ENTITY_NAME);
            vars.put("businessId", id);
            actTaskService.startProcess(PROCDEF_KEY, BUSINESS_TABLE, t01CompAggr.getId(),
                    t01CompAggr.getId(), vars);
        }
        //插入操作历史
        insertOperateHist(BUSINESS_MODULE, id, "2");
    }

    /**
     * 通过id列表获取数据
     *
     * @param idList idList
     * @return entityList
     */
    public List<T01CompAggr> findSelectedList(List<String> idList) {
        return dao.findSelectedList(idList);
    }

    /**
     * 获取到审批所需的task信息
     *
     * @param t01CompAggr entity
     * @throws BusinessException exception
     */
    @Transactional
    public void getTaskInfo(T01CompAggr t01CompAggr) throws BusinessException {

        if (t01CompAggr == null || StringUtils.isBlank(t01CompAggr.getId())
                || StringUtils.isBlank(t01CompAggr.getProcInsId())) {
            throw new NullPointerException("前往审批页失败，未找到相应任务，无法审批");
        }

        if (!ApprStatus.NOAPPR.toString().equals(t01CompAggr.getApprStat())) {
            throw new ApprStatusException("前往审批页失败，该条信息当前状态无法审批", "");
        }

        String userId = UserUtils.getUser().getLoginName();
        String procInsId = t01CompAggr.getProcInsId();

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
            t01CompAggr.getAct().setTaskId(todoList.get(0).getId());
            t01CompAggr.getAct().setTaskName(todoList.get(0).getName());
            t01CompAggr.getAct().setTaskDefKey(todoList.get(0).getTaskDefinitionKey());
            t01CompAggr.getAct().setProcInsId(todoList.get(0).getProcessInstanceId());
            t01CompAggr.getAct().setProcDefId(todoList.get(0).getProcessDefinitionId());
        } else {
            throw new ApprStatusException("前往审批页失败，当前用户没有审批权限", "");
        }
    }


    /**
     * 删除
     *
     * @param entity entity
     * @return 删除结果
     * @throws BusinessException exception
     */
    @Transactional
    public String deleteCompAggr(T01CompAggr entity) throws BusinessException {

        String result = "";

        if (entity != null & StringUtils.isNotBlank(entity.getId())) {
            List<String> matrIdList = new ArrayList<>();
            if (entity.getT01AggrMatrList() != null && !entity.getT01AggrMatrList().isEmpty()) {
                for (T01AggrMatr item : entity.getT01AggrMatrList()) {
                    matrIdList.add(item.getMatr().getId());
                }
            }
            //如果关联了进销存，则冻结
            if (!matrIdList.isEmpty() && commonDao.getRelateInvoicingNum(matrIdList) > 0) {
                entity.setAggrStat(CompAggrStates.FREEZE.toString());
                save(entity);
                result = "删除成功-协议冻结";
            } else {
                //删除协议关联物料
                t01AggrMatrDao.deleteByAggrId(entity.getId());
                //删除协议
                delete(entity);
                result = "删除成功";
            }
        } else {
            throw new NullPointerException("删除失败，未找到对应数据");
        }
        return result;
    }

    /**
     * 获取企业相关联的供货者和购货者信息
     *
     * @param compId 企业id
     * @return entity
     */
    public T01CompInfoSB getCompInfoSB(String compId) {
        if (StringUtils.isBlank(compId)) {
            throw new NullPointerException("没有指定数据");
        }
        T01CompInfoSB t01CompInfoSB = new T01CompInfoSB();

        T01ComplBuyer t01ComplBuyer = new T01ComplBuyer();
        t01ComplBuyer.setCompId(compId);
        List<T01ComplBuyer> t01ComplBuyerList = t01ComplBuyerDao.findList(t01ComplBuyer);
        if (t01ComplBuyerList != null) {
            t01ComplBuyerList = t01ComplBuyerList.stream()
                    .filter(item -> compId.equals(item.getCompId()))
                    .collect(Collectors.toList());
        }
        if (!t01ComplBuyerList.isEmpty()) {
            t01CompInfoSB.setBuyerId(t01ComplBuyerList.get(0).getCompId());
        }

        T01ComplSupl t01ComplSupl = new T01ComplSupl();
        t01ComplSupl.setCompId(compId);
        List<T01ComplSupl> t01ComplSuplList = t01ComplSuplDao.findList(t01ComplSupl);
        if (t01ComplSuplList != null) {
            t01ComplSuplList = t01ComplSuplList.stream()
                    .filter(item -> compId.equals(item.getCompId()))
                    .collect(Collectors.toList());
        }
        if (!t01ComplSuplList.isEmpty()) {
            t01CompInfoSB.setSupplierId(t01ComplSuplList.get(0).getCompId());
        }
        T01CompCert t01CompCert = new T01CompCert();
        t01CompCert.setCompId(compId);
        t01CompCert.setCertType("1");

        List<T01CompCert> t01CompCertList = t01CompCertDao.findList(t01CompCert);

        if (!t01CompCertList.isEmpty()) {
            t01CompInfoSB.setCertScop(t01CompCertList.get(0).getCertScop());
        }


        return t01CompInfoSB;
    }

    public Map<String, String> getScopeByBuyerId(String id, String salesCertId) throws BusinessException {
        Map<String, String> result = new HashMap<>();
        String showPromise = "", scope = "",location="";

        location=t01SalesCertDao.get(salesCertId).getSalesArea();

        //获取本企业id 本企业作为供货者
        String supplierCompId = getThisCompId();
        T01ComplSupl t01ComplSupl = null;
        T01ComplSupl searchComplSupl = new T01ComplSupl();
        searchComplSupl.setCompId(supplierCompId);
        List<T01ComplSupl> t01ComplSuplList = t01ComplSuplDao.findList(searchComplSupl);
        if (t01ComplSuplList != null && !t01ComplSuplList.isEmpty()) {
            t01ComplSupl = t01ComplSuplList.get(0);
        } else {
            throw new DataNotExistException("未找到对应供货者", "");
        }


        T01ComplBuyer t01ComplBuyer = t01ComplBuyerDao.get(id);
        String buyerCompId = t01ComplBuyer.getT01CompInfo().getId();

        //若购货者为境外企业或医疗资质  范围为全部“协议范围”下增加“协议范围承诺”
        if ("1".equals(t01ComplBuyer.getT01CompInfo().getAbroad())
                || ComplBuyerCertType.MedicalPracticeLicense.equals(t01ComplBuyer.getCertType())) {
            showPromise = "1";
            scope = "all";
        } else if ("1".equals(t01ComplSupl.getT01CompInfo().getAbroad())) {
            //若供货者为境外企业 范围为全部“协议范围”下增加“协议范围承诺”
            showPromise = "1";
            scope = "all";
        } else {
            //“授权产品范围”+“经营范围”的交集，可缩小范围，即交集之外的禁止勾选，交集之内的可以勾选或取消勾选
            showPromise = "0";

            String productScope, businessScope;

            //授权产品范围
            productScope = getProductScope(salesCertId);

            //经营范围
            businessScope = getBusinessScope(buyerCompId);

            if (StringUtils.isNotBlank(productScope)
                    && StringUtils.isNotBlank(businessScope)) {
                List<String> productScopeList = Arrays.asList(productScope.split(","));
                List<String> businessScopeScopeList = Arrays.asList(businessScope.split(","));

                //获取交集
                productScopeList.retainAll(businessScopeScopeList);

                scope = StringUtils.join(productScopeList, ",");
            }
        }
        result.put("showPromise", showPromise);
        result.put("scope", scope);
        result.put("location", location);

        return result;
    }

    public Map<String, String> getScopeBySupplierId(String id, String salesCertId)  throws BusinessException{
        Map<String, String> result = new HashMap<>();
        String showPromise = "", scope = "",location="";

        location=t01SalesCertDao.get(salesCertId).getSalesArea();

        //获取本企业id 本企业作为购货者
        String buyerCompId = getThisCompId();
        T01ComplBuyer t01ComplBuyer = null;
        T01ComplBuyer searchComplBuyer = new T01ComplBuyer();
        searchComplBuyer.setCompId(buyerCompId);
        List<T01ComplBuyer> t01ComplBuyerList = t01ComplBuyerDao.findList(searchComplBuyer);
        if (t01ComplBuyerList != null && !t01ComplBuyerList.isEmpty()) {
            t01ComplBuyer = t01ComplBuyerList.get(0);
        } else {
            throw new DataNotExistException("未找到对应供货者", "");
        }

        T01ComplSupl t01ComplSupl = t01ComplSuplDao.get(id);
        String supplierCompId = t01ComplSupl.getT01CompInfo().getId();

        //若购货者为境外企业或医疗资质  范围为全部“协议范围”下增加“协议范围承诺”
        if ("1".equals(t01ComplBuyer.getT01CompInfo().getAbroad())
                || ComplBuyerCertType.MedicalPracticeLicense.equals(t01ComplBuyer.getCertType())) {
            showPromise = "1";
            scope = "all";
        } else if ("1".equals(t01ComplSupl.getT01CompInfo().getAbroad())) {
            //若供货者为境外企业 范围为全部“协议范围”下增加“协议范围承诺”
            showPromise = "1";
            scope = "all";
        } else {
            //“授权产品范围”+“经营范围”的交集，可缩小范围，即交集之外的禁止勾选，交集之内的可以勾选或取消勾选
            showPromise = "0";

            String productScope, businessScope;

            //授权产品范围
            productScope = getProductScope(salesCertId);

            //经营范围
            businessScope = getBusinessScope(buyerCompId);

            if (StringUtils.isNotBlank(productScope)
                    && StringUtils.isNotBlank(businessScope)) {
                List<String> productScopeList = Arrays.asList(productScope.split(","));
                List<String> businessScopeScopeList = Arrays.asList(businessScope.split(","));

                //获取交集
                productScopeList.retainAll(businessScopeScopeList);

                scope = StringUtils.join(productScopeList, ",");
            }
        }

        result.put("showPromise", showPromise);
        result.put("scope", scope);
        result.put("location", location);

        return result;
    }

    public Map<String, Object> getSalesCertListByBuyerId() throws BusinessException {
        Map<String, Object> result = new HashMap<>();

        //获取本企业id 本企业作为供货者
        String supplierCompId = getThisCompId();

        //获取销售人员授权
        result.put("salesCertList", getSupplierSalesCertList(supplierCompId));

        return result;
    }

    public Map<String, Object> getSalesCertListBySupplierId(String id) {
        Map<String, Object> result = new HashMap<>();

        T01ComplSupl t01ComplSupl = t01ComplSuplDao.get(id);
        String supplierCompId = t01ComplSupl.getT01CompInfo().getId();

        //获取销售人员授权
        result.put("salesCertList", getSupplierSalesCertList(supplierCompId));

        return result;
    }

    private List<T01SalesCert> getSupplierSalesCertList(String compId) {
        List<T01SalesCert> t01SalesCertList;
        T01CompInfo searchCompInfo = new T01CompInfo();
        searchCompInfo.setId(compId);

        T01SalesCert searchSalesCert = new T01SalesCert();
        searchSalesCert.setComp(searchCompInfo);
        t01SalesCertList = t01SalesCertDao.findList(searchSalesCert);

        return t01SalesCertList;
    }

    private String getThisCompId() {
        String thisCompId = null;
        SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigName(CONFIG_COMPANY_KEY);
        List<SysConfig> sysConfigList = sysConfigService.findList(sysConfig);
        if (sysConfigList != null && !sysConfigList.isEmpty()) {
            thisCompId = sysConfigList.get(0).getConfigValue();
        }
        return thisCompId;
    }

    private String getBusinessScope(String compId) {
        T01CompCert searchCompCert = new T01CompCert();
        searchCompCert.setCompId(compId);
        searchCompCert.setCertType("1");

        List<T01CompCert> t01CompCertList = t01CompCertDao.findList(searchCompCert);
        return t01CompCertList.get(0).getCertScop();
    }

    private String getProductScope(String salesCertId) {

        T01SalesCert t01SalesCert = t01SalesCertDao.get(salesCertId);

        return t01SalesCert.getSalesScop();
    }

}

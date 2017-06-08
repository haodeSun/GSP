package com.thinkgem.jeesite.modules.gsp.service.t01prodcert;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.i18n.I18nHelperInterface;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.common.CommonDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.SysChanInfoDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprodcert.T01ComplProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.*;
import com.thinkgem.jeesite.modules.gsp.service.t01complprod.T01ComplProdExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01complprodcert.T01ComplProdCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoService;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Validator;
import java.lang.reflect.Field;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import static com.thinkgem.jeesite.common.utils.StringUtils.isBlank;
import static com.thinkgem.jeesite.common.utils.StringUtils.isNotBlank;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.ApprStatus.*;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.CertType;

/**
 * @author JOKING
 * @since 2016/12/3
 */
@Service("t01ProdCertService")
@Transactional(readOnly = true)
public class T01ProdCertExtService extends T01ProdCertService{
    @Autowired
    private I18nHelperInterface i18nHelper;
    private static final String PROCDEF_KEY = "prodCertAudit";
    private static final String BUSINESS_TABLE = "t01_prod_cert";
    private static final String FIRST = "0";
    private static final String CHANGE = "1";
    private static final String EXTEND = "2";
    // TODO抽取出来做成统一的消息管理
    private static final String ERR_MESSAGE_UNKNOWN_TYPE = "未识别的产品资质类型";

    private final T01ProdCertDao t01ProdCertDao;
    private final ActTaskService actTaskService;
    private final SysChanInfoDao sysChanInfoDao;
    protected final Validator validator;

    /**
     * 首营产品关联资质Service
     */
    private T01ComplProdCertService t01ComplProdCertService;
    /**
     * &#x9996;&#x8425;&#x4ea7;&#x54c1;Service
     */
    private T01ComplProdExtService t01ComplProdExtService;
    /**
     * 物料service
     */
    private T01MatrInfoService t01MatrInfoService;
    /**
     * 公共Dao
     */
    private CommonDao commonDao;

    private static final String ENTITY_NAME = "t01ProdCert";

    @Autowired
    public T01ProdCertExtService(
            SysChanInfoDao SysChanInfoDao,
            T01ProdCertDao t01ProdCertDao,
            ActTaskService actTaskService,
            Validator validator,
            T01ComplProdCertService t01ComplProdCertService,
            T01ComplProdExtService t01ComplProdExtService,
            T01MatrInfoService t01MatrInfoService, CommonDao commonDao) {
        super(t01ProdCertDao,SysChanInfoDao);
        assert t01ComplProdCertService != null;
        assert t01ComplProdExtService != null;
        assert commonDao != null;
        assert t01MatrInfoService != null;
        this.t01MatrInfoService = t01MatrInfoService;
        this.t01ProdCertDao = t01ProdCertDao;
        this.actTaskService = actTaskService;
        this.validator = validator;
        this.sysChanInfoDao = SysChanInfoDao;
        this.t01ComplProdCertService = t01ComplProdCertService;
        this.t01ComplProdExtService = t01ComplProdExtService;
        this.commonDao = commonDao;
    }

    /**
     * 查询一个资质的父节点和所有的变更信息
     * 以A1为例（A->A1->A2）
     * 查询结果就是 A+A1的变更记录
     * @param currT01ProdCert 需要查询的资质
     * @return 查询结果
     */
    @Transactional
    public T01ProdCert getParentWithChanHistory(T01ProdCert currT01ProdCert) {
        T01ProdCert parentProdCert = new T01ProdCert();
        if(currT01ProdCert == null){
            return parentProdCert;
        }
        String id = currT01ProdCert.getId();
        if(StringUtils.isBlank(id)){
            return parentProdCert;
        }
        //查询出变更来源资质id
        String parentId = getParentId(currT01ProdCert);
        //查询原资质记录，并且将当前记录的 变更历史 设置进去，带到页面上
        if(StringUtils.isNotBlank(parentId)) {
            parentProdCert = super.get(parentId);
        }
        //查询当前记录的 变更记录
        List<SysChanInfo> list = sysChanInfoDao.findList(new SysChanInfo(currT01ProdCert));
        parentProdCert.setSysChanInfoList(list);
        return parentProdCert;
    }

    /**
     * 获取当前产品资质的父节点  Id
     * @param currT01ProdCert 当前产品资质信息
     * @return 父节点Id
     */
    private String getParentId(T01ProdCert currT01ProdCert) {
        String id = currT01ProdCert.getId();
        String regiCertNbrs = currT01ProdCert.getRegiCertNbrs();
        String parentId = "";
        if(StringUtils.isNotBlank(regiCertNbrs)){
            String[] ids = regiCertNbrs.split(",");
            if(ids.length>=2){
                for (int i=0; i<ids.length; i++){
                    if(id.equals(ids[i])){
                        parentId = ids[i-1];
                    }
                }
            }
        }
        return parentId;
    }

    /**
     * 开启工作流
     *
     * @param prodCertId 产品资质id
     */
    @Transactional
    public void startProcess(String prodCertId, String taskId) throws Exception {
        T01ProdCert t01ProdCert = t01ProdCertDao.get(prodCertId);
        if (t01ProdCert == null || !isNotBlank(t01ProdCert.getId())) {
            throw new NullPointerException(i18nHelper.getText("提交失败，没有对应的资质信息，无法启动流程"));
        }
        if (ApprStatus.PASS.toString().equals(t01ProdCert.getApprStat())) {
            throw new ApprStatusException(i18nHelper.getText("提交失败，该资质信息已审核通过"), "");
        }
        if((CertType.CHANGE.toString().equals(t01ProdCert.getCertType())
                ||CertType.EXTEND.toString().equals(t01ProdCert.getCertType()))
                &&!chanCheck(prodCertId)){
            throw new ApprStatusException(i18nHelper.getText("该注册证已经有变更或延续正在审批或者已经通过审批！"),"");
        }

        // 进行Submit参数验证
        BeanValidators.validateWithException(validator, t01ProdCert, Submit.class);

        //更新资质审批状态
        t01ProdCert.setApprStat(ApprStatus.NOAPPR.toString());
        t01ProdCert.preUpdate();
        t01ProdCertDao.update(t01ProdCert);

        Map<String, Object> vars = new HashMap<>();

        //当任务ID不为空时，操作为完成任务;为空时为提交任务
        if (isNotBlank(taskId)) {
            actTaskService.complete(taskId, t01ProdCert.getProcInsId(), "", vars);
        } else {
            //如果没有taskid，并且没有 流程id，则开启流程
            if(StringUtils.isBlank(t01ProdCert.getProcInsId())) {
                vars.put("entityName", ENTITY_NAME);
                vars.put("businessId", prodCertId);
                actTaskService.startProcess(
                        PROCDEF_KEY,
                        BUSINESS_TABLE,
                        t01ProdCert.getId(),
                        t01ProdCert.getRegiCertNbr(),
                        vars
                );
            }else{
                //没有taskId，但是有流程id，只能通过我的任务中的编辑按钮  进行编辑，这个时候就会带上 taskId
                //现在改为修改时默认会带上taskId，所以这儿属于系统问题
                throw new ApprStatusException(i18nHelper.getText("提交流程出错！"),"");
            }
        }
    }


    /**
     * 获取变更和延续记录
     *
     * @param t01ProdCert 当前产品资质
     * @return 返回所有有关的记录
     */
    public List<T01ProdCert> getHistory(T01ProdCert t01ProdCert) {
        if (t01ProdCert == null) {
            return new ArrayList<>();
        }
        List<T01ProdCert> list;
        //如果通过非id来查询历史纪录，我们就默认取得最新的一条记录去查找相关的资质
        if(StringUtils.isBlank(t01ProdCert.getId())){
            list = getSortedList(t01ProdCert);
            if(list.isEmpty()) {
                return list;
            }else{
                t01ProdCert = list.get(0);
            }
        }
        String route = "";
        String regiCertNbrs = t01ProdCert.getRegiCertNbrs();
        if(StringUtils.isBlank(regiCertNbrs)){
            //为空，说明是新资质
            route = t01ProdCert.getId();
        }
        String[] splits = regiCertNbrs.split(",");
        if (isNotBlank(splits[0])) {
            route = splits[0];
        }
        list = t01ProdCertDao.getChildren("%"+route+"%");
        return list;
    }

    /**
     * 获取里当前时间最近的审批通过的一条记录
     * @param entity 参数
     * @return 符合条件的产品资质
     */
    public T01ProdCert getLatestPassedProdCert(T01ProdCert entity) {
        List<T01ProdCert> sortedList = getSortedList(entity);
        if (!sortedList.isEmpty()){
            //获取到当前资质的层级
            T01ProdCert currProdCert = sortedList.get(0);
            int currLevel = currProdCert.getLevel();
            //返回审批通过的离当前时间最进的一条记录
            List<T01ProdCert> historyList = getHistory(sortedList.get(0));
            //如果历史记录查询出来一条，则直接返回
            if(historyList.size() == 1){
                return sortedList.get(0);
            }
            historyList.sort((o1, o2) -> (int) (o2.getCreateDate().getTime() - o1.getCreateDate().getTime()));
            //过滤审批通过的
            List<T01ProdCert> result = historyList.stream().filter(
                    prod -> ApprStatus.PASS.toString().equals(prod.getApprStat())
            ).collect(Collectors.toList());
            if(!result.isEmpty()){
                //按照层级分类
                Map<Integer,List<T01ProdCert>> map = new HashMap<>();
                result.forEach(
                        prod -> {
                            int chanPosition = prod.getLevel();
                            if(chanPosition != 0) {
                                if (!map.containsKey(chanPosition)) {
                                    List<T01ProdCert> list = new ArrayList<>();
                                    list.add(prod);
                                    map.put(chanPosition, list);
                                } else {
                                    map.get(chanPosition).add(prod);
                                }
                            }
                        }
                );
                //如果当前资质不是最新的，则返回最新资质
                int lastLevel = map.size();
                List<T01ProdCert> lastProdcert = map.get(lastLevel);
                lastProdcert.sort((o1, o2) -> (int) (o2.getCreateDate().getTime() - o1.getCreateDate().getTime()));
                //处理延续的情况
                if(!entity.getRegiCertNbr()
                        .equals(lastProdcert.get(0).getRegiCertNbr())) {
                    // 当前资质的层级小于，最新的通过的层级的时候，返回最新的通过的资质
                    if(lastLevel > currLevel) {
                        return lastProdcert.get(0);
                    }else{
                        // 否则，返回查询出的同名的最新的一条
                        return sortedList.get(0);
                    }
                }
                return result.get(0);
            }else{
                // 历史记录不为空的时候，返回历史记录的最新的一条（第一次新增，审批没通过的情况）
                if(!historyList.isEmpty()){
                    return historyList.get(0);
                }
            }
        }
        return null;
    }

    /**
     * 通过条件获取排序后的产品资质列表
     * @param entity 条件实体
     * @return 按时间的降序排序后的list
     */
    private List<T01ProdCert> getSortedList(T01ProdCert entity){
        entity.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
        List<T01ProdCert> list = t01ProdCertDao.findChanList(entity);
        if (list.isEmpty()){
            return list;
        }else{
            //可能有多条，比如，注册，变更后产生的数据，很有可能用一个字段为条件查出来的是多条记录，这时就要看业务需要那一条
            //按创建时间排序
            list.sort((o1, o2) -> (int) (o2.getCreateDate().getTime() - o1.getCreateDate().getTime()));
        }
        return list;
    }

    /**
     * 变更提交检查
     * @param id 变更后的记录id
     * @return 返回检查结果
     */
    private boolean chanCheck(String id){
        if(StringUtils.isBlank(id)){
            return false;
        }
        T01ProdCert prodCert = t01ProdCertDao.get(id);
        String certNbrs = prodCert.getRegiCertNbrs();
        //获取所有的变更和延续历史
        List<T01ProdCert> history = getHistory(prodCert);
        //过滤出兄弟节点，
        List<T01ProdCert> siblingList = history.stream()
                .filter(prod -> StringUtils.isNotBlank(prod.getRegiCertNbr()))   //过滤出资质证号不为空的
                .filter(prod -> certNbrs.length() == prod.getRegiCertNbrs().length()) //资质路由长度等于当前资质的（说明是兄弟）
                .filter(prod -> CertType.equals(CertType.CHANGE, prod.getCertType()) //变更和延续类型的，不管变更还是延续，都只能有一个通过审批
                        || CertType.equals(CertType.EXTEND, prod.getCertType()))
                .collect(Collectors.toList());
        //过滤出审批通过，未审批的资质信息（排除自己）
        List<T01ProdCert> result = siblingList.stream()
                .filter(
                        prd -> (ApprStatus.PASS.toString().equals(prd.getApprStat())
                                || ApprStatus.NOAPPR.toString().equals(prd.getApprStat()))
                                && !id.equals(prd.getId())
                )
                .collect(Collectors.toList());
        return result.isEmpty();
    }

    /**
     * 注册证号唯一性检查，只要数据库中审批状态为  未审批，审批未通过，审批通过的数据有一条
     * 则检查失败，未提交状态的资质证号可以重复
     * @return 检查结果：true代表数据库中无已经审批过的资质证号；false代表数据库中有重复资质证号（已审批状态）。
     */
    public boolean uniqueCheck(String prodCertNo){
        if(!isBlank(prodCertNo)) {
            T01ProdCert t01ProdCert = new T01ProdCert();
            t01ProdCert.setRegiCertNbr(prodCertNo);
            T01ProdCert prod = getLatestPassedProdCert(t01ProdCert);
            if(NOAPPR.toString().equals(prod.getApprStat())
                    || NOPASS.toString().equals(prod.getApprStat())
                    || PASS.toString().equals(prod.getApprStat())){
                return false;
            }
        }
        return true;
    }

    /**
     * 从数据库中检查所有的记录，不管审批状态
     * @param prodCertNo 注册证号
     * @param id 需要排除的id
     * @return 检查结果
     */
    public boolean uniqueCheckAll(String prodCertNo,String id){
        if(isBlank(prodCertNo)) {
            return false;
        }else{
            T01ProdCert t01ProdCert = new T01ProdCert();
            t01ProdCert.setRegiCertNbr(prodCertNo);
            List<T01ProdCert> list = getSortedList(t01ProdCert);
            List<T01ProdCert> result;
            if(StringUtils.isNotBlank(id)){
                result = list.stream()
                        .filter(prod -> !id.equals(prod.getId()))
                        .collect(Collectors.toList());
            }else{
                result = list;
            }
            if(!result.isEmpty()){
                return false;
            }
        }
        return true;
    }

    /**
     * 处理实体中的流程数据
     * 当一个资质处于审批流程中的时候，需要每次的修改
     * 都带着流程相关的数据，在此提交的时候就可以，对流程
     * 状态进行控制，主要 审批退回的修改
     * @param entity  实体
     */
    public void handleAct(T01ProdCert entity){
        if(entity != null && StringUtils.isNotBlank(entity.getProcInsId())){
            String procInsId = entity.getProcInsId();
            Task task;
            if(StringUtils.isNotBlank(procInsId)){
                //如果存在流程id，就查出当前任务
                task = actTaskService.getProcessEngine()
                        .getTaskService()
                        .createTaskQuery()
                        .processInstanceId(procInsId)
                        .includeProcessVariables()
                        .active()
                        .orderByTaskCreateTime().desc()
                        .singleResult();
                if(task!=null){
                    //设置任务数据到实体中
                    entity.getAct().setTaskId(task.getId());
                    entity.getAct().setTaskDefKey(task.getTaskDefinitionKey());
                    entity.getAct().setTaskName(task.getName());
                    entity.getAct().setTask(task);
                }
            }
        }
    }
    /**
     * 变更时的基础校验
     * @param t01ProdCert 提交的产品资质（修改时，springmvc 会自动合并之前的）
     * @param originProdCert 原产品资质，手动查询的
     * @throws BusinessException 通过异常返回结果
     */
    public void chanValidate(T01ProdCert t01ProdCert, T01ProdCert originProdCert) throws BusinessException {
            if(t01ProdCert == null){
            throw new ChanValidateException(i18nHelper.getText("没有查询到该资质证，请确认是否存在！"),"");
        }
        List<SysChanInfo> submitAndOriginsysChanInfoList = t01ProdCert.getSysChanInfoList();

        if(StringUtils.isBlank(t01ProdCert.getRegiCertNbr())){
            throw new ChanValidateException(i18nHelper.getText("资质证号不能为空！"),"");
        }

        if (originProdCert == null) {
            throw new ChanValidateException(i18nHelper.getText("找不到对应的变更记录"),"");
        }
        //变更和延续时，验证附件不能为空
        if(StringUtils.isBlank(t01ProdCert.getAttachment())){
            throw new ChanValidateException(i18nHelper.getText("附件不能为空！"),"");
        }
        List<SysChanInfo> sysChanInfoList = originProdCert.getSysChanInfoList();
        //没有变更记录，说明是第一次变更
        if(sysChanInfoList.isEmpty()){
            //如果没有变更字段，则不能保存
            if(submitAndOriginsysChanInfoList.isEmpty()){
                throw new ChanValidateException(i18nHelper.getText("没有变更字段不能保存或者提交！"),"");
            }
            /* 再次决定附件不在验证，只做非空校验
            //附件验证
            validateAttachments(originProdCert.getAttachment(),t01ProdCert.getAttachment());*/
        }else {
            //如果审批通过就认为是 变更/延续，而不是修改
            if(ProdCertStatus.ApprStatus.equals(PASS, originProdCert.getApprStat())) {
                if(!submitAndOriginsysChanInfoList.isEmpty()){
                    List<SysChanInfo> result = submitAndOriginsysChanInfoList.stream()
                            .filter(obj -> StringUtils.isBlank(obj.getId()))
                            .collect(Collectors.toList());
                    if(result.isEmpty()){
                        throw new ChanValidateException(i18nHelper.getText("没有变更字段不能保存或者提交！"),"");
                    }
                }
            }
        }

    }

    /**
     * 审批未通过的资质，在修改之后，将审批状态设置为 “未提交” 详情见任务 YLQXHG-553
     * @param t01ProdCert 实体
     */
    public void apprStatHandle(T01ProdCert t01ProdCert) {
        if(t01ProdCert!=null
                && StringUtils.isNotBlank(t01ProdCert.getAct().getTaskId())){
            t01ProdCert.setApprStat(ApprStatus.NOSUBMIT.toString());
        }
    }
    /**
     * 检查上传的附件是不是新的
     * @param originAttachmentStr 原附件字符串
     * @param attachmentStr 变更后附件字符串
     */

    @SuppressWarnings("unused")
    private void validateAttachments(
            String originAttachmentStr,
            String attachmentStr) throws ChanValidateException {

        List<String> originAttachments = new ArrayList<>();
        List<String> attachments = new ArrayList<>();
        if(isAttachmentEmpty(originAttachmentStr)
                || isAttachmentEmpty(attachmentStr)){
            throw new ChanValidateException(i18nHelper.getText("附件不能为空！"),"");
        }else{
            if(!isAttachmentEmpty(originAttachmentStr)){
                originAttachments = getAttachments(originAttachmentStr,"[|]");
            }
            if(!isAttachmentEmpty(attachmentStr)){
                attachments = getAttachments(attachmentStr,"[|]");
            }
            //对比两个附件中的文件名，如果有一个重复就返回false
            if(originAttachments.stream().anyMatch(attachments::contains)){
                throw new ChanValidateException(i18nHelper.getText("变更之后的附件不能和之前的重复！"),"");
            }
        }
    }

    /**
     * 获取文件名列表
     * @param str 文件地址字符串
     * @param splitor 分隔符
     * @return 文件名list
     */
    public static List<String> getAttachments(String str, String splitor){
        String[] arrs = {};
        if(StringUtils.isBlank(str)
                || StringUtils.isBlank(splitor)){
            return Arrays.asList(arrs);
        }
        arrs = str.split(splitor);
        return Arrays.stream(arrs)
                .filter(StringUtils::isNotBlank)
                .map(obj->obj.substring(obj.lastIndexOf("/")+1))
                .collect(Collectors.toList());
    }


    private static boolean isAttachmentEmpty(String originAttachmentStr) {
        return StringUtils.isBlank(originAttachmentStr);
    }

    /**
     * 延续产品资质是的一些验证
     * @param t01ProdCert 提交的产品资质
     * @param prodCert 查询的资质
     * @throws BusinessException 通过异常传递消息
     */
    public void extendValidate(T01ProdCert t01ProdCert, T01ProdCert prodCert) throws BusinessException{
        if(ProdCertStatus.ApprStatus.equals(PASS,t01ProdCert.getApprStat())) {
            if (StringUtils.isBlank(t01ProdCert.getOrigRegiCertNbr())) {
                throw new ChanValidateException(i18nHelper.getText("原资质证号不能为空！"),"");
            }
            //只有首次变更的时候去比较，修改的时候不去比较
            if (!prodCert.getRegiCertNbr().equals(t01ProdCert.getOrigRegiCertNbr())) {
                throw new ChanValidateException(i18nHelper.getText("您提交的原资质证号不正确！"),"");
            }
        }
        //延续必须变更 批准日期  和  有效期至 两个字段（吴哥说的）
        List<SysChanInfo> sysChanInfoList = t01ProdCert.getSysChanInfoList();
        List<SysChanInfo> result = sysChanInfoList.stream()
                .filter(obj -> StringUtils.isBlank(obj.getId()))
                .collect(Collectors.toList());
        // 需要排除空值和，相等的情况，所以用map
        Map<String,SysChanInfo> map = new HashMap<>();
        if(!result.isEmpty()){
            result.forEach(obj -> map.put(obj.getChanCol(),obj));
            SysChanInfo apprDateChanInfo = null;
            SysChanInfo validPeriChanInfo = null;
            if(map.isEmpty()){
                throw new ChanValidateException(i18nHelper.getText("没有变更字段不能保存或者提交！"),"");
            }
            // 取出批准日期和有效期至，用来比较数据
            if(map.keySet().contains("apprDate")){
                apprDateChanInfo = map.get("apprDate");
            }
            if(map.keySet().contains("apprDate")){
                validPeriChanInfo =  map.get("validPeri");
            }
            if(apprDateChanInfo == null && validPeriChanInfo == null){
                throw new ChanValidateException(i18nHelper.getText("延续批准日期和有效期至必须改变！"),"");
            }else if(apprDateChanInfo == null){
                throw new ChanValidateException(i18nHelper.getText("延续批准日期必须改变！"),"");
            }else if(validPeriChanInfo == null){
                throw new ChanValidateException(i18nHelper.getText("延续有效期至必须改变！"),"");
            }else{
                // 两个值相同的时候也不行
                if(DateUtils.formatDate(prodCert.getApprDate()).equals(apprDateChanInfo.getChanValue())
                        || DateUtils.formatDate(prodCert.getValidPeri()).equals(validPeriChanInfo.getChanValue())){
                    throw new ChanValidateException(i18nHelper.getText("延续时批准日期和有效期至不能和原值相同！"),"");
                }
            }
        }
    }

    /**
     * 变更或者延续保存
     * @param entity 变更或者延续的产品资质
     * @throws BusinessException 业务异常，传递消息
     */
    @Transactional
    public void saveChanOrExtend(T01ProdCert entity) throws BusinessException {
        //修改start
        T01ProdCert t01ProdCert = checkIfChangeOrExtendById(entity.getId());
        if (t01ProdCert != null) {
            if (ApprStatus.PASS.toString().equals(t01ProdCert.getApprStat())) {

                throw new ChanValidateException("资质" + get(entity.getId()).getRegiCertNbr() + "" +
                        "已经变为：" + t01ProdCert.getRegiCertNbr(), "");
            } else {
                throw new ChanValidateException("该注册证已经有变更或延续的记录", "");
            }
        }
        //修改end
        handleChanAndExtendData(entity);
        //数据验证  YLQXHG-593
        BeanValidators.validateWithException(validator, entity,Submit.class);
        //去掉id，模拟新增的操作
        entity.setId(null);
        super.save(entity);
    }

    /**
     * 变更资质 修改
     * @param entity  实体数据
     * @param currId 当前id
     */
    @Transactional
    public void updateChanOrExtend(T01ProdCert entity, String currId) throws BusinessException {
        handleChanAndExtendData(entity);
        updateChan(entity,currId);
    }

    private void updateChan(T01ProdCert entity, String currId) throws BusinessException {
        if(StringUtils.isNotBlank(currId)){
            T01ProdCert prodCert = getOwnerWithChanHistory(new T01ProdCert(currId));
            entity.setProcInsId(prodCert.getProcInsId());
            entity.setId(currId);
            //修改时记录变更历史
            String regiCertNbrs = entity.getRegiCertNbrs();
            if (StringUtils.isNotBlank(regiCertNbrs)) {
                entity.setRegiCertNbrs(regiCertNbrs + entity.getId() + ",");
            } else {
                entity.setRegiCertNbrs(entity.getId() + ",");
            }
            //数据验证
            BeanValidators.validateWithException(validator, entity,Submit.class);
            //修改时删除原来的变更记录
            prodCert.getSysChanInfoList().forEach(
                    sysChanInfoDao::delete
            );
            super.save(entity);
        }
    }

    /**
     * 变更和延续之前的数据处理
     * @param entity 当前资质信息
     * @throws BusinessException 业务异常
     */
    private void handleChanAndExtendData(T01ProdCert entity) throws BusinessException {
        //获取资质类型
        String qualificationType = entity.getCertType();
        SysChanInfoHandler handler;
       /* if (IsSave.NO.toString().equals(entity.getIsappr())) {
            return ServiceFlag.SUCCESS;
        }*/
        switch (qualificationType) {
            case CHANGE:
                handler = new SysChanInfoHandler() {
                    @Override
                    boolean handleChangeInfo(SysChanInfo info) {
                        info.setChanType(CHANGE);
                        return true;
                    }
                };
                handler.handle(entity);
                break;
            case EXTEND:
                handler = new SysChanInfoHandler() {
                    @Override
                    boolean handleChangeInfo(SysChanInfo info) {
                        info.setChanType(EXTEND);
                        return true;
                    }
                };
                handler.handle(entity);
                break;
            default:
                // Error handle
                logger.warn(ERR_MESSAGE_UNKNOWN_TYPE);
                throw new NoSuchTypeException(ERR_MESSAGE_UNKNOWN_TYPE, qualificationType);
        }
    }

    /**
     * 获取当前资质和变更历史
     * @param t01ProdCert 当前资质信息
     * @return 包含变更记录的资质信息
     */
    public T01ProdCert getOwnerWithChanHistory(T01ProdCert t01ProdCert) {
        T01ProdCert prodCert = new T01ProdCert();
        if(t01ProdCert != null) {
            if (StringUtils.isNotBlank(t01ProdCert.getId())) {
                prodCert = super.get(t01ProdCert.getId());
                prodCert.setSysChanInfoList(sysChanInfoDao.findList(new SysChanInfo(prodCert)));
            }
        }
        return prodCert;
    }

    /**
     * 获取与产品资质关联的物料信息
     * @param t01ProdCert 要查询的产品资质
     * @return 物料list
     */
    public List<T01MatrInfo> getMatrInfoList(T01ProdCert t01ProdCert) {
        List<T01MatrInfo> t01MatrInfoList = new ArrayList<>();
        if(t01ProdCert != null && StringUtils.isNotBlank(t01ProdCert.getId())) {
            T01ComplProdCert t01ComplProdCert = new T01ComplProdCert();
            t01ComplProdCert.setProdCertId(t01ProdCert.getId());
            // 通过产品资质查询出首营产品-物料关联信息得到  首映产品 id
            List<T01ComplProdCert> list = t01ComplProdCertService.findList(t01ComplProdCert);
            list.forEach(complProdCert -> {
                // 通过首营产品id 查出物料 id
                T01ComplProd t01ComplProd = t01ComplProdExtService.get(complProdCert.getComplProdId());
                // 查询物料id 添加到list中
                t01MatrInfoList.add(t01MatrInfoService.get(t01ComplProd.getMatrId()));
            });
        }
        return t01MatrInfoList;
    }

    abstract class SysChanInfoHandler {

        void handleChanInfo(T01ProdCert productCertification) throws SetValueException {
            T01ProdCert originProductCertification = t01ProdCertDao.get(productCertification.getId());
            //这里是新建变更记录的时候，因此只有在这个时候需要创建变更记录
            createAttachChanInfo(originProductCertification,productCertification);
            //获取原始记录的变更项
            List<SysChanInfo> orgChanInfoList = originProductCertification.getSysChanInfoList();
            Set<String> set = new HashSet<>();
            orgChanInfoList.forEach(
                    orgCan -> set.add(orgCan.getChanCol())
            );


            List<SysChanInfo> list = new ArrayList<>();
            List<SysChanInfo> sysChanInfoList = productCertification.getSysChanInfoList();
            for (SysChanInfo ent : sysChanInfoList) {
                String chanCol = ent.getChanCol();
                if (StringUtils.isNotBlank(chanCol)) {

                    //如果变更值和原值相同，则不算是变更，不记录变更历史，详情页也不显示高亮
                    if(StringUtils.isNotBlank(ent.getChanValue())
                            &&ent.getChanValue().equals(getOriginValue(originProductCertification,chanCol))){
                        continue;
                    }
                    ent.setId(StringUtils.EMPTY);
                    ent.setChanCol(chanCol);
                    ent.setChanOrigId(productCertification.getId());
                    ent.setChanTbl("t01_prod_cert");
                    ent.setOrgiValue(getOriginValue(originProductCertification, chanCol));

                    //填充主表
                    setParentValue(productCertification, chanCol, ent.getChanValue());
                    if (handleChangeInfo(ent)) {
                        list.add(ent);
                    }
                }
            }
            // TODO 要考虑修改变更和延续的情况
            //记录变更路由
            String route = originProductCertification.getRegiCertNbrs();
            if (StringUtils.isNotBlank(route)) {
                productCertification.setRegiCertNbrs(route);
            }
            //设置变更或者延续后的新的产品资质的审批状态，默认为"未提交"
            productCertification.setApprStat(ProdCertStatus.ApprStatus.NOSUBMIT.toString());
            //productCertification.setId(StringUtils.SPACE);
            productCertification.setProcInsId(StringUtils.EMPTY);
            productCertification.setSysChanInfoList(list);
        }

        public void handle(T01ProdCert productCertification) throws BusinessException {
            //只有在审批通过的情况下，才新建出一条记录
            if (ProdCertStatus.ApprStatus.PASS.toString().equals(productCertification.getApprStat())) {
                handleChanInfo(productCertification);
            } else if (ProdCertStatus.ApprStatus.in(
                    new ProdCertStatus.ApprStatus[]{NOSUBMIT, NOPASS},
                    productCertification.getApprStat())) {

                handleChanInfo(productCertification);
                // 当用户再次编辑的时候，我们需要更具变更记录查找附件记录，进行更新
                SysChanInfo sysChangeInfo = productCertification.getSysChanInfoList()
                        .stream()
                        .filter(s -> s.getChanCol().equals("attachment"))  // 过滤附件变更记录
                        .map(s -> s.setChanValue(productCertification.getAttachment())) // 更新附件变更记录中的附件内容
                        .findFirst()  // 这里应该只有一条或者没有
                        .orElseGet(() -> { // 没有找到附件变更记录，附件一定发生变更处理
                            // 处理一下异常情况
                            String originId = productCertification.fetchPreviousVersionId(); // 找到变更之前的记录
                            if(originId!=null) {
                                T01ProdCert originProdCert = t01ProdCertDao.get(originId);
                                if (originProdCert != null) { // 查到原始记录是正常情况
                                    SysChanInfo change = createSysChangeInfo(
                                            originProdCert,
                                            originProdCert.getAttachment(),
                                            productCertification.getAttachment());
                                    productCertification.addSysChanInfo(change); // 添加新的附件变更记录
                                    return change;
                                }
                            }
                            return null; // 找不到之前变更记录，那么这个记录本身就是无效的
                        })
                        ;
                if (sysChangeInfo == null) {
                    // TODO 这里究竟处理成什么样需要再讨论一下
                    // 错误处理
                    logger.warn("failed to find change info for attachment");
                }
            }
        }

        /**
         * 专门用来新建附件变更记录
         * @param originProductCertification 资质证原始记录
         * @param productCertification 新提交的资质证
         */
        private void createAttachChanInfo(
                T01ProdCert originProductCertification,
                T01ProdCert productCertification) {
            String originAttach = originProductCertification.getAttachment();
            String attach = productCertification.getAttachment();

            SysChanInfo sysChanInfo = createSysChangeInfo(
                    originProductCertification,
                    originAttach,
                    attach);
            // 将新纪录添加到变更记录表里
            productCertification.addSysChanInfo(sysChanInfo);
        }

        /**
         * 创建一条附件变更记录
         * @param originProductCertification 原资质
         * @param originAttach 旧附件
         * @param attach 新附件
         * @return 变更记录
         */
        private SysChanInfo createSysChangeInfo(
                T01ProdCert originProductCertification,
                String originAttach,
                String attach) {
            if (originProductCertification == null) {
                return null;
            }
            SysChanInfo sysChanInfo = new SysChanInfo();
            sysChanInfo.setChanOrigId(originProductCertification.getId());
            sysChanInfo.setChanCol("attachment");
            sysChanInfo.setChanTbl("t01_prod_cert");
            sysChanInfo.setChanValue(attach);
            sysChanInfo.setOrgiValue(originAttach);
            return sysChanInfo;
        }

        /**
         * 处理变更记录
         *
         * @param info 变更信息
         * @return 返回true加入列表，返回false则不需要加入更新列表
         */
        abstract boolean handleChangeInfo(SysChanInfo info);

    }

    /**
     * 获取变更之前的值
     *
     * @param entity  原始数据
     * @param chanCol 变化字段
     * @return 原值，如果根据反射找不到原值，就返回空（这个合理吗？）
     */
    private String getOriginValue(T01ProdCert entity, String chanCol) {
        final String[] value = {""};
        Class<?> entityClazz = entity.getClass();
        Field[] fields = entityClazz.getDeclaredFields();
        Arrays.stream(fields)
                .filter(fd -> chanCol.equals(fd.getName()))
                .findFirst()
                .ifPresent(fd -> {
                    Class<?> type = fd.getType();
                    if(type == Date.class){
                        // 如果是日期的话按照固定的格式返回 字符串
                        value[0] = DateUtils.formatDate((Date)Reflections.invokeGetter(entity,fd.getName()));
                    }else {
                        value[0] = String.valueOf(Reflections.invokeGetter(entity,fd.getName()));
                    }
                });
        return value[0];
    }

    /**
     * 设置主表变更后的值
     *
     * @param entity    实体
     * @param chanCol   变更字段
     * @param chanValue 变更值
     */
    private void setParentValue(T01ProdCert entity,
                                String chanCol,
                                String chanValue) throws SetValueException {
        Object value = chanValue;
        try {
            Field field = Reflections.getAccessibleField(entity,chanCol);
            Class<?> type = field != null ? field.getType() : null;
            // 如果变更类型为日期的话，将提交上来的字符串按照固定格式转为日期
            if (type == Date.class) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                // 如果日期类型提交了值得，就转换为固定格式的Date对象，否则设置为null
                if(StringUtils.isNotBlank(chanValue)) {
                    value = sdf.parse(chanValue);
                }else{
                    value = null;
                }
            }
            // 设置父表的值
            Reflections.invokeSetter(entity, chanCol, value);
        } catch (SecurityException | ParseException e) {
            // FIXME 这个处理肯定不行，需要细化
            logger.error("Failed to set parent value", e);
            throw new SetValueException(i18nHelper.getText("设置变更值失败！"),null);
        }
    }
    /**
     * 产品资质删除
     * @param entity entity
     * @return 删除结果
     * @throws BusinessException exception
     */
    @Transactional
    public String deleteProdCert(T01ProdCert entity) throws BusinessException {

        String result;

        if (entity != null && StringUtils.isNotBlank(entity.getId())) {

            T01ComplProdCert t01ComplProdCert = new T01ComplProdCert();
            t01ComplProdCert.setProdCertId(entity.getId());
            List<T01ComplProdCert> t01ComplProdCertList = t01ComplProdCertService.findList(t01ComplProdCert);

            //判断是否关联物料信息
            if (t01ComplProdCertList != null && !t01ComplProdCertList.isEmpty()) {

                //获取到关联的产品idSet
                Set<String> complProdIdsSet = new HashSet<>();
                for (T01ComplProdCert item : t01ComplProdCertList) {
                    complProdIdsSet.add(item.getComplProdId());
                }
                List<String> matrIdList = new ArrayList<>();
                for (String complProdId : complProdIdsSet) {
                    T01ComplProd t01ComplProd = t01ComplProdExtService.get(complProdId);
                    matrIdList.add(t01ComplProd.getMatrId());
                }
                //如果关联了进销存，则冻结
                if (commonDao.getRelateInvoicingNum(matrIdList) > 0) {
                    entity.setCertStat(ProdCertStatus.CertStatus.FREEZE.toString());
                    save(entity);
                    result = "删除成功-资质冻结";
                } else {
                    //提示请先清除物料与本资质的关联，否则无法删除；
                    result = "删除失败,请先清除物料与本资质的关联，否则无法删除";
                }
            } else {
                //没有关联物料直接删除
                delete(entity);
                result = "删除成功";
            }
        } else {
            throw new NullPointerException("删除失败，未找到对应数据");
        }

        return result;
    }

    /**
     * 判断产品资质是否有过变更或延续历史
     *
     * @param regiCertNbr 注册证/备案凭证编号
     * @return 变更后的产品资质 没有返回null
     */
    public T01ProdCert checkIfChangeOrExtend(String regiCertNbr) {
        T01ProdCert t01ProdCert = null;

        if (StringUtils.isNotBlank(regiCertNbr)) {
            T01ProdCert t01ProdCertSearch = new T01ProdCert();

            t01ProdCertSearch.setApprStat(ApprStatus.PASS.toString());
            t01ProdCertSearch.setRegiCertNbr(regiCertNbr);

            List<T01ProdCert> t01ProdCertList = findList(t01ProdCertSearch).stream()
                    .filter(item -> regiCertNbr.equals(item.getRegiCertNbr()))
                    .collect(Collectors.toList());
            if (t01ProdCertList != null && !t01ProdCertList.isEmpty()) {
                SysChanInfo sysChanInfo = new SysChanInfo();

                sysChanInfo.setChanTbl(BUSINESS_TABLE);
                sysChanInfo.setChanOrigId(t01ProdCertList.get(0).getId());

                List<SysChanInfo> sysChanInfoList = sysChanInfoDao.findList(sysChanInfo);

                if (sysChanInfoList != null && !sysChanInfoList.isEmpty()) {
                    t01ProdCert = get(sysChanInfoList.get(0).getChanId());
                }
            }
        }
        return t01ProdCert;
    }

    /**
     * 判断产品资质是否有过变更或延续历史
     *
     * @param id id
     * @return 变更或延续后的产品资质 没有返回null
     */
    public T01ProdCert checkIfChangeOrExtendById(String id) {
        T01ProdCert t01ProdCert = null;

        if (StringUtils.isNotBlank(id)) {
            SysChanInfo sysChanInfo = new SysChanInfo();

            sysChanInfo.setChanTbl(BUSINESS_TABLE);
            sysChanInfo.setChanOrigId(id);

            List<SysChanInfo> sysChanInfoList = sysChanInfoDao.findList(sysChanInfo);

            if (sysChanInfoList != null && !sysChanInfoList.isEmpty()) {
                t01ProdCert = get(sysChanInfoList.get(0).getChanId());
            }
        }
        return t01ProdCert;
    }

}

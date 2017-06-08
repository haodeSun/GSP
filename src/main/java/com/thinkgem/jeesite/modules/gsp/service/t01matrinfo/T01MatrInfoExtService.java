package com.thinkgem.jeesite.modules.gsp.service.t01matrinfo;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.common.CommonDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01matrinfo.T01MatrInfoDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.MatrInfoStates;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfoImport;
import com.thinkgem.jeesite.modules.gsp.entity.t01operatehist.T01OperateHist;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01complprod.T01ComplProdExtService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 物料信息ExtService
 *
 * @author xuxiaoshuo
 * @version 2016-11-22
 */
@SuppressWarnings("FieldCanBeLocal")
@Service
public class T01MatrInfoExtService extends BaseService {

    /**
     * 日志对象
     */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    private final ActTaskService actTaskService;
    /**
     * 物料同步表批次前缀
     */
    private final String BATCH_PREFIX = "fromexcel_";
    /**
     * 物料状态为未同步
     */
    private final String NOT_SYNC = "0";
    /**
     * 物料同步成功
     */
    private final String SYNC_SUCESS = "1";
    /**
     * 物料同步失败
     */
    private final String SYNC_FAIL = "2";
    /**
     * 流程定义KEY
     */
    private static final String PROCDEF_KEY = "t01MatrInfoAppr";
    /**
     * 业务表表名
     */
    private static final String BUSINESS_TABLE = "t01_matr_info";
    /**
     * 业务表表名
     */
    private static final String ENTITY_NAME = "T01MatrInfo";
    /**
     * 验证Bean实例对象
     */
    protected final Validator validator;

    private T01MatrInfoDao dao;

    private final T01MatrInfoService t01MatrInfoService;
    /** 工作流Service */
    private final TaskService taskService;
    /**
     * 首营产品Service
     */
    private T01ComplProdExtService t01ComplProdExtService;

    private CommonDao commonDao;

    @Autowired
    public T01MatrInfoExtService(
            T01MatrInfoDao dao,
            ActTaskService actTaskService,
            Validator validator,
            T01MatrInfoService t01MatrInfoService,
            TaskService taskService,
            T01ComplProdExtService t01ComplProdExtService,
            CommonDao commonDao) {
        assert dao != null;
        assert actTaskService != null;
        assert validator != null;
        assert t01MatrInfoService != null;
        assert taskService != null;
        assert t01ComplProdExtService != null;
        Assert.notNull(commonDao);

        this.dao = dao;
        this.actTaskService = actTaskService;
        this.validator = validator;
        this.t01MatrInfoService = t01MatrInfoService;
        this.taskService = taskService;
        this.t01ComplProdExtService = t01ComplProdExtService;
        this.commonDao = commonDao;
    }
    /**
     * 获取到审批所需的task信息
     *
     * @param t01MatrInfo entity
     * @throws BusinessException exception
     */
    @Transactional
    public void getTaskInfo(T01MatrInfo t01MatrInfo) throws BusinessException {

        if (t01MatrInfo == null
                || StringUtils.isBlank(t01MatrInfo.getId())
                || StringUtils.isBlank(t01MatrInfo.getProcInsId())) {
            throw new NullPointerException("前往审批页失败，未找到相应任务，无法审批");
        }

        if (!ApprStatus.NOAPPR.toString().equals(t01MatrInfo.getApprStat())) {
            throw new ApprStatusException("前往审批页失败，该条信息当前状态无法审批", "");
        }

        String userId = UserUtils.getUser().getLoginName();
        String procInsId = t01MatrInfo.getProcInsId();

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
            t01MatrInfo.getAct().setTaskId(todoList.get(0).getId());
            t01MatrInfo.getAct().setTaskName(todoList.get(0).getName());
            t01MatrInfo.getAct().setTaskDefKey(todoList.get(0).getTaskDefinitionKey());
            t01MatrInfo.getAct().setProcInsId(todoList.get(0).getProcessInstanceId());
            t01MatrInfo.getAct().setProcDefId(todoList.get(0).getProcessDefinitionId());
        } else {
            throw new ApprStatusException("前往审批页失败，当前用户没有审批权限", "");
        }
    }

    /**
     * 将excel文件保持到物料信息同步表
     *
     * @param stream 文件流
     * @throws IOException 文件操作异常
     */
    @Transactional
    public void ImportExcelToSync(InputStream stream) throws IOException {
        List<T01MatrInfoImport> allList = getT01MatrInfoImports(stream);
        if (allList == null || allList.isEmpty()) {
            throw new NullPointerException("没有找到导入数据");
        }
        insertImportBatch(allList);
    }

    /**
     * 批量插入导入数据
     *
     * @param t01MatrInfoImportList 物料信息列表
     */
    @SuppressWarnings("WeakerAccess")
    @Transactional
    public void insertImportBatch(List<T01MatrInfoImport> t01MatrInfoImportList) {
        dao.insertImportBatch(t01MatrInfoImportList);
    }

    /**
     * 通过导入批次查询数据
     *
     * @param batch 同步信息表的批次
     * @return 物料信息列表
     */
    @SuppressWarnings("unused")
    @Transactional
    public List<T01MatrInfoImport> findImportList(String batch) {
        return dao.findImportList(batch);
    }

    /**
     * 通过id list查询导入数据
     *
     * @param ids LIST of ID
     * @return 导入物料信息列表
     */
    @SuppressWarnings("WeakerAccess")
    @Transactional
    public List<T01MatrInfoImport> findSelectedImportList(List<String> ids) {
        return dao.findSelectedImportList(ids);
    }

    /**
     * 更新同步表中导入数据状态
     *
     * @param t01MatrInfoImport 物料导入entity
     */
    @SuppressWarnings("WeakerAccess")
    @Transactional
    public void updateImportState(T01MatrInfoImport t01MatrInfoImport) {
        dao.updateImportState(t01MatrInfoImport);
    }

    /**
     * 删除指定的数据
     *
     * @param ids 待删除资质id
     */
    @Transactional
    public void deleteList(List<String> ids) throws BusinessException{
        List<T01MatrInfo> t01MatrInfoList=findSelectedList(ids);
        for(T01MatrInfo item :t01MatrInfoList){
            t01MatrInfoService.delete(item);
        }
    }

    /**
     * 删除物料
     * @param entity entity
     * @return 删除结果
     * @throws BusinessException exception
     */
    @Transactional
    public String deleteMatrInfo(T01MatrInfo entity) throws BusinessException {

        String result = "";

        if (entity != null & StringUtils.isNotBlank(entity.getId())) {
            T01ComplProd t01ComplProd = new T01ComplProd();
            t01ComplProd.setMatrId(entity.getId());
            List<T01ComplProd> t01ComplProdList = t01ComplProdExtService.findList(t01ComplProd);
            //判断是否关联产品资质信息
            if (t01ComplProdList != null && !t01ComplProdList.isEmpty()) {
                List<String> matrIdList = new ArrayList<>();
                matrIdList.add(entity.getId());
                //如果关联了进销存，则冻结
                if (commonDao.getRelateInvoicingNum(matrIdList) > 0) {
                    entity.setMartStat(MatrInfoStates.FREEZE.toString());
                    t01MatrInfoService.save(entity);
                    result = "删除成功-物料冻结";
                } else {
                    //仅关联产品资质/协议的物料信息需要在解除关联后才可删除
                    result = "删除失败,请先清除资质/协议与本物料的关联，否则无法删除";
                }
            } else {
                //没有关联产品资质直接删除
                t01MatrInfoService.delete(entity);
                result = "删除成功";
            }
        } else {
            throw new NullPointerException("删除失败，未找到对应数据");
        }
        return result;
    }


    /**
     * 获取指定的数据
     *
     * @param ids 待删除资质id
     */
    @Transactional
    public List<T01MatrInfo> findSelectedList(List<String> ids) {
        return dao.findSelectedList(ids);
    }

    /**
     * 通过物料号获取数据
     *
     * @param matrNbr 物料号
     * @return 物料列表
     */
    @Transactional
    public List<T01MatrInfo> findByMatrNbr(String matrNbr) {
        return dao.findByMatrNbr(matrNbr);
    }

    /**
     * 批量导入数据
     *
     * @param t01MatrInfoList 物料信息list
     */
    @SuppressWarnings("unused")
    @Transactional
    public void insertBatch(List<T01MatrInfo> t01MatrInfoList) {
        dao.insertBatch(t01MatrInfoList);
    }

    /**
     * 同步数据到物料信息表
     *
     * @param idList 指定的信息id列表
     * @throws IOException 文件异常
     */
    @Transactional
    public void SyncImport(List<String> idList) {

        List<T01MatrInfoImport> importList = findSelectedImportList(idList);
        if (importList == null || importList.isEmpty()) {
            throw new NullPointerException("操作失败,没有找到导入数据");
        }

        for (T01MatrInfoImport item : importList) {
            try {
                item.setIsNewRecord(true);
                // 进行参数验证
                BeanValidators.validateWithException(validator, item, Submit.class);
                t01MatrInfoService.save(item);
                item.setSyncStat(SYNC_SUCESS);
                updateImportState(item);
            } catch (ConstraintViolationException cvExc) {//捕获验证异常
                String message = "";
                for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                    message += violation.getMessage();
                }
                item.setSyncStat(SYNC_FAIL);
                item.setSyncRslt(message);
                updateImportState(item);
            } catch (Exception e) {
                item.setSyncStat(SYNC_FAIL);
                item.setSyncRslt(e.getMessage());
                updateImportState(item);
                logger.error("导入失败失败原因：" + e.getMessage());
            }
        }
    }

    /**
     * 将文件流输入到list对象中
     *
     * @param stream 文件流
     * @return List列表
     * @throws IOException 文件操作异常
     */
    private List<T01MatrInfoImport> getT01MatrInfoImports(InputStream stream) throws IOException {
        List<T01MatrInfoImport> allList = new ArrayList<>();
        // 记录导入异常的数据

        XSSFWorkbook xssfWorkbook = new XSSFWorkbook(stream);

        for (Sheet sheet : xssfWorkbook) {
            boolean first = true;
            for (Row row : sheet) {
                if (first) {
                    first = false;
                    continue;
                }
                //过滤掉空行
                int valueNum = 8;
                int blankNum = 0;
                for (int i = 0; i < 8; i++) {
                    if (StringUtils.isBlank(getValue(row.getCell(i)))) {
                        blankNum++;
                    }
                }
                if(valueNum==blankNum){
                    continue;
                }

                T01MatrInfoImport item = new T01MatrInfoImport();

                item.setMatrNbr(getValue(row.getCell(0)));
                item.setMatrNmCn(getValue(row.getCell(1)));
                item.setMatrNmEn(getValue(row.getCell(2)));
                item.setMatrDesc(getValue(row.getCell(3)));
                item.setMatrType(getValue(row.getCell(4)));
                item.setPriceUnit(getValue(row.getCell(5)));
                item.setMatrPrice(StringUtils.isBlank(getValue(row.getCell(6))) ? "" : getValue(row.getCell(6)));
//                item.setRemarks(getValue(row.getCell(7)));
                item.setBatch(BATCH_PREFIX + UserUtils.getUser().getId());
                item.preInsert();
                item.setSyncStat(NOT_SYNC);
                item.setApprStat(ApprStatus.NOSUBMIT.toString());//设置新添加的数据审核状态为未提交
                item.setMartStat(MatrInfoStates.NOT_RELATED.toString());
                item.setIsNewRecord(true);// 这里设置为true不然会执行update语句
                BeanValidators.validateWithException(validator, item, Submit.class);
                allList.add(item);
            }
        }
        xssfWorkbook.close();
        return allList;
    }

    /**
     * 返回excel单元格的字符串数据
     *
     * @param cell 单元格对象
     * @return 字符串
     */
    private String getValue(Cell cell) {
        DecimalFormat df = new DecimalFormat("0");
        if (cell == null) {
            return "";
        } else {
            // poi 4.0 以后会升级getCellType并返回枚举
            if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
                return String.valueOf(cell.getBooleanCellValue());
            } else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
                return String.valueOf(df.format(cell.getNumericCellValue()));
            } else {
                return String.valueOf(cell.getStringCellValue());
            }
        }
    }

    /**
     * 物料信息已经录入，通过物料ID启动物料管理流程
     *
     * @param matrInfoId 物料ID
     * @throws Exception 验证异常
     */
    @Transactional
    public void startProcess(String matrInfoId, String taskId) throws Exception {
        T01MatrInfo t01MatrInfo = t01MatrInfoService.get(matrInfoId);

        //寻找taskid
        if(StringUtils.isNotBlank(t01MatrInfo.getProcInsId())) {
            String userId = UserUtils.getUser().getLoginName();
            TaskQuery todoTaskQuery = taskService.createTaskQuery()
                    .taskAssignee(userId)
                    .processInstanceId(t01MatrInfo.getProcInsId())
                    .active()
                    .includeProcessVariables()
                    .orderByTaskCreateTime()
                    .desc();
            List<Task> todoList = todoTaskQuery.list();

            if (todoList != null && !todoList.isEmpty()) {
                taskId = todoList.get(0).getId();
            }
        }

        if (t01MatrInfo == null || !StringUtils.isNotBlank(t01MatrInfo.getId())) {
            throw new NullPointerException("提交失败，没有对应的物料信息，无法启动流程");
        }
        if (ApprStatus.NOAPPR.toString().equals(t01MatrInfo.getApprStat())) {
            throw new ApprStatusException("提交失败，该物料信息已提交审核，请耐心等待审批结果", "");
        }
        if (ApprStatus.PASS.toString().equals(t01MatrInfo.getApprStat())) {
            throw new ApprStatusException("提交失败，该物料信息已审核通过", "");
        }
        if (StringUtils.isBlank(taskId) && ApprStatus.NOPASS.toString().equals(t01MatrInfo.getApprStat())) {
            throw new ApprStatusException("提交失败，该物料信息审核未通过，重新编辑后才能提交", "");
        }
        // 进行Submit参数验证
        BeanValidators.validateWithException(validator, t01MatrInfo, Submit.class);

        //更新物料审批状态
        t01MatrInfo.setApprStat(ApprStatus.NOAPPR.toString());
        dao.update(t01MatrInfo);

        Map<String, Object> vars = new HashMap<>();

        //当任务ID不为空时，操作为完成任务;为空时为提交任务
        if (StringUtils.isNotBlank(taskId)) {
            vars.put("pass", 1);
            actTaskService.complete(taskId, "", "", vars);
        } else {
            vars.put("entityName", ENTITY_NAME);
            vars.put("businessId", matrInfoId);
            actTaskService.startProcess(PROCDEF_KEY, BUSINESS_TABLE, t01MatrInfo.getId(), t01MatrInfo.getMatrNbr(), vars);
        }
        insertOperateHist("t01MatrInfo",matrInfoId,"2");
    }
}
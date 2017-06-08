/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01complprod;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.dao.ActDao;
import com.thinkgem.jeesite.modules.act.entity.Act;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.common.CommonDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complprod.T01ComplProdDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complprodcert.T01ComplProdCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01matrinfo.T01MatrInfoDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.ComplProdStates;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprodcert.T01ComplProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.MatrInfoStates;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01complprodcert.T01ComplProdCertService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.validation.Validator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 首营产品Service
 * @author XXS
 * @version 2016-12-06
 */
@Service
@Transactional(readOnly = true)
public class T01ComplProdExtService extends T01ComplProdService{

	/** 流程定义KEY */
	private static final String PROCDEF_KEY = "t01ComplProdAppr";
	/** 业务表表名 */
	private static final String BUSINESS_TABLE = "t01_compl_prod";
	/** 工作流Service */
	private final TaskService taskService;
	private final ActTaskService actTaskService;
	private final RuntimeService runtimeService;
	/** 验证Bean实例对象 */
	protected final Validator validator;
	/** 工作流Dao */
	private final ActDao actDao;
	/** 审批同意标识 */
	private final String APPR_YES="1";
	/** 逐级退回审批标识 */
	private final String APPR_PREV = "2";
	/** 第一个审批人标识 */
	private final String APPR_FIRST = "aduit";
	/**
	 * 公共Dao
	 */
	private final CommonDao commonDao;
	/**
	 * 首营产品关联资质Service
	 */
	private final T01ComplProdCertService t01ComplProdCertService;
	/**
	 * 物料信息Dao
	 */
	private T01MatrInfoDao t01MatrInfoDao;

	@Autowired
	public T01ComplProdExtService(
			T01ComplProdDao dao,
			Validator validator,
			TaskService taskService,
			ActTaskService actTaskService,
			RuntimeService runtimeService,
			ActDao actDao,
			CommonDao commonDao,
			T01ComplProdCertService t01ComplProdCertService,
			T01MatrInfoDao t01MatrInfoDao) {
		super(dao);
		Assert.notNull(validator);
		Assert.notNull(taskService);
		Assert.notNull(actTaskService);
		Assert.notNull(runtimeService);
		Assert.notNull(actDao);
		Assert.notNull(commonDao);
		Assert.notNull(t01ComplProdCertService);
		Assert.notNull(t01MatrInfoDao);
		this.validator = validator;
		this.taskService = taskService;
		this.actTaskService = actTaskService;
		this.runtimeService = runtimeService;
		this.actDao = actDao;
		this.commonDao = commonDao;
		this.t01ComplProdCertService = t01ComplProdCertService;
		this.t01MatrInfoDao = t01MatrInfoDao;
	}
	/**
	 * 删除产品
	 * @param entity entity
	 * @return 删除结果
	 * @throws BusinessException exception
	 */
//	@Transactional
//	public String deleteComplProd(T01ComplProd entity) throws BusinessException {
//
//		String result = "";
//
//		if (entity != null & StringUtils.isNotBlank(entity.getMatrId())) {
//
//			List<String> matrIdList = new ArrayList<>();
//			matrIdList.add(entity.getMatrId());
//			//如果关联了进销存，则冻结
//			if (commonDao.getRelateInvoicingNum(matrIdList) > 0) {
//				T01ComplProdCert t01ComplProdCert=new T01ComplProdCert();
//				t01ComplProdCert.setComplProdId(entity.getId());
//				//删除关联的资质
//				List<T01ComplProdCert> t01ComplProdCertList=t01ComplProdCertService.findList(t01ComplProdCert);
//				if(t01ComplProdCertList!=null&&!t01ComplProdCertList.isEmpty()){
//					for(T01ComplProdCert item:t01ComplProdCertList){
//						t01ComplProdCertService.delete(item);
//					}
//				}
//				//更新物料信息的状态
//				updateMatrInfoStates(entity.getMatrId());
//
//				entity.setComplProdStat(ComplProdStates.FREEZE.toString());
//				save(entity);
//				result = "解除成功-首营产品冻结";
//			} else {
//				T01ComplProdCert t01ComplProdCert=new T01ComplProdCert();
//				t01ComplProdCert.setComplProdId(entity.getId());
//				//删除关联的资质
//				List<T01ComplProdCert> t01ComplProdCertList=t01ComplProdCertService.findList(t01ComplProdCert);
//				if(t01ComplProdCertList!=null&&!t01ComplProdCertList.isEmpty()){
//					for(T01ComplProdCert item:t01ComplProdCertList){
//						t01ComplProdCertService.delete(item);
//					}
//				}
//				//删除产品
//				delete(entity);
//				//更新物料信息的状态
//				updateMatrInfoStates(entity.getMatrId());
//				result = "解除成功";
//			}
//		} else {
//			throw new NullPointerException("解除失败，未找到对应数据");
//		}
//		return result;
//	}
	@Transactional
	public String deleteComplProd(T01ComplProd entity) throws BusinessException {

		String result = "";

		//根据产品资质关联表的id删除
		if (entity != null & StringUtils.isNotBlank(entity.getComplProdCertId())) {

			T01ComplProdCert t01ComplProdCert = t01ComplProdCertService.get(entity.getComplProdCertId());

			String complProdId = t01ComplProdCert.getComplProdId();

			T01ComplProd t01ComplProd = get(complProdId);

			List<String> matrIdList = new ArrayList<>();
			matrIdList.add(t01ComplProd.getMatrId());

			//如果关联了进销存，则冻结
			if (commonDao.getRelateInvoicingNum(matrIdList) > 0) {
				dao.freeze(entity.getComplProdCertId());
				//更新物料信息的状态
				updateMatrInfoStates(t01ComplProd.getMatrId());
				result = "解除成功-首营产品冻结";
			} else {
				t01ComplProdCertService.delete(t01ComplProdCert);

				T01ComplProdCert t01ComplProdCertSearch = new T01ComplProdCert();
				t01ComplProdCertSearch.setComplProdId(complProdId);
				List<T01ComplProdCert> t01ComplProdCertList = t01ComplProdCertService.findList(t01ComplProdCertSearch);
				//如果首营产品关联资质列表为空
				if (t01ComplProdCertList == null || t01ComplProdCertList.isEmpty()) {
					//删除产品
					delete(t01ComplProd);
				}
				//更新物料信息的状态
				updateMatrInfoStates(t01ComplProd.getMatrId());
				result = "解除成功";
			}
		} else {
			throw new NullPointerException("解除失败，未找到对应数据");
		}
		return result;
	}


	/**
	 * 启动审批流程
	 * @param id entityId
	 * @param taskId 任务id
	 * @throws Exception exception
	 */
	@Transactional
	public void startProcess(String id, String taskId) throws Exception {

		T01ComplProd t01ComplProd = get(id);
		//寻找taskid
		if(StringUtils.isNotBlank(t01ComplProd.getProcInsId())) {
			String userId = UserUtils.getUser().getLoginName();
			TaskQuery todoTaskQuery = taskService.createTaskQuery()
					.taskAssignee(userId)
					.processInstanceId(t01ComplProd.getProcInsId())
					.active()
					.includeProcessVariables()
					.orderByTaskCreateTime()
					.desc();
			List<Task> todoList = todoTaskQuery.list();

			if (todoList != null && !todoList.isEmpty()) {
				taskId = todoList.get(0).getId();
			}
		}
		if (t01ComplProd == null || !StringUtils.isNotBlank(t01ComplProd.getId())) {
			throw new NullPointerException("提交失败，没有对应的信息，无法启动流程");
		}
		if (ApprStatus.NOAPPR.toString().equals(t01ComplProd.getApprStat())) {
			throw new ApprStatusException("提交失败，该条信息已提交审核，请耐心等待审批结果", "");
		}
		if (ApprStatus.PASS.toString().equals(t01ComplProd.getApprStat())) {
			throw new ApprStatusException("提交失败，该条信息已审核通过", "");
		}
		if (StringUtils.isBlank(taskId) && ApprStatus.NOPASS.toString().equals(t01ComplProd.getApprStat())) {
			throw new ApprStatusException("提交失败，该条信息审核未通过，重新编辑后才能提交", "");
		}
		// 进行参数验证
		BeanValidators.validateWithException(validator, t01ComplProd);

		//更新审批状态为未审批
		t01ComplProd.setApprStat(ApprStatus.NOAPPR.toString());
		dao.update(t01ComplProd);

		Map<String, Object> vars = new HashMap<>();

		//当taskID不为空时，操作为完成任务;为空时为提交任务
		if (StringUtils.isNotBlank(taskId)) {
			vars.put("pass", 1);
			actTaskService.complete(taskId, "", "", vars);
		} else {
			actTaskService.startProcess(PROCDEF_KEY, BUSINESS_TABLE, t01ComplProd.getId(), t01ComplProd.getMatrNbr(), vars);
		}
	}

	/**
	 * 首营产品审批处理逻辑
	 * @param t01ComplProd entity
	 * @throws Exception exception
	 */
	@Transactional
	public void approve(T01ComplProd t01ComplProd) throws Exception {

		//寻找taskid
		if(t01ComplProd!=null&&StringUtils.isNotBlank(t01ComplProd.getProcInsId())) {
			String userId = UserUtils.getUser().getLoginName();

			//判断用户在当前审批流程是否有代签收任务
			TaskQuery toClaimQuery = taskService.createTaskQuery()
					.taskCandidateUser(userId)
					.processInstanceId(t01ComplProd.getProcInsId())
					.includeProcessVariables()
					.active()
					.orderByTaskCreateTime()
					.desc();

			List<Task> toClaimList = toClaimQuery.list();
			//用户在当前审批流程有代签收任务，则自动签收
			if (toClaimList != null && !toClaimList.isEmpty()) {
				actTaskService.claim(toClaimList.get(0).getId(), userId);
			}
			//判断用户在当前审批流程是否有代办任务
			TaskQuery todoTaskQuery = taskService.createTaskQuery()
					.taskAssignee(userId)
					.processInstanceId(t01ComplProd.getProcInsId())
					.active()
					.includeProcessVariables()
					.orderByTaskCreateTime()
					.desc();
			List<Task> todoList = todoTaskQuery.list();
			//用户在当前审批流程有代办任务，则设置任务的taskId和procInsId
			if (todoList != null && !todoList.isEmpty()) {
				t01ComplProd.getAct().setTaskId(todoList.get(0).getId());
				t01ComplProd.getAct().setProcInsId(todoList.get(0).getProcessInstanceId());
				t01ComplProd.getAct().setTaskDefKey(todoList.get(0).getTaskDefinitionKey());
			} else {
				throw new ApprStatusException("当前用户没有审批权限","");
			}
		}else{
			throw new ApprStatusException("未找到对应流程实例","");
		}

		// 提交流程任务
		Map<String, Object> vars = new HashMap<>();
		vars.put("pass", t01ComplProd.getAct().getFlag());
		actTaskService.complete(
				t01ComplProd.getAct().getTaskId(),
				t01ComplProd.getAct().getProcInsId(),
				t01ComplProd.getAct().getComment(),
				vars);

		String actStatus;

		if (runtimeService
				.createProcessInstanceQuery()
				.processInstanceId(t01ComplProd.getProcInsId())
				.singleResult() == null) {
			actStatus = ApprStatus.PASS.toString();
		} else {
			if (APPR_YES.equals(t01ComplProd.getAct().getFlag())) {
				actStatus = ApprStatus.NOAPPR.toString();
			} else if (APPR_PREV.equals(t01ComplProd.getAct().getFlag())) {
				if (APPR_FIRST.equals(t01ComplProd.getAct().getTaskDefKey())) {
					actStatus = ApprStatus.NOPASS.toString();
				} else {
					actStatus = ApprStatus.NOAPPR.toString();
				}
			} else {
				actStatus = ApprStatus.NOPASS.toString();
			}
		}

		//更新业务表状态
		Act act = new Act();
		act.setBusinessTable(BUSINESS_TABLE);
		act.setBusinessId(t01ComplProd.getId());
		act.setStatus(actStatus);
		actDao.updateStatusByBusinessId(act);

		//更新物料信息的状态
		updateMatrInfoStates(t01ComplProd.getMatrId());
	}

	/**
	 * 更新物料信息的状态
	 * @param matrId 物料id
	 */
	private void updateMatrInfoStates(String matrId) {
		T01ComplProd t01ComplProd = new T01ComplProd();
		t01ComplProd.setMatrId(matrId);
		t01ComplProd.setApprStat(ApprStatus.PASS.toString());
		List<T01ComplProd> t01ComplProdList = findList(t01ComplProd);
		T01MatrInfo t01MatrInfo = t01MatrInfoDao.get(matrId);
		if (t01ComplProdList != null && !t01ComplProdList.isEmpty()) {
			t01MatrInfo.setMartStat(MatrInfoStates.RELATED.toString());
		} else {
			t01MatrInfo.setMartStat(MatrInfoStates.NOT_RELATED.toString());
		}
		t01MatrInfoDao.update(t01MatrInfo);
	}


	/**
	 * 判断当前用户在对应流程实例中是否有审批权限
	 * @param t01ComplProd entity
	 * @throws Exception exception
	 */
	@Transactional
	public void CheckPermissionToTask(T01ComplProd t01ComplProd) throws Exception {
		//判断流程实例id是否为空
		if (StringUtils.isNotBlank(t01ComplProd.getProcInsId())) {
			String userId = UserUtils.getUser().getLoginName();
			//判断用户在当前审批流程是否有代签收任务
			TaskQuery toClaimQuery = taskService.createTaskQuery()
					.taskCandidateUser(userId)
					.processInstanceId(t01ComplProd.getProcInsId())
					.includeProcessVariables()
					.active()
					.orderByTaskCreateTime()
					.desc();

			List<Task> toClaimList = toClaimQuery.list();
			//用户在当前审批流程没有代签收任务
			if (toClaimList == null || toClaimList.isEmpty()) {
				//判断用户在当前审批流程是否有代办任务
				TaskQuery todoTaskQuery = taskService.createTaskQuery()
						.taskAssignee(userId)
						.processInstanceId(t01ComplProd.getProcInsId())
						.active()
						.includeProcessVariables()
						.orderByTaskCreateTime()
						.desc();
				List<Task> todoList = todoTaskQuery.list();
				//用户在当前审批流程没有代办任务
				if (todoList == null || todoList.isEmpty()) {
					throw new ApprStatusException("当前用户没有审批权限", "");
				}
			}
		} else {
			throw new ApprStatusException("未找到对应流程实例", "");
		}
	}

	/**
	 * 获取指定id列表的entity列表
	 * @param idList id列表
	 * @return entity列表
	 */
	public List<T01ComplProd> findSelectedList(List<String> idList) {
		return dao.findSelectedList(idList);
	}
}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 保存job信息Entity
 * @author yohu
 * @version 2016-12-04
 */
public class SysJob extends DataEntity<SysJob> {
	
	private static final long serialVersionUID = 1L;
	private String jobName;		// 任务名称
	private String targgerName;		// trigger名称
	private String jobGroup;		// job_group
	private String triggerGroup;		// trigger_group
	private String clazzName;		// 任务执行类
	private String jobStatus;		// 任务状态
	private String lastRunTime;		// 上次运行时间
	private String expression;		// 表达式
	
	public SysJob() {
		super();
	}

	public SysJob(String id){
		super(id);
	}

	@Length(min=0, max=50, message="任务名称长度必须介于 0 和 50 之间")
	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}
	
	@Length(min=0, max=50, message="trigger名称长度必须介于 0 和 50 之间")
	public String getTarggerName() {
		return targgerName;
	}

	public void setTarggerName(String targgerName) {
		this.targgerName = targgerName;
	}
	
	@Length(min=0, max=50, message="job_group长度必须介于 0 和 50 之间")
	public String getJobGroup() {
		return jobGroup;
	}

	public void setJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
	}
	
	@Length(min=0, max=50, message="trigger_group长度必须介于 0 和 50 之间")
	public String getTriggerGroup() {
		return triggerGroup;
	}

	public void setTriggerGroup(String triggerGroup) {
		this.triggerGroup = triggerGroup;
	}
	
	@Length(min=0, max=2048, message="任务执行类长度必须介于 0 和 50 之间")
	public String getClazzName() {
		return clazzName;
	}

	public void setClazzName(String clazzName) {
		this.clazzName = clazzName;
	}
	
	@Length(min=0, max=50, message="任务状态长度必须介于 0 和 50 之间")
	public String getJobStatus() {
		return jobStatus;
	}

	public void setJobStatus(String jobStatus) {
		this.jobStatus = jobStatus;
	}
	
	@Length(min=0, max=50, message="上次运行时间长度必须介于 0 和 50 之间")
	public String getLastRunTime() {
		return lastRunTime;
	}

	public void setLastRunTime(String lastRunTime) {
		this.lastRunTime = lastRunTime;
	}
	
	@Length(min=0, max=200, message="表达式长度必须介于 0 和 50 之间")
	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}
	
}
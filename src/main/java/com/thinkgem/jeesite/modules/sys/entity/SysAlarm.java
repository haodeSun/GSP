/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 预警配置表Entity
 * @author yohu
 * @version 2016-12-21
 */
public class SysAlarm extends DataEntity<SysAlarm> {
	
	private static final long serialVersionUID = 1L;
	private String className;		// 关联类
	private String warnCont;		// 预警内容
	private Integer aheadTime;		// 提前时间（按月计算）
	private Integer alarmFreq;		// 提醒频率（几天一次）
	private Boolean sendFlag;		// 预警开关
	private String qualifyType;		// 资质类型
	private Date lastAlarmTime;		// 上次提醒时间
	
	public SysAlarm() {
		super();
	}

	public SysAlarm(String id){
		super(id);
	}

	@Length(min=0, max=100, message="关联类长度必须介于 0 和 100 之间")
	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}
	
	@Length(min=0, max=100, message="预警内容长度必须介于 0 和 100 之间")
	public String getWarnCont() {
		return warnCont;
	}

	public void setWarnCont(String warnCont) {
		this.warnCont = warnCont;
	}
	
	public Integer getAheadTime() {
		return aheadTime;
	}

	public void setAheadTime(Integer aheadTime) {
		this.aheadTime = aheadTime;
	}
	
	public Integer getAlarmFreq() {
		return alarmFreq;
	}

	public void setAlarmFreq(Integer alarmFreq) {
		this.alarmFreq = alarmFreq;
	}
	
	public Boolean getSendFlag() {
		return sendFlag;
	}

	public void setSendFlag(Boolean sendFlag) {
		this.sendFlag = sendFlag;
	}
	
	@Length(min=0, max=100, message="资质类型长度必须介于 0 和 100 之间")
	public String getQualifyType() {
		return qualifyType;
	}

	public void setQualifyType(String qualifyType) {
		this.qualifyType = qualifyType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getLastAlarmTime() {
		return lastAlarmTime;
	}

	public void setLastAlarmTime(Date lastAlarmTime) {
		this.lastAlarmTime = lastAlarmTime;
	}
	
}
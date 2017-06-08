/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 首营购货者Entity
 * @author XXS
 * @version 2016-12-15
 */
public class SysChangeInfo extends DataEntity<SysChangeInfo> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String chanTbl;		// 变更表
	private String chanCol;		// 变更表_字段
	private String chanOrigId;		// 变更表_原记录id
	private T01ComplBuyer chanId;		// 变更表_记录id 父类
	private String chanType;		// 变更类型
	private String orgiValue;		// 原值
	private String chanValue;		// 变更值
	private String chanReason;		// 变更原因
	
	public SysChangeInfo() {
		super();
	}

	public SysChangeInfo(String id){
		super(id);
	}

	public SysChangeInfo(T01ComplBuyer chanId){
		this.chanId = chanId;
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="变更表长度必须介于 0 和 100 之间")
	public String getChanTbl() {
		return chanTbl;
	}

	public void setChanTbl(String chanTbl) {
		this.chanTbl = chanTbl;
	}
	
	@Length(min=0, max=100, message="变更表_字段长度必须介于 0 和 100 之间")
	public String getChanCol() {
		return chanCol;
	}

	public void setChanCol(String chanCol) {
		this.chanCol = chanCol;
	}
	
	@Length(min=0, max=100, message="变更表_原记录id长度必须介于 0 和 100 之间")
	public String getChanOrigId() {
		return chanOrigId;
	}

	public void setChanOrigId(String chanOrigId) {
		this.chanOrigId = chanOrigId;
	}
	
	@Length(min=0, max=100, message="变更表_记录id长度必须介于 0 和 100 之间")
	public T01ComplBuyer getChanId() {
		return chanId;
	}

	public void setChanId(T01ComplBuyer chanId) {
		this.chanId = chanId;
	}
	
	@Length(min=0, max=100, message="变更类型长度必须介于 0 和 100 之间")
	public String getChanType() {
		return chanType;
	}

	public void setChanType(String chanType) {
		this.chanType = chanType;
	}
	
	@Length(min=0, max=100, message="原值长度必须介于 0 和 100 之间")
	public String getOrgiValue() {
		return orgiValue;
	}

	public void setOrgiValue(String orgiValue) {
		this.orgiValue = orgiValue;
	}
	
	@Length(min=0, max=100, message="变更值长度必须介于 0 和 100 之间")
	public String getChanValue() {
		return chanValue;
	}

	public void setChanValue(String chanValue) {
		this.chanValue = chanValue;
	}
	
	@Length(min=0, max=100, message="变更原因长度必须介于 0 和 100 之间")
	public String getChanReason() {
		return chanReason;
	}

	public void setChanReason(String chanReason) {
		this.chanReason = chanReason;
	}
	
}
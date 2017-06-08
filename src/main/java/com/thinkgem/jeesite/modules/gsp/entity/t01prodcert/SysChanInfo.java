/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01prodcert;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 产品资质Entity
 * @author gyq
 * @version 2016-11-28
 */
public class SysChanInfo extends DataEntity<SysChanInfo> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String chanTbl;		// 变更表
	private String chanCol;		// 变更表_字段
	private String chanOrigId;		// 变更表_原记录id
	private T01ProdCert chanId;		// 变更表_记录id 父类
	private String chanType;		// 变更类型
	private String orgiValue;		// 原值
	private String chanValue;		// 变更值
	private String chanReason;		// 变更原因
	
	public SysChanInfo() {
		super();
	}

	public SysChanInfo(String id){
		super(id);
	}

	public SysChanInfo(T01ProdCert chanId){
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
	public T01ProdCert getChanId() {
		return chanId;
	}

	public void setChanId(T01ProdCert chanId) {
		this.chanId = chanId;
	}
	
	@Length(min=0, max=100, message="变更类型长度必须介于 0 和 100 之间")
	public String getChanType() {
		return chanType;
	}

	public void setChanType(String chanType) {
		this.chanType = chanType;
	}
	
	@Length(min=0, max=2048, message="原值长度必须介于 0 和 2048 之间")
	public String getOrgiValue() {
		return orgiValue;
	}

	public void setOrgiValue(String orgiValue) {
		this.orgiValue = orgiValue;
	}
	
	@Length(min=0, max=2048, message="变更值长度必须介于 0 和 2048 之间")
	public String getChanValue() {
		return chanValue;
	}

	public SysChanInfo setChanValue(String chanValue) {
		this.chanValue = chanValue;
		return this;
	}
	
	@Length(min=0, max=100, message="变更原因长度必须介于 0 和 100 之间")
	public String getChanReason() {
		return chanReason;
	}

	public void setChanReason(String chanReason) {
		this.chanReason = chanReason;
	}
	
}
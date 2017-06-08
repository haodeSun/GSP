/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01matrsync;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 物料信息同步Entity
 * @author xxs
 * @version 2016-11-30
 */
public class T01MatrSync extends DataEntity<T01MatrSync> {
	
	private static final long serialVersionUID = 1L;
	private String matrNbr;		// 物料号
	private String matrNmCn;		// 物料名称（中文）
	private String matrNmEn;		// 物料名称（英文）
	private String matrDesc;		// 描述
	private String matrType;		// 物料分类
	private String priceUnit;		// 货币单位
	private String matrPrice;		// 物料单价
	private String martStat;		// 物料状态
	private String procInsId;		// 流程实例ID
	private String syncSys;		// 源系统
	private String syncMode;		// 同步方式
	private String batch;		// 导入批次
	private String syncStat;		// 同步状态
	private String syncRslt;		// 同步结果
	private String extId;		// 外部数据关联
	
	public T01MatrSync() {
		super();
	}

	public T01MatrSync(String id){
		super(id);
	}

	@Length(min=1, max=128, message="物料号长度必须介于 1 和 128 之间")
	public String getMatrNbr() {
		return matrNbr;
	}

	public void setMatrNbr(String matrNbr) {
		this.matrNbr = matrNbr;
	}
	
	@Length(min=1, max=128, message="物料名称（中文）长度必须介于 1 和 128 之间")
	public String getMatrNmCn() {
		return matrNmCn;
	}

	public void setMatrNmCn(String matrNmCn) {
		this.matrNmCn = matrNmCn;
	}
	
	@Length(min=1, max=128, message="物料名称（英文）长度必须介于 1 和 128 之间")
	public String getMatrNmEn() {
		return matrNmEn;
	}

	public void setMatrNmEn(String matrNmEn) {
		this.matrNmEn = matrNmEn;
	}
	
	@Length(min=1, max=500, message="描述长度必须介于 1 和 500 之间")
	public String getMatrDesc() {
		return matrDesc;
	}

	public void setMatrDesc(String matrDesc) {
		this.matrDesc = matrDesc;
	}
	
	@Length(min=0, max=64, message="物料分类长度必须介于 0 和 64 之间")
	public String getMatrType() {
		return matrType;
	}

	public void setMatrType(String matrType) {
		this.matrType = matrType;
	}
	
	@Length(min=1, max=64, message="货币单位长度必须介于 1 和 64 之间")
	public String getPriceUnit() {
		return priceUnit;
	}

	public void setPriceUnit(String priceUnit) {
		this.priceUnit = priceUnit;
	}
	
	public String getMatrPrice() {
		return matrPrice;
	}

	public void setMatrPrice(String matrPrice) {
		this.matrPrice = matrPrice;
	}
	
	@Length(min=0, max=10, message="物料状态长度必须介于 0 和 10 之间")
	public String getMartStat() {
		return martStat;
	}

	public void setMartStat(String martStat) {
		this.martStat = martStat;
	}
	
	@Length(min=0, max=128, message="流程实例ID长度必须介于 0 和 128 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=128, message="源系统长度必须介于 0 和 128 之间")
	public String getSyncSys() {
		return syncSys;
	}

	public void setSyncSys(String syncSys) {
		this.syncSys = syncSys;
	}
	
	@Length(min=0, max=128, message="同步方式长度必须介于 0 和 128 之间")
	public String getSyncMode() {
		return syncMode;
	}

	public void setSyncMode(String syncMode) {
		this.syncMode = syncMode;
	}
	
	@Length(min=0, max=128, message="导入批次长度必须介于 0 和 128 之间")
	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}
	
	@Length(min=0, max=128, message="同步状态长度必须介于 0 和 128 之间")
	public String getSyncStat() {
		return syncStat;
	}

	public void setSyncStat(String syncStat) {
		this.syncStat = syncStat;
	}
	
	@Length(min=0, max=128, message="同步结果长度必须介于 0 和 128 之间")
	public String getSyncRslt() {
		return syncRslt;
	}

	public void setSyncRslt(String syncRslt) {
		this.syncRslt = syncRslt;
	}
	
	@Length(min=0, max=128, message="外部数据关联长度必须介于 0 和 128 之间")
	public String getExtId() {
		return extId;
	}

	public void setExtId(String extId) {
		this.extId = extId;
	}
	
}
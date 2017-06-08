/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02stockin;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 入库Entity
 * @author yohu
 * @version 2016-11-24
 */
public class T02StockinMate extends DataEntity<T02StockinMate> {
	
	private static final long serialVersionUID = 1L;
	private String mateId;		// 物料id
	private String procInsId;		// 流程实例ID
	private String sequence;		// 序号
	private String description;		// 描述
	private String storQuan;		// 入库数量
	private String qualStat;		// 质量状态/区域
	private String comments;		// 备注
	private T02Stockin stockinId;		// 入库单id 父类
	
	public T02StockinMate() {
		super();
	}

	public T02StockinMate(String id){
		super(id);
	}

	public T02StockinMate(T02Stockin stockinId){
		this.stockinId = stockinId;
	}

	@Length(min=0, max=100, message="物料id长度必须介于 0 和 100 之间")
	public String getMateId() {
		return mateId;
	}

	public void setMateId(String mateId) {
		this.mateId = mateId;
	}
	
	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="序号长度必须介于 0 和 100 之间")
	public String getSequence() {
		return sequence;
	}

	public void setSequence(String sequence) {
		this.sequence = sequence;
	}
	
	@Length(min=0, max=100, message="描述长度必须介于 0 和 100 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=11, message="入库数量长度必须介于 0 和 11 之间")
	public String getStorQuan() {
		return storQuan;
	}

	public void setStorQuan(String storQuan) {
		this.storQuan = storQuan;
	}
	
	@Length(min=0, max=100, message="质量状态/区域长度必须介于 0 和 100 之间")
	public String getQualStat() {
		return qualStat;
	}

	public void setQualStat(String qualStat) {
		this.qualStat = qualStat;
	}
	
	@Length(min=0, max=100, message="备注长度必须介于 0 和 100 之间")
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
	@Length(min=0, max=100, message="入库单id长度必须介于 0 和 100 之间")
	public T02Stockin getStockinId() {
		return stockinId;
	}

	public void setStockinId(T02Stockin stockinId) {
		this.stockinId = stockinId;
	}
	
}
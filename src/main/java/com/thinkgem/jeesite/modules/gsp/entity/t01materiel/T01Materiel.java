/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01materiel;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 物料信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T01Materiel extends DataEntity<T01Materiel> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String mateName;		// 物料名
	private String description;		// 描述
	private String longDesc;		// 长描述
	private String type;		// 类型
	private String storCond;		// 储存条件
	private String storCondTemp;		// 储存条件_温度
	private String storCondHumi;		// 储存条件_湿度
	private String tranCond;		// 运输条件
	private String tranCondTemp;		// 运输条件_温度
	private String tranCondHumi;		// 运输条件_湿度
	private String comments;		// 备注
	
	public T01Materiel() {
		super();
	}

	public T01Materiel(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="物料名长度必须介于 0 和 100 之间")
	public String getMateName() {
		return mateName;
	}

	public void setMateName(String mateName) {
		this.mateName = mateName;
	}
	
	@Length(min=0, max=100, message="描述长度必须介于 0 和 100 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=100, message="长描述长度必须介于 0 和 100 之间")
	public String getLongDesc() {
		return longDesc;
	}

	public void setLongDesc(String longDesc) {
		this.longDesc = longDesc;
	}
	
	@Length(min=0, max=100, message="类型长度必须介于 0 和 100 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=100, message="储存条件长度必须介于 0 和 100 之间")
	public String getStorCond() {
		return storCond;
	}

	public void setStorCond(String storCond) {
		this.storCond = storCond;
	}
	
	@Length(min=0, max=100, message="储存条件_温度长度必须介于 0 和 100 之间")
	public String getStorCondTemp() {
		return storCondTemp;
	}

	public void setStorCondTemp(String storCondTemp) {
		this.storCondTemp = storCondTemp;
	}
	
	@Length(min=0, max=100, message="储存条件_湿度长度必须介于 0 和 100 之间")
	public String getStorCondHumi() {
		return storCondHumi;
	}

	public void setStorCondHumi(String storCondHumi) {
		this.storCondHumi = storCondHumi;
	}
	
	@Length(min=0, max=100, message="运输条件长度必须介于 0 和 100 之间")
	public String getTranCond() {
		return tranCond;
	}

	public void setTranCond(String tranCond) {
		this.tranCond = tranCond;
	}
	
	@Length(min=0, max=100, message="运输条件_温度长度必须介于 0 和 100 之间")
	public String getTranCondTemp() {
		return tranCondTemp;
	}

	public void setTranCondTemp(String tranCondTemp) {
		this.tranCondTemp = tranCondTemp;
	}
	
	@Length(min=0, max=100, message="运输条件_湿度长度必须介于 0 和 100 之间")
	public String getTranCondHumi() {
		return tranCondHumi;
	}

	public void setTranCondHumi(String tranCondHumi) {
		this.tranCondHumi = tranCondHumi;
	}
	
	@Length(min=0, max=100, message="备注长度必须介于 0 和 100 之间")
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
}
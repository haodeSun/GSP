/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02rejemate;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 退回-物料信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02RejeMate extends DataEntity<T02RejeMate> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String commCode;		// 商品编码
	private String commBarCode;		// 商品条码
	private String commName;		// 商品名称
	private String unit;		// 单位
	private String unitCont;		// 单位含量
	private String origCoun;		// 原单数量
	private String count;		// 数量
	private String pickBatc;		// 挑批次
	private String soldPric;		// 最后售价
	private String taxTranPric;		// 含税成交单价
	private String taxAmou;		// 含税金额
	private String actiType;		// 活动类型
	private String promNo;		// 促销活动号
	
	public T02RejeMate() {
		super();
	}

	public T02RejeMate(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=11, message="商品编码长度必须介于 1 和 11 之间")
	public String getCommCode() {
		return commCode;
	}

	public void setCommCode(String commCode) {
		this.commCode = commCode;
	}
	
	@Length(min=0, max=11, message="商品条码长度必须介于 0 和 11 之间")
	public String getCommBarCode() {
		return commBarCode;
	}

	public void setCommBarCode(String commBarCode) {
		this.commBarCode = commBarCode;
	}
	
	@Length(min=1, max=11, message="商品名称长度必须介于 1 和 11 之间")
	public String getCommName() {
		return commName;
	}

	public void setCommName(String commName) {
		this.commName = commName;
	}
	
	@Length(min=1, max=11, message="单位长度必须介于 1 和 11 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=1, max=11, message="单位含量长度必须介于 1 和 11 之间")
	public String getUnitCont() {
		return unitCont;
	}

	public void setUnitCont(String unitCont) {
		this.unitCont = unitCont;
	}
	
	@Length(min=1, max=11, message="原单数量长度必须介于 1 和 11 之间")
	public String getOrigCoun() {
		return origCoun;
	}

	public void setOrigCoun(String origCoun) {
		this.origCoun = origCoun;
	}
	
	@Length(min=1, max=11, message="数量长度必须介于 1 和 11 之间")
	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}
	
	@Length(min=1, max=11, message="挑批次长度必须介于 1 和 11 之间")
	public String getPickBatc() {
		return pickBatc;
	}

	public void setPickBatc(String pickBatc) {
		this.pickBatc = pickBatc;
	}
	
	@Length(min=1, max=11, message="最后售价长度必须介于 1 和 11 之间")
	public String getSoldPric() {
		return soldPric;
	}

	public void setSoldPric(String soldPric) {
		this.soldPric = soldPric;
	}
	
	@Length(min=1, max=11, message="含税成交单价长度必须介于 1 和 11 之间")
	public String getTaxTranPric() {
		return taxTranPric;
	}

	public void setTaxTranPric(String taxTranPric) {
		this.taxTranPric = taxTranPric;
	}
	
	@Length(min=1, max=11, message="含税金额长度必须介于 1 和 11 之间")
	public String getTaxAmou() {
		return taxAmou;
	}

	public void setTaxAmou(String taxAmou) {
		this.taxAmou = taxAmou;
	}
	
	@Length(min=1, max=11, message="活动类型长度必须介于 1 和 11 之间")
	public String getActiType() {
		return actiType;
	}

	public void setActiType(String actiType) {
		this.actiType = actiType;
	}
	
	@Length(min=1, max=11, message="促销活动号长度必须介于 1 和 11 之间")
	public String getPromNo() {
		return promNo;
	}

	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}
	
}
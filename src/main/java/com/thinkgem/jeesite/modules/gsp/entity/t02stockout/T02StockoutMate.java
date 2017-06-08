/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02stockout;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 出库信息Entity
 * @author yohu
 * @version 2016-11-25
 */
public class T02StockoutMate extends DataEntity<T02StockoutMate> {
	
	private static final long serialVersionUID = 1L;
	private String mateId;		// id
	private String procInsId;		// 流程实例ID
	private String seriNo;		// 序号
	private String describe;		// 描述
	private String outQuan;		// 出库数量
	private String unit;		// 单位
	private String unitCont;		// 单位含量
	private String count;		// 数量
	private String batchNumb;		// 批次号
	private String comm;		// 备注
	private T02Stockout stockoutId;		// 出库单id 父类
	
	public T02StockoutMate() {
		super();
	}

	public T02StockoutMate(String id){
		super(id);
	}

	public T02StockoutMate(T02Stockout stockoutId){
		this.stockoutId = stockoutId;
	}

	@Length(min=0, max=100, message="id长度必须介于 0 和 100 之间")
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
	
	@Length(min=1, max=100, message="序号长度必须介于 1 和 100 之间")
	public String getSeriNo() {
		return seriNo;
	}

	public void setSeriNo(String seriNo) {
		this.seriNo = seriNo;
	}
	
	@Length(min=0, max=100, message="描述长度必须介于 0 和 100 之间")
	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}
	
	@Length(min=1, max=11, message="出库数量长度必须介于 1 和 11 之间")
	public String getOutQuan() {
		return outQuan;
	}

	public void setOutQuan(String outQuan) {
		this.outQuan = outQuan;
	}
	
	@Length(min=0, max=100, message="单位长度必须介于 0 和 100 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=100, message="单位含量长度必须介于 0 和 100 之间")
	public String getUnitCont() {
		return unitCont;
	}

	public void setUnitCont(String unitCont) {
		this.unitCont = unitCont;
	}
	
	@Length(min=0, max=100, message="数量长度必须介于 0 和 100 之间")
	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}
	
	@Length(min=0, max=100, message="批次号长度必须介于 0 和 100 之间")
	public String getBatchNumb() {
		return batchNumb;
	}

	public void setBatchNumb(String batchNumb) {
		this.batchNumb = batchNumb;
	}
	
	@Length(min=0, max=100, message="备注长度必须介于 0 和 100 之间")
	public String getComm() {
		return comm;
	}

	public void setComm(String comm) {
		this.comm = comm;
	}
	
	@Length(min=0, max=100, message="出库单id长度必须介于 0 和 100 之间")
	public T02Stockout getStockoutId() {
		return stockoutId;
	}

	public void setStockoutId(T02Stockout stockoutId) {
		this.stockoutId = stockoutId;
	}
	
}
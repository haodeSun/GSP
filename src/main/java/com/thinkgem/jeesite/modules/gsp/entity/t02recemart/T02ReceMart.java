/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02recemart;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 收货-物料信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02ReceMart extends DataEntity<T02ReceMart> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String mateNumb;		// 物料号
	private String described;		// 描述
	private String prodName;		// 产品名称
	private String regiCertNo;		// 注册证号
	private String orderQuan;		// 订货数量
	private String arriQuan;		// 到货数量
	private String prodBatch;		// 生产批号
	private String prodDate;		// 生产日期
	private String disaDate;		// 失效日期
	
	public T02ReceMart() {
		super();
	}

	public T02ReceMart(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="物料号长度必须介于 0 和 100 之间")
	public String getMateNumb() {
		return mateNumb;
	}

	public void setMateNumb(String mateNumb) {
		this.mateNumb = mateNumb;
	}
	
	@Length(min=0, max=100, message="描述长度必须介于 0 和 100 之间")
	public String getDescribed() {
		return described;
	}

	public void setDescribed(String described) {
		this.described = described;
	}
	
	@Length(min=0, max=100, message="产品名称长度必须介于 0 和 100 之间")
	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	
	@Length(min=0, max=100, message="注册证号长度必须介于 0 和 100 之间")
	public String getRegiCertNo() {
		return regiCertNo;
	}

	public void setRegiCertNo(String regiCertNo) {
		this.regiCertNo = regiCertNo;
	}
	
	@Length(min=0, max=100, message="订货数量长度必须介于 0 和 100 之间")
	public String getOrderQuan() {
		return orderQuan;
	}

	public void setOrderQuan(String orderQuan) {
		this.orderQuan = orderQuan;
	}
	
	@Length(min=0, max=100, message="到货数量长度必须介于 0 和 100 之间")
	public String getArriQuan() {
		return arriQuan;
	}

	public void setArriQuan(String arriQuan) {
		this.arriQuan = arriQuan;
	}
	
	@Length(min=0, max=100, message="生产批号长度必须介于 0 和 100 之间")
	public String getProdBatch() {
		return prodBatch;
	}

	public void setProdBatch(String prodBatch) {
		this.prodBatch = prodBatch;
	}
	
	@Length(min=0, max=100, message="生产日期长度必须介于 0 和 100 之间")
	public String getProdDate() {
		return prodDate;
	}

	public void setProdDate(String prodDate) {
		this.prodDate = prodDate;
	}
	
	@Length(min=0, max=100, message="失效日期长度必须介于 0 和 100 之间")
	public String getDisaDate() {
		return disaDate;
	}

	public void setDisaDate(String disaDate) {
		this.disaDate = disaDate;
	}
	
}
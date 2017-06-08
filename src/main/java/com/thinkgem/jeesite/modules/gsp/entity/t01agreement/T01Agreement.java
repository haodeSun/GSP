/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01agreement;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 协议模块Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T01Agreement extends DataEntity<T01Agreement> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String agreNumb;		// 协议编号
	private String prodName;		// 产品名称
	private String specModel;		// 规格型号
	private String regiCertNumb;		// 注册证号
	private String manuEnte;		// 生产企业
	private String supplier;		// 供货者
	private String unitPrice;		// 单价
	private String amount;		// 金额
	private String effeDate;		// 生效日期
	private String validPeriTo;		// 有效期至
	
	public T01Agreement() {
		super();
	}

	public T01Agreement(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="协议编号长度必须介于 0 和 100 之间")
	public String getAgreNumb() {
		return agreNumb;
	}

	public void setAgreNumb(String agreNumb) {
		this.agreNumb = agreNumb;
	}
	
	@Length(min=0, max=100, message="产品名称长度必须介于 0 和 100 之间")
	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	
	@Length(min=0, max=100, message="规格型号长度必须介于 0 和 100 之间")
	public String getSpecModel() {
		return specModel;
	}

	public void setSpecModel(String specModel) {
		this.specModel = specModel;
	}
	
	@Length(min=0, max=100, message="注册证号长度必须介于 0 和 100 之间")
	public String getRegiCertNumb() {
		return regiCertNumb;
	}

	public void setRegiCertNumb(String regiCertNumb) {
		this.regiCertNumb = regiCertNumb;
	}
	
	@Length(min=0, max=100, message="生产企业长度必须介于 0 和 100 之间")
	public String getManuEnte() {
		return manuEnte;
	}

	public void setManuEnte(String manuEnte) {
		this.manuEnte = manuEnte;
	}
	
	@Length(min=0, max=100, message="供货者长度必须介于 0 和 100 之间")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=0, max=100, message="单价长度必须介于 0 和 100 之间")
	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	@Length(min=0, max=100, message="金额长度必须介于 0 和 100 之间")
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	@Length(min=0, max=100, message="生效日期长度必须介于 0 和 100 之间")
	public String getEffeDate() {
		return effeDate;
	}

	public void setEffeDate(String effeDate) {
		this.effeDate = effeDate;
	}
	
	@Length(min=0, max=100, message="有效期至长度必须介于 0 和 100 之间")
	public String getValidPeriTo() {
		return validPeriTo;
	}

	public void setValidPeriTo(String validPeriTo) {
		this.validPeriTo = validPeriTo;
	}
	
}
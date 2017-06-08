/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01complprodcert;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 首营产品关联资质Entity
 * @author XXS
 * @version 2016-12-06
 */
public class T01ComplProdCert extends DataEntity<T01ComplProdCert> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String prodCertId;		// 产品资质ID
	private String complProdId;		// 首营产品ID
	
	public T01ComplProdCert() {
		super();
	}

	public T01ComplProdCert(String id){
		super(id);
	}

	@Length(min=0, max=128, message="流程实例ID长度必须介于 0 和 128 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=128, message="产品资质ID长度必须介于 1 和 128 之间")
	public String getProdCertId() {
		return prodCertId;
	}

	public void setProdCertId(String prodCertId) {
		this.prodCertId = prodCertId;
	}
	
	@Length(min=1, max=128, message="首营产品ID长度必须介于 1 和 128 之间")
	public String getComplProdId() {
		return complProdId;
	}

	public void setComplProdId(String complProdId) {
		this.complProdId = complProdId;
	}
	
}
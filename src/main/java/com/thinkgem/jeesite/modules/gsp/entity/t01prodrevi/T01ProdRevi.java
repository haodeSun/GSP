/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01prodrevi;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 产品审核Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T01ProdRevi extends DataEntity<T01ProdRevi> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String mateNumb;		// 物料号
	private String mateName;		// 物料名称
	private String regiCertNo;		// 注册证编号
	private String prodName;		// 产品名称
	
	public T01ProdRevi() {
		super();
	}

	public T01ProdRevi(String id){
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
	
	@Length(min=0, max=100, message="物料名称长度必须介于 0 和 100 之间")
	public String getMateName() {
		return mateName;
	}

	public void setMateName(String mateName) {
		this.mateName = mateName;
	}
	
	@Length(min=0, max=100, message="注册证编号长度必须介于 0 和 100 之间")
	public String getRegiCertNo() {
		return regiCertNo;
	}

	public void setRegiCertNo(String regiCertNo) {
		this.regiCertNo = regiCertNo;
	}
	
	@Length(min=0, max=100, message="产品名称长度必须介于 0 和 100 之间")
	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	
}
/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01materevi;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 首营审核Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T01MateRevi extends DataEntity<T01MateRevi> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String compNumb;		// 企业编号
	private String compName;		// 企业名称
	private String certNumb;		// 证书编号
	private String certName;		// 证书名称
	private String chanSitu;		// 变更情况
	private String viewQual;		// 查看资质
	
	public T01MateRevi() {
		super();
	}

	public T01MateRevi(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="企业编号长度必须介于 0 和 100 之间")
	public String getCompNumb() {
		return compNumb;
	}

	public void setCompNumb(String compNumb) {
		this.compNumb = compNumb;
	}
	
	@Length(min=0, max=100, message="企业名称长度必须介于 0 和 100 之间")
	public String getCompName() {
		return compName;
	}

	public void setCompName(String compName) {
		this.compName = compName;
	}
	
	@Length(min=0, max=100, message="证书编号长度必须介于 0 和 100 之间")
	public String getCertNumb() {
		return certNumb;
	}

	public void setCertNumb(String certNumb) {
		this.certNumb = certNumb;
	}
	
	@Length(min=0, max=100, message="证书名称长度必须介于 0 和 100 之间")
	public String getCertName() {
		return certName;
	}

	public void setCertName(String certName) {
		this.certName = certName;
	}
	
	@Length(min=0, max=100, message="变更情况长度必须介于 0 和 100 之间")
	public String getChanSitu() {
		return chanSitu;
	}

	public void setChanSitu(String chanSitu) {
		this.chanSitu = chanSitu;
	}
	
	@Length(min=0, max=100, message="查看资质长度必须介于 0 和 100 之间")
	public String getViewQual() {
		return viewQual;
	}

	public void setViewQual(String viewQual) {
		this.viewQual = viewQual;
	}
	
}
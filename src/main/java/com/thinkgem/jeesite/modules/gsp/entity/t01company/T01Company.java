/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01company;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 企业信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T01Company extends DataEntity<T01Company> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String compNumb;		// 编号
	private String compNameCn;		// 企业名称（中文）
	private String compNameEn;		// 企业名称（英文）
	private String abbreviation;		// 简称
	private String description;		// 描述
	private String regiNumb;		// 注册号
	private String apprDate;		// 批准日期
	private String validPeriTo;		// 有效期至
	private String busiScope;		// 经营范围
	private String attachment;		// 附件
	
	public T01Company() {
		super();
	}

	public T01Company(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="编号长度必须介于 0 和 100 之间")
	public String getCompNumb() {
		return compNumb;
	}

	public void setCompNumb(String compNumb) {
		this.compNumb = compNumb;
	}
	
	@Length(min=0, max=100, message="企业名称（中文）长度必须介于 0 和 100 之间")
	public String getCompNameCn() {
		return compNameCn;
	}

	public void setCompNameCn(String compNameCn) {
		this.compNameCn = compNameCn;
	}
	
	@Length(min=0, max=100, message="企业名称（英文）长度必须介于 0 和 100 之间")
	public String getCompNameEn() {
		return compNameEn;
	}

	public void setCompNameEn(String compNameEn) {
		this.compNameEn = compNameEn;
	}
	
	@Length(min=0, max=100, message="简称长度必须介于 0 和 100 之间")
	public String getAbbreviation() {
		return abbreviation;
	}

	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}
	
	@Length(min=0, max=100, message="描述长度必须介于 0 和 100 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=100, message="注册号长度必须介于 0 和 100 之间")
	public String getRegiNumb() {
		return regiNumb;
	}

	public void setRegiNumb(String regiNumb) {
		this.regiNumb = regiNumb;
	}
	
	@Length(min=0, max=100, message="批准日期长度必须介于 0 和 100 之间")
	public String getApprDate() {
		return apprDate;
	}

	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	
	@Length(min=0, max=100, message="有效期至长度必须介于 0 和 100 之间")
	public String getValidPeriTo() {
		return validPeriTo;
	}

	public void setValidPeriTo(String validPeriTo) {
		this.validPeriTo = validPeriTo;
	}
	
	@Length(min=0, max=100, message="经营范围长度必须介于 0 和 100 之间")
	public String getBusiScope() {
		return busiScope;
	}

	public void setBusiScope(String busiScope) {
		this.busiScope = busiScope;
	}
	
	@Length(min=0, max=100, message="附件长度必须介于 0 和 100 之间")
	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	
}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01compinfo;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 销售人员授权Entity
 * @author Andrea
 * @version 2016-12-20
 */
public class SalesCert extends DataEntity<SalesCert> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String compId;		// 企业id
	private String salesName;		// 销售人员姓名
	private String idType;		// 证件类型
	private String idNbr;		// 证件号
	private String salesArea;		// 销售区域
	private String salesScop;		// 授权产品范围
	private String salesCertNbr;		// 授权书编号
	private Date effecDate;		// 生效日期
	private Date validDate;		// 有效期至
	private String apprStat;		// 审批状态
	private String attachment;		// 附件
	
	public SalesCert() {
		super();
	}

	public SalesCert(String id){
		super(id);
	}

	@Length(min=0, max=128, message="流程实例ID长度必须介于 0 和 128 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=128, message="企业id长度必须介于 1 和 128 之间")
	public String getCompId() {
		return compId;
	}

	public void setCompId(String compId) {
		this.compId = compId;
	}
	
	@Length(min=1, max=16, message="销售人员姓名长度必须介于 1 和 16 之间")
	public String getSalesName() {
		return salesName;
	}

	public void setSalesName(String salesName) {
		this.salesName = salesName;
	}
	
	@Length(min=1, max=1, message="证件类型长度必须介于 1 和 1 之间")
	public String getIdType() {
		return idType;
	}

	public void setIdType(String idType) {
		this.idType = idType;
	}
	
	@Length(min=1, max=64, message="证件号长度必须介于 1 和 64 之间")
	public String getIdNbr() {
		return idNbr;
	}

	public void setIdNbr(String idNbr) {
		this.idNbr = idNbr;
	}
	
	@Length(min=1, max=128, message="销售区域长度必须介于 1 和 128 之间")
	public String getSalesArea() {
		return salesArea;
	}

	public void setSalesArea(String salesArea) {
		this.salesArea = salesArea;
	}
	
	@Length(min=0, max=128, message="授权产品范围长度必须介于 0 和 128 之间")
	public String getSalesScop() {
		return salesScop;
	}

	public void setSalesScop(String salesScop) {
		this.salesScop = salesScop;
	}
	
	@Length(min=0, max=64, message="授权书编号长度必须介于 0 和 64 之间")
	public String getSalesCertNbr() {
		return salesCertNbr;
	}

	public void setSalesCertNbr(String salesCertNbr) {
		this.salesCertNbr = salesCertNbr;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="生效日期不能为空")
	public Date getEffecDate() {
		return effecDate;
	}

	public void setEffecDate(Date effecDate) {
		this.effecDate = effecDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="有效期至不能为空")
	public Date getValidDate() {
		return validDate;
	}

	public void setValidDate(Date validDate) {
		this.validDate = validDate;
	}
	
	@Length(min=1, max=16, message="审批状态长度必须介于 1 和 16 之间")
	public String getApprStat() {
		return apprStat;
	}

	public void setApprStat(String apprStat) {
		this.apprStat = apprStat;
	}
	
	@Length(min=0, max=2048, message="附件长度必须介于 0 和 2048 之间")
	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	
}
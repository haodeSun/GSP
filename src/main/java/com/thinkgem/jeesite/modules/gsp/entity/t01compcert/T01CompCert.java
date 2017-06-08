/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01compcert;

import cn.com.dataocean.validator.comparator.Before;
import cn.com.dataocean.validator.constraints.DateConstraint;
import com.thinkgem.jeesite.common.beanvalidator.*;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 企业资质Entity
 * @author XXS
 * @version 2016-12-13
 */
@DateConstraint.List({
		@DateConstraint(field1 = "effeDate", field2 = "validDate", comparator = Before.class, message = "资质的批准日期需早于有效期至的日期", groups = {Submit.class})
})
public class T01CompCert extends DataEntity<T01CompCert> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String compId;		// 企业id
	private String certNbr;		// 资质证号
	private String certType;		// 资质类型
	private String certName;		// 机构名称/销售人员姓名
	private String certScop;		// 生产/经营/销售范围/诊疗科目
	private Date effecDate;		// 生效日期/发证日期
	private Date validDate;		// 有效期至
	private String certStat;		// 资质状态
	private String apprStat;		// 审批状态
	private String attachment;		// 附件
	private Date effecDateBg;		// 生效日期
	private Date effecDateEd;		// 生效日期
	private Date validDateBg;		// 有效期至
	private Date validDateEd;		// 有效期至
	
	public T01CompCert() {
		super();
	}

	public T01CompCert(String id){
		super(id);
	}


	public Date getEffecDateBg() {
		return effecDateBg;
	}

	public void setEffecDateBg(Date effecDateBg) {
		this.effecDateBg = effecDateBg;
	}

	public Date getEffecDateEd() {
		return effecDateEd;
	}

	public void setEffecDateEd(Date effecDateEd) {
		this.effecDateEd = effecDateEd;
	}

	public Date getValidDateBg() {
		return validDateBg;
	}

	public void setValidDateBg(Date validDateBg) {
		this.validDateBg = validDateBg;
	}

	public Date getValidDateEd() {
		return validDateEd;
	}

	public void setValidDateEd(Date validDateEd) {
		this.validDateEd = validDateEd;
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

	@Length.List({
			@Length(max = 250, message = "名称长度必须介于 0 和 250 之间", groups = {CompCert0.class}),
			@Length(min = 1, max = 250, message = "经营许可证号/备案凭证号长度必须介于 1 和 250 之间", groups = {CompCert1.class}),
			@Length(min = 1, max = 250, message = "编号长度必须介于 1 和 250 之间", groups = {CompCert2.class}),
			@Length(min = 1, max = 250, message = "登记号长度必须介于 1 和 250 之间", groups = {CompCert4.class})
	})
	public String getCertNbr() {
		return certNbr;
	}

	public void setCertNbr(String certNbr) {
		this.certNbr = certNbr;
	}
	
	@Length(min=1, max=16, message="资质类型长度必须介于 1 和 16 之间")
	public String getCertType() {
		return certType;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	@Length.List({
			@Length(min = 1, max = 250, message = "名称长度必须介于 1 和 250 之间", groups = {CompCert0.class}),
			@Length(min = 1, max = 250, message = "企业名称长度必须介于 1 和 250 之间", groups = {CompCert1.class}),
			@Length(min = 1, max = 250, message = "企业名称长度必须介于 1 和 250 之间", groups = {CompCert2.class}),
			@Length(min = 1, max = 250, message = "机构名称长度必须介于 1 和 250 之间", groups = {CompCert4.class})
	})
	public String getCertName() {
		return certName;
	}

	public void setCertName(String certName) {
		this.certName = certName;
	}

	@Length.List({
			@Length(min = 1, max = 1000, message = "营业执照经营范围长度必须介于 1 和 1000 之间", groups = {CompCert0.class}),
			@Length(min = 1, max = 1000, message = "经营资质经营范围长度必须介于 1 和 1000 之间", groups = {CompCert1.class}),
			@Length(min = 1, max = 1000, message = "生产范围长度必须介于 1 和 1000 之间", groups = {CompCert2.class}),
			@Length(min = 1, max = 1000, message = "诊疗科目长度必须介于 1 和 1000 之间", groups = {CompCert4.class})
	})
	public String getCertScop() {
		return certScop;
	}

	public void setCertScop(String certScop) {
		this.certScop = certScop;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="生效日期/发证日期不能为空",
			groups = {CompCert0.class,CompCert1.class,CompCert2.class,CompCert4.class})
	public Date getEffecDate() {
		return effecDate;
	}

	public void setEffecDate(Date effecDate) {
		this.effecDate = effecDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="有效期至不能为空",
			groups = {CompCert0.class,CompCert1.class,CompCert2.class,CompCert4.class})
	public Date getValidDate() {
		return validDate;
	}

	public void setValidDate(Date validDate) {
		this.validDate = validDate;
	}
	
	@Length(min=1, max=16, message="资质状态长度必须介于 1 和 16 之间")
	public String getCertStat() {
		return certStat;
	}

	public void setCertStat(String certStat) {
		this.certStat = certStat;
	}
	
	@Length(min=1, max=16, message="审批状态长度必须介于 1 和 16 之间")
	public String getApprStat() {
		return apprStat;
	}

	public void setApprStat(String apprStat) {
		this.apprStat = apprStat;
	}
	
	@Length(min=1, max=2048, message="附件长度必须介于 1 和 2048 之间",
			groups = {CompCert0.class,CompCert1.class,CompCert2.class,CompCert4.class})
	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	
}
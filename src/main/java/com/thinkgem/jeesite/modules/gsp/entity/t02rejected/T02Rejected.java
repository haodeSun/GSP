/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02rejected;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 退回信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02Rejected extends DataEntity<T02Rejected> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String sourNo;		// 来源单号
	private String orgaCode;		// 组织编码
	private String custNo;		// 客户号
	private String saleReprCode;		// 销售代表编码
	private String wareCode;		// 仓库编码
	private String autoNo;		// 自动单号
	private String retuMeth;		// 退货方式
	private String retuReas;		// 退货原因
	private String alf;		// ALF
	private String comm;		// 备注
	private Date billDate;		// 开单日期
	private Date billEffeDate;		// 单据有效日
	private String taxAmou;		// 含税金额
	private String totaBoxCoun;		// 退货总箱数
	private String totaBranCoun;		// 退货总支数
	
	public T02Rejected() {
		super();
	}

	public T02Rejected(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=100, message="来源单号长度必须介于 1 和 100 之间")
	public String getSourNo() {
		return sourNo;
	}

	public void setSourNo(String sourNo) {
		this.sourNo = sourNo;
	}
	
	@Length(min=1, max=100, message="组织编码长度必须介于 1 和 100 之间")
	public String getOrgaCode() {
		return orgaCode;
	}

	public void setOrgaCode(String orgaCode) {
		this.orgaCode = orgaCode;
	}
	
	@Length(min=1, max=100, message="客户号长度必须介于 1 和 100 之间")
	public String getCustNo() {
		return custNo;
	}

	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	
	@Length(min=1, max=100, message="销售代表编码长度必须介于 1 和 100 之间")
	public String getSaleReprCode() {
		return saleReprCode;
	}

	public void setSaleReprCode(String saleReprCode) {
		this.saleReprCode = saleReprCode;
	}
	
	@Length(min=1, max=100, message="仓库编码长度必须介于 1 和 100 之间")
	public String getWareCode() {
		return wareCode;
	}

	public void setWareCode(String wareCode) {
		this.wareCode = wareCode;
	}
	
	@Length(min=0, max=100, message="自动单号长度必须介于 0 和 100 之间")
	public String getAutoNo() {
		return autoNo;
	}

	public void setAutoNo(String autoNo) {
		this.autoNo = autoNo;
	}
	
	@Length(min=0, max=100, message="退货方式长度必须介于 0 和 100 之间")
	public String getRetuMeth() {
		return retuMeth;
	}

	public void setRetuMeth(String retuMeth) {
		this.retuMeth = retuMeth;
	}
	
	@Length(min=1, max=100, message="退货原因长度必须介于 1 和 100 之间")
	public String getRetuReas() {
		return retuReas;
	}

	public void setRetuReas(String retuReas) {
		this.retuReas = retuReas;
	}
	
	@Length(min=0, max=100, message="ALF长度必须介于 0 和 100 之间")
	public String getAlf() {
		return alf;
	}

	public void setAlf(String alf) {
		this.alf = alf;
	}
	
	@Length(min=0, max=100, message="备注长度必须介于 0 和 100 之间")
	public String getComm() {
		return comm;
	}

	public void setComm(String comm) {
		this.comm = comm;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBillDate() {
		return billDate;
	}

	public void setBillDate(Date billDate) {
		this.billDate = billDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBillEffeDate() {
		return billEffeDate;
	}

	public void setBillEffeDate(Date billEffeDate) {
		this.billEffeDate = billEffeDate;
	}
	
	@Length(min=0, max=11, message="含税金额长度必须介于 0 和 11 之间")
	public String getTaxAmou() {
		return taxAmou;
	}

	public void setTaxAmou(String taxAmou) {
		this.taxAmou = taxAmou;
	}
	
	@Length(min=0, max=11, message="退货总箱数长度必须介于 0 和 11 之间")
	public String getTotaBoxCoun() {
		return totaBoxCoun;
	}

	public void setTotaBoxCoun(String totaBoxCoun) {
		this.totaBoxCoun = totaBoxCoun;
	}
	
	@Length(min=0, max=11, message="退货总支数长度必须介于 0 和 11 之间")
	public String getTotaBranCoun() {
		return totaBranCoun;
	}

	public void setTotaBranCoun(String totaBranCoun) {
		this.totaBranCoun = totaBranCoun;
	}
	
}
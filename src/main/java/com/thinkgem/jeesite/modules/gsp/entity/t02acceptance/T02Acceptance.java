/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02acceptance;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 验收信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02Acceptance extends DataEntity<T02Acceptance> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String apprNumb;		// 验收单号
	private String arriDate;		// 到货日期
	private String receNumb;		// 收货单号
	private String veriTemp;		// 运输温度的核实
	private String acceSign;		// 验收人员签字
	private String accePersName;		// 验收人员姓名
	private String signature;		// 签字
	
	public T02Acceptance() {
		super();
	}

	public T02Acceptance(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="验收单号长度必须介于 0 和 100 之间")
	public String getApprNumb() {
		return apprNumb;
	}

	public void setApprNumb(String apprNumb) {
		this.apprNumb = apprNumb;
	}
	
	@Length(min=0, max=100, message="到货日期长度必须介于 0 和 100 之间")
	public String getArriDate() {
		return arriDate;
	}

	public void setArriDate(String arriDate) {
		this.arriDate = arriDate;
	}
	
	@Length(min=0, max=100, message="收货单号长度必须介于 0 和 100 之间")
	public String getReceNumb() {
		return receNumb;
	}

	public void setReceNumb(String receNumb) {
		this.receNumb = receNumb;
	}
	
	@Length(min=0, max=100, message="运输温度的核实长度必须介于 0 和 100 之间")
	public String getVeriTemp() {
		return veriTemp;
	}

	public void setVeriTemp(String veriTemp) {
		this.veriTemp = veriTemp;
	}
	
	@Length(min=0, max=100, message="验收人员签字长度必须介于 0 和 100 之间")
	public String getAcceSign() {
		return acceSign;
	}

	public void setAcceSign(String acceSign) {
		this.acceSign = acceSign;
	}
	
	@Length(min=0, max=100, message="验收人员姓名长度必须介于 0 和 100 之间")
	public String getAccePersName() {
		return accePersName;
	}

	public void setAccePersName(String accePersName) {
		this.accePersName = accePersName;
	}
	
	@Length(min=0, max=100, message="签字长度必须介于 0 和 100 之间")
	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}
	
}
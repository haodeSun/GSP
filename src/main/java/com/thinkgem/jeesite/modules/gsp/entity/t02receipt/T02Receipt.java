/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02receipt;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 收货信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02Receipt extends DataEntity<T02Receipt> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String receNo;		// 收货单号
	private String wayBillNo;		// 运单号
	private String suppCode;		// 供货者编号/代码
	private String receName;		// 名称
	private String purcOrderNo;		// 采购单号
	private String arriDate;		// 到货日期
	private String tranAgree;		// 运输条件是否一致
	private String havePeerList;		// 有无随货同行单
	private String deliMan;		// 送货人
	private String reciMan;		// 接收人
	private String peerListAgree;		// 随货同行单是否一致
	private String toExam;		// 审核
	
	public T02Receipt() {
		super();
	}

	public T02Receipt(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="收货单号长度必须介于 0 和 100 之间")
	public String getReceNo() {
		return receNo;
	}

	public void setReceNo(String receNo) {
		this.receNo = receNo;
	}
	
	@Length(min=0, max=100, message="运单号长度必须介于 0 和 100 之间")
	public String getWayBillNo() {
		return wayBillNo;
	}

	public void setWayBillNo(String wayBillNo) {
		this.wayBillNo = wayBillNo;
	}
	
	@Length(min=0, max=100, message="供货者编号/代码长度必须介于 0 和 100 之间")
	public String getSuppCode() {
		return suppCode;
	}

	public void setSuppCode(String suppCode) {
		this.suppCode = suppCode;
	}
	
	@Length(min=0, max=100, message="名称长度必须介于 0 和 100 之间")
	public String getReceName() {
		return receName;
	}

	public void setReceName(String receName) {
		this.receName = receName;
	}
	
	@Length(min=0, max=100, message="采购单号长度必须介于 0 和 100 之间")
	public String getPurcOrderNo() {
		return purcOrderNo;
	}

	public void setPurcOrderNo(String purcOrderNo) {
		this.purcOrderNo = purcOrderNo;
	}
	
	@Length(min=0, max=100, message="到货日期长度必须介于 0 和 100 之间")
	public String getArriDate() {
		return arriDate;
	}

	public void setArriDate(String arriDate) {
		this.arriDate = arriDate;
	}
	
	@Length(min=0, max=100, message="运输条件是否一致长度必须介于 0 和 100 之间")
	public String getTranAgree() {
		return tranAgree;
	}

	public void setTranAgree(String tranAgree) {
		this.tranAgree = tranAgree;
	}
	
	@Length(min=0, max=100, message="有无随货同行单长度必须介于 0 和 100 之间")
	public String getHavePeerList() {
		return havePeerList;
	}

	public void setHavePeerList(String havePeerList) {
		this.havePeerList = havePeerList;
	}
	
	@Length(min=0, max=100, message="送货人长度必须介于 0 和 100 之间")
	public String getDeliMan() {
		return deliMan;
	}

	public void setDeliMan(String deliMan) {
		this.deliMan = deliMan;
	}
	
	@Length(min=0, max=100, message="接收人长度必须介于 0 和 100 之间")
	public String getReciMan() {
		return reciMan;
	}

	public void setReciMan(String reciMan) {
		this.reciMan = reciMan;
	}
	
	@Length(min=0, max=100, message="随货同行单是否一致长度必须介于 0 和 100 之间")
	public String getPeerListAgree() {
		return peerListAgree;
	}

	public void setPeerListAgree(String peerListAgree) {
		this.peerListAgree = peerListAgree;
	}
	
	@Length(min=0, max=100, message="审核长度必须介于 0 和 100 之间")
	public String getToExam() {
		return toExam;
	}

	public void setToExam(String toExam) {
		this.toExam = toExam;
	}
	
}
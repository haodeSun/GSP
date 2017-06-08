/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02ship;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 发货信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02Ship extends DataEntity<T02Ship> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String invoNo;		// 发货单号
	private String wayBillNo;		// 运单号
	private String suppCode;		// 供货者编号/代码
	private String name;		// 名称
	private String purcOrderNo;		// 采购单号
	private Date arriDate;		// 到货日期
	private String tranAgree;		// 运输条件是是一致
	private String havePeerList;		// 有无随货同行单
	private String deliMan;		// 送货人
	private String peerListAgree;		// 上述随货同行单是是一致
	private String reciMan;		// 接收人
	private String toExam;		// 审核
	
	public T02Ship() {
		super();
	}

	public T02Ship(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=100, message="发货单号长度必须介于 1 和 100 之间")
	public String getInvoNo() {
		return invoNo;
	}

	public void setInvoNo(String invoNo) {
		this.invoNo = invoNo;
	}
	
	@Length(min=1, max=100, message="运单号长度必须介于 1 和 100 之间")
	public String getWayBillNo() {
		return wayBillNo;
	}

	public void setWayBillNo(String wayBillNo) {
		this.wayBillNo = wayBillNo;
	}
	
	@Length(min=1, max=100, message="供货者编号/代码长度必须介于 1 和 100 之间")
	public String getSuppCode() {
		return suppCode;
	}

	public void setSuppCode(String suppCode) {
		this.suppCode = suppCode;
	}
	
	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=1, max=100, message="采购单号长度必须介于 1 和 100 之间")
	public String getPurcOrderNo() {
		return purcOrderNo;
	}

	public void setPurcOrderNo(String purcOrderNo) {
		this.purcOrderNo = purcOrderNo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="到货日期不能为空")
	public Date getArriDate() {
		return arriDate;
	}

	public void setArriDate(Date arriDate) {
		this.arriDate = arriDate;
	}
	
	@Length(min=1, max=100, message="运输条件是是一致长度必须介于 1 和 100 之间")
	public String getTranAgree() {
		return tranAgree;
	}

	public void setTranAgree(String tranAgree) {
		this.tranAgree = tranAgree;
	}
	
	@Length(min=1, max=100, message="有无随货同行单长度必须介于 1 和 100 之间")
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
	
	@Length(min=1, max=100, message="上述随货同行单是是一致长度必须介于 1 和 100 之间")
	public String getPeerListAgree() {
		return peerListAgree;
	}

	public void setPeerListAgree(String peerListAgree) {
		this.peerListAgree = peerListAgree;
	}
	
	@Length(min=0, max=100, message="接收人长度必须介于 0 和 100 之间")
	public String getReciMan() {
		return reciMan;
	}

	public void setReciMan(String reciMan) {
		this.reciMan = reciMan;
	}
	
	@Length(min=1, max=100, message="审核长度必须介于 1 和 100 之间")
	public String getToExam() {
		return toExam;
	}

	public void setToExam(String toExam) {
		this.toExam = toExam;
	}
	
}
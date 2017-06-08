/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02purchase;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 采购Entity
 * @author yohu
 * @version 2016-11-16
 */
public class T02Purchase extends DataEntity<T02Purchase> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String purcNumb;		// 采购编号
	private Date purcDate;		// 采购日期
	private String suggVendCont;		// 联系方式
	private String mateId;		// 物料id
	private String reviewStatus;		// 审核状态
	private String shipViaLookCode;		// 运输方式
	private String documents;		// 单据
	private String comments;		// 备注
	private String totalOrderPrice;		// 订单总价
	private String buyerCode;		// 采购员编码
	private String orderType;		// 订单类型
	private String totalBoxNumb;		// 总箱数
	private String totalNumb;		// 总支数
	private Date billDate;		// 单据日期
	private Date arriDate;		// 到货日期
	private String taxAmou;		// 含税金额
	private String receAmou;		// 收货金额
	private String notification;		// 提示
	private List<T02PurcMate> t02PurcMateList = Lists.newArrayList();		// 子表列表
	
	public T02Purchase() {
		super();
	}

	public T02Purchase(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="采购编号长度必须介于 0 和 100 之间")
	public String getPurcNumb() {
		return purcNumb;
	}

	public void setPurcNumb(String purcNumb) {
		this.purcNumb = purcNumb;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPurcDate() {
		return purcDate;
	}

	public void setPurcDate(Date purcDate) {
		this.purcDate = purcDate;
	}
	
	@Length(min=0, max=100, message="联系方式长度必须介于 0 和 100 之间")
	public String getSuggVendCont() {
		return suggVendCont;
	}

	public void setSuggVendCont(String suggVendCont) {
		this.suggVendCont = suggVendCont;
	}
	
	@Length(min=0, max=100, message="物料id长度必须介于 0 和 100 之间")
	public String getMateId() {
		return mateId;
	}

	public void setMateId(String mateId) {
		this.mateId = mateId;
	}
	
	@Length(min=0, max=1, message="审核状态长度必须介于 0 和 1 之间")
	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}
	
	@Length(min=0, max=100, message="运输方式长度必须介于 0 和 100 之间")
	public String getShipViaLookCode() {
		return shipViaLookCode;
	}

	public void setShipViaLookCode(String shipViaLookCode) {
		this.shipViaLookCode = shipViaLookCode;
	}
	
	@Length(min=0, max=100, message="单据长度必须介于 0 和 100 之间")
	public String getDocuments() {
		return documents;
	}

	public void setDocuments(String documents) {
		this.documents = documents;
	}
	
	@Length(min=0, max=100, message="备注长度必须介于 0 和 100 之间")
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
	public String getTotalOrderPrice() {
		return totalOrderPrice;
	}

	public void setTotalOrderPrice(String totalOrderPrice) {
		this.totalOrderPrice = totalOrderPrice;
	}
	
	@Length(min=0, max=100, message="采购员编码长度必须介于 0 和 100 之间")
	public String getBuyerCode() {
		return buyerCode;
	}

	public void setBuyerCode(String buyerCode) {
		this.buyerCode = buyerCode;
	}
	
	@Length(min=0, max=1, message="订单类型长度必须介于 0 和 1 之间")
	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	@Length(min=0, max=100, message="总箱数长度必须介于 0 和 100 之间")
	public String getTotalBoxNumb() {
		return totalBoxNumb;
	}

	public void setTotalBoxNumb(String totalBoxNumb) {
		this.totalBoxNumb = totalBoxNumb;
	}
	
	@Length(min=0, max=100, message="总支数长度必须介于 0 和 100 之间")
	public String getTotalNumb() {
		return totalNumb;
	}

	public void setTotalNumb(String totalNumb) {
		this.totalNumb = totalNumb;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBillDate() {
		return billDate;
	}

	public void setBillDate(Date billDate) {
		this.billDate = billDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getArriDate() {
		return arriDate;
	}

	public void setArriDate(Date arriDate) {
		this.arriDate = arriDate;
	}
	
	public String getTaxAmou() {
		return taxAmou;
	}

	public void setTaxAmou(String taxAmou) {
		this.taxAmou = taxAmou;
	}
	
	public String getReceAmou() {
		return receAmou;
	}

	public void setReceAmou(String receAmou) {
		this.receAmou = receAmou;
	}
	
	@Length(min=0, max=100, message="提示长度必须介于 0 和 100 之间")
	public String getNotification() {
		return notification;
	}

	public void setNotification(String notification) {
		this.notification = notification;
	}
	
	public List<T02PurcMate> getT02PurcMateList() {
		return t02PurcMateList;
	}

	public void setT02PurcMateList(List<T02PurcMate> t02PurcMateList) {
		this.t02PurcMateList = t02PurcMateList;
	}
}
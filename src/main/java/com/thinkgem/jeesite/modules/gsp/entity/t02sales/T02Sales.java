/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02sales;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 售出信息Entity
 * @author yohu
 * @version 2016-11-17
 */
public class T02Sales extends DataEntity<T02Sales> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String salesNumb;		// 销售编号
	private Date salesDate;		// 销售日期
	private String custCompanyId;		// 购货者id
	private String contMeth;		// 联系方式
	private Date deliDate;		// 发货日期
	private String tranMeth;		// 运输方式
	private String bill;		// 单据
	private String comments;		// 备注
	private String totalOrderPrice;		// 订单总价
	private String department;		// 部门
	private String customer;		// 客户
	private String salesRepr;		// 销售代表
	private String deliWare;		// 发货仓库
	private String settMeth;		// 贸易结算方式
	private String deliAddr;		// 送货地址
	private String autoNumb;		// 自动单号
	private String manuNumb;		// 手工单号
	private String alf;		// ALF
	private String issueAddr;		// 出单地址
	private String prePayAmou;		// 预付款金额
	private String taxAmou;		// 含税金额
	private String totalBoxNumb;		// 总箱数
	private String totalNumb;		// 总支数
	private String shipMeth;		// 付运方式
	private String totalRetaSales;		// 零售额合计
	private List<T02SalesMate> t02SalesMateList = Lists.newArrayList();		// 子表列表
	
	public T02Sales() {
		super();
	}

	public T02Sales(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=100, message="销售编号长度必须介于 1 和 100 之间")
	public String getSalesNumb() {
		return salesNumb;
	}

	public void setSalesNumb(String salesNumb) {
		this.salesNumb = salesNumb;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="销售日期不能为空")
	public Date getSalesDate() {
		return salesDate;
	}

	public void setSalesDate(Date salesDate) {
		this.salesDate = salesDate;
	}
	
	@Length(min=1, max=100, message="购货者id长度必须介于 1 和 100 之间")
	public String getCustCompanyId() {
		return custCompanyId;
	}

	public void setCustCompanyId(String custCompanyId) {
		this.custCompanyId = custCompanyId;
	}
	
	@Length(min=1, max=11, message="联系方式长度必须介于 1 和 11 之间")
	public String getContMeth() {
		return contMeth;
	}

	public void setContMeth(String contMeth) {
		this.contMeth = contMeth;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="发货日期不能为空")
	public Date getDeliDate() {
		return deliDate;
	}

	public void setDeliDate(Date deliDate) {
		this.deliDate = deliDate;
	}
	
	@Length(min=0, max=100, message="运输方式长度必须介于 0 和 100 之间")
	public String getTranMeth() {
		return tranMeth;
	}

	public void setTranMeth(String tranMeth) {
		this.tranMeth = tranMeth;
	}
	
	@Length(min=1, max=100, message="单据长度必须介于 1 和 100 之间")
	public String getBill() {
		return bill;
	}

	public void setBill(String bill) {
		this.bill = bill;
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
	
	@Length(min=1, max=100, message="部门长度必须介于 1 和 100 之间")
	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}
	
	@Length(min=1, max=100, message="客户长度必须介于 1 和 100 之间")
	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}
	
	@Length(min=1, max=100, message="销售代表长度必须介于 1 和 100 之间")
	public String getSalesRepr() {
		return salesRepr;
	}

	public void setSalesRepr(String salesRepr) {
		this.salesRepr = salesRepr;
	}
	
	@Length(min=1, max=100, message="发货仓库长度必须介于 1 和 100 之间")
	public String getDeliWare() {
		return deliWare;
	}

	public void setDeliWare(String deliWare) {
		this.deliWare = deliWare;
	}
	
	@Length(min=0, max=100, message="贸易结算方式长度必须介于 0 和 100 之间")
	public String getSettMeth() {
		return settMeth;
	}

	public void setSettMeth(String settMeth) {
		this.settMeth = settMeth;
	}
	
	@Length(min=0, max=100, message="送货地址长度必须介于 0 和 100 之间")
	public String getDeliAddr() {
		return deliAddr;
	}

	public void setDeliAddr(String deliAddr) {
		this.deliAddr = deliAddr;
	}
	
	@Length(min=0, max=100, message="自动单号长度必须介于 0 和 100 之间")
	public String getAutoNumb() {
		return autoNumb;
	}

	public void setAutoNumb(String autoNumb) {
		this.autoNumb = autoNumb;
	}
	
	@Length(min=0, max=100, message="手工单号长度必须介于 0 和 100 之间")
	public String getManuNumb() {
		return manuNumb;
	}

	public void setManuNumb(String manuNumb) {
		this.manuNumb = manuNumb;
	}
	
	@Length(min=0, max=100, message="ALF长度必须介于 0 和 100 之间")
	public String getAlf() {
		return alf;
	}

	public void setAlf(String alf) {
		this.alf = alf;
	}
	
	@Length(min=0, max=100, message="出单地址长度必须介于 0 和 100 之间")
	public String getIssueAddr() {
		return issueAddr;
	}

	public void setIssueAddr(String issueAddr) {
		this.issueAddr = issueAddr;
	}
	
	public String getPrePayAmou() {
		return prePayAmou;
	}

	public void setPrePayAmou(String prePayAmou) {
		this.prePayAmou = prePayAmou;
	}
	
	public String getTaxAmou() {
		return taxAmou;
	}

	public void setTaxAmou(String taxAmou) {
		this.taxAmou = taxAmou;
	}
	
	@Length(min=0, max=11, message="总箱数长度必须介于 0 和 11 之间")
	public String getTotalBoxNumb() {
		return totalBoxNumb;
	}

	public void setTotalBoxNumb(String totalBoxNumb) {
		this.totalBoxNumb = totalBoxNumb;
	}
	
	@Length(min=0, max=11, message="总支数长度必须介于 0 和 11 之间")
	public String getTotalNumb() {
		return totalNumb;
	}

	public void setTotalNumb(String totalNumb) {
		this.totalNumb = totalNumb;
	}
	
	@Length(min=0, max=100, message="付运方式长度必须介于 0 和 100 之间")
	public String getShipMeth() {
		return shipMeth;
	}

	public void setShipMeth(String shipMeth) {
		this.shipMeth = shipMeth;
	}
	
	public String getTotalRetaSales() {
		return totalRetaSales;
	}

	public void setTotalRetaSales(String totalRetaSales) {
		this.totalRetaSales = totalRetaSales;
	}
	
	public List<T02SalesMate> getT02SalesMateList() {
		return t02SalesMateList;
	}

	public void setT02SalesMateList(List<T02SalesMate> t02SalesMateList) {
		this.t02SalesMateList = t02SalesMateList;
	}
}
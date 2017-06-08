/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02purchase;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 采购Entity
 * @author yohu
 * @version 2016-11-16
 */
public class T02PurcMate extends DataEntity<T02PurcMate> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String mateId;		// 物料id
	private String purcPrice;		// 采购单价
	private T02Purchase purcId;		// 采购信息id 父类
	private String purcCount;		// 采购数量
	private String amount;		// 金额
	private String quota;		// 配额
	private String measUnit;		// 单位
	private String unitCont;		// 单位含量
	private String orderQuan;		// 订货量
	private String purcSurp;		// 采购余量
	private String tranPriceNoTax;		// 不含税成交单价
	private String fee;		// 扣率
	private String noTaxAmou;		// 不含税金额
	private String taxTranPrice;		// 含税成交单价
	private String taxAmou;		// 含税金额
	private String taxRates;		// 税率
	private String tax;		// 税额
	private String refePrice;		// 参考进价（单品）
	private String prodUnit;		// 单品单位
	private String prodPriceNoTax;		// 单品不含税单价
	private String stanBoxCoef;		// 标准箱系数
	private String stanBoxQuan;		// 标准箱数量
	private String comments;		// 备注
	private String outerBoxCont;		// 外箱含量
	
	public T02PurcMate() {
		super();
	}

	public T02PurcMate(String id){
		super(id);
	}

	public T02PurcMate(T02Purchase purcId){
		this.purcId = purcId;
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="物料id长度必须介于 0 和 100 之间")
	public String getMateId() {
		return mateId;
	}

	public void setMateId(String mateId) {
		this.mateId = mateId;
	}
	
	public String getPurcPrice() {
		return purcPrice;
	}

	public void setPurcPrice(String purcPrice) {
		this.purcPrice = purcPrice;
	}
	
	@Length(min=0, max=100, message="采购信息id长度必须介于 0 和 100 之间")
	public T02Purchase getPurcId() {
		return purcId;
	}

	public void setPurcId(T02Purchase purcId) {
		this.purcId = purcId;
	}
	
	@Length(min=0, max=11, message="采购数量长度必须介于 0 和 11 之间")
	public String getPurcCount() {
		return purcCount;
	}

	public void setPurcCount(String purcCount) {
		this.purcCount = purcCount;
	}
	
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	@Length(min=0, max=11, message="配额长度必须介于 0 和 11 之间")
	public String getQuota() {
		return quota;
	}

	public void setQuota(String quota) {
		this.quota = quota;
	}
	
	@Length(min=0, max=100, message="单位长度必须介于 0 和 100 之间")
	public String getMeasUnit() {
		return measUnit;
	}

	public void setMeasUnit(String measUnit) {
		this.measUnit = measUnit;
	}
	
	@Length(min=0, max=100, message="单位含量长度必须介于 0 和 100 之间")
	public String getUnitCont() {
		return unitCont;
	}

	public void setUnitCont(String unitCont) {
		this.unitCont = unitCont;
	}
	
	@Length(min=0, max=11, message="订货量长度必须介于 0 和 11 之间")
	public String getOrderQuan() {
		return orderQuan;
	}

	public void setOrderQuan(String orderQuan) {
		this.orderQuan = orderQuan;
	}
	
	@Length(min=0, max=11, message="采购余量长度必须介于 0 和 11 之间")
	public String getPurcSurp() {
		return purcSurp;
	}

	public void setPurcSurp(String purcSurp) {
		this.purcSurp = purcSurp;
	}
	
	public String getTranPriceNoTax() {
		return tranPriceNoTax;
	}

	public void setTranPriceNoTax(String tranPriceNoTax) {
		this.tranPriceNoTax = tranPriceNoTax;
	}
	
	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}
	
	public String getNoTaxAmou() {
		return noTaxAmou;
	}

	public void setNoTaxAmou(String noTaxAmou) {
		this.noTaxAmou = noTaxAmou;
	}
	
	public String getTaxTranPrice() {
		return taxTranPrice;
	}

	public void setTaxTranPrice(String taxTranPrice) {
		this.taxTranPrice = taxTranPrice;
	}
	
	public String getTaxAmou() {
		return taxAmou;
	}

	public void setTaxAmou(String taxAmou) {
		this.taxAmou = taxAmou;
	}
	
	public String getTaxRates() {
		return taxRates;
	}

	public void setTaxRates(String taxRates) {
		this.taxRates = taxRates;
	}
	
	public String getTax() {
		return tax;
	}

	public void setTax(String tax) {
		this.tax = tax;
	}
	
	public String getRefePrice() {
		return refePrice;
	}

	public void setRefePrice(String refePrice) {
		this.refePrice = refePrice;
	}
	
	@Length(min=0, max=100, message="单品单位长度必须介于 0 和 100 之间")
	public String getProdUnit() {
		return prodUnit;
	}

	public void setProdUnit(String prodUnit) {
		this.prodUnit = prodUnit;
	}
	
	public String getProdPriceNoTax() {
		return prodPriceNoTax;
	}

	public void setProdPriceNoTax(String prodPriceNoTax) {
		this.prodPriceNoTax = prodPriceNoTax;
	}
	
	@Length(min=0, max=100, message="标准箱系数长度必须介于 0 和 100 之间")
	public String getStanBoxCoef() {
		return stanBoxCoef;
	}

	public void setStanBoxCoef(String stanBoxCoef) {
		this.stanBoxCoef = stanBoxCoef;
	}
	
	@Length(min=0, max=11, message="标准箱数量长度必须介于 0 和 11 之间")
	public String getStanBoxQuan() {
		return stanBoxQuan;
	}

	public void setStanBoxQuan(String stanBoxQuan) {
		this.stanBoxQuan = stanBoxQuan;
	}
	
	@Length(min=0, max=100, message="备注长度必须介于 0 和 100 之间")
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
	@Length(min=0, max=11, message="外箱含量长度必须介于 0 和 11 之间")
	public String getOuterBoxCont() {
		return outerBoxCont;
	}

	public void setOuterBoxCont(String outerBoxCont) {
		this.outerBoxCont = outerBoxCont;
	}
	
}
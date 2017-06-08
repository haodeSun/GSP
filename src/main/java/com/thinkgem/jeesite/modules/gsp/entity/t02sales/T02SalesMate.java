/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02sales;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 售出信息Entity
 * @author yohu
 * @version 2016-11-17
 */
public class T02SalesMate extends DataEntity<T02SalesMate> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String mateId;		// 物料号
	private T02Sales salesId;		// 售出单id 父类
	private String salePrice;		// 销售单价
	private String saleCount;		// 销售数量
	private String unit;		// 单位
	private String amount;		// 金额
	private String commCode;		// 商品编码
	private String commBarCode;		// 商品条码
	private String convCode;		// 转换码
	private String outerBoxCont;		// 外箱含量
	private String orderQuan;		// 订单数量
	private String suppCommCode;		// 供应商商品编码
	private String inveCost;		// 库存单品成本
	private String priceDisc;		// 售价扣率
	private String taxAmou;		// 含税金额
	private String noTaxAmou;		// 不含税金额
	private String actiType;		// 活动类型
	private String promSaleNo;		// 促销单号
	private String basePrice;		// 基价
	private String retaAmou;		// 零售金额
	private String stanBoxQuan;		// 标准箱数量
	private String singProdCost;		// 单品成本
	
	public T02SalesMate() {
		super();
	}

	public T02SalesMate(String id){
		super(id);
	}

	public T02SalesMate(T02Sales salesId){
		this.salesId = salesId;
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=100, message="物料号长度必须介于 1 和 100 之间")
	public String getMateId() {
		return mateId;
	}

	public void setMateId(String mateId) {
		this.mateId = mateId;
	}
	
	@Length(min=1, max=100, message="售出单id长度必须介于 1 和 100 之间")
	public T02Sales getSalesId() {
		return salesId;
	}

	public void setSalesId(T02Sales salesId) {
		this.salesId = salesId;
	}
	
	public String getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}
	
	@Length(min=1, max=11, message="销售数量长度必须介于 1 和 11 之间")
	public String getSaleCount() {
		return saleCount;
	}

	public void setSaleCount(String saleCount) {
		this.saleCount = saleCount;
	}
	
	@Length(min=1, max=100, message="单位长度必须介于 1 和 100 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	@Length(min=1, max=100, message="商品编码长度必须介于 1 和 100 之间")
	public String getCommCode() {
		return commCode;
	}

	public void setCommCode(String commCode) {
		this.commCode = commCode;
	}
	
	@Length(min=1, max=100, message="商品条码长度必须介于 1 和 100 之间")
	public String getCommBarCode() {
		return commBarCode;
	}

	public void setCommBarCode(String commBarCode) {
		this.commBarCode = commBarCode;
	}
	
	@Length(min=0, max=100, message="转换码长度必须介于 0 和 100 之间")
	public String getConvCode() {
		return convCode;
	}

	public void setConvCode(String convCode) {
		this.convCode = convCode;
	}
	
	@Length(min=0, max=100, message="外箱含量长度必须介于 0 和 100 之间")
	public String getOuterBoxCont() {
		return outerBoxCont;
	}

	public void setOuterBoxCont(String outerBoxCont) {
		this.outerBoxCont = outerBoxCont;
	}
	
	@Length(min=0, max=11, message="订单数量长度必须介于 0 和 11 之间")
	public String getOrderQuan() {
		return orderQuan;
	}

	public void setOrderQuan(String orderQuan) {
		this.orderQuan = orderQuan;
	}
	
	@Length(min=0, max=100, message="供应商商品编码长度必须介于 0 和 100 之间")
	public String getSuppCommCode() {
		return suppCommCode;
	}

	public void setSuppCommCode(String suppCommCode) {
		this.suppCommCode = suppCommCode;
	}
	
	public String getInveCost() {
		return inveCost;
	}

	public void setInveCost(String inveCost) {
		this.inveCost = inveCost;
	}
	
	public String getPriceDisc() {
		return priceDisc;
	}

	public void setPriceDisc(String priceDisc) {
		this.priceDisc = priceDisc;
	}
	
	public String getTaxAmou() {
		return taxAmou;
	}

	public void setTaxAmou(String taxAmou) {
		this.taxAmou = taxAmou;
	}
	
	public String getNoTaxAmou() {
		return noTaxAmou;
	}

	public void setNoTaxAmou(String noTaxAmou) {
		this.noTaxAmou = noTaxAmou;
	}
	
	@Length(min=0, max=3, message="活动类型长度必须介于 0 和 3 之间")
	public String getActiType() {
		return actiType;
	}

	public void setActiType(String actiType) {
		this.actiType = actiType;
	}
	
	@Length(min=0, max=100, message="促销单号长度必须介于 0 和 100 之间")
	public String getPromSaleNo() {
		return promSaleNo;
	}

	public void setPromSaleNo(String promSaleNo) {
		this.promSaleNo = promSaleNo;
	}
	
	public String getBasePrice() {
		return basePrice;
	}

	public void setBasePrice(String basePrice) {
		this.basePrice = basePrice;
	}
	
	public String getRetaAmou() {
		return retaAmou;
	}

	public void setRetaAmou(String retaAmou) {
		this.retaAmou = retaAmou;
	}
	
	@Length(min=0, max=11, message="标准箱数量长度必须介于 0 和 11 之间")
	public String getStanBoxQuan() {
		return stanBoxQuan;
	}

	public void setStanBoxQuan(String stanBoxQuan) {
		this.stanBoxQuan = stanBoxQuan;
	}
	
	public String getSingProdCost() {
		return singProdCost;
	}

	public void setSingProdCost(String singProdCost) {
		this.singProdCost = singProdCost;
	}
	
}
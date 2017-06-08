/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02stocmate;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 盘点-物料信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02StocMate extends DataEntity<T02StocMate> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String location;		// 库位
	private String mateNumb;		// 物料号
	private String description;		// 描述
	private String prodName;		// 产品名称
	private String modelSpec;		// 规格型号
	private String regiCertNo;		// 注册证号
	private String unit;		// 单位
	private String prodEnteName;		// 生产企业名称
	private String seriNumb;		// 生产批号/序列号
	private String valiPeri;		// 有效期
	private String disaDate;		// 失效日期
	private String storTime;		// 入库时间
	private String stockQuan;		// 库存数量
	private String actuInveQuan;		// 实际盘点数量
	private String commBarCode;		// 商品条码
	private String commName;		// 商品名称
	private String suppCode;		// 供应商编码
	private String prodClas;		// 品类
	private String brand;		// 品牌
	private String convFact;		// 转换因子
	private String outerBoxFact;		// 外箱因子
	private String retaPrice;		// 零售价
	private String whichWhole;		// 其中整件
	private String whichScat;		// 其中零散
	private String whole;		// 实盘整件
	private String scattered;		// 零散
	private String total;		// 总数
	private String variance;		// 差异
	private String currInveCost;		// 当前库存成本
	
	public T02StocMate() {
		super();
	}

	public T02StocMate(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="库位长度必须介于 0 和 100 之间")
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	
	@Length(min=0, max=100, message="物料号长度必须介于 0 和 100 之间")
	public String getMateNumb() {
		return mateNumb;
	}

	public void setMateNumb(String mateNumb) {
		this.mateNumb = mateNumb;
	}
	
	@Length(min=0, max=100, message="描述长度必须介于 0 和 100 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=100, message="产品名称长度必须介于 0 和 100 之间")
	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	
	@Length(min=0, max=100, message="规格型号长度必须介于 0 和 100 之间")
	public String getModelSpec() {
		return modelSpec;
	}

	public void setModelSpec(String modelSpec) {
		this.modelSpec = modelSpec;
	}
	
	@Length(min=0, max=100, message="注册证号长度必须介于 0 和 100 之间")
	public String getRegiCertNo() {
		return regiCertNo;
	}

	public void setRegiCertNo(String regiCertNo) {
		this.regiCertNo = regiCertNo;
	}
	
	@Length(min=0, max=100, message="单位长度必须介于 0 和 100 之间")
	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	
	@Length(min=0, max=100, message="生产企业名称长度必须介于 0 和 100 之间")
	public String getProdEnteName() {
		return prodEnteName;
	}

	public void setProdEnteName(String prodEnteName) {
		this.prodEnteName = prodEnteName;
	}
	
	@Length(min=0, max=100, message="生产批号/序列号长度必须介于 0 和 100 之间")
	public String getSeriNumb() {
		return seriNumb;
	}

	public void setSeriNumb(String seriNumb) {
		this.seriNumb = seriNumb;
	}
	
	@Length(min=0, max=100, message="有效期长度必须介于 0 和 100 之间")
	public String getValiPeri() {
		return valiPeri;
	}

	public void setValiPeri(String valiPeri) {
		this.valiPeri = valiPeri;
	}
	
	@Length(min=0, max=100, message="失效日期长度必须介于 0 和 100 之间")
	public String getDisaDate() {
		return disaDate;
	}

	public void setDisaDate(String disaDate) {
		this.disaDate = disaDate;
	}
	
	@Length(min=0, max=100, message="入库时间长度必须介于 0 和 100 之间")
	public String getStorTime() {
		return storTime;
	}

	public void setStorTime(String storTime) {
		this.storTime = storTime;
	}
	
	@Length(min=0, max=100, message="库存数量长度必须介于 0 和 100 之间")
	public String getStockQuan() {
		return stockQuan;
	}

	public void setStockQuan(String stockQuan) {
		this.stockQuan = stockQuan;
	}
	
	@Length(min=0, max=100, message="实际盘点数量长度必须介于 0 和 100 之间")
	public String getActuInveQuan() {
		return actuInveQuan;
	}

	public void setActuInveQuan(String actuInveQuan) {
		this.actuInveQuan = actuInveQuan;
	}
	
	@Length(min=0, max=100, message="商品条码长度必须介于 0 和 100 之间")
	public String getCommBarCode() {
		return commBarCode;
	}

	public void setCommBarCode(String commBarCode) {
		this.commBarCode = commBarCode;
	}
	
	@Length(min=0, max=100, message="商品名称长度必须介于 0 和 100 之间")
	public String getCommName() {
		return commName;
	}

	public void setCommName(String commName) {
		this.commName = commName;
	}
	
	@Length(min=0, max=100, message="供应商编码长度必须介于 0 和 100 之间")
	public String getSuppCode() {
		return suppCode;
	}

	public void setSuppCode(String suppCode) {
		this.suppCode = suppCode;
	}
	
	@Length(min=0, max=100, message="品类长度必须介于 0 和 100 之间")
	public String getProdClas() {
		return prodClas;
	}

	public void setProdClas(String prodClas) {
		this.prodClas = prodClas;
	}
	
	@Length(min=0, max=100, message="品牌长度必须介于 0 和 100 之间")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}
	
	@Length(min=0, max=100, message="转换因子长度必须介于 0 和 100 之间")
	public String getConvFact() {
		return convFact;
	}

	public void setConvFact(String convFact) {
		this.convFact = convFact;
	}
	
	@Length(min=0, max=100, message="外箱因子长度必须介于 0 和 100 之间")
	public String getOuterBoxFact() {
		return outerBoxFact;
	}

	public void setOuterBoxFact(String outerBoxFact) {
		this.outerBoxFact = outerBoxFact;
	}
	
	@Length(min=0, max=100, message="零售价长度必须介于 0 和 100 之间")
	public String getRetaPrice() {
		return retaPrice;
	}

	public void setRetaPrice(String retaPrice) {
		this.retaPrice = retaPrice;
	}
	
	@Length(min=0, max=100, message="其中整件长度必须介于 0 和 100 之间")
	public String getWhichWhole() {
		return whichWhole;
	}

	public void setWhichWhole(String whichWhole) {
		this.whichWhole = whichWhole;
	}
	
	@Length(min=0, max=100, message="其中零散长度必须介于 0 和 100 之间")
	public String getWhichScat() {
		return whichScat;
	}

	public void setWhichScat(String whichScat) {
		this.whichScat = whichScat;
	}
	
	@Length(min=0, max=100, message="实盘整件长度必须介于 0 和 100 之间")
	public String getWhole() {
		return whole;
	}

	public void setWhole(String whole) {
		this.whole = whole;
	}
	
	@Length(min=0, max=100, message="零散长度必须介于 0 和 100 之间")
	public String getScattered() {
		return scattered;
	}

	public void setScattered(String scattered) {
		this.scattered = scattered;
	}
	
	@Length(min=0, max=100, message="总数长度必须介于 0 和 100 之间")
	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}
	
	@Length(min=0, max=100, message="差异长度必须介于 0 和 100 之间")
	public String getVariance() {
		return variance;
	}

	public void setVariance(String variance) {
		this.variance = variance;
	}
	
	@Length(min=0, max=100, message="当前库存成本长度必须介于 0 和 100 之间")
	public String getCurrInveCost() {
		return currInveCost;
	}

	public void setCurrInveCost(String currInveCost) {
		this.currInveCost = currInveCost;
	}
	
}
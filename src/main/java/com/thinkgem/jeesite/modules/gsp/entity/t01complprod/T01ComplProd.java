/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01complprod;

import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.validation.constraints.Pattern;

/**
 * 首营产品Entity
 * @author XXS
 * @version 2016-12-06
 */
public class T01ComplProd extends ActEntity<T01ComplProd> {
	
	private static final long serialVersionUID = 1L;

	private String complProdCertId;//资质关联表id
	private String matrId;		// 物料id
	private List<String> prodCertIdList;		// 产品资质id

	@ExcelField(title = "注册证/备案凭证编号")
	private String regiCertNbr;		// 注册证/备案凭证编号
	@ExcelField(title = "原注册证/备案凭证编号")
	private String origRegiCertNbr;		// 原注册证/备案凭证编号
	@ExcelField(title = "风险分类",dictType = "t01_riskClass")
	private String riskClass;		// 风险分类
	@ExcelField(title = "技术分类-名称",dictType = "t01_tech_cate_cd")
	private String techCateCd;		// 技术分类-名称
	@ExcelField(title = "生效日期")
	private Date effeDate;		// 生效日期
	@ExcelField(title = "有效期至")
	private Date validPeri;		// 有效期至
	@ExcelField(title = "资质状态",dictType = "t01_certStat")
	private String certStat;		// 资质状态
	@ExcelField(title = "资质类型" ,dictType = "t01_certType")
	private String certType;		// 资质类型
	@ExcelField(title = "物料号")
	private String matrNbr;		// 物料号
	@ExcelField(title = "物料名称（中文）")
	private String matrNmCn;		// 物料名称（中文）
	@ExcelField(title = "物料名称（英文）")
	private String matrNmEn;		// 物料名称（英文）
	@ExcelField(title = "描述")
	private String matrDesc;		// 描述
	@ExcelField(title = "物料分类" ,dictType = "t01_matr_info_matr_type")
	private String matrType;		// 物料分类
	@ExcelField(title = "存储条件_最低温度")
	@Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "存储条件_最低温度必须为数字！")
	private String storTemp;		// 存储条件_温度
	@ExcelField(title = "存储条件_最低湿度")
	@Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "存储条件_最低湿度必须为数字！")
	private String storWet;		// 存储条件_湿度
	@ExcelField(title = "运输条件_最低温度")
	@Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "运输条件_最低温度必须为数字！")
	private String tranTemp;		// 运输条件_温度
	@ExcelField(title = "运输条件_最低湿度")
	@Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "运输条件_最低湿度必须为数字！")
	private String tranWet;		// 运输条件_湿度

    @ExcelField(title = "存储条件_最高温度")
    @Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "存储条件_最高温度必须为数字！")
    private String storTemp2;		// 存储条件_温度
    @ExcelField(title = "存储条件_最高湿度")
    @Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "存储条件_最高湿度必须为数字！")
    private String storWet2;		// 存储条件_湿度
    @ExcelField(title = "运输条件_最高温度")
    @Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "运输条件_最高温度必须为数字！")
    private String tranTemp2;		// 运输条件_温度
    @ExcelField(title = "运输条件_最高湿度")
    @Pattern(regexp="^-?[0-9]+\\.?[0-9]*$",message = "运输条件_最高湿度必须为数字！")
    private String tranWet2;		// 运输条件_湿度

    @ExcelField(title = "物料单位")
	@Length(min=1, max=250, message="物料单位长度必须介于 1 和 250 之间")
	private String martUnit;		// 物料单位
	@ExcelField(title = "货币单位")
	private String priceUnit;		// 货币单位
	@ExcelField(title = "物料单价")
	private String matrPrice;		// 物料单价
	@ExcelField(title = "物料规格")
	@Length(min=1, max=250, message="物料规格长度必须介于 1 和 250 之间")
	private String specType;		// 物料规格
	@ExcelField(title = "产品有效期（月）")
	@Pattern(regexp="^[0-9]+\\.?[0-9]*$",message = "产品有效期（月）必须为数字且为非负数！")
	private String validMonths;		// 产品有效期（月）
	@ExcelField(title = "首营产品状态",sort = 91 ,dictType = "t01ComplProd_complProdStat")
	private String complProdStat;		// 首营产品状态
	@ExcelField(title = "审批状态",sort = 92 ,dictType = "t01_matr_info_appr_stat")
	private String apprStat;		// 审批状态
	private String freezeFlag;		// 冻结标志
	private String procInsId;		// 流程实例id
	private String beginStorTemp;		// 开始 存储条件_温度
	private String endStorTemp;		// 结束 存储条件_温度
	private String beginStorWet;		// 开始 存储条件_湿度
	private String endStorWet;		// 结束 存储条件_湿度
	private String beginTranTemp;		// 开始 运输条件_温度
	private String endTranTemp;		// 结束 运输条件_温度
	private String beginTranWet;		// 开始 运输条件_湿度
	private String endTranWet;		// 结束 运输条件_湿度
	
	public T01ComplProd() {
		super();
	}

	public T01ComplProd(String id){
		super(id);
	}

	@ExcelField(title = "备注",sort = 90)
	@Length(min = 0, max = 1000, message = "备注长度必须小于1000 ")
	public String getRemarks() {
		return remarks;
	}

	@ExcelField(title = "更新时间",sort = 100)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdateDate() {
		return updateDate;
	}

	public String getRegiCertNbr() {
		return regiCertNbr;
	}

	public void setRegiCertNbr(String regiCertNbr) {
		this.regiCertNbr = regiCertNbr;
	}

	public String getOrigRegiCertNbr() {
		return origRegiCertNbr;
	}

	public void setOrigRegiCertNbr(String origRegiCertNbr) {
		this.origRegiCertNbr = origRegiCertNbr;
	}


	public String getRiskClass() {
		return riskClass;
	}

	public void setRiskClass(String riskClass) {
		this.riskClass = riskClass;
	}

	public String getTechCateCd() {
		return techCateCd;
	}

	public void setTechCateCd(String techCateCd) {
		this.techCateCd = techCateCd;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEffeDate() {
		return effeDate;
	}

	public void setEffeDate(Date effeDate) {
		this.effeDate = effeDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getValidPeri() {
		return validPeri;
	}

	public void setValidPeri(Date validPeri) {
		this.validPeri = validPeri;
	}

	public String getCertStat() {
		return certStat;
	}

	public void setCertStat(String certStat) {
		this.certStat = certStat;
	}

	public String getCertType() {
		return certType;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	public String getMatrNbr() {
		return matrNbr;
	}

	public void setMatrNbr(String matrNbr) {
		this.matrNbr = matrNbr;
	}

	public String getMatrNmCn() {
		return matrNmCn;
	}

	public void setMatrNmCn(String matrNmCn) {
		this.matrNmCn = matrNmCn;
	}

	public String getMatrNmEn() {
		return matrNmEn;
	}

	public void setMatrNmEn(String matrNmEn) {
		this.matrNmEn = matrNmEn;
	}

	public String getMatrDesc() {
		return matrDesc;
	}

	public void setMatrDesc(String matrDesc) {
		this.matrDesc = matrDesc;
	}

	public String getMatrType() {
		return matrType;
	}

	public void setMatrType(String matrType) {
		this.matrType = matrType;
	}
	
	public String getStorTemp() {
		return storTemp;
	}

	public void setStorTemp(String storTemp) {
		this.storTemp = storTemp;
	}
	
	public String getStorWet() {
		return storWet;
	}

	public void setStorWet(String storWet) {
		this.storWet = storWet;
	}
	
	public String getTranTemp() {
		return tranTemp;
	}

	public void setTranTemp(String tranTemp) {
		this.tranTemp = tranTemp;
	}
	
	public String getTranWet() {
		return tranWet;
	}

	public void setTranWet(String tranWet) {
		this.tranWet = tranWet;
	}

	public String getMartUnit() {
		return martUnit;
	}

	public void setMartUnit(String martUnit) {
		this.martUnit = martUnit;
	}

	public String getPriceUnit() {
		return priceUnit;
	}

	public void setPriceUnit(String priceUnit) {
		this.priceUnit = priceUnit;
	}

	public String getMatrPrice() {
		return matrPrice;
	}

	public void setMatrPrice(String matrPrice) {
		this.matrPrice = matrPrice;
	}

	public String getSpecType() {
		return specType;
	}

	public void setSpecType(String specType) {
		this.specType = specType;
	}

	public String getValidMonths() {
		return validMonths;
	}

	public void setValidMonths(String validMonths) {
		this.validMonths = validMonths;
	}

	public String getComplProdStat() {
		return complProdStat;
	}

	public void setComplProdStat(String complProdStat) {
		this.complProdStat = complProdStat;
	}

	public String getApprStat() {
		return apprStat;
	}

	public void setApprStat(String apprStat) {
		this.apprStat = apprStat;
	}

	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}

	public String getBeginStorTemp() {
		return beginStorTemp;
	}

	public void setBeginStorTemp(String beginStorTemp) {
		this.beginStorTemp = beginStorTemp;
	}
	
	public String getEndStorTemp() {
		return endStorTemp;
	}

	public void setEndStorTemp(String endStorTemp) {
		this.endStorTemp = endStorTemp;
	}
		
	public String getBeginStorWet() {
		return beginStorWet;
	}

	public void setBeginStorWet(String beginStorWet) {
		this.beginStorWet = beginStorWet;
	}
	
	public String getEndStorWet() {
		return endStorWet;
	}

	public void setEndStorWet(String endStorWet) {
		this.endStorWet = endStorWet;
	}
		
	public String getBeginTranTemp() {
		return beginTranTemp;
	}

	public void setBeginTranTemp(String beginTranTemp) {
		this.beginTranTemp = beginTranTemp;
	}
	
	public String getEndTranTemp() {
		return endTranTemp;
	}

	public void setEndTranTemp(String endTranTemp) {
		this.endTranTemp = endTranTemp;
	}
		
	public String getBeginTranWet() {
		return beginTranWet;
	}

	public void setBeginTranWet(String beginTranWet) {
		this.beginTranWet = beginTranWet;
	}

	public String getEndTranWet() {
		return endTranWet;
	}

	public void setEndTranWet(String endTranWet) {
		this.endTranWet = endTranWet;
	}

	public String getMatrId() {
		return matrId;
	}

	public void setMatrId(String matrId) {
		this.matrId = matrId;
	}

	public List<String> getProdCertIdList() {
		return prodCertIdList;
	}

	public void setProdCertIdList(List<String> prodCertIdList) {
		this.prodCertIdList = prodCertIdList;
	}

	public String getComplProdCertId() {
		return complProdCertId;
	}

	public void setComplProdCertId(String complProdCertId) {
		this.complProdCertId = complProdCertId;
	}

	public String getFreezeFlag() {
		return freezeFlag;
	}

	public void setFreezeFlag(String freezeFlag) {
		this.freezeFlag = freezeFlag;
	}
    public String getStorTemp2() {
        return storTemp2;
    }

    public void setStorTemp2(String storTemp2) {
        this.storTemp2 = storTemp2;
    }

    public String getStorWet2() {
        return storWet2;
    }

    public void setStorWet2(String storWet2) {
        this.storWet2 = storWet2;
    }

    public String getTranTemp2() {
        return tranTemp2;
    }

    public void setTranTemp2(String tranTemp2) {
        this.tranTemp2 = tranTemp2;
    }

    public String getTranWet2() {
        return tranWet2;
    }

    public void setTranWet2(String tranWet2) {
        this.tranWet2 = tranWet2;
    }
}
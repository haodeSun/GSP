/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.beanvalidator.ComplBuyer;
import com.thinkgem.jeesite.common.beanvalidator.ComplSupl;
import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.SalesCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.List;

/**
 * 企业信息Entity
 * 
 * @author XXS
 * @version 2016-12-13
 */
public class T01CompInfoNew extends DataEntity<T01CompInfoNew> {

  private static final long serialVersionUID = 1L;
  private String procInsId; // 流程实例ID
  private String compType; // 企业类型
  private String uniCretNbr; // 统一社会信用代码
  private String regiNbr; // 注册证号
  private String orgCertNbr; // 组织机构代码证号
  private String taxNbr; // 税务登记证号
  private String busiMode; // 经营方式
  private String busiLoca; // 经营场所
  private String storLoca; // 库房地址
  private String compNameCn; // 企业名称（中文）
  private String compNameEn; // 企业名称（英文）
  private String shortName; // 简称
  private String compDesc; // 描述
  private String regiLoca; // 注册地址
  private String annuCheckStat; // 年检状态
  private String legalPers; // 法人姓名
  private String prodAbliEval; // 生产能力评价
  private String qualMgrEval; // 质量管理评价
  private String storAbliEval; // 仓储能力评价
  private String deliAbliEval; // 交付能力评价
  private String afteSaleAbliEval; // 售后服务能力评价
  private String phonetic; // 拼音
  private String code; // 邮编
  private String areaCode; // 区号
  private String telephone; // 电话
  private String fax; // 传真
  private String telegraph; // 电报
  private String contPers; // 联系人
  private String contPersTel; // 联系人电话
  private String email; // 邮箱
  private String apprStat;		// 审批状态
  private String buyerId;		//购货者id
  private String suplId;		//供货者id
  private String buyerIsChanged;		//购货者IsChanged 0：未被变更 1：被变更
  private String suplIsChanged;		//供货者IsChanged 0：未被变更 1：被变更
  private String compUniNbr;		// 企业唯一编码
  private String abroad;		// 0国内 1 国外
  private T01CompCert t01CompCert0 = new T01CompCert();   //企业资质对象0：企业资质（国内）
  private T01CompCert t01CompCert3 = new T01CompCert();   //企业资质对象3：企业资质（国外）
  private T01CompCert t01CompCert1 = new T01CompCert();   //企业资质对象1：经营资质
  private T01CompCert t01CompCert2 = new T01CompCert();   //企业资质对象2：生产资质
  private List<T01SalesCert> t01SalesCertList=new ArrayList<>();//销售人员授权书列表
  /**
   * 变更状态
   * 0：未处于变更流程中
   * 1：处于供货者变更流程中
   * 2：处于购货者变更流程中
   */
  private String changeStat;


  private List<SalesCert> salesCerts = Lists.newArrayList(); // 子表销售人员授权列表

  @Length(min=0, max=1000)
  @Override
  public String getRemarks() {
    return super.getRemarks();
  }

  public T01CompCert getT01CompCert1() {
    return t01CompCert1;
  }

  public void setT01CompCert1(T01CompCert t01CompCert1) {
    this.t01CompCert1 = t01CompCert1;
  }

  public T01CompCert getT01CompCert2() {
    return t01CompCert2;
  }

  public void setT01CompCert2(T01CompCert t01CompCert2) {
    this.t01CompCert2 = t01CompCert2;
  }

  public List<T01SalesCert> getT01SalesCertList() {
    return t01SalesCertList;
  }

  public void setT01SalesCertList(List<T01SalesCert> t01SalesCertList) {
    this.t01SalesCertList = t01SalesCertList;
  }

  public String getBuyerIsChanged() {
    return buyerIsChanged;
  }

  public void setBuyerIsChanged(String buyerIsChanged) {
    this.buyerIsChanged = buyerIsChanged;
  }

  public String getSuplIsChanged() {
    return suplIsChanged;
  }

  public void setSuplIsChanged(String suplIsChanged) {
    this.suplIsChanged = suplIsChanged;
  }

  public String getBuyerId() {
    return buyerId;
  }

  public void setBuyerId(String buyerId) {
    this.buyerId = buyerId;
  }

  public String getSuplId() {
    return suplId;
  }

  public void setSuplId(String suplId) {
    this.suplId = suplId;
  }

  public String getAbroad() {
        return abroad;
    }

    public void setAbroad(String abroad) {
        this.abroad = abroad;
    }

    public String getCompUniNbr() {
    return compUniNbr;
  }

  public void setCompUniNbr(String compUniNbr) {
    this.compUniNbr = compUniNbr;
  }

  public T01CompCert getT01CompCert0() {
    return t01CompCert0;
  }

  public void setT01CompCert0(T01CompCert t01CompCert0) {
    this.t01CompCert0 = t01CompCert0;
  }

  public T01CompCert getT01CompCert3() {
    return t01CompCert3;
  }

  public void setT01CompCert3(T01CompCert t01CompCert3) {
    this.t01CompCert3 = t01CompCert3;
  }

  public T01CompInfoNew() {
    super();
  }

  public T01CompInfoNew(String id) {
    super(id);
  }

  @Length(min = 0, max = 128, message = "流程实例ID长度必须介于 0 和 128 之间")
  public String getProcInsId() {
    return procInsId;
  }

  public void setProcInsId(String procInsId) {
    this.procInsId = procInsId;
  }

  @Length(min = 0, max = 16, message = "企业类型长度必须介于 0 和 16 之间")
  public String getCompType() {
    return compType;
  }

  public void setCompType(String compType) {
    this.compType = compType;
  }

  @Length(min = 0, max = 250, message = "注册证号长度必须介于 0 和 250 之间")
  public String getRegiNbr() {
    return regiNbr;
  }

  public void setRegiNbr(String regiNbr) {
    this.regiNbr = regiNbr;
  }

  @Length(min = 0, max = 250, message = "组织机构代码证号长度必须介于 0 和 250 之间")
  public String getOrgCertNbr() {
    return orgCertNbr;
  }

  public void setOrgCertNbr(String orgCertNbr) {
    this.orgCertNbr = orgCertNbr;
  }

  @Length(min = 0, max = 250, message = "税务登记证号长度必须介于 0 和 250 之间")
  public String getTaxNbr() {
    return taxNbr;
  }

  public void setTaxNbr(String taxNbr) {
    this.taxNbr = taxNbr;
  }

  @Length(min = 0, max = 16, message = "经营方式长度必须介于 0 和 16 之间")
  public String getBusiMode() {
    return busiMode;
  }

  public void setBusiMode(String busiMode) {
    this.busiMode = busiMode;
  }

  @Length(min = 0, max = 250, message = "经营场所长度必须介于 0 和 250 之间")
  public String getBusiLoca() {
    return busiLoca;
  }

  public void setBusiLoca(String busiLoca) {
    this.busiLoca = busiLoca;
  }

  @Length(min = 0, max = 250, message = "库房地址长度必须介于 0 和 250 之间")
  public String getStorLoca() {
    return storLoca;
  }

  public void setStorLoca(String storLoca) {
    this.storLoca = storLoca;
  }

  @Length.List({@Length(min = 1, max = 250, message = "供货者名称（中文）长度必须介于 1 和 250 之间", groups = {ComplSupl.class}),
      @Length(min = 1, max = 250, message = "购货者名称（中文）长度必须介于 1 和 250 之间", groups = {ComplBuyer.class})})
  public String getCompNameCn() {
    return compNameCn;
  }

  public void setCompNameCn(String compNameCn) {
    this.compNameCn = compNameCn;
  }

  @Length.List({@Length(max = 250, message = "供货者名称（英文）长度必须介于 0 和 250 之间", groups = {ComplSupl.class}),
          @Length(max = 250, message = "购货者名称（英文）长度必须介于 0 和 250 之间", groups = {ComplBuyer.class})})
  public String getCompNameEn() {
    return compNameEn;
  }

  public void setCompNameEn(String compNameEn) {
    this.compNameEn = compNameEn;
  }

  @Length(min = 0, max = 250, message = "简称长度必须介于 0 和 250 之间")
  public String getShortName() {
    return shortName;
  }

  public void setShortName(String shortName) {
    this.shortName = shortName;
  }

  @Length(min = 0, max = 1000, message = "描述长度必须介于 0 和 1000 之间")
  public String getCompDesc() {
    return compDesc;
  }

  public void setCompDesc(String compDesc) {
    this.compDesc = compDesc;
  }

  @Length.List({@Length(min = 0, max = 250, message = "注册地址长度必须小于250 ", groups = {Save.class}),
      @Length(min = 1, max = 250, message = "注册地址长度必须介于 1 和 250 之间", groups = {Submit.class})})
  public String getRegiLoca() {
    return regiLoca;
  }

  public void setRegiLoca(String regiLoca) {
    this.regiLoca = regiLoca;
  }

  @Length.List({@Length(min = 0, max = 250, message = "年检状态长度必须小于250 ", groups = {Save.class}),
      @Length(min = 1, max = 250, message = "年检状态长度必须介于 1 和 250 之间", groups = {Submit.class})})
  public String getAnnuCheckStat() {
    return annuCheckStat;
  }

  public List<SalesCert> getSalesCerts() {
    return salesCerts;
  }

  public void setSalesCerts(List<SalesCert> salesCerts) {
    this.salesCerts = salesCerts;
  }

  public void setAnnuCheckStat(String annuCheckStat) {
    this.annuCheckStat = annuCheckStat;
  }

  @Length.List({@Length(min = 0, max = 250, message = "法人姓名长度必须小于250 ", groups = {Save.class}),
      @Length(min = 1, max = 250, message = "法人姓名长度必须介于 1 和 250 之间", groups = {Submit.class})})
  public String getLegalPers() {
    return legalPers;
  }

  public void setLegalPers(String legalPers) {
    this.legalPers = legalPers;
  }

  @Length(min = 0, max = 1000, message = "生产能力评价长度必须介于 0 和 1000 之间")
  public String getProdAbliEval() {
    return prodAbliEval;
  }

  public void setProdAbliEval(String prodAbliEval) {
    this.prodAbliEval = prodAbliEval;
  }

  @Length(min = 0, max = 1000, message = "质量管理评价长度必须介于 0 和 1000 之间")
  public String getQualMgrEval() {
    return qualMgrEval;
  }

  public void setQualMgrEval(String qualMgrEval) {
    this.qualMgrEval = qualMgrEval;
  }

  @Length(min = 0, max = 1000, message = "仓储能力评价长度必须介于 0 和 1000 之间")
  public String getStorAbliEval() {
    return storAbliEval;
  }

  public void setStorAbliEval(String storAbliEval) {
    this.storAbliEval = storAbliEval;
  }

  @Length(min = 0, max = 1000, message = "交付能力评价长度必须介于 0 和 1000 之间")
  public String getDeliAbliEval() {
    return deliAbliEval;
  }

  public void setDeliAbliEval(String deliAbliEval) {
    this.deliAbliEval = deliAbliEval;
  }

  @Length(min = 0, max = 1000, message = "售后服务能力评价长度必须介于 0 和 1000 之间")
  public String getAfteSaleAbliEval() {
    return afteSaleAbliEval;
  }

  public void setAfteSaleAbliEval(String afteSaleAbliEval) {
    this.afteSaleAbliEval = afteSaleAbliEval;
  }

  @Length(min = 0, max = 250, message = "拼音长度必须介于 0 和 250 之间")
  public String getPhonetic() {
    return phonetic;
  }

  public void setPhonetic(String phonetic) {
    this.phonetic = phonetic;
  }

  @Length(min = 0, max = 250, message = "邮编长度必须介于 0 和 250 之间")
  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  @Length(min = 0, max = 250, message = "区号长度必须介于 0 和 250 之间")
  public String getAreaCode() {
    return areaCode;
  }

  public void setAreaCode(String areaCode) {
    this.areaCode = areaCode;
  }

  @Length(min = 0, max = 250, message = "电话长度必须介于 0 和 250 之间")
  public String getTelephone() {
    return telephone;
  }

  public void setTelephone(String telephone) {
    this.telephone = telephone;
  }

  @Length(min = 0, max = 250, message = "传真长度必须介于 0 和 250 之间")
  public String getFax() {
    return fax;
  }

  public void setFax(String fax) {
    this.fax = fax;
  }

  @Length(min = 0, max = 250, message = "电报长度必须介于 0 和 250 之间")
  public String getTelegraph() {
    return telegraph;
  }

  public void setTelegraph(String telegraph) {
    this.telegraph = telegraph;
  }

  @Length(min = 0, max = 250, message = "联系人长度必须介于 0 和 250 之间")
  public String getContPers() {
    return contPers;
  }

  public void setContPers(String contPers) {
    this.contPers = contPers;
  }

  @Length(min = 0, max = 250, message = "联系人电话长度必须介于 0 和 250 之间")
  public String getContPersTel() {
    return contPersTel;
  }

  public void setContPersTel(String contPersTel) {
    this.contPersTel = contPersTel;
  }

  @Length(min = 0, max = 250, message = "邮箱长度必须介于 0 和 250 之间")
  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  @Length.List({@Length(min = 0, max = 250, message = "统一社会信用代码长度必须小于250 ", groups = {Save.class}),
      @Length(min = 1, max = 250, message = "统一社会信用代码长度必须介于 1 和 250 之间", groups = {Submit.class})})
  public String getUniCretNbr() {
    return uniCretNbr;
  }

  public void setUniCretNbr(String uniCretNbr) {
    this.uniCretNbr = uniCretNbr;
  }


  public String getApprStat() {
    return apprStat;
  }

  public void setApprStat(String apprStat) {
    this.apprStat = apprStat;
  }

  public String getChangeStat() {
    return changeStat;
  }

  public void setChangeStat(String changeStat) {
    this.changeStat = changeStat;
  }
}

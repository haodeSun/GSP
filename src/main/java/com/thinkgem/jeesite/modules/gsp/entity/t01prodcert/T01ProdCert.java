/*
                                                                                 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
                                                                                 */
package com.thinkgem.jeesite.modules.gsp.entity.t01prodcert;

import cn.com.dataocean.validator.comparator.Before;
import cn.com.dataocean.validator.comparator.NotBeforeThan;
import cn.com.dataocean.validator.constraints.DateConstraint;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Optional;


/**
 * 产品资质Entity
 *
 * @author gyq
 * @version 2016-11-28
 */
@SuppressWarnings({"unused", "DefaultAnnotationParam"})
@DateConstraint.List({
        @DateConstraint(field1 = "effeDate", field2 = "apprDate", comparator = NotBeforeThan.class, message = "资质的生效日期需晚于或等于批准日期;", groups = {Submit.class}),
        @DateConstraint(field1 = "effeDate", field2 = "validPeri", comparator = Before.class, message = "资质的生效日期需早于有效期至的日期;", groups = {Submit.class}),
        @DateConstraint(field1 = "apprDate", field2 = "validPeri", comparator = Before.class, message = "资质的批准日期需早于有效期至的日期;", groups = {Submit.class})
})
@ExcelField.List({
        @ExcelField(title = "备注", field = "remarks", align = 2, sort = 160),
        @ExcelField(title = "更新时间", field = "updateDate", align = 2, sort = 31),
})
public class T01ProdCert extends ActEntity<T01ProdCert> {

    private static final long serialVersionUID = 1L;
    private String procInsId;        // 流程实例ID
    @ExcelField(title = "注册证/备案凭证编号", align = 2, sort = 1)
    private String regiCertNbr;        // 注册证/备案凭证编号
    @ExcelField(title = "原注册证/备案凭证编号", align = 2, sort = 5)
    private String origRegiCertNbr;        // 原注册证/备案凭证编号
    @ExcelField(title = "风险分类", align = 2, sort = 10)
    private String riskClass;        // 风险分类
    @ExcelField(title = "技术分类-名称", align = 2, sort = 15, dictType = "t01_tech_cate_cd")
    private String techCateCd;        // 技术分类代码
    @ExcelField(title = "批准日期", align = 2, sort = 20)
    private Date apprDate;        // 批准日期
    @ExcelField(title = "生效日期", align = 2, sort = 25)
    private Date effeDate;        // 生效日期
    @ExcelField(title = "有效期至", align = 2, sort = 30)
    private Date validPeri;        // 有效期至
    @ExcelField(title = "产品名称（中文）", align = 2, sort = 35)
    private String prodNameCn;        // 产品名称（中文）
    @ExcelField(title = "产品名称（英文）", align = 2, sort = 40)
    private String prodNameEn;        // 产品名称（英文）
    private String isImport;        // 国内/进口
    @ExcelField(title = "型号规格", align = 2, sort = 45)
    private String modelSpec;        // 型号规格
    @ExcelField(title = "结构及组成", align = 2, sort = 50)
    private String struComp;        // 结构及组成
    @ExcelField(title = "主要组成成分", align = 2, sort = 55)
    private String mainMnt;        // 主要组成成分
    @ExcelField(title = "预期用途", align = 2, sort = 60)
    private String expeUsage;        // 预期用途
    @ExcelField(title = "适用范围", align = 2, sort = 65)
    private String useScope;        // 适用范围
    @ExcelField(title = "产品有效期（月）", align = 2, sort = 70)
    private String effiDate;        // 产品有效期（月）
    private String prodStat;        // 产品标准
    @ExcelField(title = "储存条件", align = 2, sort = 75)
    private String storCond;        // 储存条件
    @ExcelField(title = "运输条件", align = 2, sort = 80)
    private String tranCond;        // 运输条件
    @ExcelField(title = "注册人/备案人名称(原文)", align = 2, sort = 85)
    private String regiPersName;        // 注册人/备案人名称(原文)
    @ExcelField(title = "注册人/备案人名称(翻译)", align = 2, sort = 90)
    private String regiPersNameTran;        // 注册人/备案人名称(翻译)
    @ExcelField(title = "注册人/备案人住所", align = 2, sort = 95)
    private String regiPersAddr;        // 注册人/备案人住所
    @ExcelField(title = "注册人/备案人联系方式", align = 2, sort = 100)
    private String regiPersCont;        // 注册人/备案人联系方式
    @ExcelField(title = "生产地址", align = 2, sort = 105)
    private String produAddr;        // 生产地址
    @ExcelField(title = "生产国或地区（中文）", align = 2, sort = 110)
    private String produAreaCn;        // 生产国或地区（中文）
    @ExcelField(title = "生产国或地区（英文）", align = 2, sort = 120)
    private String produAreaEn;        // 生产国或地区（英文）
    @ExcelField(title = "生产厂商名称（中文）", align = 2, sort = 115)
    private String produFactCn;        // 生产厂商名称（中文）
    private String apprOrg;        // 审批部门
    @ExcelField(title = "代理人名称", align = 2, sort = 125)
    private String agentName;        // 代理人名称
    @ExcelField(title = "代理人住所", align = 2, sort = 130)
    private String agentAddr;        // 代理人住所
    @ExcelField(title = "代理人联系方式", align = 2, sort = 135)
    private String agentCont;        // 代理人联系方式
    @ExcelField(title = "售后服务单位", align = 2, sort = 140)
    private String saledServOrg;        // 售后服务机构（进口）
    private String prodTechRequ;        // 产品技术要求
    private String prodSpec;        // 产品说明书
    private String others;        // 其它内容
    @ExcelField(title = "资质类型", align = 2, sort = 155, dictType = "t01_certType")
    private String certType;        // 资质类型
    @ExcelField(title = "资质状态", align = 2, sort = 150, dictType = "t01_certStat")
    private String certStat;        // 资质状态
    @ExcelField(title = "审批状态", align = 2, sort = 145, dictType = "t01_apprStat")
    private String apprStat;        // 审批状态
    private String apprOpin;        // 审批意见
    @ExcelField(title = "说明", align = 2, sort = 165)
    private String explanation;        // 说明
    private String attachment;        // 附件
    private String regiCertNbrs;        // 注册证号变更历史
    private String isappr;        // isappr
    private List<SysAlarm> sysAlarmList = Lists.newArrayList();        // 子表列表
    private List<SysChanInfo> sysChanInfoList = Lists.newArrayList();        // 子表列表

    public T01ProdCert() {
        super();
    }

    public T01ProdCert(String id) {
        super(id);
    }

    public String fetchPreviousVersionId(){
        if(regiCertNbr==null){
            return null;
        }
        String[] ids = regiCertNbr.split(",");
        if(ids.length >= 2) {
            Optional<String> opt = Arrays.stream(ids)
                    .skip(ids.length - 2)
                    .findFirst();
            return opt.orElse(null);
        }
        return null;
    }

    public void addSysChanInfo(SysChanInfo change){
        sysChanInfoList.add(change);
    }

    public String getProcInsId() {
        return procInsId;
    }

    public void setProcInsId(String procInsId) {
        this.procInsId = procInsId;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "注册证/备案凭证编号长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "注册证/备案凭证编号长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getRegiCertNbr() {
        return regiCertNbr;
    }

    public void setRegiCertNbr(String regiCertNbr) {
        this.regiCertNbr = regiCertNbr;
    }

    @Length(min = 0, max = 250, message = "原注册证/备案凭证编号长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getOrigRegiCertNbr() {
        return origRegiCertNbr;
    }

    public void setOrigRegiCertNbr(String origRegiCertNbr) {
        this.origRegiCertNbr = origRegiCertNbr;
    }

    @Length.List({
            @Length(min = 0, max = 128, message = "风险分类长度必须介于 0 和 128 之间", groups = {Save.class}),
            @Length(min = 1, max = 128, message = "风险分类长度必须介于 1 和 128 之间", groups = {Submit.class})
    })
    public String getRiskClass() {
        return riskClass;
    }

    public void setRiskClass(String riskClass) {
        this.riskClass = riskClass;
    }

    @Length.List({
            @Length(min = 0, max = 128, message = "技术分类代码长度必须介于 0 和 128 之间", groups = {Save.class}),
            @Length(min = 1, max = 128, message = "技术分类代码长度必须介于 1 和 128 之间", groups = {Submit.class})
    })
    public String getTechCateCd() {
        return techCateCd;
    }

    public void setTechCateCd(String techCateCd) {
        this.techCateCd = techCateCd;
    }

    @NotNull(groups = {Submit.class}, message="批准日期不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getApprDate() {
        return apprDate;
    }

    public void setApprDate(Date apprDate) {
        this.apprDate = apprDate;
    }

    @NotNull(groups = {Submit.class}, message="生效日期不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getEffeDate() {
        return effeDate;
    }

    public void setEffeDate(Date effeDate) {
        this.effeDate = effeDate;
    }

    @NotNull(groups = {Submit.class}, message="有效期至不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getValidPeri() {
        return validPeri;
    }

    public void setValidPeri(Date validPeri) {
        this.validPeri = validPeri;
    }

    @Length(min = 1, max = 250, message = "产品名称（中文）长度必须介于 1 和 250 之间", groups = {Save.class,Submit.class})
    public String getProdNameCn() {
        return prodNameCn;
    }

    public void setProdNameCn(String prodNameCn) {
        this.prodNameCn = prodNameCn;
    }

    @Length(min = 0, max = 250, message = "产品名称（英文）长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getProdNameEn() {
        return prodNameEn;
    }

    public void setProdNameEn(String prodNameEn) {
        this.prodNameEn = prodNameEn;
    }

    public String getIsImport() {
        return isImport;
    }

    public void setIsImport(String isImport) {
        this.isImport = isImport;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "型号规格长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "型号规格长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getModelSpec() {
        return modelSpec;
    }

    public void setModelSpec(String modelSpec) {
        this.modelSpec = modelSpec;
    }

    @Length.List({
            @Length(min = 0, max = 1000, message = "结构及组成长度必须介于 0 和 1000 之间", groups = {Save.class}),
            @Length(min = 1, max = 1000, message = "结构及组成长度必须介于 1 和 1000 之间", groups = {Submit.class})
    })
    public String getStruComp() {
        return struComp;
    }

    public void setStruComp(String struComp) {
        this.struComp = struComp;
    }

    @Length(min = 0, max = 1000, message = "主要组成成分长度必须介于 0 和 1000 之间", groups = {Save.class,Submit.class})
    public String getMainMnt() {
        return mainMnt;
    }

    public void setMainMnt(String mainMnt) {
        this.mainMnt = mainMnt;
    }

    @Length(min = 0, max = 1000, message = "预期用途长度必须介于 0 和 1000 之间", groups = {Save.class,Submit.class})
    public String getExpeUsage() {
        return expeUsage;
    }

    public void setExpeUsage(String expeUsage) {
        this.expeUsage = expeUsage;
    }

    @Length(min = 0, max = 1000, message = "适用范围长度必须介于 0 和 1000 之间", groups = {Save.class,Submit.class})
    public String getUseScope() {
        return useScope;
    }

    public void setUseScope(String useScope) {
        this.useScope = useScope;
    }

    @Pattern(regexp="^[0-9]+\\.?[0-9]*$", groups = {Save.class,Submit.class},message = "产品有效期（月）必须为数字！")
    public String getEffiDate() {
        return effiDate;
    }

    public void setEffiDate(String effiDate) {
        this.effiDate = effiDate;
    }

    public String getProdStat() {
        return prodStat;
    }

    public void setProdStat(String prodStat) {
        this.prodStat = prodStat;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "储存条件长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "储存条件长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getStorCond() {
        return storCond;
    }

    public void setStorCond(String storCond) {
        this.storCond = storCond;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "运输条件长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "运输条件长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getTranCond() {
        return tranCond;
    }

    public void setTranCond(String tranCond) {
        this.tranCond = tranCond;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "注册人/备案人名称(原文)长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "注册人/备案人名称(原文)长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getRegiPersName() {
        return regiPersName;
    }

    public void setRegiPersName(String regiPersName) {
        this.regiPersName = regiPersName;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "注册人/备案人名称(翻译)长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "注册人/备案人名称(翻译)长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getRegiPersNameTran() {
        return regiPersNameTran;
    }

    public void setRegiPersNameTran(String regiPersNameTran) {
        this.regiPersNameTran = regiPersNameTran;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "注册人/备案人住所长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "注册人/备案人住所长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getRegiPersAddr() {
        return regiPersAddr;
    }

    public void setRegiPersAddr(String regiPersAddr) {
        this.regiPersAddr = regiPersAddr;
    }

    @Length(min = 0, max = 250, message = "注册人/备案人联系方式长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getRegiPersCont() {
        return regiPersCont;
    }

    public void setRegiPersCont(String regiPersCont) {
        this.regiPersCont = regiPersCont;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "生产地址长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "生产地址长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getProduAddr() {
        return produAddr;
    }

    public void setProduAddr(String produAddr) {
        this.produAddr = produAddr;
    }

    @Length(min = 0, max = 250, message = "生产国或地区（中文）长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getProduAreaCn() {
        return produAreaCn;
    }

    public void setProduAreaCn(String produAreaCn) {
        this.produAreaCn = produAreaCn;
    }

    @Length(min = 0, max = 250, message = "生产国或地区（英文）长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getProduAreaEn() {
        return produAreaEn;
    }

    public void setProduAreaEn(String produAreaEn) {
        this.produAreaEn = produAreaEn;
    }

    @Length(min = 0, max = 250, message = "生产厂商名称（中文）长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getProduFactCn() {
        return produFactCn;
    }

    public void setProduFactCn(String produFactCn) {
        this.produFactCn = produFactCn;
    }

    public String getApprOrg() {
        return apprOrg;
    }

    public void setApprOrg(String apprOrg) {
        this.apprOrg = apprOrg;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "代理人名称长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "代理人名称长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getAgentName() {
        return agentName;
    }

    public void setAgentName(String agentName) {
        this.agentName = agentName;
    }

    @Length.List({
            @Length(min = 0, max = 250, message = "代理人住所长度必须介于 0 和 250 之间", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "代理人住所长度必须介于 1 和 250 之间", groups = {Submit.class})
    })
    public String getAgentAddr() {
        return agentAddr;
    }

    public void setAgentAddr(String agentAddr) {
        this.agentAddr = agentAddr;
    }

    @Length(min = 0, max = 250, message = "代理人联系方式长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getAgentCont() {
        return agentCont;
    }

    public void setAgentCont(String agentCont) {
        this.agentCont = agentCont;
    }

    @Length(min = 0, max = 250, message = "售后服务单位 长度必须介于 0 和 250 之间", groups = {Save.class,Submit.class})
    public String getSaledServOrg() {
        return saledServOrg;
    }

    public void setSaledServOrg(String saledServOrg) {
        this.saledServOrg = saledServOrg;
    }

    public String getProdTechRequ() {
        return prodTechRequ;
    }

    public void setProdTechRequ(String prodTechRequ) {
        this.prodTechRequ = prodTechRequ;
    }

    public String getProdSpec() {
        return prodSpec;
    }

    public void setProdSpec(String prodSpec) {
        this.prodSpec = prodSpec;
    }

    public String getOthers() {
        return others;
    }

    public void setOthers(String others) {
        this.others = others;
    }

    @Length.List({
            @Length(min = 0, max = 128, message = "资质类型长度必须介于 0 和 128 之间", groups = {Save.class}),
            @Length(min = 1, max = 128, message = "资质类型长度必须介于 1 和 128 之间", groups = {Submit.class})
    })
    public String getCertType() {
        return certType;
    }

    public void setCertType(String certType) {
        this.certType = certType;
    }

    @Length(min = 0, max = 16, message = "资质状态长度必须介于 0 和 16 之间")
    public String getCertStat() {
        return certStat;
    }

    public void setCertStat(String certStat) {
        this.certStat = certStat;
    }

    @Length(min = 0, max = 16, message = "审批状态长度必须介于 0 和 16 之间")
    public String getApprStat() {
        return apprStat;
    }

    public void setApprStat(String apprStat) {
        this.apprStat = apprStat;
    }

    public String getApprOpin() {
        return apprOpin;
    }

    public void setApprOpin(String apprOpin) {
        this.apprOpin = apprOpin;
    }

    @Length(min = 0, max = 1000, message = "说明长度必须介于 0 和 1000 之间", groups = {Save.class,Submit.class})
    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    @NotEmpty(message = "附件不能为空", groups={Save.class,Submit.class})
    @Length( max = 2048, message = "附件长度必须介于 0 和 2048 之间",groups={Save.class,Submit.class})
    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    @Length(max = 2048, message = "注册证号变更历史长度必须介于 0 和 2048 之间")
    public String getRegiCertNbrs() {
        return regiCertNbrs;
    }

    public void setRegiCertNbrs(String regiCertNbrs) {
        this.regiCertNbrs = regiCertNbrs;
    }

    public String getIsappr() {
        return isappr;
    }

    public void setIsappr(String isappr) {
        this.isappr = isappr;
    }

    public List<SysAlarm> getSysAlarmList() {
        return sysAlarmList;
    }

    public void setSysAlarmList(List<SysAlarm> sysAlarmList) {
        this.sysAlarmList = sysAlarmList;
    }

    public List<SysChanInfo> getSysChanInfoList() {
        return sysChanInfoList;
    }

    public void setSysChanInfoList(List<SysChanInfo> sysChanInfoList) {
        this.sysChanInfoList = sysChanInfoList;
    }

    /**
     * 得到资质的层级
     */
    public int getLevel(){
        return getParents().size();
    }

    /**
     * 得到当前资质的变更历史
     */
    public List<String> getParents(){
        return UserUtils.stringToList(this.getRegiCertNbrs(),",");
    }
}

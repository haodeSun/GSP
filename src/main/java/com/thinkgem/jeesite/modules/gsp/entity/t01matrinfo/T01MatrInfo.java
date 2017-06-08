/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo;

import java.util.Date;
import java.util.List;

import cn.com.dataocean.validator.constraints.DictType;
import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Pattern;
import java.util.Date;

/**
 * 物料信息Entity
 *
 * @author xuxiaoshuo
 * @version 2016-11-23
 */
public class T01MatrInfo extends ActEntity<T01MatrInfo> {

    private static final long serialVersionUID = 1L;

    private String freeze; // 0 解冻 1 冻结
    private String matrNbr; // 物料号
    private String matrNmCn; // 物料名称（中文）
    private String matrNmEn; // 物料名称（英文）
    private String matrDesc; // 描述
    private String matrType; // 物料分类
    private String priceUnit; // 货币单位
    private String matrPrice; // 物料单价
    private String martStat; // 物料状态
    private String procInsId; // 流程实例ID
    private String apprStat; // 审批状态
    private String apprOpin; // 审批意见
    private List<String> prodCertIdList; // 产品资质id

    public T01MatrInfo() {
        super();
    }

    public T01MatrInfo(String id) {
        super(id);
    }

    public String getFreeze() {
        return freeze;
    }

    public void setFreeze(String freeze) {
        this.freeze = freeze;
    }

    @ExcelField(title = "备注", sort = 8, groups = {0, 1})
    @Length(min = 0, max = 1000, message = "备注长度必须小于1000 ", groups = {Save.class, Submit.class})
    public String getRemarks() {
        return remarks;
    }

    @ExcelField(title = "更新时间", sort = 12, groups = {0})
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date getUpdateDate() {
        return updateDate;
    }

    @ExcelField(title = "物料号", sort = 1, groups = {0, 1})
    @Length.List({
            @Length(min = 0, max = 250, message = "物料号长度必须小于250 ", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "物料号长度必须介于 1 和 250 之间", groups = {
                    Submit.class})})
    public String getMatrNbr() {
        return matrNbr;
    }

    public void setMatrNbr(String matrNbr) {
        this.matrNbr = matrNbr;
    }

    @ExcelField(title = "物料名称（中文）", sort = 2, groups = {0, 1})
    @Length.List({
            @Length(min = 0, max = 250, message = "物料名称（中文）长度必须小于250 ", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "物料名称（中文）长度必须介于 1 和 250 之间", groups = {
                    Submit.class})})
    public String getMatrNmCn() {
        return matrNmCn;
    }

    public void setMatrNmCn(String matrNmCn) {
        this.matrNmCn = matrNmCn;
    }

    @ExcelField(title = "物料名称（英文）", sort = 3, groups = {0, 1})
    @Length(min = 0, max = 250, message = "物料名称（英文）长度必须小于250 ", groups = {Save.class, Submit.class})
    public String getMatrNmEn() {
        return matrNmEn;
    }

    public void setMatrNmEn(String matrNmEn) {
        this.matrNmEn = matrNmEn;
    }

    @ExcelField(title = "描述", sort = 4, groups = {0, 1})
    @Length(min = 0, max = 1000, message = "描述长度必须小于1000", groups = {Save.class, Submit.class})
    public String getMatrDesc() {
        return matrDesc;
    }

    public void setMatrDesc(String matrDesc) {
        this.matrDesc = matrDesc;
    }

    @DictType.List({@DictType(dictType = "t01_matr_info_matr_type", groups = {Save.class}),
            @DictType(dictType = "t01_matr_info_matr_type", canBlank = false, message = "物料分类输入值必须属于对应字典类型的值", groups = {Submit.class})
    })
    @ExcelField(title = "物料分类", sort = 5, dictType = "t01_matr_info_matr_type", groups = {0, 1})
    @Length.List({@Length(min = 0, max = 10, message = "物料分类格式必须正确 ", groups = {Save.class}),
            @Length(min = 1, max = 10, message = "物料分类必填", groups = {Submit.class})})
    public String getMatrType() {
        return matrType;
    }

    public void setMatrType(String matrType) {
        this.matrType = matrType;
    }

    @ExcelField(title = "货币单位", sort = 6, groups = {0, 1})
    @Length.List({@Length(min = 0, max = 250, message = "货币单位长度必须小于250 ", groups = {Save.class}),
            @Length(min = 1, max = 250, message = "货币单位长度必须介于 1 和 250 之间", groups = {Submit.class})})
    public String getPriceUnit() {
        return priceUnit;
    }

    public void setPriceUnit(String priceUnit) {
        this.priceUnit = priceUnit;
    }

    @Pattern(regexp="^[0-9]+\\.?[0-9]*$", groups = {Save.class,Submit.class},message = "物料单价必须为数字！")
    @ExcelField(title = "物料单价", sort = 7, groups = {0, 1})
    public String getMatrPrice() {
        return matrPrice;
    }

    public void setMatrPrice(String matrPrice) {
        this.matrPrice = matrPrice;
    }

    @ExcelField(title = "物料状态", sort = 9, dictType = "t01_matr_info_mart_stat", groups = {0})
    public String getMartStat() {
        return martStat;
    }

    public void setMartStat(String martStat) {
        this.martStat = martStat;
    }

    public String getProcInsId() {
        return procInsId;
    }

    public void setProcInsId(String procInsId) {
        this.procInsId = procInsId;
    }

    @ExcelField(title = "审批状态", sort = 10, dictType = "t01_matr_info_appr_stat", groups = {0})
    public String getApprStat() {
        return apprStat;
    }

    public void setApprStat(String apprStat) {
        this.apprStat = apprStat;
    }

    @Length(min = 0, max = 255, message = "审批意见长度必须介于 0 和 255 之间")
    public String getApprOpin() {
        return apprOpin;
    }

    public void setApprOpin(String apprOpin) {
        this.apprOpin = apprOpin;
    }

    public List<String> getProdCertIdList() {
        return prodCertIdList;
    }

    public void setProdCertIdList(List<String> prodCertIdList) {
        this.prodCertIdList = prodCertIdList;
    }
}
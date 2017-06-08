/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01operatehist;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonGetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;

import java.util.Date;
import java.util.List;

/**
 * 操作历史Entity
 *
 * @author xuxiaoshuo
 * @version 2017-03-22
 */
public class T01OperateHist extends DataEntity<T01OperateHist> {

    private static final long serialVersionUID = 1L;
    /**
     * 所在模块
     */
    private String module;
    /**
     * 数据id
     */
    private String dataId;
    /**
     * 操作内容
     * 提交审批/审批通过/审批不通过/冻结/解冻
     */
    private String operateType;
    /**
     * 操作说明
     * 审批通过、审批不通时的意见，及冻结、解冻时的说明
     */
    private String description;

    private String classify;//操作列表 0 审批 1 冻结

    @JsonIgnore(value = false)
    @Override
    public User getUpdateBy() {
        return updateBy;
    }

    @Override
    public void setUpdateBy(User updateBy) {
        this.updateBy = updateBy;
    }

    public String getClassify() {
        return classify;
    }

    public void setClassify(String classify) {
        this.classify = classify;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getDataId() {
        return dataId;
    }

    public void setDataId(String dataId) {
        this.dataId = dataId;
    }

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
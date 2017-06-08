/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer;


import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.beanvalidator.Save;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.List;
/**
 * 首营购货者Entity
 *
 * @author XXS
 * @version 2016-12-13
 */
@SuppressWarnings("unused")
@Accessors(chain = true)
public class T01ComplBuyer extends ActEntity<T01ComplBuyer> {

    private static final long serialVersionUID = 1L;
    @Getter @Setter
    private String freeze; // 0 解冻 1 冻结

    protected List<Menu> certScopList;//经营范围数据列表

    private boolean needCheck = false;//是否验证 默认 false

    @Getter
    @Length(max = 128, message = "流程实例ID长度必须介于 0 和 128 之间")
    private String procInsId;        // 流程实例ID
    @Getter @Setter
    @Length(min = 1, max = 128, message = "企业id长度必须介于 1 和 128 之间")
    private String compId;           // 企业id
    @Getter @Setter
    @Length(min = 1, max = 16, message = "购货者状态长度必须介于 1 和 16 之间")
    private String buyerStat;        // 购货者状态
    @Getter @Setter
    @Length(min = 1, max = 16, message = "审批状态长度必须介于 1 和 16 之间")
    private String apprStat;         // 审批状态
    @Getter @Setter
    @Length(max=2048, message="附件长度必须介于 0 和 2048 之间")
    private String attachment;       // 附件

    @Length(min = 0, max = 250, message = "备注长度必须介于 0 和 250 之间")
    private String remarks;	// 备注
    @Getter @Setter
    private String isChanged;        // 是否被变更标志
    @Length(min = 1, max = 250, message = "资质类型不能为空",groups = Save.class)
    @Getter @Setter
    private String certType; // 资质类型

    @Setter
    private T01CompInfo t01CompInfo = new T01CompInfo();    //企业信息对象

    @Setter
    private T01CompCert t01CompCert0 = new T01CompCert();   //企业资质对象0：营业执照


    private T01CompCert t01CompCert3 = new T01CompCert();   //企业资质对象3：境外

    @Setter
    private T01CompCert t01CompCert1 = new T01CompCert();   //企业资质对象1：经营资质

    @Setter
    private T01CompCert t01CompCert4 = new T01CompCert();   //企业资质对象4：医疗机构执业许可

    @Setter @Getter
    private List<SysChangeInfo> sysChanInfoList = Lists.newArrayList();        // 子表列表

    public T01ComplBuyer() {
        super();
    }

    public T01ComplBuyer(String id) {
        super(id);
    }


    public T01CompCert getT01CompCert3() {
        return t01CompCert3;
    }

    public void setT01CompCert3(T01CompCert t01CompCert3) {
        this.t01CompCert3 = t01CompCert3;
    }

    public T01CompInfo getT01CompInfo() {
        if (t01CompInfo == null) {
            t01CompInfo = new T01CompInfo();
        }
        return t01CompInfo;
    }

    public T01CompCert getT01CompCert0() {
        if (t01CompCert0 == null) {
            t01CompCert0 = new T01CompCert();
        }
        return t01CompCert0;
    }

    public T01CompCert getT01CompCert1() {
        if (t01CompCert1 == null) {
            t01CompCert1 = new T01CompCert();
        }
        return t01CompCert1;
    }

    public T01CompCert getT01CompCert4() {
        if (t01CompCert4 == null) {
            t01CompCert4 = new T01CompCert();
        }
        return t01CompCert4;
    }

    public void setProcInsId(String procInsId) {
        this.procInsId = procInsId;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public boolean isNeedCheck() {
        return needCheck;
    }

    public void setNeedCheck(boolean needCheck) {
        this.needCheck = needCheck;
    }

    public List<Menu> getCertScopList() {
        if (certScopList == null) {
            certScopList = new ArrayList<>();
        }
        return certScopList;
    }

    public void setCertScopList(List<Menu> certScopList) {
        this.certScopList = certScopList;
    }
}

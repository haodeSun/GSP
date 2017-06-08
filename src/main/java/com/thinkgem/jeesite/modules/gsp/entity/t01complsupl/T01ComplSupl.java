/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01complsupl;

import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;

/**
 * 首营供货者Entity
 *
 * @author Andrea
 * @version 2016-12-20
 */
@SuppressWarnings("unused")
@Accessors(chain = true)
public class T01ComplSupl extends ActEntity<T01ComplSupl> {

	private static final long serialVersionUID = 1L;

	protected List<Menu> certScopList;//经营范围数据列表

	private boolean needCheck = false;//是否验证 默认 false

	@Getter
	@Length(max=128, message="流程实例ID长度必须介于 0 和 128 之间")
	private String procInsId;		// 流程实例ID
    @Getter @Setter
    @Length(min = 1, max = 128, message = "企业id长度必须介于 1 和 128 之间")
    private String compId; // 企业id

    @Getter @Setter
	private T01CompInfo comp;		    // 企业id
	@Getter @Setter
	@Length(min=1, max=16, message="审批状态长度必须介于 1 和 16 之间")
	private String apprStat;		// 审批状态
	@Getter @Setter
	@Length(min=1, max=16, message="供货者状态长度必须介于 1 和 16 之间")
	private String suplStat;		// 供货者状态
	@Getter @Setter
	@Length(max=2048, message="附件长度必须介于 0 和 2048 之间")
	private String attachment;		// 附件

	@Length(min = 0, max = 250, message = "备注长度必须介于 0 和 250 之间")
	private String remarks;	// 备注
    @Getter @Setter
    private String isChanged; // 是否被变更标志
	@Length(min = 1, max = 250, message = "资质类型不能为空")
	@Getter @Setter
	private String certType; // 资质类型

	protected T01CompInfo t01CompInfo;// 企业信息对象


    protected T01CompCert t01CompCert0;// 企业资质对象0：营业执照


	private T01CompCert t01CompCert3 = new T01CompCert();   //企业资质对象3：境外


    protected T01CompCert t01CompCert1;// 企业资质对象1：经营资质


    protected T01CompCert t01CompCert2;// 企业资质对象2：生产资质

	@Getter @Setter
	private String t01SalesCertIDs="";//销售人员授权书IDs字符串[变更时使用]

	@Getter @Setter
	protected List<T01SalesCert> t01SalesCertList=new ArrayList<>();//销售人员授权书列表

	@Getter @Setter
	protected List<String> t01SalesCertIDList=new ArrayList<>();//销售人员授权书ID列表
    @Getter @Setter
    private List<SysChangeInfoForT01ComplSupl> sysChanInfoList = Lists.newArrayList(); // 子表列表

    public T01ComplSupl() {
		super();
	}

	public T01ComplSupl(String id){
		super(id);
	}

	public T01CompCert getT01CompCert3() {
		return t01CompCert3;
	}

	public void setT01CompCert3(T01CompCert t01CompCert3) {
		this.t01CompCert3 = t01CompCert3;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}

	public T01CompInfo getT01CompInfo() {
		if (t01CompInfo == null) {
			t01CompInfo = new T01CompInfo();
		}
		return t01CompInfo;

	}

	public void setT01CompInfo(T01CompInfo t01CompInfo) {
		this.t01CompInfo = t01CompInfo;
	}

	public T01CompCert getT01CompCert0() {
		if (t01CompCert0 == null) {
			t01CompCert0 = new T01CompCert();
		}
		return t01CompCert0;
	}

	public void setT01CompCert0(T01CompCert t01CompCert0) {
		this.t01CompCert0 = t01CompCert0;
	}

	public T01CompCert getT01CompCert1() {
		if (t01CompCert1 == null) {
			t01CompCert1 = new T01CompCert();
		}
		return t01CompCert1;
	}

	public void setT01CompCert1(T01CompCert t01CompCert1) {
		this.t01CompCert1 = t01CompCert1;
	}

	public T01CompCert getT01CompCert2() {
		if (t01CompCert2 == null) {
			t01CompCert2 = new T01CompCert();
		}
		return t01CompCert2;
	}

	public void setT01CompCert2(T01CompCert t01CompCert2) {
		this.t01CompCert2 = t01CompCert2;
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

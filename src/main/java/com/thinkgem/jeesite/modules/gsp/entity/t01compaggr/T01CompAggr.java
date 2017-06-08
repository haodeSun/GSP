/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01compaggr;

import cn.com.dataocean.validator.comparator.Before;
import cn.com.dataocean.validator.constraints.DateConstraint;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.StatusEnum.EffectiveStatus;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.persistence.ActEntity;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 企业相关协议信息Entity
 * @author XXS
 * @version 2016-12-13
 */
@SuppressWarnings("unused")
@DateConstraint.List({
		@DateConstraint(field1 = "effecDate", field2 = "validDate", comparator = Before.class, message = "协议的生效日期需早于有效期至的日期", groups = {Submit.class}),
})
@Accessors(chain=true)
public class T01CompAggr extends ActEntity<T01CompAggr> {
	
	private static final long serialVersionUID = 1L;

	protected List<Menu> certScopList;//经营范围数据列表
	@Getter @Setter
	private String freeze; // 0 解冻 1 冻结
	@Getter @Setter
	private T01ComplSupl supplier = new T01ComplSupl();		    // 供货者

	@Getter @Setter
	private T01ComplBuyer buyer = new T01ComplBuyer();		    // 购货者

	@Getter @Setter @NotNull
	@Length(min=1, max=250, message="协议编号长度必须介于 1 和 250 之间")
    private String agreementNo;                                 // 协议编号

    @Getter @Setter
	private T01CompAggr parentAgreement;	                    // 上级协议

    @Getter @Setter
    private List<T01AggrMatr> t01AggrMatrList = new ArrayList<>(); //关联物料列表

	@Getter @Setter
	List<T01CompAggrRelateMatrInfo> t01CompAggrRelateMatrInfoList = new ArrayList<>();//关联物料展示列表

    @Getter @Setter
	private List<T01SalesCert> sales = new ArrayList<>();       // 销售人员

    @Getter @Setter @NotNull(message = "需要设置授权人")
	@Length(min=1, max=250, message="授权人长度必须介于 1 和 250 之间")
	private String author;		               					// 授权人

	@Getter @Setter
	private String authorName;		               					// 授权人名称

    @Getter @Setter @NotNull(message = "需要设置地址信息")
	@Length(min=1, max=250, message="地址信息长度必须介于 1 和 250 之间")
	private String location;		           					// 地址信息

    @Getter @Setter @NotNull(message = "需要设置协议类别")
	@Length(min=1, max=16, message="协议类别长度必须介于 1 和 16 之间")
	private String aggrType;		           					// 协议类别

	@Getter @Setter
	@Length(max=1000, message="经营范围长度必须介于 0 和 1000 之间")
	private String aggrScop;		           					// 经营范围

	@Getter @Setter
	@Length(max=1000, message="生成范围长度必须介于 0 和 1000 之间")
	private String prodScop;		           					// 生产范围

    @Getter @Setter
	@Length(max=250, message="生产企业长度必须介于 0 和 250 之间")
	private String prodComp;		           					// 生产企业

    @Getter @Setter
	@Length(max=250, message="协议金额长度必须介于 0 和 250 之间")
	private String aggrAmnt;		           					// 协议金额

	@Getter @Setter
	@Length(min=1, max=16, message="协议状态长度必须介于 1 和 16 之间")
	private String aggrStat;		           					// 协议状态

	@Setter @Getter
	@Length(min=1, max=16, message="审核状态长度必须介于 1 和 16 之间")
	private String apprStat;		           					// 审核状态

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="生效日期不能为空")
	@Getter @Setter
	private Date effecDate;		               					// 生效日期

	@Getter @Setter
	private Date effecDateBg;		               					// 生效日期开始

	@Getter @Setter
	private Date effecDateEd;		               					// 生效日期结束

	@Getter @Setter
	private Date validDateBg;		               					// 有效期至开始

	@Getter @Setter
	private Date validDateEd;		               					// 有效期至结束


	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="有效期至不能为空")
    @Getter @Setter
	private Date validDate;		               					// 有效期至

	@Length(max=2048, message="附件长度必须介于 0 和 2048 之间")
	@Getter @Setter
	private String attachment;		           					// 附件

	@Length(max=1000, message="协议说明长度必须介于 0 和 1000 之间")
	@Getter @Setter
	private String explain;   //协议说明
	public T01CompAggr() {
		super();
	}

	public T01CompAggr(String id){
		super(id);
	}

	public T01CompAggr setAggrStatus(EffectiveStatus status) {
	    aggrStat = status.toString();
		return this;
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
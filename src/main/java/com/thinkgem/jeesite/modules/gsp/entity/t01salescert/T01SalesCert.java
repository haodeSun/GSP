/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01salescert;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 管理销售人员授权Entity
 * @author greg.song
 * @version 2016-12-21
 */
@SuppressWarnings("unused")
@Accessors(chain = true)
public class T01SalesCert extends DataEntity<T01SalesCert> {

	private static final long serialVersionUID = 1L;

	@Length(min=0, max=128, message="流程实例ID长度必须介于 0 和 128 之间")
    @Getter @Setter
	private String procInsId;		// 流程实例ID

	@JsonBackReference
	@NotNull(message="企业不能为空")
    @Getter @Setter
	private T01CompInfo comp;		// 企业
    @Getter @Setter
	@Length(min=1, max=250, message="销售人员姓名长度必须介于 1 和 250 之间")
	private String salesName;		// 销售人员姓名
	@Getter @Setter
	@Length(min=1, max=1, message="证件类型长度必须介于 1 和 1 之间")
	private String idType;		// 证件类型
	@Length(min=1, max=64, message="证件号长度必须介于 1 和 64 之间")
	@Getter @Setter
	private String idNbr;		// 证件号
	@Length(min=1, max=1000, message="销售区域长度必须介于 1 和 1000 之间")
	@Getter @Setter
	private String salesArea;		// 销售区域
	@Length(min=0, max=1000, message="授权产品范围长度必须介于 0 和 1000 之间")
	@Getter @Setter
	private String salesScop;		// 授权产品范围
	@Length(min=0, max=250, message="授权书编号长度必须介于 0 和 250 之间")
	@Getter @Setter
	private String salesCertNbr;		// 授权书编号
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="生效日期不能为空")
	@Getter @Setter
	private Date effecDate;		// 生效日期
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="有效期至不能为空")
	@Getter @Setter
	private Date validDate;		// 有效期至
	@Length(min=1, max=16, message="审批状态长度必须介于 1 和 16 之间")
	@Getter @Setter
	private String apprStat;		// 审批状态
	@Length(min=0, max=2048, message="附件长度必须介于 0 和 2048 之间")
	@Getter @Setter
	private String attachment;		// 附件

	@Getter @Setter
	private String certStat;		//资质状态
	@Getter @Setter
	private Date effecDateBg;		// 生效日期
	@Getter @Setter
	private Date effecDateEd;		// 生效日期
	@Getter @Setter
	private Date validDateBg;		// 有效期至
	@Getter @Setter
	private Date validDateEd;		// 有效期至

	public T01SalesCert() {
		super();
	}

	public T01SalesCert(String id){
		super(id);
	}
}

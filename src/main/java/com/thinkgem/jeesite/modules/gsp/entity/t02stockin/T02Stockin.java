/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02stockin;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 入库Entity
 * @author yohu
 * @version 2016-11-24
 */
public class T02Stockin extends DataEntity<T02Stockin> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String stocNo;		// 入库单号
	private String checkNo;		// 验收单号
	private Date stocDate;		// 入库时间
	private String auditPers;		// 审核人
	private String wareHouseId;		// 仓库id
	private String wareSign;		// 仓库管理员签字
	private List<T02StockinMate> t02StockinMateList = Lists.newArrayList();		// 子表列表
	
	public T02Stockin() {
		super();
	}

	public T02Stockin(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="入库单号长度必须介于 0 和 100 之间")
	public String getStocNo() {
		return stocNo;
	}

	public void setStocNo(String stocNo) {
		this.stocNo = stocNo;
	}
	
	@Length(min=0, max=100, message="验收单号长度必须介于 0 和 100 之间")
	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStocDate() {
		return stocDate;
	}

	public void setStocDate(Date stocDate) {
		this.stocDate = stocDate;
	}
	
	@Length(min=0, max=100, message="审核人长度必须介于 0 和 100 之间")
	public String getAuditPers() {
		return auditPers;
	}

	public void setAuditPers(String auditPers) {
		this.auditPers = auditPers;
	}
	
	@Length(min=0, max=100, message="仓库id长度必须介于 0 和 100 之间")
	public String getWareHouseId() {
		return wareHouseId;
	}

	public void setWareHouseId(String wareHouseId) {
		this.wareHouseId = wareHouseId;
	}
	
	@Length(min=0, max=100, message="仓库管理员签字长度必须介于 0 和 100 之间")
	public String getWareSign() {
		return wareSign;
	}

	public void setWareSign(String wareSign) {
		this.wareSign = wareSign;
	}
	
	public List<T02StockinMate> getT02StockinMateList() {
		return t02StockinMateList;
	}

	public void setT02StockinMateList(List<T02StockinMate> t02StockinMateList) {
		this.t02StockinMateList = t02StockinMateList;
	}
}
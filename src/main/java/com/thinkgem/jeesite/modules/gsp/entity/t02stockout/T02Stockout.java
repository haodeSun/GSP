/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02stockout;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 出库信息Entity
 * @author yohu
 * @version 2016-11-25
 */
public class T02Stockout extends DataEntity<T02Stockout> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String stocNumb;		// 出库单号
	private String checkNo;		// 验收单号
	private Date stocDate;		// 出库时间
	private String wareName;		// 库房管理员姓名
	private String wareSign;		// 库房管理员签字
	private String auditPers;		// 审核人
	private String wareHouseId;		// 仓库id
	private String orgaCode;		// 组织编码
	private String comments;		// 备注
	private String noTaxAmou;		// 不含税金额
	private String boxCount;		// 箱数
	private String singProdCount;		// 单品数量
	private Date deliDate;		// 出库时间
	private List<T02StockoutMate> t02StockoutMateList = Lists.newArrayList();		// 子表列表
	
	public T02Stockout() {
		super();
	}

	public T02Stockout(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=100, message="出库单号长度必须介于 1 和 100 之间")
	public String getStocNumb() {
		return stocNumb;
	}

	public void setStocNumb(String stocNumb) {
		this.stocNumb = stocNumb;
	}
	
	@Length(min=1, max=100, message="验收单号长度必须介于 1 和 100 之间")
	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="出库时间不能为空")
	public Date getStocDate() {
		return stocDate;
	}

	public void setStocDate(Date stocDate) {
		this.stocDate = stocDate;
	}
	
	@Length(min=0, max=100, message="库房管理员姓名长度必须介于 0 和 100 之间")
	public String getWareName() {
		return wareName;
	}

	public void setWareName(String wareName) {
		this.wareName = wareName;
	}
	
	@Length(min=0, max=100, message="库房管理员签字长度必须介于 0 和 100 之间")
	public String getWareSign() {
		return wareSign;
	}

	public void setWareSign(String wareSign) {
		this.wareSign = wareSign;
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
	
	@Length(min=1, max=100, message="组织编码长度必须介于 1 和 100 之间")
	public String getOrgaCode() {
		return orgaCode;
	}

	public void setOrgaCode(String orgaCode) {
		this.orgaCode = orgaCode;
	}
	
	@Length(min=1, max=100, message="备注长度必须介于 1 和 100 之间")
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
	@Length(min=0, max=11, message="不含税金额长度必须介于 0 和 11 之间")
	public String getNoTaxAmou() {
		return noTaxAmou;
	}

	public void setNoTaxAmou(String noTaxAmou) {
		this.noTaxAmou = noTaxAmou;
	}
	
	@Length(min=0, max=11, message="箱数长度必须介于 0 和 11 之间")
	public String getBoxCount() {
		return boxCount;
	}

	public void setBoxCount(String boxCount) {
		this.boxCount = boxCount;
	}
	
	@Length(min=0, max=11, message="单品数量长度必须介于 0 和 11 之间")
	public String getSingProdCount() {
		return singProdCount;
	}

	public void setSingProdCount(String singProdCount) {
		this.singProdCount = singProdCount;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDeliDate() {
		return deliDate;
	}

	public void setDeliDate(Date deliDate) {
		this.deliDate = deliDate;
	}
	
	public List<T02StockoutMate> getT02StockoutMateList() {
		return t02StockoutMateList;
	}

	public void setT02StockoutMateList(List<T02StockoutMate> t02StockoutMateList) {
		this.t02StockoutMateList = t02StockoutMateList;
	}
}
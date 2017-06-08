/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02stocktaking;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 盘点信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02Stocktaking extends DataEntity<T02Stocktaking> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String warehouse;		// 库房/地点
	private String qualStat;		// 质量状态/区域
	private String inveCount;		// 盘点编号
	private String inveName;		// 盘点人姓名
	private String orgaCode;		// 组织编码
	private String wareCode;		// 仓库编码
	private Date inveDate;		// 盘点日期
	private String nearDays;		// 临期天数
	private String manuCode;		// 生产商编码
	private String cateCode;		// 品类编码
	private String brandCode;		// 品牌编码
	private String comments;		// 备注
	private String salesStartDate;		// 销售开始日期
	private String salesEndDate;		// 销售截止日期
	private String nearGood;		// 临其商品
	
	public T02Stocktaking() {
		super();
	}

	public T02Stocktaking(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="库房/地点长度必须介于 0 和 100 之间")
	public String getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(String warehouse) {
		this.warehouse = warehouse;
	}
	
	@Length(min=0, max=100, message="质量状态/区域长度必须介于 0 和 100 之间")
	public String getQualStat() {
		return qualStat;
	}

	public void setQualStat(String qualStat) {
		this.qualStat = qualStat;
	}
	
	@Length(min=0, max=100, message="盘点编号长度必须介于 0 和 100 之间")
	public String getInveCount() {
		return inveCount;
	}

	public void setInveCount(String inveCount) {
		this.inveCount = inveCount;
	}
	
	@Length(min=0, max=100, message="盘点人姓名长度必须介于 0 和 100 之间")
	public String getInveName() {
		return inveName;
	}

	public void setInveName(String inveName) {
		this.inveName = inveName;
	}
	
	@Length(min=0, max=100, message="组织编码长度必须介于 0 和 100 之间")
	public String getOrgaCode() {
		return orgaCode;
	}

	public void setOrgaCode(String orgaCode) {
		this.orgaCode = orgaCode;
	}
	
	@Length(min=0, max=100, message="仓库编码长度必须介于 0 和 100 之间")
	public String getWareCode() {
		return wareCode;
	}

	public void setWareCode(String wareCode) {
		this.wareCode = wareCode;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getInveDate() {
		return inveDate;
	}

	public void setInveDate(Date inveDate) {
		this.inveDate = inveDate;
	}
	
	@Length(min=0, max=100, message="临期天数长度必须介于 0 和 100 之间")
	public String getNearDays() {
		return nearDays;
	}

	public void setNearDays(String nearDays) {
		this.nearDays = nearDays;
	}
	
	@Length(min=0, max=100, message="生产商编码长度必须介于 0 和 100 之间")
	public String getManuCode() {
		return manuCode;
	}

	public void setManuCode(String manuCode) {
		this.manuCode = manuCode;
	}
	
	@Length(min=0, max=100, message="品类编码长度必须介于 0 和 100 之间")
	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}
	
	@Length(min=0, max=100, message="品牌编码长度必须介于 0 和 100 之间")
	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}
	
	@Length(min=0, max=100, message="备注长度必须介于 0 和 100 之间")
	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
	
	@Length(min=0, max=100, message="销售开始日期长度必须介于 0 和 100 之间")
	public String getSalesStartDate() {
		return salesStartDate;
	}

	public void setSalesStartDate(String salesStartDate) {
		this.salesStartDate = salesStartDate;
	}
	
	@Length(min=0, max=100, message="销售截止日期长度必须介于 0 和 100 之间")
	public String getSalesEndDate() {
		return salesEndDate;
	}

	public void setSalesEndDate(String salesEndDate) {
		this.salesEndDate = salesEndDate;
	}
	
	@Length(min=0, max=100, message="临其商品长度必须介于 0 和 100 之间")
	public String getNearGood() {
		return nearGood;
	}

	public void setNearGood(String nearGood) {
		this.nearGood = nearGood;
	}
	
}
/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02check;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 检查信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02Check extends DataEntity<T02Check> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String inventory;		// 库房
	private String time;		// 时间
	private String item;		// 项目
	private String conclusion;		// 结论
	private String handMeas;		// 处理措施
	private String operator;		// 操作人
	
	public T02Check() {
		super();
	}

	public T02Check(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="库房长度必须介于 0 和 100 之间")
	public String getInventory() {
		return inventory;
	}

	public void setInventory(String inventory) {
		this.inventory = inventory;
	}
	
	@Length(min=0, max=100, message="时间长度必须介于 0 和 100 之间")
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	@Length(min=0, max=100, message="项目长度必须介于 0 和 100 之间")
	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}
	
	@Length(min=0, max=100, message="结论长度必须介于 0 和 100 之间")
	public String getConclusion() {
		return conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}
	
	@Length(min=0, max=100, message="处理措施长度必须介于 0 和 100 之间")
	public String getHandMeas() {
		return handMeas;
	}

	public void setHandMeas(String handMeas) {
		this.handMeas = handMeas;
	}
	
	@Length(min=0, max=100, message="操作人长度必须介于 0 和 100 之间")
	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}
	
}
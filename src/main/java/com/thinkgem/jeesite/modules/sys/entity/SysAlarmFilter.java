/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 预警过滤配置Entity
 * @author yohu
 * @version 2016-12-26
 */
public class SysAlarmFilter extends DataEntity<SysAlarmFilter> {
	
	private static final long serialVersionUID = 1L;
	private String role;		// 过滤规则
	private Boolean included;		// 包含关系
	
	public SysAlarmFilter() {
		super();
	}

	public SysAlarmFilter(String id){
		super(id);
	}

	@Length(min=0, max=500, message="过滤规则长度必须介于 0 和 500 之间")
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public Boolean getIncluded() {
		return included;
	}

	public void setIncluded(Boolean included) {
		this.included = included;
	}
	
}
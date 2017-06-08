/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户参数配置Entity
 * @author XXS
 * @version 2017-03-29
 */
public class SysUserConfig extends DataEntity<SysUserConfig> {
	
	private static final long serialVersionUID = 1L;
	@JsonIgnore
	private User user;		// 用户id
	private String configType;		// 配置类别
	private String configParam;		// 参数名称
	private String configValue;		// 参数值
	
	public SysUserConfig() {
		super();
	}

	public SysUserConfig(String id){
		super(id);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=100, message="配置类别长度必须介于 1 和 100 之间")
	public String getConfigType() {
		return configType;
	}

	public void setConfigType(String configType) {
		this.configType = configType;
	}
	
	@Length(min=0, max=255, message="参数名称长度必须介于 0 和 255 之间")
	public String getConfigParam() {
		return configParam;
	}

	public void setConfigParam(String configParam) {
		this.configParam = configParam;
	}
	
	@Length(min=0, max=1000, message="参数值长度必须介于 0 和 1000 之间")
	public String getConfigValue() {
		return configValue;
	}

	public void setConfigValue(String configValue) {
		this.configValue = configValue;
	}
	
}
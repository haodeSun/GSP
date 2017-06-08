/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;

/**
 * 保存系统配置DAO接口
 * @author yohu
 * @version 2016-12-13
 */


@MyBatisDao
public interface SysConfigExtDao {
	public SysConfig findByName(String configName);
}
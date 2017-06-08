/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarmFilter;

/**
 * 预警过滤配置DAO接口
 * @author yohu
 * @version 2016-12-26
 */


@MyBatisDao
public interface SysAlarmFilterDao extends CrudDao<SysAlarmFilter>{
	
}
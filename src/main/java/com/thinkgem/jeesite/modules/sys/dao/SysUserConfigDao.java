/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.SysUserConfig;

/**
 * 用户参数配置DAO接口
 * @author XXS
 * @version 2017-03-29
 */


@MyBatisDao
public interface SysUserConfigDao extends CrudDao<SysUserConfig>{
	
}
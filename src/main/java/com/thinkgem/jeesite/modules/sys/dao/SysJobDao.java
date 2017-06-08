/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.SysJob;

/**
 * 保存job信息DAO接口
 * @author yohu
 * @version 2016-12-04
 */


@MyBatisDao
public interface SysJobDao extends CrudDao<SysJob>{
	
}
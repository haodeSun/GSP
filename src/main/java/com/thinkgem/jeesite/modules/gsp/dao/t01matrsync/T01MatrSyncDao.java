/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01matrsync;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrsync.T01MatrSync;

/**
 * 物料信息同步DAO接口
 * @author xxs
 * @version 2016-11-30
 */


@MyBatisDao
public interface T01MatrSyncDao extends CrudDao<T01MatrSync>{
	
}
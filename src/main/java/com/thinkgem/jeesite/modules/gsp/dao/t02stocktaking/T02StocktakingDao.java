/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t02stocktaking;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stocktaking.T02Stocktaking;

/**
 * 盘点信息DAO接口
 * @author gyq
 * @version 2016-10-26
 */
@MyBatisDao
public interface T02StocktakingDao extends CrudDao<T02Stocktaking> {
	
}
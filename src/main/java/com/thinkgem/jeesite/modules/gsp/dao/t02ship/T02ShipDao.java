/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t02ship;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02ship.T02Ship;

/**
 * 发货信息DAO接口
 * @author gyq
 * @version 2016-10-26
 */
@MyBatisDao
public interface T02ShipDao extends CrudDao<T02Ship> {
	
}
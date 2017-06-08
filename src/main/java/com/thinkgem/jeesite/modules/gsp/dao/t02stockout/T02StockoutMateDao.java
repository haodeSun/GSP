/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t02stockout;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockout.T02StockoutMate;

/**
 * 出库信息DAO接口
 * @author yohu
 * @version 2016-11-25
 */


@MyBatisDao
public interface T02StockoutMateDao extends CrudDao<T02StockoutMate>{
	
}
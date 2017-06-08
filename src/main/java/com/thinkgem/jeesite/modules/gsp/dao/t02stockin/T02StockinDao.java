/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t02stockin;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;

/**
 * 入库DAO接口
 * @author yohu
 * @version 2016-11-24
 */


@MyBatisDao
public interface T02StockinDao extends CrudDao<T02Stockin> ,T02StockinExtDao {
	
}
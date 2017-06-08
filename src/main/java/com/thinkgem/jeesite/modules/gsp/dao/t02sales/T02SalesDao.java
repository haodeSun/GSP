/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t02sales;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02sales.T02Sales;

/**
 * 售出信息DAO接口
 * @author yohu
 * @version 2016-11-17
 */


@MyBatisDao
public interface T02SalesDao extends CrudDao<T02Sales>{
	
}
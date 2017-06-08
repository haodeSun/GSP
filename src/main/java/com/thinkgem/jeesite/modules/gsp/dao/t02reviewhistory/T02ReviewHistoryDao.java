/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t02reviewhistory;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02reviewhistory.T02ReviewHistory;

/**
 * 审核记录DAO接口
 * @author yohu
 * @version 2016-11-17
 */


@MyBatisDao
public interface T02ReviewHistoryDao extends CrudDao<T02ReviewHistory>{
	
}
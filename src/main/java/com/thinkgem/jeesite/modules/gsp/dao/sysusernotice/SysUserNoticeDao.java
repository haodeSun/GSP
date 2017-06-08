/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.sysusernotice;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.sysusernotice.SysUserNotice;

/**
 * 用户notice表DAO接口
 * @author gyq
 * @version 2016-10-29
 */
@MyBatisDao
public interface SysUserNoticeDao extends CrudDao<SysUserNotice> {
	
}
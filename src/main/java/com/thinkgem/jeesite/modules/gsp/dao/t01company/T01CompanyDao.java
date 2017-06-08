/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01company;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01company.T01Company;

/**
 * 企业信息DAO接口
 * @author gyq
 * @version 2016-10-26
 */
@MyBatisDao
public interface T01CompanyDao extends CrudDao<T01Company> {
	
}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01compinfo;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;

/**
 * 企业信息DAO接口
 * @author XXS
 * @version 2016-12-13
 */


@MyBatisDao
public interface T01CompInfoDao extends CrudDao<T01CompInfo>{

    int getCountNumOfChangeStatByCompNameCn(String compNameCn);

}
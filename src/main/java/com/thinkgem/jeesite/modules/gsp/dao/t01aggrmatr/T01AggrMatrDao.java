/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01aggrmatr;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;

/**
 * 协议与物料的关联信息DAO接口
 * @author XXS
 * @version 2016-12-05
 */


@MyBatisDao
public interface T01AggrMatrDao extends CrudDao<T01AggrMatr>{
    int deleteByAggrId(String aggrId);
}
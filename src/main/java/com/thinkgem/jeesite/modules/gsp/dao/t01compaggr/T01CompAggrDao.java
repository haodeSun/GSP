/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01compaggr;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;

import java.util.List;

/**
 * 企业相关协议信息DAO接口
 * @author XXS
 * @version 2016-12-13
 */


@MyBatisDao
public interface T01CompAggrDao extends CrudDao<T01CompAggr>{
    /** 通过id列表获取数据 */
    public List<T01CompAggr> findSelectedList(List<String> idList);
}
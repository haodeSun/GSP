/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01complprod;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;

import java.util.List;

/**
 * 首营产品DAO接口
 * @author XXS
 * @version 2016-12-06
 */


@MyBatisDao
public interface T01ComplProdDao extends CrudDao<T01ComplProd>{

    /**
     * 通过id列表获取数据
     */
    List<T01ComplProd> findSelectedList(List<String> idList);

    int freeze(String id);
}
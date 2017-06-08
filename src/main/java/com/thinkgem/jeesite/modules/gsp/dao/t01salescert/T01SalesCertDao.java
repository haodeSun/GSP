/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01salescert;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;

import java.util.List;

/**
 * 管理销售人员授权DAO接口
 * @author greg.song
 * @version 2016-12-21
 */


@MyBatisDao
public interface T01SalesCertDao extends CrudDao<T01SalesCert>{
    /**
     *
     * 通过id列表获取数据
     * @param ids 销售人员授权id列表
     * @return 符合条件的销售人员授权列表
     */
    List<T01SalesCert> findSelectedList(List<String> ids);
    /**
     * 替换企业id
     * @param newCompId 替换后的企业id
     * @param oldCompId 替换前的企业id
     * @return sql影响行数
     */
    int replaceCompId(String newCompId, String oldCompId);
}
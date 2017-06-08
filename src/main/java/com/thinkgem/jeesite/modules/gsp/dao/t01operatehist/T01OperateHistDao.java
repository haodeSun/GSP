/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01operatehist;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01operatehist.T01OperateHist;

import java.util.List;

/**
 * 操作历史DAO接口
 *
 * @author XXS
 * @version 2017-03-22
 */


@MyBatisDao
public interface T01OperateHistDao extends CrudDao<T01OperateHist> {
    List<T01OperateHist> findFreezeAndUnfreezeList(T01OperateHist entity);

    /**
     * 更新对应table的冻结状态
     * @param table 表
     * @param entity 操作实体
     * @return 更新的行数
     */
    int updateFreezeStatusById(String table, T01OperateHist entity);
}
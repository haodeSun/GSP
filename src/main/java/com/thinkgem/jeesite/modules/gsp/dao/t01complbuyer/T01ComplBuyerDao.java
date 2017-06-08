/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;

/**
 * 首营购货者DAO接口
 *
 * @author XXS
 * @version 2016-12-13
 */


@MyBatisDao
public interface T01ComplBuyerDao extends CrudDao<T01ComplBuyer>{

    /**
     *
     * 通过id列表获取数据
     * @param ids 购货者id列表
     * @return 符合条件的购货者列表
     */
    List<T01ComplBuyer> findSelectedList(List<String> ids);


    /**
     * 获取企业ID对应的最新的购货者记录
     * TODO 暂时没有想好如何实现获取最新的buyer记录
     * @param buyer 购货者
     * @return 最新的购货者记录
     */
    T01ComplBuyer getLatestValidBuyer(T01ComplBuyer buyer);

    /**
     * 当供货者变更审批通过时调用，更新购货者的企业id
     * @param newCompId 变更后的企业id
     * @param oldCompId 变更前的企业id
     * @return sql影响行数
     */
    int updateCompIdWhenChangePass(String newCompId, String oldCompId);


    int checkOnlyByComp(T01ComplBuyer entity);
}
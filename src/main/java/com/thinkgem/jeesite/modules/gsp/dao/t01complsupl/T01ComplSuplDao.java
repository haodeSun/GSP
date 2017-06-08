/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01complsupl;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;

/**
 * 首营供货者DAO接口
 * 
 * @author Andrea
 * @version 2016-12-20
 */


@MyBatisDao
public interface T01ComplSuplDao extends CrudDao<T01ComplSupl> {
  /** 通过id列表获取数据 */
  public List<T01ComplSupl> findSelectedList(List<String> idList);

  /**
   * 当购货者变更审批通过时调用，更新供货者的企业id
   *
   * @param newCompId 变更后的企业id
   * @param oldCompId 变更前的企业id
   * @return sql影响行数
   */
  int updateCompIdWhenChangePass(String newCompId, String oldCompId);

  int checkOnlyByComp(T01ComplSupl entity);
}

/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01matrinfo;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfoImport;

/**
 * 物料信息DAO接口
 *
 * @author xuxiaoshuo
 * @version 2016-11-23
 */

@MyBatisDao
public interface T01MatrInfoDao extends CrudDao<T01MatrInfo> {

    // 通过id的list列表删除数据
    public int deleteList(List<String> idList);

    // 通过id的list列表查询数据
    public List<T01MatrInfo> findSelectedList(List<String> idList);

    // 批量插入数据
    public void insertBatch(List<T01MatrInfo> t01MatrInfoList);

    // 通过物料号查询数据
    public List<T01MatrInfo> findByMatrNbr(String matrNbr);

    // 通过导入批次查询数据
    public List<T01MatrInfoImport> findImportList(String batch);

    // 批量插入导入数据
    public void insertImportBatch(List<T01MatrInfoImport> t01MatrInfoImportList);

    // 通过id的list列表查询导入数据
    public List<T01MatrInfoImport> findSelectedImportList(List<String> idList);

    // 更新导入数据状态
    public void updateImportState(T01MatrInfoImport t01MatrInfoImport);

}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01prodcert;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;

import java.util.List;

/**
 * 产品资质DAO接口
 * @author gyq
 * @version 2016-11-13
 */


@MyBatisDao
public interface T01ProdCertExtDao extends CrudDao<T01ProdCert>{

    /**
     * 获取历史纪录
     *            获取当前记录之后记录：参数为当前 记录id   "%#{Id}%"
     *            获取兄弟记录，参数为当前路由值  "#{regiCertNbrs}"
     *            获取所有记录，参数为当前记录路由值得 第一个id  "%#{Id}%"
     * @param route 路由
     * @return 查询结果
     */
    List<T01ProdCert> getChildren(String route);

    /**
     * 获取历史纪录
     *            获取当前记录之前记录：参数为当前路由值   "%#{regiCertNbrs}%"
     * @param route 路由
     * @return 查询结果
     */
    List<T01ProdCert> getPreHistory(String route);


    /**
     * 查询资质证号相同的资质
     * @param t01ProdCert 查询条件
     * @return 查询结果
     */
    List<T01ProdCert> findChanList(T01ProdCert t01ProdCert);
}
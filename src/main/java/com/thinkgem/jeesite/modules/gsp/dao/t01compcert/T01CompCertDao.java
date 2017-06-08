/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01compcert;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;

/**
 * 企业资质DAO接口
 * @author XXS
 * @version 2016-12-13
 */


@MyBatisDao
public interface T01CompCertDao extends CrudDao<T01CompCert>{
    /**
     * 替换指定资质类别的企业id
     * @param newCompId 替换后的企业id
     * @param oldCompId 替换前的企业id
     * @param certType 资质类别
     * @return sql影响行数
     */
    int replaceCompIdByCertType(String newCompId, String oldCompId,String certType);

    /**
     * 删除指定企业id和资质类别的资质
     * @param compId 企业id
     * @param certType 资质类别
     * @return sql影响行数
     */
    int deleteByCompIdAndCertType(String compId,String certType);
}
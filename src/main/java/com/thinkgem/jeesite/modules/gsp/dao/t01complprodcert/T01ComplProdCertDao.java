/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01complprodcert;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprodcert.T01ComplProdCert;

/**
 * 首营产品关联资质DAO接口
 * @author XXS
 * @version 2016-12-06
 */


@MyBatisDao
public interface T01ComplProdCertDao extends CrudDao<T01ComplProdCert>{
    /** 通过首营产品id删除首营产品资质关联信息 */
    public int deleteByComplProdId(String complProdId);
}
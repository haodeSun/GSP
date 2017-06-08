/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.dao.t01compinfonew;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew.T01CompInfoNew;

import java.util.List;

/**
 * 企业信息DAO接口
 * @author XXS
 * @version 2016-12-13
 */


@MyBatisDao
public interface T01CompInfoNewDao extends CrudDao<T01CompInfoNew>{

    int getCountNumOfChangeStatByUniCretNbr(String uniCretNbr);

    int getCountNumOfChangeStatByRegiNbr(String regiNbr);

    int checkOnlyByCompNameCn(T01CompInfoNew entity);

    int checkOnlyByUniCretNbr(T01CompInfoNew entity);

    int checkOnlyByRegiNbr(T01CompInfoNew entity);

    /**
     *
     * 通过id列表获取数据
     * @param ids 企业信息id列表
     * @return 符合条件的企业信息列表
     */
    List<T01CompInfoNew> findSelectedList(List<String> ids);

}
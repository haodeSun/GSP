package com.thinkgem.jeesite.modules.gsp.dao.common;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01operatehist.T01OperateHist;

import java.util.List;

/**
 * Created by ZCTT-lls on 2016/12/21.
 */
@MyBatisDao
public interface CommonDao {

    /**
     * 判断物料是否关联进销存
     *
     * @param matrInfoIdList 物料idList
     * @return >0:关联了进销存
     */
    int getRelateInvoicingNum(List<String> matrInfoIdList);

    /**
     * 判断数据是否存在
     *
     * @param table 表名
     * @param id    id
     * @return 存在返回1 不存在返回0
     */
    int checkDataExistById(String table, String id);

    /**
     * 插入操作历史
     *
     * @param t01OperateHist 操作历史
     * @return 行数
     */
    int insertT01OperateHist(T01OperateHist t01OperateHist);
}

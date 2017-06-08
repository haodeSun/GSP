/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01salescert;

import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01salescert.T01SalesCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BeforeHandleStatusErrorException;
import com.thinkgem.jeesite.modules.gsp.service.exception.DataNotExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * 管理销售人员授权HelperService
 *
 * @author XXS
 * @version 2017-03-29
 */
@Service
@Transactional(readOnly = true)
public class T01SalesCertHelperService extends BaseService {

    private final static String TABLE = "t01_sales_cert";

    @Autowired
    private T01SalesCertDao t01SalesCertDao;


    /**
     * 检查处理前数据的状态是否正确
     *
     * @param handle 处理的名
     * @param entity 检查的数据
     * @throws BeforeHandleStatusErrorException exception
     */
    public void checkStatusBeforeHandle(String handle, T01SalesCert entity) throws BeforeHandleStatusErrorException, DataNotExistException {
        if (StringUtils.isBlank(handle) || entity == null) {
            throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确参数错误", "");
        }

        switch (handle) {
            case "edit":
                checkDataExistById(TABLE, entity.getId());
                break;
            case "delete":
                checkDataExistById(TABLE, entity.getId());
                checkStatusBeforeDelete(entity);
                break;
            default:
                throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确无对应处理的检查逻辑", "");
        }
    }

    private void checkStatusBeforeDelete(T01SalesCert entity) throws BeforeHandleStatusErrorException {

        entity = t01SalesCertDao.get(entity.getId());
        T01SalesCert search = new T01SalesCert();
        T01CompInfo t01CompInfo = new T01CompInfo();
        t01CompInfo.setId(entity.getComp().getId());
        search.setComp(t01CompInfo);

        List<T01SalesCert> t01SalesCertList = t01SalesCertDao.findList(search);

        if (t01SalesCertList == null || t01SalesCertList.size() <= 1) {
            throw new BeforeHandleStatusErrorException("该销售人员为其企业下唯一的销售人员，不可删除。", "");
        }
    }

}
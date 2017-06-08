/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01matrinfo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.dao.t01matrinfo.T01MatrInfoDao;

/**
 * 物料信息Service
 *
 * @author xuxiaoshuo
 * @version 2016-11-23
 */
@Service
@Transactional(readOnly = true)
public class T01MatrInfoService extends ExtCrudService<T01MatrInfoDao, T01MatrInfo> {

    @SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
    @Autowired(required = false)
    private List<BusinessService<T01MatrInfo>> businessServices = new ArrayList<>();

    @Autowired
    public T01MatrInfoService(T01MatrInfoDao dao) {
        super(dao);
    }

    public T01MatrInfo get(String id) {
        // 执行保存前的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            businessService.preFetch(id);
        }
        T01MatrInfo t01MatrInfo = super.get(id);

        // 执行保存后的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            businessService.postFetch(t01MatrInfo);
        }

        return t01MatrInfo;
    }

    public List<T01MatrInfo> findList(T01MatrInfo t01MatrInfo) {
        return super.findList(t01MatrInfo);
    }

    public Page<T01MatrInfo> findPage(Page<T01MatrInfo> page, T01MatrInfo t01MatrInfo) {
        // 执行保存前的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            businessService.prePaging(page, t01MatrInfo);
        }
        Page<T01MatrInfo> paginator = super.findPage(page, t01MatrInfo);
        // 执行保存后的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            businessService.postPaging(paginator);
        }
        return paginator;
    }

    @Transactional
    public void save(T01MatrInfo t01MatrInfo) throws BusinessException {
        boolean isNewRecord = t01MatrInfo.getIsNewRecord();
        // 执行保存前的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            if (!isNewRecord) {
                businessService.preUpdate(t01MatrInfo);
            } else {
                businessService.preInsert(t01MatrInfo);
            }
        }
        // 执行保存操作
        super.save(t01MatrInfo);
        // 执行保存后的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            if (!isNewRecord) {
                businessService.postUpdate(t01MatrInfo);
            } else {
                businessService.postInsert(t01MatrInfo);
            }
        }
    }

    @Transactional
    public void delete(T01MatrInfo t01MatrInfo) throws BusinessException{
        // 执行保存前的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            businessService.preDelete(t01MatrInfo);
        }
        // 删除
        super.delete(t01MatrInfo);
        // 执行保存前的业务代码
        for (BusinessService<T01MatrInfo> businessService : businessServices) {
            businessService.postDelete(t01MatrInfo);
        }
    }

}
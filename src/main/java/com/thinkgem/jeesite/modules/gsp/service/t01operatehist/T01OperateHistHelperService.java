/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01operatehist;

import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t01operatehist.T01OperateHistDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01operatehist.T01OperateHist;
import com.thinkgem.jeesite.modules.gsp.service.exception.BeforeHandleStatusErrorException;
import com.thinkgem.jeesite.modules.gsp.service.exception.DataNotExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 操作历史HelperService
 *
 * @author xxs
 * @version 2017-03-24
 */
@Service
@Transactional(readOnly = true)
public class T01OperateHistHelperService extends BaseService {
    @Autowired
    private T01OperateHistDao t01OperateHistDao;

    /**
     * 检查处理前数据的状态是否正确
     *
     * @param handle 处理的名
     * @param entity 检查的数据
     * @throws BeforeHandleStatusErrorException exception
     */
    public void checkBeforeHandleStatus(String handle, T01OperateHist entity) throws BeforeHandleStatusErrorException, DataNotExistException {
        if (StringUtils.isBlank(handle) || entity == null) {
            throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确参数错误", "");
        }

        checkDataExistById(getTableFromModule(entity.getModule()), entity.getDataId());

        switch (handle) {
            case "freeze":
                checkBeforeFreezeStatus(entity);
                break;
            case "unfreeze":
                checkBeforeUnfreezeStatus(entity);
                break;
            default:
                throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确无对应处理的检查逻辑", "");
        }
    }

    /**
     * 检查冻结前数据的状态是否正确
     *
     * @param entity 数据对象
     * @throws BeforeHandleStatusErrorException exception
     */
    private void checkBeforeFreezeStatus(T01OperateHist entity) throws BeforeHandleStatusErrorException {
        if (StringUtils.isBlank(entity.getModule())
                || StringUtils.isBlank(entity.getDataId())) {
            throw new BeforeHandleStatusErrorException("冻结前的参数错误", "");
        }

        List<T01OperateHist> t01OperateHistList = t01OperateHistDao.findFreezeAndUnfreezeList(entity);

        if (t01OperateHistList != null && !t01OperateHistList.isEmpty()) {
            if ("1".equals(t01OperateHistList.get(0).getOperateType())) {
                throw new BeforeHandleStatusErrorException("只有未冻结的数据才能冻结", "");
            }
        }
    }

    /**
     * 检查解冻前数据的状态是否正确
     *
     * @param entity 数据对象
     * @throws BeforeHandleStatusErrorException exception
     */
    private void checkBeforeUnfreezeStatus(T01OperateHist entity) throws BeforeHandleStatusErrorException {
        if (StringUtils.isBlank(entity.getModule())
                || StringUtils.isBlank(entity.getDataId())) {
            throw new BeforeHandleStatusErrorException("解冻前的参数错误", "");
        }

        List<T01OperateHist> t01OperateHistList = t01OperateHistDao.findFreezeAndUnfreezeList(entity);

        if (t01OperateHistList == null
                || t01OperateHistList.isEmpty()
                || !"1".equals(t01OperateHistList.get(0).getOperateType())) {
            throw new BeforeHandleStatusErrorException("只有冻结的数据才能解冻", "");
        }
    }
}
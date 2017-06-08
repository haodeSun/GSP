/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights
 * reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01complbuyer;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01compinfo.T01CompInfoDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complbuyer.T01ComplBuyerDao;

import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.service.exception.BeforeHandleStatusErrorException;
import com.thinkgem.jeesite.modules.gsp.service.exception.DataNotExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 首营购货者HelperService
 *
 * @author XXS
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class T01ComplBuyerHelperService extends BaseService {


    private final static String TABLE = "t01_compl_buyer";

    @Autowired
    private T01ComplBuyerDao t01ComplBuyerDao;

    @Autowired
    private T01CompInfoDao t01CompInfoDao;


    /**
     * 检查处理前数据的状态是否正确
     *
     * @param handle 处理的名
     * @param entity 检查的数据
     * @throws BeforeHandleStatusErrorException exception
     */
    public void checkStatusBeforeHandle(String handle, T01ComplBuyer entity) throws BeforeHandleStatusErrorException, DataNotExistException {
        if (StringUtils.isBlank(handle) || entity == null) {
            throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确参数错误", "");
        }

        switch (handle) {
            case "checkOnlyByComp":
                checkOnlyByComp(entity);
                break;
            case "save":
                checkStatusBeforeSave(entity);
                break;
            case "edit":
                checkDataExistById(TABLE, entity.getId());
                checkStatusBeforeEdit(entity);
                break;
            case "delete":
                checkDataExistById(TABLE, entity.getId());
                checkStatusBeforeDelete(entity);
                break;
            case "change":
                checkStatusBeforeChange(entity);
                break;
            case "appr":
                checkDataExistById(TABLE, entity.getId());
                checkStatusBeforeAppr(entity);
                break;
            default:
                throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确无对应处理的检查逻辑", "");
        }
    }

    private void checkOnlyByComp(T01ComplBuyer entity) throws BeforeHandleStatusErrorException {
        if (t01ComplBuyerDao.checkOnlyByComp(entity) > 0) {
            throw new BeforeHandleStatusErrorException("该企业已添加购货者，无法再次添加", "");
        }
    }

    private void checkStatusBeforeSave(T01ComplBuyer entity) throws BeforeHandleStatusErrorException {
        if (StringUtils.isBlank(entity.getT01CompInfo().getId())) {
            throw new BeforeHandleStatusErrorException("添加购货者必须绑定企业信息", "");
        }
        checkOnlyByComp(entity);
    }


    private void checkStatusBeforeEdit(T01ComplBuyer entity) throws BeforeHandleStatusErrorException {

        entity = t01ComplBuyerDao.get(entity.getId());

        if (ApprStatus.NOAPPR.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("数据正在审批不可修改", "");
        }
        if (ApprStatus.PASS.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("数据已审批通过不可修改", "");
        }
    }

    private void checkStatusBeforeDelete(T01ComplBuyer entity) throws BeforeHandleStatusErrorException {

        if (ApprStatus.PASS.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("审批通过状态的数据不可以删除！", "");
        }
        if (ApprStatus.NOAPPR.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("未审批状态的数据不可以删除！", "");
        }
    }

    private void checkStatusBeforeChange(T01ComplBuyer entity) throws BeforeHandleStatusErrorException, DataNotExistException {
        if (StringUtils.isBlank(entity.getId()) && StringUtils.isBlank(entity.getT01CompInfo().getCompNameCn())) {
            throw new BeforeHandleStatusErrorException("检查变更前数据的状态是否正确参数错误", "");
        }

        if (StringUtils.isBlank(entity.getT01CompInfo().getCompNameCn())) {

            checkDataExistById(TABLE, entity.getId());

            entity = t01ComplBuyerDao.get(entity.getId());
        }
        if (t01CompInfoDao.getCountNumOfChangeStatByCompNameCn(entity.getT01CompInfo().getCompNameCn()) > 0) {
            throw new BeforeHandleStatusErrorException("该企业已处于变更流程中，不可重复变更", "");
        }
        T01CompInfo search = new T01CompInfo();
        search.setCompNameCn(entity.getT01CompInfo().getCompNameCn());
        List<T01CompInfo> findList = t01CompInfoDao.findList(search);
        findList = findList.stream().filter(item -> search.getCompNameCn().equals(item.getCompNameCn()))
                .collect(Collectors.toList());
        if (findList == null || findList.isEmpty()) {
            throw new BeforeHandleStatusErrorException("该企业名称不存在，不可变更", "");
        }
        if (findList.size() > 1) {

        }
        if (!ApprStatus.PASS.toString().equals(findList.get(0).getApprStat())) {
            throw new BeforeHandleStatusErrorException("只有审批通过状态的数据可以变更！", "");
        }

    }

    private void checkStatusBeforeAppr(T01ComplBuyer entity) throws BeforeHandleStatusErrorException {
        entity = t01ComplBuyerDao.get(entity.getId());

        if(!ApprStatus.NOAPPR.toString().equals(entity.getApprStat())){
            throw new BeforeHandleStatusErrorException("只有未审批状态的数据可以审批！", "");
        }
        if(StringUtils.isBlank(entity.getProcInsId())){
            throw new BeforeHandleStatusErrorException("未查询到对应的审批流程，无法审批！", "");
        }
    }

}

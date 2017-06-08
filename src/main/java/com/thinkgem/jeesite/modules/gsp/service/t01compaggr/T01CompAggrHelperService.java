package com.thinkgem.jeesite.modules.gsp.service.t01compaggr;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01compaggr.T01CompAggrDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;
import com.thinkgem.jeesite.modules.gsp.service.exception.BeforeHandleStatusErrorException;
import com.thinkgem.jeesite.modules.gsp.service.exception.DataNotExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author XXS
 * @date 2017/4/14
 */
@Service
public class T01CompAggrHelperService extends BaseService {
    private final static String TABLE = "t01_comp_aggr";

    @Autowired
    private T01CompAggrDao t01CompAggrDao;

    /**
     * 检查处理前数据的状态是否正确
     *
     * @param handle 处理的名
     * @param entity 检查的数据
     * @throws BeforeHandleStatusErrorException exception
     */
    public void checkStatusBeforeHandle(String handle, T01CompAggr entity) throws BeforeHandleStatusErrorException, DataNotExistException {
        if (StringUtils.isBlank(handle) || entity == null) {
            throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确参数错误", "");
        }

        switch (handle) {
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
            case "appr":
                checkDataExistById(TABLE, entity.getId());
                checkStatusBeforeAppr(entity);
                break;
            default:
                throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确无对应处理的检查逻辑", "");
        }
    }

    private void checkStatusBeforeSave(T01CompAggr entity) throws BeforeHandleStatusErrorException {

    }


    private void checkStatusBeforeEdit(T01CompAggr entity) throws BeforeHandleStatusErrorException {

        entity = t01CompAggrDao.get(entity.getId());

        if (ApprStatus.NOAPPR.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("数据正在审批不可修改", "");
        }
        if (ApprStatus.PASS.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("数据已审批通过不可修改", "");
        }
    }

    private void checkStatusBeforeDelete(T01CompAggr entity) throws BeforeHandleStatusErrorException {

        if (ApprStatus.PASS.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("审批通过状态的数据不可以删除！", "");
        }
        if (ApprStatus.NOAPPR.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("未审批状态的数据不可以删除！", "");
        }
    }

    private void checkStatusBeforeAppr(T01CompAggr entity) throws BeforeHandleStatusErrorException {
        entity = t01CompAggrDao.get(entity.getId());

        if(!ApprStatus.NOAPPR.toString().equals(entity.getApprStat())){
            throw new BeforeHandleStatusErrorException("只有未审批状态的数据可以审批！", "");
        }
        if(StringUtils.isBlank(entity.getProcInsId())){
            throw new BeforeHandleStatusErrorException("未查询到对应的审批流程，无法审批！", "");
        }
    }
}

package com.thinkgem.jeesite.modules.gsp.service.t01compinfonew;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01compinfonew.T01CompInfoNewDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01salescert.T01SalesCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew.T01CompInfoNew;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BeforeHandleStatusErrorException;
import com.thinkgem.jeesite.modules.gsp.service.exception.DataNotExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author XXS
 * @date 2017/3/28
 */
@Service
@Transactional(readOnly = true)
public class T01CompInfoNewHelperService extends BaseService {

    private final static String TABLE = "t01_comp_info";

    @Autowired
    private T01CompInfoNewDao t01CompInfoNewDao;

    @Autowired
    private T01SalesCertDao t01SalesCertDao;

    /**
     * 检查处理前数据的状态是否正确
     *
     * @param handle 处理的名
     * @param entity 检查的数据
     * @throws BeforeHandleStatusErrorException exception
     */
    public void checkStatusBeforeHandle(String handle, T01CompInfoNew entity) throws BeforeHandleStatusErrorException, DataNotExistException {
        if (StringUtils.isBlank(handle) || entity == null) {
            throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确参数错误", "");
        }

        switch (handle) {
            case "checkOnlyByCompNameCn":
                checkOnlyByCompNameCn(entity);
                break;
            case "checkOnlyByRegiNbr":
                checkOnlyByRegiNbr(entity);
                break;
            case "checkOnlyByUniCretNbr":
                checkOnlyByUniCretNbr(entity);
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
            default:
                throw new BeforeHandleStatusErrorException("检查处理前数据的状态是否正确无对应处理的检查逻辑", "");
        }
    }

    private void checkOnlyByCompNameCn(T01CompInfoNew entity) throws BeforeHandleStatusErrorException {
        if (t01CompInfoNewDao.checkOnlyByCompNameCn(entity) > 0) {
            throw new BeforeHandleStatusErrorException("企业名称（中文）已存在，无法添加", "");
        }
    }
    private void checkOnlyByRegiNbr(T01CompInfoNew entity) throws BeforeHandleStatusErrorException {
        if (t01CompInfoNewDao.checkOnlyByRegiNbr(entity) > 0) {
            throw new BeforeHandleStatusErrorException("注册号已存在，无法添加", "");
        }
    }
    private void checkOnlyByUniCretNbr(T01CompInfoNew entity) throws BeforeHandleStatusErrorException {
        if (t01CompInfoNewDao.checkOnlyByUniCretNbr(entity) > 0) {
            throw new BeforeHandleStatusErrorException("统一社会信用代码已存在，无法添加", "");
        }
    }

    private void checkStatusBeforeSave(T01CompInfoNew entity) throws BeforeHandleStatusErrorException {

        checkOnlyByCompNameCn(entity);
        if(StringUtils.isNotBlank(entity.getUniCretNbr())){
            checkOnlyByUniCretNbr(entity);
        }
        if(StringUtils.isNotBlank(entity.getRegiNbr())){
            checkOnlyByRegiNbr(entity);
        }
    }


    private void checkStatusBeforeEdit(T01CompInfoNew entity) throws BeforeHandleStatusErrorException {

        T01CompInfoNew t01CompInfoNew = t01CompInfoNewDao.get(entity.getId());

        if (ApprStatus.NOAPPR.toString().equals(t01CompInfoNew.getApprStat())) {
            throw new BeforeHandleStatusErrorException("数据正在审批不可修改", "");
        }
        if (ApprStatus.PASS.toString().equals(t01CompInfoNew.getApprStat())) {
            throw new BeforeHandleStatusErrorException("数据已审批通过不可修改", "");
        }
    }

    private void checkStatusBeforeDelete(T01CompInfoNew entity) throws BeforeHandleStatusErrorException {

        if (ApprStatus.PASS.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("审批通过状态的数据不可以删除！", "");
        }
        if (ApprStatus.NOAPPR.toString().equals(entity.getApprStat())) {
            throw new BeforeHandleStatusErrorException("未审批状态的数据不可以删除！", "");
        }

        T01SalesCert search=new T01SalesCert();
        T01CompInfo t01CompInfo=new T01CompInfo();
        t01CompInfo.setId(entity.getId());
        search.setComp(t01CompInfo);

        List<T01SalesCert> t01SalesCertList=t01SalesCertDao.findList(search);

        if (t01SalesCertList!=null&&!t01SalesCertList.isEmpty()) {
            throw new BeforeHandleStatusErrorException("该数据已有销售人员授权，不可删除！", "");
        }
    }
}

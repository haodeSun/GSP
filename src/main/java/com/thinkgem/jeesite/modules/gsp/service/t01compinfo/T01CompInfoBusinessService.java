package com.thinkgem.jeesite.modules.gsp.service.t01compinfo;


import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 企业信息BusinessService
 *
 * @author XXS
 * @since 2016/12/23
 */
@Service
@Transactional
public class T01CompInfoBusinessService extends GenericBusinessService<T01CompInfo> {


//    @Autowired
    public T01CompInfoBusinessService() {
    }

    @Override
    public ServiceFlag preInsert(T01CompInfo entity) throws BusinessException {
        entity.setApprStat(ApprStatus.NOSUBMIT.toString());
        return ServiceFlag.SUCCESS;
    }
}

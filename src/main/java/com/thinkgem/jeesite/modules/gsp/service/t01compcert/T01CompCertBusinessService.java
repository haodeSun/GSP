package com.thinkgem.jeesite.modules.gsp.service.t01compcert;


import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 企业资质BusinessService
 *
 * @author XXS
 * @since 2016/12/23
 */
@Service
@Transactional
public class T01CompCertBusinessService extends GenericBusinessService<T01CompCert> {


//    @Autowired
    public T01CompCertBusinessService() {
    }

    @Override
    public ServiceFlag preInsert(T01CompCert entity) throws BusinessException {
        entity.setApprStat(ApprStatus.NOSUBMIT.toString());
        return ServiceFlag.SUCCESS;
    }
}

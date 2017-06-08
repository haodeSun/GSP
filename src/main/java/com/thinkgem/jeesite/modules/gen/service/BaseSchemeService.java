package com.thinkgem.jeesite.modules.gen.service;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Greg Song
 * @since 07/11/2016
 */
public class BaseSchemeService extends BaseService {
    static final String FLAG_SAVE = "1";

    @Transactional
    public <E extends DataEntity> PersistStatus save(E genObject) {
        PersistStatus status;
        if (StringUtils.isBlank(genObject.getId())){
            genObject.preInsert();
            status = PersistStatus.NEW;
        }else{
            genObject.preUpdate();
            status = PersistStatus.CHANGED;
        }
        return status;
    }
}

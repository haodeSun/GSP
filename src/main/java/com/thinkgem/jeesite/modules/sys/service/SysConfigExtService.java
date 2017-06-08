/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.stat.TableStat.Name;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
import com.thinkgem.jeesite.modules.sys.dao.SysConfigDao;

/**
 * 保存系统配置Service
 * @author yohu
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class SysConfigExtService extends SysConfigService {


    @Autowired
    public SysConfigExtService(
            SysConfigDao dao) {
        super(dao);
    }
    public SysConfig findByName(String configName){
		return dao.findByName(configName);
	}
}
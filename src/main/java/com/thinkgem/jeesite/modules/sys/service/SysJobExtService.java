/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.modules.sys.entity.SysJob;
import com.thinkgem.jeesite.modules.sys.dao.SysJobDao;

/**
 * 保存job信息Service
 * @author yohu
 * @version 2016-12-15
 */
@Service()
@Transactional(readOnly = true)
public class SysJobExtService extends SysJobService {


    @Autowired
    public SysJobExtService(
            SysJobDao dao) {
        super(dao);
    }

}
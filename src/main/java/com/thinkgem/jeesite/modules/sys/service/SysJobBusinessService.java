package com.thinkgem.jeesite.modules.sys.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.Reflections;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.NoSuchTypeException;
import com.thinkgem.jeesite.modules.sys.dao.SysJobDao;
import com.thinkgem.jeesite.modules.sys.entity.SysJob;

import org.quartz.Job;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Field;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional
public class SysJobBusinessService extends GenericBusinessService<SysJob>{

  @Autowired
  private QuartzManagerService quartzManagerService;
	private final SysJobDao sysJobDao;

	@Autowired
	private  QuartzHelperService quartzHelperService;
    @Autowired
	public SysJobBusinessService(SysJobDao sysJobDao) {
		this.sysJobDao = sysJobDao;
	}

    @Override
    public ServiceFlag preInsert (SysJob entity) throws BusinessException
    {
//      @SuppressWarnings ("unchecked")
//      Class<? extends Job> clazz;
//      try
//      {
//        clazz = (Class<? extends Job>) Class.forName(entity.getClazzName ());
//        quartzManagerService.addJob (entity.getJobName (), clazz, entity.getExpression());
//      }
//      catch (ClassNotFoundException e)
//      {
//        e.printStackTrace();
//      }
//		try {
//			quartzHelperService.saveJob(entity.getClazzName(), entity.getJobName(), entity.getJobGroup(), entity.getExpression());
//		}catch (Exception e){
//			logger.error(e.getMessage());
//		}
      return super.preInsert (entity);
    }

	@Override
	public ServiceFlag postUpdate(SysJob entity) throws BusinessException {
//		try {
//			quartzHelperService.saveJob(entity.getClazzName(), entity.getJobName(), entity.getJobGroup(), entity.getExpression());
//		}catch (Exception e){
//			logger.error(e.getMessage());
//		}
		return super.postUpdate(entity);
	}

	@Override
	public ServiceFlag postInsert(SysJob entity) throws BusinessException {
		entity.setJobStatus("正常");
		sysJobDao.update(entity);
		return super.postInsert(entity);
	}

	@Override
	public ServiceFlag postPaging(Page<SysJob> page) {
		quartzManagerService.retrieveJobs(page.getList());
		return super.postPaging(page);
	}

	@Override
	public ServiceFlag postFetch(SysJob entity) {
		// TODO Auto-generated method stub
		return super.postFetch(entity);
	}

	@Override
	public ServiceFlag preDelete(SysJob entity) {
		entity=sysJobDao.get(entity);
		quartzManagerService.removeJob(entity.getJobName());
		return super.preDelete(entity);
	}
	
}

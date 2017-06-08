package com.thinkgem.jeesite.modules.act.servicetask;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.delegate.JavaDelegate;
import org.activiti.engine.impl.context.Context;

import com.thinkgem.jeesite.modules.act.dao.ActDao;
import com.thinkgem.jeesite.modules.act.entity.Act;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

public class StockinServiceTask implements JavaDelegate 
{
  
  @Override
  public void execute (DelegateExecution execution) throws Exception
  {
	  String businessId = (String) execution.getVariable("businessId");
	    String businessTable = (String) execution.getVariable("businessTable");
	    
	    
	    //不能从spring中直接获取bean。
	    ActDao actDao  = (ActDao) Context.getProcessEngineConfiguration().getBeans().get("actDao");
	   
	    Act act = new Act();
		act.setBusinessTable(businessTable);// 业务表名
		act.setBusinessId(businessId);	// 业务表ID
		act.setStatus("自动审批完成");
		
		actDao.updateProcInsIdByBusinessId(act);
		actDao.updateStatusByBusinessId(act);
  }

}

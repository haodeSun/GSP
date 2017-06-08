package com.thinkgem.jeesite.modules.act.servicetask;

import java.util.List;
import java.util.Map;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;
import org.activiti.engine.impl.context.Context;

import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
/**
 * 预警流程服务的执行类
 * @author huyong
 *
 */
public class ExpirationAlarm implements JavaDelegate{

	@Override
	public void execute(DelegateExecution execution) throws Exception {
		SysAlarm sysAlarm = (SysAlarm) execution.getVariable("sysAlarm");
	    List<?> alarmList = (List<?>) execution.getVariable("alarmList");
	    
	    //不能从spring中直接获取bean。
	    SystemService systemService  = (SystemService) Context.getProcessEngineConfiguration().getBeans().get("systemService");
	    OaNotifyService oaNotifyService  = (OaNotifyService) Context.getProcessEngineConfiguration().getBeans().get("oaNotifyService");
	    for (Object obj:alarmList) {
	    	
	    	Map<String, String> map = (Map<String, String>) obj;
	    	
	    	
	    	User u = new User();
			u.setId("1");
			List<User> userList = systemService.findAllUser(u);
			
			OaNotify notify = new OaNotify();
			notify.setContent(sysAlarm.getWarnCont()+" " +map.get("name"));
			notify.setTitle(map.get("type"));
			notify.setRemarks(map.get("id"));
			notify.setOaNotifyRecordIds(userList);
			notify.setStatus("1");//发布
			notify.setType("3");//预警通知（需要根据字典表配置相关记录）
			notify.setCreateBy(new User("1"));
			notify.setUpdateBy(new User("1"));
			
			oaNotifyService.save(notify);
		}
	}

}

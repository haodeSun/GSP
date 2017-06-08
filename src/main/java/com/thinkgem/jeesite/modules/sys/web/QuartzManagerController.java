package com.thinkgem.jeesite.modules.sys.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.modules.sys.service.QuartzManagerService;
@Controller
@RequestMapping(value = "${adminPath}/sys/quartz")
public class QuartzManagerController {
	
	@Autowired
	private QuartzManagerService quartzManagerService;
	
	@RequestMapping(value="startQuartz")
	public void startQuartz(){
		quartzManagerService.addJob("first Job", com.thinkgem.jeesite.modules.sys.jobs.QuartzJob.class, "0/1 * * * * ?");
	}
	@RequestMapping(value="removeQuartz")
	public void removeQuartz(){
		quartzManagerService.removeJob("first Job");
	}
	
	@RequestMapping(value="pauseJob")
	public void pauseJob(){
		quartzManagerService.pauseJob("first Job");
	}
	
	@RequestMapping(value="resumeJob")
	public void resumeJob(){
		quartzManagerService.resumeJob("first Job");
	}
}

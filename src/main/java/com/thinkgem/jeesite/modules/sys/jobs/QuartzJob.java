package com.thinkgem.jeesite.modules.sys.jobs;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.thinkgem.jeesite.modules.sys.service.KettleUtilService;

/**
 * kettle执行job
 * @author huyong
 *
 */
public class QuartzJob implements Job {

	private static Logger logger = LoggerFactory.getLogger(QuartzJob.class);
	@Autowired
	private KettleUtilService service;

	@Override
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		logger.debug(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(new Date()) + "★★★★★★★★★★★");
		service.trans();
	}

}

package com.thinkgem.jeesite.modules.sys.service;

import org.quartz.*;
import org.quartz.impl.StdScheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * @author Xxs
 * @since 2017/03/04
 */
@Service
@Transactional
public class QuartzHelperService {
    protected Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    protected StdScheduler stdScheduler;

    /**
     * 添加基于cron的job创建
     * and the job or trigger use the same name and group
     *
     * @param jobClass       name of the class which impl job
     * @param name           job or trigger name
     * @param group          job or trigger group
     * @param cronExpression cron
     * @throws Exception exception
     */
    public void saveJob(String jobClass, String name, String group, String cronExpression) throws Exception {

        JobKey jobKey = new JobKey(name, group);
        if (stdScheduler.checkExists(jobKey)) {
            stdScheduler.deleteJob(jobKey);
        }
        try {
            JobDetail jobDetail = JobBuilder
                    .newJob(Class.forName(jobClass).asSubclass(Job.class))
                    .withIdentity(name, group)
                    .build();

            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);
            CronTrigger trigger = TriggerBuilder
                    .newTrigger()
                    .withIdentity(name, group)
                    .withSchedule(scheduleBuilder.withMisfireHandlingInstructionDoNothing())
                    .build();
            stdScheduler.scheduleJob(jobDetail, trigger);

        } catch (Exception e) {
            logger.error("saveJob-Error:{0}", e.getMessage());
            throw e;
        }
    }

    /**
     * 通过name and group pause a job
     *
     * @param name  name
     * @param group group
     * @throws SchedulerException exception
     */
    public void pauseJob(String name, String group) throws SchedulerException {

        JobKey jobKey = new JobKey(name, group);
        if (stdScheduler.checkExists(jobKey)) {
            stdScheduler.pauseJob(jobKey);
        }
    }

    /**
     * 通过name and group resume a job
     *
     * @param name  name
     * @param group group
     * @throws SchedulerException exception
     */
    public void resumeJob(String name, String group) throws SchedulerException {

        JobKey jobKey = new JobKey(name, group);
        if (stdScheduler.checkExists(jobKey)) {
            stdScheduler.resumeJob(jobKey);
        }
    }


}

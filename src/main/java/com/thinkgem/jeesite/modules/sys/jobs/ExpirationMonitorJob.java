package com.thinkgem.jeesite.modules.sys.jobs;

import java.util.List;

import com.thinkgem.jeesite.modules.gsp.service.exception.NoSuchTypeException;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.thinkgem.jeesite.modules.gsp.service.QualificationService;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmService;

/**
 * 预警监控job
 *
 * @author huyong
 */
public class ExpirationMonitorJob extends QuartzJobBean {
    /**
     * 日志对象
     */
    protected Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private SysAlarmService sysAlarmService;

    @Override
    protected void executeInternal(JobExecutionContext context)
            throws JobExecutionException {

        //1：获取到全部预警列表
        SysAlarm sysAlarm = new SysAlarm();
        List<SysAlarm> sysAlarmList = sysAlarmService.findList(sysAlarm);

        for (SysAlarm entity : sysAlarmList) {
            //2：如果开启预警
            if (entity.getSendFlag()) {
                //3:获取预警service
                String serviceName = entity.getClassName();
                try {
                    SchedulerContext schCtx;

                    //4:获取springContext
                    schCtx = context.getScheduler().getContext();
                    ApplicationContext appCtx = (ApplicationContext) schCtx.get("applicationContext");

                    //5：调用预警service
                    Object bean=appCtx.getBean(serviceName);
                    if (bean instanceof QualificationService) {
                        QualificationService<?, ?> service = (QualificationService<?, ?>) bean;
                        service.startProcess(entity);
                    }else {
                        throw new NoSuchTypeException("预警service必须继承QualificationService","");
                    }

                } catch (Exception e) {
                    //捕获所有异常，当某一个预警service启动失败时，不影响其他预警service启动
                    logger.error("预警错误:" + serviceName + "启动失败：" + e.getMessage());
                }
            }
        }


    }

}

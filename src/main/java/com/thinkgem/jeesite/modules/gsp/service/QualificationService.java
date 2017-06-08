package com.thinkgem.jeesite.modules.gsp.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.modules.sys.service.SysAlarmFilterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.entity.SysAlarm;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmService;

@Transactional(readOnly = false)
public abstract class QualificationService<D extends CrudDao<T>, T extends DataEntity<T>> extends ExtCrudService<D, T> {
    /**
     * 流程定义KEY
     */
    private static final String PROCESS_KEY = "alarmProcess";
    @Autowired
    private SysAlarmService sysAlarmService;
    @Autowired
    private ActTaskService actTaskService;
    @Autowired
    protected SysAlarmFilterService sysalarmFilterService;

    public QualificationService(D dao) {
        super(dao);
    }

    /**
     * 启动预警流程
     *
     * @param sysAlarm
     */
    public void startProcess(SysAlarm sysAlarm) throws BusinessException {
        List<Map<String, String>> alarmList = retrieveAlarmNameList(sysAlarm);
        if (alarmList != null && !alarmList.isEmpty()) {
            //the object send to Task
            Map<String, Object> vars = Maps.newHashMap();
            vars.put("sysAlarm", sysAlarm);
            vars.put("alarmList", alarmList);

            //无论是否需要发送预警消息都将预警时间设置为当前时间
            sysAlarm.setLastAlarmTime(new Date());
            sysAlarmService.save(sysAlarm);
            actTaskService.startProcess(PROCESS_KEY, "", "", vars);
        }
    }

    /**
     * subclasses must override this method to get the data need to alarm
     *
     * @param sysAlarm alarm object
     * @return the data need to alarm
     * @throws BusinessException exception
     */
    public abstract List<Map<String, String>> retrieveAlarmNameList(SysAlarm sysAlarm) throws BusinessException;

    /**
     * 判断是否需要提醒
     *
     * @param validPeriDate 截至时间
     * @param sysAlarm      alarm实体
     * @return true：需要提醒 false：不需要提醒
     */
    public boolean checkAlarm(Date validPeriDate, SysAlarm sysAlarm) {

        boolean nearEffective = true;
        boolean needAlarm = false;

        Date now = new Date();
        if (DateUtils.getDistanceDayOfTwoDate(now, validPeriDate) > sysAlarm.getAheadTime() * 30) {
            nearEffective = false;
        }
        if (DateUtils.getDistanceDayOfTwoDate(now, validPeriDate) < 0) {
            nearEffective = false;
        }

        //距离上次预警天数
        int lastAlarmDist;
        Date lastAlarmDate = sysAlarm.getLastAlarmTime();
        if (lastAlarmDate == null) {
            lastAlarmDist = sysAlarm.getAlarmFreq();
        } else {
            lastAlarmDist = DateUtils.getDistanceDayOfTwoDate(lastAlarmDate, now);
        }

        if (lastAlarmDist >= sysAlarm.getAlarmFreq()) {
            needAlarm = true;
        }

        if (nearEffective && needAlarm) {
            return true;
        }
        return false;

    }
}

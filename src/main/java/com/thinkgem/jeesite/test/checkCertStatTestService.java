/**mokito官方网站  http://site.mockito.org/*/
/**参考示例   http://blog.csdn.net/zhoudaxia/article/details/33056093*/
package com.thinkgem.jeesite.test;


import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplStat;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.Calendar;
import java.util.Date;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class checkCertStatTestService {

    @Test
    public void testMockito(){

        Date beginDate0=DateUtils.parseDate("2016-01-01");
        Date endDate0=DateUtils.parseDate("2016-01-02");

        assertEquals(ComplSuplStat.NOT_EFFECTIVE,checkBuyerStat(beginDate0,endDate0));
    }
    @Test
    public void testMockito1(){
        Date beginDate1=DateUtils.parseDate("2018-01-01");
        Date endDate1=DateUtils.parseDate("2018-01-02");

        assertEquals(ComplSuplStat.NOT_EFFECTIVE,checkBuyerStat(beginDate1,endDate1));
    }
    @Test
    public void testMockito2(){
        Date beginDate2=DateUtils.parseDate("2017-02-07");
        Date endDate2=DateUtils.parseDate("2017-09-09");
        Date now = new Date();


       assertEquals(ComplSuplStat.EFFECTIVE,checkBuyerStat(beginDate2,endDate2));
    }

    @Test
    public void testMockito3(){
        Date beginDate3=DateUtils.parseDate("2016-01-01");
        Date endDate3=DateUtils.parseDate("2017-03-02");

        assertEquals(ComplSuplStat.NEAR_EFFECTIVE,checkBuyerStat(beginDate3,endDate3));
    }


    private String checkBuyerStat(Date beginDate, Date endDate) {
        String stat = ComplSuplStat.EFFECTIVE;
        Date now = new Date();
        if (DateUtils.getDistanceDayOfTwoDate(now, beginDate) > 0 ||
                DateUtils.getDistanceDayOfTwoDate(endDate, now) > 0) {
            stat = ComplSuplStat.NOT_EFFECTIVE;
        }else if(DateUtils.getDistanceDayOfTwoDate(now, endDate) <= 6*30){
            stat = ComplSuplStat.NEAR_EFFECTIVE;
        }
        return stat;
    }
   
}

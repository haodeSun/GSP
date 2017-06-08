package com.thinkgem.jeesite.common.job;

import java.text.SimpleDateFormat;
import java.util.Date;

public class KettleJob {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
    public void reportCurrentTime() {
        System.out.println("The time is " +dateFormat.format(new Date()));
    }
}

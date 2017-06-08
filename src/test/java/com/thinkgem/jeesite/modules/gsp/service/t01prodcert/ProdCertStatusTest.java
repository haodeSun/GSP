package com.thinkgem.jeesite.modules.gsp.service.t01prodcert;

import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.ApprStatus;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.RiskClass;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * @author JOKING
 * @since 2016/11/26
 */

public class ProdCertStatusTest {
    @Before
    public void setUp() throws Exception {


    }

    @Test
    public void testRiskClass() throws Exception {
        String name = "ONE";
        RiskClass clazz = RiskClass.valueOf(name);
        assertEquals(clazz, RiskClass.ONE);
    }

    @Test
    public void testRiskClassFromString() throws Exception {
        String name;
        RiskClass clazz = RiskClass.fromString(null);
        assertEquals(clazz, RiskClass.UNKNOWN);

        name = "1";
        clazz = RiskClass.fromString(name);
        assertEquals(clazz, RiskClass.ONE);

        name = "unknown";
        clazz = RiskClass.fromString(name);
        assertEquals(clazz, RiskClass.UNKNOWN);
    }

    @Test
    public void testApprStatusFromString() throws Exception {
        String name;
        ApprStatus clazz = ApprStatus.fromString(null);
        assertEquals(clazz, ApprStatus.UNKNOWN);

        name = "1";
        clazz = ApprStatus.fromString(name);
        assertEquals(clazz, ApprStatus.NOAPPR);

        name = "unknown";
        clazz = ApprStatus.fromString(name);
        assertEquals(clazz, ApprStatus.UNKNOWN);
    }
}
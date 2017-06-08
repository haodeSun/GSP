package com.thinkgem.jeesite.modules.local;

import com.thinkgem.jeesite.common.utils.FreeMarkers;
import com.thinkgem.jeesite.common.utils.functions.FreeMarkerAttachHandler;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;

import static org.junit.Assert.assertEquals;

/**
 * @author JOKING
 * @since 2016/11/29
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-context.xml"})
public class FreeMarkerFunctionTest {

    @Test
    public void testGetAttachLabel(){
        String str = "<div>${getAttachLabel(test)}</div>";
        HashMap<String, Object> model = new HashMap<>();
        model.put("getAttachLabel",new FreeMarkerAttachHandler());
        model.put("test","|1.jpg|2.jpg");

        String result = FreeMarkers.renderString("hello", str, model);
        assertEquals("<div><a href=\"1.jpg\" target=\"_blank\">1.jpg</a></br><a href=\"2.jpg\" target=\"_blank\">2.jpg</a></br></div>",result);
    }


}
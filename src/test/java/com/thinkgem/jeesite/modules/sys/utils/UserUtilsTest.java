package com.thinkgem.jeesite.modules.sys.utils;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertEquals;

/**
 * @author JOKING
 * @since 2016/11/26
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-context.xml"})
public class UserUtilsTest {
    @Test
    public void getAttachLabel() throws Exception {
        String attach = "|user/1_%E9%9C%80%E6%B1%82%E8%A7%84%E6%A0%BC%E8%AF%B4%E6%98%8E%E4%B9%A6-%E4%BA%A7%E5%93%81%E8%B5%84%E8%B4%A8%E7%AE%A1%E7%90%86(1).docx|/userfiles/1/files/gsp/t01prodcert/t01ProdCert/2016/11/mybatis-3_3_0.pdf|/userfiles/1/files/gsp/t01prodcert/t01ProdCert/2016/11/%E6%96%B0%E5%BB%BA%E6%96%87%E6%9C%AC%E6%96%87%E6%A1%A3.txt|/userfiles/1/files/gsp/t01prodcert/t01ProdCert/2016/11/%E6%B5%8B%E8%AF%95.jpg";

        String label = UserUtils.getAttachLabel(attach);

        assertEquals("<a href=\"user/1_%E9%9C%80%E6%B1%82%E8%A7%84%E6%A0%BC%E8%AF%B4%E6%98%8E%E4%B9%A6-%E4%BA%A7%E5%93%81%E8%B5%84%E8%B4%A8%E7%AE%A1%E7%90%86(1).docx\" target=\"_blank\">1_需求规格说明书-产品资质管理(1).docx</a></br><a href=\"/userfiles/1/files/gsp/t01prodcert/t01ProdCert/2016/11/mybatis-3_3_0.pdf\" target=\"_blank\">mybatis-3_3_0.pdf</a></br><a href=\"/userfiles/1/files/gsp/t01prodcert/t01ProdCert/2016/11/%E6%96%B0%E5%BB%BA%E6%96%87%E6%9C%AC%E6%96%87%E6%A1%A3.txt\" target=\"_blank\">新建文本文档.txt</a></br><a href=\"/userfiles/1/files/gsp/t01prodcert/t01ProdCert/2016/11/%E6%B5%8B%E8%AF%95.jpg\" target=\"_blank\">测试.jpg</a></br>",label);
    }

}
/**mokito官方网站  http://site.mockito.org/*/
/**参考示例   http://blog.csdn.net/zhoudaxia/article/details/33056093*/
package com.thinkgem.jeesite.test;

import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class MokitoTestService {
	
	@Mock
	private T01ProdCertService t01ProdCertService;
	
    @Test
    public void testMockito(){
    	T01ProdCert  t01ProdCert = new T01ProdCert();
    	t01ProdCert.setId("1");
    	t01ProdCert.setRegiCertNbr("注册证号1");
    	
    	// 验证选择性和显式调用
        try {
            t01ProdCertService.save(t01ProdCert);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        try {
            verify(t01ProdCertService ).save(t01ProdCert);
        } catch (com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException e) {
            e.printStackTrace();
        }
        //设置调用返回结果
    	when(t01ProdCertService.get("1")).thenReturn(t01ProdCert);
    	System.out.println(t01ProdCertService.get("1"));
    	  
    	assertEquals("注册证号1", t01ProdCert.getRegiCertNbr());
        
    }
  
   
}

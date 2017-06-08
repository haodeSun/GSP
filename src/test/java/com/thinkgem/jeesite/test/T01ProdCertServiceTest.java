package com.thinkgem.jeesite.test;

import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertExtService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-context.xml", "classpath:spring-context-activiti.xml"})
public class T01ProdCertServiceTest {
	@Autowired
	private T01ProdCertExtService t01ProdCertExtService;

	@Test
	public void testGetEntity(){
		T01ProdCert t = new T01ProdCert();
		t.setRegiCertNbr("999");
		
		T01ProdCert entity = t01ProdCertExtService.getLatestPassedProdCert(t);
		System.out.println(entity);
	}

}

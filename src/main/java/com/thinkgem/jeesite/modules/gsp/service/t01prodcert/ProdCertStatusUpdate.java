package com.thinkgem.jeesite.modules.gsp.service.t01prodcert;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;

public class ProdCertStatusUpdate implements JavaDelegate {

    public void execute(DelegateExecution execution) throws Exception {
        String processBusinessKey = execution.getProcessBusinessKey();
        String status = (String)execution.getVariable("status");
        System.out.println(status);
    }

}

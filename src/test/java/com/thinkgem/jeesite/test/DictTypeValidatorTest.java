package com.thinkgem.jeesite.test;

import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoService;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by XXS on 2016/12/2.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/spring-context*.xml"})
public class DictTypeValidatorTest {
    /**
     * 验证Bean实例对象
     */
    @Autowired
    private Validator validator;
    @Autowired
    private T01MatrInfoService t01MatrInfoService;

    @Test
    @Ignore
    public void test() {
        System.out.println("001");
        T01MatrInfo t01MatrInfo = t01MatrInfoService.get("06bb57f554f449928a0f0b439251c8a3");
        System.out.println("002");
        try {
            System.out.println("003");
            BeanValidators.validateWithException(validator, t01MatrInfo, Submit.class);
            System.out.println("004");
        } catch (ConstraintViolationException cvExc) {//捕获验证异常
            System.out.println("005");
            List<String> list = new ArrayList<>();
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                list.add(violation.getMessage());
            }
            list.add(0, "数据验证失败，提交审批前请完善物料信息：");
            for (String item : list) {
                System.out.println(item);
            }
        }
    }
}

package com.thinkgem.jeesite.modules.sys.utils;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import org.springframework.context.ApplicationContext;

/**
 * @author Greg Song
 * @since 25/12/2016
 */
@SuppressWarnings("unused")
public class EntityUtils {
    public static final ApplicationContext context;

    public static DataEntity getData(String beanName, String id) {
        ExtCrudService service = (ExtCrudService) context.getBean(beanName);
        if (id == null || service == null) {
            return null; // 这样做非常不安全，但是暂时只能这样
        }
        return service.get(id);
    }
    static {
        context = SpringContextHolder.getApplicationContext();
    }
}

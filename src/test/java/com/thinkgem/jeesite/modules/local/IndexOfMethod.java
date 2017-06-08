package com.thinkgem.jeesite.modules.local;

import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

import java.util.List;

/**
 * @author JOKING
 * @since 2016/11/29
 */
public class IndexOfMethod implements TemplateMethodModelEx {
    @Override
    public Object exec(List arguments) throws TemplateModelException {
        if(arguments.size()>0){
            System.out.println(arguments);
            String value = arguments.get(0).toString();
            return UserUtils.getAttachLabel(value);
        }
        return null;
    }
}

package com.thinkgem.jeesite.common.utils.functions;

import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import freemarker.template.SimpleScalar;
import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

import java.util.List;

/**
 * freemarker的自定义方法，用来在freemarker渲染模板的时候按照我们的规则处理文件上传字符串
 * @author JOKING
 * @since 2016/11/29
 */
public class FreeMarkerAttachHandler implements TemplateMethodModelEx{
    @Override
    public Object exec(List arguments) throws TemplateModelException {
        if(!arguments.isEmpty() && arguments.get(0) instanceof SimpleScalar ) {
            String value = ((SimpleScalar) arguments.get(0)).getAsString();
            return UserUtils.getAttachLabel(value);
        }
        return "";
    }
}

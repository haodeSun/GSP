package com.thinkgem.jeesite.modules.gsp.web;

import com.thinkgem.jeesite.common.web.BaseController;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Greg Song
 * @since 05/12/2016
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/")
public class DefaultController extends BaseController{
    @RequiresPermissions("gsp:dashboard:index")
    @RequestMapping(value = {"index", ""})
    public String index() {
        return "modules/gsp/gspIndex";
    }
}

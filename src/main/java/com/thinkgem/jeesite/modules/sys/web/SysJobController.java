/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.service.QuartzHelperService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.entity.SysJob;
import com.thinkgem.jeesite.modules.sys.service.QuartzManagerService;
import com.thinkgem.jeesite.modules.sys.service.SysJobService;

/**
 * 保存job信息Controller
 *
 * @author yohu
 * @version 2016-12-04
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysJob")
public class SysJobController extends BaseController {

    @SuppressWarnings("WeakerAccess")
    SysJobService sysJobService;

    @Autowired
    private QuartzManagerService quartzManagerService;

    @Autowired
    private QuartzHelperService quartzHelperService;

    @Autowired
    public SysJobController(SysJobService sysJobService) {
        Assert.notNull(sysJobService);
        this.sysJobService = sysJobService;
    }

    @ModelAttribute
    public SysJob get(@RequestParam(required = false) String id) {
        SysJob entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = sysJobService.get(id);
        }
        if (entity == null) {
            entity = new SysJob();
        }
        return entity;
    }

    @RequiresPermissions("sys:sysJob:view")
    @RequestMapping(value = {"list", ""})
    public String list(SysJob sysJob, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SysJob> page = sysJobService.findPage(new Page<>(request, response), sysJob);
        model.addAttribute("page", page);
        return "modules/sys/sysJobList";
    }

    @RequiresPermissions("sys:sysJob:view")
    @RequestMapping(value = "form")
    public String form(SysJob sysJob, Model model, String view) {
        model.addAttribute("sysJob", sysJob);
        if (view != null && !view.isEmpty()) {
            return view;
        }
        return "modules/sys/sysJobForm";
    }

    @RequiresPermissions("sys:sysJob:edit")
    @RequestMapping(value = "save")
    public String save(
            SysJob sysJob,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, sysJob)) {
            return form(sysJob, model, null);
        }
        try {
            sysJobService.save(sysJob);
            try {
                quartzHelperService.saveJob(sysJob.getClazzName(), sysJob.getJobName(), sysJob.getJobGroup(), sysJob.getExpression());
            }catch (Exception e){
                logger.error(e.getMessage());
            }
        } catch (Exception e) {
            String message = e.getMessage();
            if (message != null && !message.isEmpty()) {
                String[] mess = message.split(",");
                if (mess.length >= 2) {
                    message = mess[0];
                }
                addMessage(redirectAttributes, message);
            }
            return form(sysJob, model, null);
        }
        addMessage(redirectAttributes, "保存任务表成功");
        return "redirect:" + Global.getAdminPath() + "/sys/sysJob/?repage";
    }

    @RequiresPermissions("sys:sysJob:edit")
    @RequestMapping(value = "delete")
    public String delete(
            SysJob sysJob,
            RedirectAttributes redirectAttributes) {
        try {
            sysJobService.delete(sysJob);
        } catch (BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "删除任务表成功");
        return "redirect:" + Global.getAdminPath() + "/sys/sysJob/?repage";
    }

    @RequestMapping(value = "pauseJob")
    public String pauseJob(SysJob sysJob) throws BusinessException {

        sysJob = sysJobService.get(sysJob.getId());
        sysJob.setJobStatus("暂停");
        sysJobService.save(sysJob);
//        quartzManagerService.pauseJob(sysJob.getJobName());
        try {
            quartzHelperService.pauseJob(sysJob.getJobName(),sysJob.getJobGroup());
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
        return "redirect:" + Global.getAdminPath() + "/sys/sysJob/?repage";
    }

    @RequestMapping(value = "resumeJob")
    public String resumeJob(SysJob sysJob) throws BusinessException {

        sysJob = sysJobService.get(sysJob.getId());
        sysJob.setJobStatus("正常");
        sysJobService.save(sysJob);
//        quartzManagerService.resumeJob(sysJob.getJobName());
        try {
            quartzHelperService.resumeJob(sysJob.getJobName(),sysJob.getJobGroup());
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
        return "redirect:" + Global.getAdminPath() + "/sys/sysJob/?repage";
    }
}
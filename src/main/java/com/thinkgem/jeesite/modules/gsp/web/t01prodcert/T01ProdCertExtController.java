/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01prodcert;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.json.JsonResponseCode;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.SysChanInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.ChanValidateException;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.ApprStatus;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.thinkgem.jeesite.common.json.JsonResponseCode.*;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.ApprStatus.*;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.CertType.CHANGE;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.CertType.EXTEND;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.IsAppr;

/**
 * 产品资质Controller
 *
 * @author gyq
 * @version 2016-11-02
 */
@SuppressWarnings("MVCPathVariableInspection")
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01prodcert/t01ProdCert")
public class T01ProdCertExtController extends T01ProdCertController {

    private final TaskService taskService;

    @Autowired
    public T01ProdCertExtController(
            T01ProdCertService t01ProdCertService,
            T01ProdCertExtService t01ProdCertExtService,
            TaskService taskService) {
        super(t01ProdCertService,t01ProdCertExtService);
        this.taskService = taskService;
    }

    @RequestMapping("getRecord")
    @ResponseBody
    public Object getRecord(T01ProdCert entity) {
        T01ProdCert latestProdCert;
        try {
            if(entity != null){
                if(StringUtils.isBlank(entity.getRegiCertNbr())){
                    return JsonResponse.create(FAILED, getText("请输入资质证号！"), "");
                }
//                latestProdCert = t01ProdCertExtService.getLatestPassedProdCert(entity);
                //修改start
                latestProdCert = t01ProdCertExtService.checkIfChangeOrExtend(entity.getRegiCertNbr());
                if (latestProdCert == null) {
                    T01ProdCert t01ProdCertSearch = new T01ProdCert();

                    t01ProdCertSearch.setRegiCertNbr(entity.getRegiCertNbr());
                    List<T01ProdCert> t01ProdCertList = t01ProdCertExtService.findList(t01ProdCertSearch).stream()
                            .filter(item -> entity.getRegiCertNbr().equals(item.getRegiCertNbr()))
                            .collect(Collectors.toList());
                    if (t01ProdCertList != null && !t01ProdCertList.isEmpty()) {
                        if (ApprStatus.PASS.toString().equals(t01ProdCertList.get(0).getApprStat())) {
                            return JsonResponse.create(SUCCESS, getText("ok"), t01ProdCertList.get(0));
                        } else {
                            return JsonResponse.create(FAILED,getText("只有审批通过的资质才能进行变更或延续！"),latestProdCert);
                        }
                    } else {
                        throw new NullPointerException();
                    }
                } else {
                    if (ApprStatus.PASS.toString().equals(latestProdCert.getApprStat())) {
                        return JsonResponse.create(FAILED, getText("资质\"" + entity.getRegiCertNbr() + "\"" +
                                "已经变为：" + latestProdCert.getRegiCertNbr()), latestProdCert);
                    } else {
                        return JsonResponse.create(FAILED, getText("该注册证已经有变更或延续的记录！"), "");
                    }
                }
                //修改end
            }else{
                return JsonResponse.create(FAILED, getText("系统错误，请稍后重试！"), "");
            }
        }catch (NullPointerException e){
            return JsonResponse.create(FAILED, getText("对不起，没有找到你查询的记录！"), e.getMessage());
        }catch (Exception e){
            return JsonResponse.create(FAILED, getText("查询数据失败，请稍后重试！"), e.getMessage());
        }

//        if (null == latestProdCert) {
//            return JsonResponse.create(FAILED, getText("没有找到该资质！"), null);
//        }
//        if(ApprStatus.equals(PASS,latestProdCert.getApprStat())){
//            if(!entity.getRegiCertNbr()
//                    .equals(latestProdCert.getRegiCertNbr())){
//                return JsonResponse.create(FAILED,getText("资质\""+entity.getRegiCertNbr()+"\"" +
//                        "已经变为："+latestProdCert.getRegiCertNbr()),latestProdCert);
//            }
//            return JsonResponse.create(SUCCESS, getText("ok"), latestProdCert);
//        }else if(ApprStatus.equals(NOAPPR,latestProdCert.getApprStat())
//                || ApprStatus.equals(NOPASS,latestProdCert.getApprStat())){
//            return JsonResponse.create(FAILED,getText("审批没有通过的资质不能进行变更或延续！"),latestProdCert);
//        }
//        return JsonResponse.create(FAILED,getText("还没有提交审批的资质不能进行变更或延续！"),latestProdCert);
    }

    /**
     * 跳转到变更页方法
     * @param method 当前跳转是修改还是第一次变更，修改就传update，否则为空
     * @param t01ProdCert 修改时带到页面上的资质信息
     * @param model model对象
     * @return 返回变更view
     */
    @RequestMapping("toChan")
    @RequiresPermissions("gsp:t01prodcert:t01ProdCert:chan")
    public String toChan(
            @RequestParam(required = false)String method,
            T01ProdCert t01ProdCert,
            Model model) {
        //不需要变更的字段信息，以后可能改为配置形式,"effeDate", 592生效日期可以变更
        String[] fields = {"origRegiCertNbr", "regiCertNbr", "validPeri", "attachment","certType"};
        model.addAttribute("fields", fields);
        t01ProdCertExtService.handleAct(t01ProdCert);
        T01ProdCert prodCert = new T01ProdCert();
        // 如果参数method不为空并且为 update 时，说明是更新，就拿到原资质信息，和变更历史
        if(StringUtils.isNotBlank(method)
                && "update".equals(method)) {
            prodCert = handlerChanAndExtendUpdate(t01ProdCert, model);
        }else{
            // 否则就是第一次变更，直接查询源资质
            if(StringUtils.isNotBlank(t01ProdCert.getId())) {
                prodCert = t01ProdCertExtService.get(t01ProdCert.getId());
            }
        }
        List<SysChanInfo> list = t01ProdCert.getSysChanInfoList();
        //设置变更后的值
        if(!list.isEmpty()){
            // 清除主表数据，只保留主表id
            list.forEach(chanInfo -> chanInfo.setChanId(new T01ProdCert(t01ProdCert.getId())));
            prodCert.setSysChanInfoList(list);
        }
        //设置注册证号和原注册证号
        prodCert.setOrigRegiCertNbr(t01ProdCert.getOrigRegiCertNbr());
        prodCert.setRegiCertNbr(t01ProdCert.getRegiCertNbr());
        //如果变更记录中的id 都为空，则认为是首测变更的时候出问题了
        model.addAttribute("t01ProdCert", prodCert);
        return "modules/gsp/t01prodcert/t01ProdCertChanForm";
    }

    /**
     * 跳转到延续页方法
     * @param method 当前跳转是修改还是第一次延续，修改就传update，否则为空
     * @param t01ProdCert 修改时带到页面上的资质信息
     * @param model model对象
     * @return 返回延续view
     */
    @RequestMapping("toExtend")
    @RequiresPermissions("gsp:t01prodcert:t01ProdCert:conti")
    public String toExtend(
            @RequestParam(required = false) String method,
            T01ProdCert t01ProdCert,
            Model model) {
        //不需要变更的字段信息，以后可能改为配置形式
        String[] fields = {"origRegiCertNbr", "regiCertNbr", "attachment","certType"};
        model.addAttribute("fields", fields);
        t01ProdCertExtService.handleAct(t01ProdCert);
        T01ProdCert prodCert = new T01ProdCert();
        // 如果参数method不为空并且为 update 时，说明是更新，就拿到源资质信息，和变更历史
        if(StringUtils.isNotBlank(method)
                && "update".equals(method)) {
            prodCert = handlerChanAndExtendUpdate(t01ProdCert, model);
        }else{
            // 否则就是第一次变更，直接查询源资质
            if(StringUtils.isNotBlank(t01ProdCert.getId())) {
                prodCert = t01ProdCertExtService.get(t01ProdCert.getId());
            }
        }
        List<SysChanInfo> list = t01ProdCert.getSysChanInfoList();
        //设置变更后的值
        if(!list.isEmpty()){
            // 清除主表数据，只保留主表id
            list.forEach(chanInfo -> chanInfo.setChanId(new T01ProdCert(t01ProdCert.getId())));
            prodCert.setSysChanInfoList(list);
        }
        //设置注册证号和原注册证号
        prodCert.setOrigRegiCertNbr(t01ProdCert.getOrigRegiCertNbr());
        prodCert.setRegiCertNbr(t01ProdCert.getRegiCertNbr());
        //如果变更记录中的id 都为空，则认为是首测变更的时候出问题了
        model.addAttribute("t01ProdCert", prodCert);
        return "modules/gsp/t01prodcert/t01ProdCertContinueForm";
    }

    private T01ProdCert handlerChanAndExtendUpdate(T01ProdCert t01ProdCert, Model model){
        T01ProdCert prodCert = new T01ProdCert();
        if(t01ProdCert != null){
            //如果是修改，就查询字表信息，也就是变更记录
            prodCert = t01ProdCertExtService.getParentWithChanHistory(t01ProdCert);
            List<SysChanInfo> list = prodCert.getSysChanInfoList();
            if (!list.isEmpty()
                    && (CHANGE.toString().equals(t01ProdCert.getCertType())
                    || EXTEND.toString().equals(t01ProdCert.getCertType()))) {
                model.addAttribute("currId", t01ProdCert.getId());
            }
            //将变更时上传的附件带回到页面上
            prodCert.setAttachment(t01ProdCert.getAttachment());
            prodCert.setProcInsId(t01ProdCert.getProcInsId());
            //将原来的流程数据带到页面上
            prodCert.setAct(t01ProdCert.getAct());
        }
        return prodCert;
    }

    /**
     * 跳转到审批详情页方法
     * @param conditionOrder 保存查询条件
     * @param t01ProdCert 需要审批的资质信息
     * @param request 请求对象
     * @param response 响应对象
     * @param model model
     * @return 返回审批页数据
     */
    @RequestMapping("toAppr")
    @RequiresPermissions("gsp:t01prodcert:t01ProdCert:approve")
    public String toAppr(
            @RequestParam(required = false) String conditionOrder,
            T01ProdCert t01ProdCert,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        try {
            //设置默认条件
            t01ProdCert.setApprStat(ApprStatus.NOAPPR.toString());
            Page<T01ProdCert> page = t01ProdCertService.findPage(new Page<>(request, response), t01ProdCert);
            model.addAttribute("page", page);
            //保存上次查询条件
            model.addAttribute("conditionOrder", conditionOrder);
//            if (page.getList().isEmpty()) {
//                addMessage(model, "没有查到你要找的记录！");
//            }
        } catch (Exception e) {
            logger.error("查询列表出错：" + e.getMessage());
            addMessage(model, "查询列表出错！");
            return "modules/gsp/t01prodcert/t01ProdCertApprList";
        }
        return "modules/gsp/t01prodcert/t01ProdCertApprList";
    }

    /**
     * 产品自主删除列表页
     * @param t01ProdCert entity
     * @param request request
     * @param response response
     * @param model model
     * @param conditionOrder conditionOrder
     * @return view
     */
    @RequestMapping("toDelete")
    @RequiresPermissions("gsp:t01prodcert:t01ProdCert:delete")
    public String toDelete(
            T01ProdCert t01ProdCert,
            HttpServletRequest request,
            HttpServletResponse response, Model model,
            @RequestParam(required = false) String conditionOrder) {
        try {
            Page<T01ProdCert> page = t01ProdCertService.findPage(new Page<>(request, response), t01ProdCert);
            model.addAttribute("page", page);
            model.addAttribute("conditionOrder", conditionOrder);
//            if (page.getList().isEmpty()) {
//                addMessage(model, "没有查到你要找的记录！");
//            }
        }catch (Exception e){
            logger.error("查询列表出错："+e.getMessage());
            addMessage(model, "查询列表出错！");
            return "modules/gsp/t01prodcert/t01ProdCertDeleteList";
        }
        return "modules/gsp/t01prodcert/t01ProdCertDeleteList";
    }

    /**
     * 审批页审批任务
     * @param prodCertId 业务数据id
     * @param conditionOrder 查询排序
     * @param t01ProdCert 查询条件
     * @param request request
     * @param response 相应对象
     * @param model model
     * @return 页面数据
     */
    @RequestMapping("toDoTask")
    @RequiresPermissions("gsp:t01prodcert:t01ProdCert:audit")
    public String toDoTask(
            @RequestParam() String prodCertId,
            @RequestParam(required = false) String conditionOrder,
            T01ProdCert t01ProdCert,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model){
        boolean isOwnerTask;
        if(StringUtils.isBlank(prodCertId)){
            addMessage(model,getText("审批任务出错！"));
            return toAppr(conditionOrder,t01ProdCert,request,response,model);
        }
        Task task;
        try{
            T01ProdCert prodCert = t01ProdCertService.get(prodCertId);
            if(NOSUBMIT.toString().equals(prodCert.getApprStat())
                    || StringUtils.isBlank(prodCert.getProcInsId())){
                throw new ApprStatusException(getText("该资质处于未提交状态，不能审批！"),"");
            }else if(PASS.toString().equals(prodCert.getApprStat())){
                throw new ApprStatusException(getText("该资质已经通过审批，不能再次审批！"),"");
            }else if(NOPASS.toString().equals(prodCert.getApprStat())){
                throw new ApprStatusException(getText("该资质审批未通过，修改提交之后再审批！"),"");
            }
            String userId = UserUtils.getUser().getLoginName();
            task = taskService.createTaskQuery()
                    .taskCandidateOrAssigned(userId)
                    .processInstanceId(prodCert.getProcInsId())
                    .includeProcessVariables()
                    .active()
                    .orderByTaskCreateTime().desc()
                    .singleResult();

            if (task == null) {
                addMessage(model,"前往审批页失败，此任务不在您的审批范围内！");
                return toAppr(conditionOrder,t01ProdCert,request,response,model);
            }
            isOwnerTask = checkAndClaimTaskOwner(task, userId);
        }catch (BusinessException e){
            addMessage(model,getText(e.getMessage()));
            return toAppr(conditionOrder,t01ProdCert,request,response,model);
        }catch (Exception e){
            addMessage(model,getText("系统出错！"));
            return toAppr(conditionOrder,t01ProdCert,request,response,model);
        }
        if(isOwnerTask){
            request.getSession().setAttribute("view","redirect:"+adminPath+"/gsp/t01prodcert/t01ProdCert/toAppr");
            return "forward:" + Global.getAdminPath() + "/act/task/form?taskId="+task.getId()
                    +"&taskName="+task.getName()
                    +"&taskDefKey="+task.getTaskDefinitionKey()
                    +"&procInsId="+task.getProcessInstanceId()
                    +"&procDefId="+task.getProcessDefinitionId()
                    +"&status=todo";
        }else{
            addMessage(model,getText("前往审批页失败，此任务不在您的审批范围内！"));
            return toAppr(conditionOrder,t01ProdCert,request,response,model);
        }
    }

    /**
     * 判断用户是否可以执行特定任务
     * @param task Activiti 流程任务
     * @param userId 用户id
     * @return true：传入用户能够执行该任务；false：反之
     */
    private boolean checkAndClaimTaskOwner(Task task, String userId) {
        boolean isOwnerTask;
        if (task == null) {
            //这个任务不属于当前用户
            isOwnerTask = false;
        } else {
            //任务候选用户（或组）中包含当前用户，则自动签收
            taskService.claim(task.getId(), userId);
            //task.setAssignee(userId);
            isOwnerTask = true;
        }

        return isOwnerTask;
    }

    /**
     * 删除产品资质
     * @param t01ProdCert entity
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequestMapping("deleteProdCert")
    @RequiresPermissions("gsp:t01prodcert:t01ProdCert:delete")
    public String deleteProdCert(
            T01ProdCert t01ProdCert,
            RedirectAttributes redirectAttributes) {
        String result;
        try{
            result=t01ProdCertExtService.deleteProdCert(t01ProdCert);
        }catch (BusinessException|NullPointerException e1){
            addMessage(redirectAttributes, getText(e1.getMessage()));
            return "redirect:"+Global.getAdminPath()+"/gsp/t01prodcert/t01ProdCert/toDelete?repage";
        }catch (Exception e2){
            addMessage(redirectAttributes, "删除失败,系统错误");
            return "redirect:"+Global.getAdminPath()+"/gsp/t01prodcert/t01ProdCert/toDelete?repage";
        }
        addMessage(redirectAttributes, getText(result));
        return "redirect:"+Global.getAdminPath()+"/gsp/t01prodcert/t01ProdCert/toDelete?repage";
    }


    @ResponseBody
    @RequestMapping(value = "startAudit")
    public Object startAudit(@RequestParam() String prodCertId) {
        /*
          返回结果格式
          {
              code："1";
              data：object;
              message: "提示信息";
          }
         */
        T01ProdCert t01ProdCert;
        try {
             t01ProdCert = t01ProdCertService.get(prodCertId);
        }catch (Exception e){
            logger.error("查询数据库出错："+e.getMessage());
            return JsonResponse.create(
                    JsonResponseCode.FAILED,
                    getText("开启流程失败！"),
                    getText("查询数据库出问题！"));

        }

        String procInsId = t01ProdCert.getProcInsId();
        if (StringUtils.isNoneBlank(procInsId)) {
            return JsonResponse.create(APPROVING_DONE, getText("该记录正在审批或已经通过审批！"), null);
        }
        try {
            t01ProdCertExtService.startProcess(t01ProdCert.getId(),t01ProdCert.getAct().getTaskId());
        }catch (ConstraintViolationException cvExc) {//捕获验证异常
            String message = "";
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                message +=violation.getMessage();
            }
            return JsonResponse.create(SUCCESS, getText(message), null);
        } catch (BusinessException | NullPointerException e) {
            logger.error(e.getMessage());
            return JsonResponse.create(FAILED_2_START_TASK, getText(e.getMessage()), e.getMessage());
        }catch(Exception e) {
            logger.error(e.getMessage());
            return JsonResponse.create(FAILED_2_START_TASK, getText("流程开启失败，请稍后重试！"), e.getMessage());
        }
        return JsonResponse.create(SUCCESS, getText("审批流程提交成功！"), null);
    }

    @RequiresPermissions("gsp:t01prodcert:t01ProdCert:view")
    @RequestMapping(value = {"listAlarm"})
    public String listAlarm(
            T01ProdCert t01ProdCert,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01ProdCert> page = t01ProdCertService.findPage(
                new Page<>(request, response),
                t01ProdCert);
        model.addAttribute("page", page);
        return "modules/gsp/t01prodcert/t01ProdAlarm";
    }

    /**
     * 产品资质文件导出方法
     * @param ids 页面选择的导出资质 id 数组
     * @param t01ProdCert 查询条件
     * @param response 响应对象
     * @param redirectAttributes 数据传输对象
     * @return 导出的excel数据
     */
    @RequestMapping(value = "export", method = RequestMethod.POST)
    public String exportFile(
            String[] ids,
            T01ProdCert t01ProdCert,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {
        List<T01ProdCert> list = new ArrayList<>();
        try {
            List<T01ProdCert> finalList = list;
            //用户选择了到处条目
            if (ids != null && ids.length>0) {
                Arrays.stream(ids)
                        .filter(StringUtils::isNotBlank)
                        .forEach(id -> finalList.add(t01ProdCertService.get(id)));
            }else{
                list = t01ProdCertService.findList(t01ProdCert);
            }
            String fileName = "资质数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            new ExportExcel(getText("产品资质数据"), T01ProdCert.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, getText("导出数据失败！失败信息：") + e.getMessage());
        }
        return "redirect:" + adminPath + "/gsp/t01prodcert/t01ProdCert/list?repage";
    }

    /**
     * 获取资质的详情页
     * @param t01ProdCert 需要展示详情的资质数据
     * @param model model对象
     * @param redirectAttributes redirect数据传输对象
     * @return 返回详情页数据
     */
    @RequestMapping("details")
    public String getDetails(T01ProdCert t01ProdCert, Model model, RedirectAttributes redirectAttributes) {

        if(t01ProdCert != null && StringUtils.isNotBlank(t01ProdCert.getId())) {
            T01ProdCert prodCert = t01ProdCertExtService.getOwnerWithChanHistory(t01ProdCert);
            List<T01ProdCert> list = t01ProdCertExtService.getHistory(t01ProdCert);
            List<T01MatrInfo> matrInfoList = t01ProdCertExtService.getMatrInfoList(t01ProdCert);
            list = list.stream().filter(
                    prd -> !t01ProdCert.getId().equals(prd.getId())).collect(Collectors.toList());
            model.addAttribute("t01ProdCert", prodCert);
            model.addAttribute("history", list);
            model.addAttribute("matrInfoList",matrInfoList);
            return "modules/gsp/t01prodcert/t01ProdCertDetail";
        }else{
            addMessage(redirectAttributes, getText("获取详情出错！"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01prodcert/t01ProdCert/?repage";
        }
    }

    /**
     * 修改之前的检查
     * 这个方法暂时没用了
     * @param t01ProdCert 当前修改的数据
     * @return 检查结果
     */
    @RequestMapping("beforeUpdate")
    @ResponseBody
    public Object beforeUpdate(T01ProdCert t01ProdCert){
        if(t01ProdCert != null){
            String apprStat = t01ProdCert.getApprStat();
            if(NOAPPR.toString().equals(apprStat) || PASS.toString().equals(apprStat)){
                return JsonResponse.create(FAILED,getText("该记录已经进入审批流程或已通过审批，不可修改！"),null);
            }
            return JsonResponse.create(SUCCESS,getText("ok"),null);
        }
        return JsonResponse.create(FAILED,getText("没有找到该条记录！"),null);
    }

    /**
     * TODO 这个方法里面包含了太多的业务逻辑，需要重构到Service层
     * 变更保存
     * @param t01ProdCert 产品资质
     * @param model View Model
     * @param redirectAttributes redirect attributes
     * @return view url
     */
    @RequestMapping("chanSave")
    public String chanSave(
            @RequestParam(required = false) String currId,
            T01ProdCert t01ProdCert,
            Model model,
            RedirectAttributes redirectAttributes) {
        String view = "redirect:" + Global.getAdminPath() + "/gsp/t01prodcert/t01ProdCert?repage";
        model.addAttribute("t01ProdCert",t01ProdCert);
        model.addAttribute("currId",currId);
        if (StringUtils.isBlank(t01ProdCert.getId())){
            model.addAttribute("message",getText("系统错误！"));
            return toChan("",t01ProdCert,model);
        }
        try {
            T01ProdCert prodCert = t01ProdCertService.get(t01ProdCert.getId());
            if (prodCert == null) {
                model.addAttribute("message",getText("找不到对应的变更记录"));
                return toChan("",t01ProdCert, model);
            }
            if(!prodCert.getRegiCertNbr().equals(t01ProdCert.getRegiCertNbr())){
                throw new ChanValidateException(i18nHelper.getText("资质证号不正确！"),"");
            }
            //做一些变更时基础验证,上传附件的验证
            t01ProdCertExtService.chanValidate(t01ProdCert, prodCert);
            t01ProdCert.setOrigRegiCertNbr("");
            t01ProdCert.setCertType(CHANGE.toString());

            if(StringUtils.isBlank(currId)) {
                //没有currId就是变更，或者延续，否则为修改
                t01ProdCertExtService.saveChanOrExtend(t01ProdCert);
            }else {
                //设置审批状态
                t01ProdCertExtService.apprStatHandle(t01ProdCert);
                t01ProdCertExtService.updateChanOrExtend(t01ProdCert,currId);
            }
            addMessage(model,getText("资质保存成功！"));
        }catch (ConstraintViolationException cvExc) {//捕获验证异常
            String message = "";
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                message +=violation.getMessage()+"</br>";
            }
            addMessage(model,getText("数据校验失败:"+message));
            if(StringUtils.isNotBlank(currId)){
                return toChan("update",t01ProdCert,model);
            }
            return toChan("",t01ProdCert,model);
        } catch (BusinessException e) {
            logger.error(getText("资质变更失败！"),e.getMessage());
            addMessage(model,getText(e.getMessage()));
            if(StringUtils.isNotBlank(currId)){
                return toChan("update",t01ProdCert,model);
            }
            return toChan("",t01ProdCert,model);
        } catch (Exception e){
            addMessage(model,getText("数据库错误！"));
            if(StringUtils.isNotBlank(currId)){
                return toChan("update",t01ProdCert,model);
            }
            return toChan("",t01ProdCert,model);
        }
        //如果是提交，则开启流程
        if(IsAppr.yes(t01ProdCert.getIsappr())){
            try{
                t01ProdCertExtService.startProcess(
                        t01ProdCert.getId(),
                        t01ProdCert.getAct().getTaskId()
                );
                addMessage(redirectAttributes,getText("数据保存成功，流程开启成功！"));
                return view;
            }catch (ConstraintViolationException cvExc) {//捕获验证异常
                List<String> list = new ArrayList<>();
                for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                    list.add(violation.getMessage());
                }
                list.add(0, getText("数据验证失败，提交审批前请完善资质信息："));
                addMessage(model, list.toArray(new String[]{}));
                return toChan("update",t01ProdCert,model);
            }catch (BusinessException e){
                logger.error(getText("流程启动失败："),e.getMessage());
                model.addAttribute("message",getText(e.getMessage()));
                return toChan("update",t01ProdCert,model);
            }catch (Exception e){
                logger.error(getText("流程启动失败："),e.getMessage());
                model.addAttribute("message",getText("流程开启失败，已经保存！"));
                return toChan("update",t01ProdCert,model);
            }
        }else {
            return toChan("update", t01ProdCert, model);
        }
    }

    /**
     * 延续保存
     */
    @RequestMapping("extendSave")
    public String extendSave(
            @RequestParam(required = false) String currId,
            T01ProdCert t01ProdCert,
            Model model,
            RedirectAttributes redirectAttributes) {
        String view = "redirect:" + Global.getAdminPath() + "/gsp/t01prodcert/t01ProdCert?repage";
        model.addAttribute("t01ProdCert",t01ProdCert);
        model.addAttribute("currId",currId);
        if (StringUtils.isBlank(t01ProdCert.getId())){
            model.addAttribute("message",getText("系统错误，请重试！"));
            return toExtend("",t01ProdCert,model);
        }
        try {
            T01ProdCert prodCert = t01ProdCertService.get(t01ProdCert.getId());
            //做一些变更时基础验证，上传附件的验证
            t01ProdCertExtService.chanValidate(t01ProdCert, prodCert);
            t01ProdCertExtService.extendValidate(t01ProdCert,prodCert);

            t01ProdCert.setCertType(EXTEND.toString());
            if(StringUtils.isBlank(currId)) {
                //没有currId就是变更，或者延续，否则为修改
                t01ProdCertExtService.saveChanOrExtend(t01ProdCert);
            }else {
                t01ProdCertExtService.updateChanOrExtend(t01ProdCert,currId);
            }
            addMessage(model,getText("资质保存成功！"));
        }catch (ConstraintViolationException cvExc) {//捕获验证异常
            String message = "";
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                message +=violation.getMessage()+"</br>";
            }
            addMessage(model,getText(" 数据校验失败:"+message));
            if(StringUtils.isNotBlank(currId)){
                return toExtend("update",t01ProdCert,model);
            }
            return toExtend("",t01ProdCert,model);
        }catch (BusinessException e) {
            logger.error(getText("资质延续失败！"),e.getMessage());
            model.addAttribute("message",getText(e.getMessage()));
            if(StringUtils.isNotBlank(currId)){
                return toExtend("update",t01ProdCert,model);
            }
            return toExtend("",t01ProdCert,model);
        } catch (Exception e){
            addMessage(model,getText("数据库错误！"));
            if(StringUtils.isNotBlank(currId)){
                return toExtend("update",t01ProdCert,model);
            }
            return toExtend("",t01ProdCert,model);
        }
        //如果是提交，则开启流程
        if(IsAppr.YES.toString().equals(t01ProdCert.getIsappr())){
            try{
                t01ProdCertExtService.startProcess(t01ProdCert.getId(),t01ProdCert.getAct().getTaskId());
            }catch (ConstraintViolationException cvExc) {//捕获验证异常
                String message = "";
                for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                    message +=violation.getMessage()+"</br>";
                }
                addMessage(model,getText("数据校验失败:"+message));
                return toExtend("update",t01ProdCert,model);
            }catch (BusinessException e){
                logger.error(getText("流程启动失败 ："),e.getMessage());
                model.addAttribute("message",getText(e.getMessage()));
                return toExtend("update",t01ProdCert,model);
            }catch (Exception e){
                logger.error(getText("流程启动失败 ："),e.getMessage());
                model.addAttribute("message",getText("流程开启失败，数据已经保存！"));
                return toExtend("update",t01ProdCert,model);
            }
            addMessage(redirectAttributes,getText("数据保存成功，流程开启成功！"));
            return view;
        }else{
            return toExtend("update",t01ProdCert,model);
        }
    }

    /**
     * 带审批状态的唯一性检查
     * @param prodCertNo 注册证号
     * @return json
     */
    @RequestMapping("uniqueValid")
    @ResponseBody
    public Object uniqueValid(String prodCertNo){
        boolean result = t01ProdCertExtService.uniqueCheck(prodCertNo);
        if(result){
            return JsonResponse.create(SUCCESS,getText("ok"),null);
        }
        return JsonResponse.create(FAILED,getText("已经存在相同名称的注册证号！"),null);
    }

    /**
     * 和所有数据检查唯一性
     * @param prodCertNo 注册证号
     * @return json
     */
    @RequestMapping("uniqueForAll")
    @ResponseBody
    public Object uniqueForAll(String prodCertNo){
        boolean result;
        try{
            if(StringUtils.isBlank(prodCertNo)){
                return JsonResponse.create(FAILED,getText("请输入注册证号！"),null);
            }
            result = t01ProdCertExtService.uniqueCheckAll(prodCertNo,null);
        }catch (NullPointerException e){
            return JsonResponse.create(SUCCESS,getText("ok"),e.getMessage());
        }
        if(result){
            return JsonResponse.create(SUCCESS,getText("ok"),null);
        }
        return JsonResponse.create(FAILED,getText("已经存在相同名称的注册证号！"),null);
    }

    /**
     * 审批详情页获取变更历史
     * @param t01ProdCert 获取变更历史的资质
     * @return 变更的字段名
     */
    @ResponseBody
    @RequestMapping("getChanInfo")
    public Object getChanInfo(T01ProdCert t01ProdCert){
        List<String> result = new ArrayList<>();
        if(StringUtils.isBlank(t01ProdCert.getId())){
            return result;
        }
        //获取当前资质的变更历史
        t01ProdCert = t01ProdCertExtService.getOwnerWithChanHistory(t01ProdCert);
        List<SysChanInfo> infoList = t01ProdCert.getSysChanInfoList();
        //将其添加到一个list中，并返回
        infoList.forEach(chanInfo -> result.add(chanInfo.getChanCol()));
        return result;
    }
}
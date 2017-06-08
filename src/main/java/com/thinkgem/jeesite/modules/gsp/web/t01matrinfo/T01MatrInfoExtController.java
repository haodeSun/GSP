/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01matrinfo;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrsync.T01MatrSync;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01matrsync.T01MatrSyncService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

import static com.thinkgem.jeesite.modules.gsp.web.t01matrinfo.ImportStatus.*;

/**
 * 物料信息Controller
 *
 * @author xuxiaoshuo
 * @version 2016-11-22
 */
@SuppressWarnings("MVCPathVariableInspection")
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01matrinfo/t01MatrInfo")
public class T01MatrInfoExtController extends T01MatrInfoController {

    private final T01MatrInfoExtService t01MatrInfoExtService;
    @SuppressWarnings("WeakerAccess")
    T01MatrSyncService t01MatrSyncService;

    @Autowired
    public T01MatrInfoExtController(
            T01MatrInfoService t01MatrInfoService,
            T01MatrSyncService t01MatrSyncService,
            T01MatrInfoExtService t01MatrInfoExtService) {
        super(t01MatrInfoService, t01MatrInfoExtService);
        Assert.notNull(t01MatrSyncService);
        this.t01MatrSyncService = t01MatrSyncService;
        this.t01MatrInfoExtService = t01MatrInfoExtService;
    }

    /**
     * 跳转审批详情页
     * @param conditionOrder conditionOrder
     * @param t01MatrInfo entity
     * @param request request
     * @param response response
     * @param model model
     * @return view
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:appr")
    @RequestMapping(value = {"toApprDetail"})
    public String toApprDetail(
            @RequestParam(required = false) String conditionOrder,
            T01MatrInfo t01MatrInfo,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {

        try {
            t01MatrInfoExtService.getTaskInfo(t01MatrInfo);
        } catch (NullPointerException | BusinessException e) {
            addMessage(model, getText(e.getMessage()));
            return toAppr(conditionOrder, new T01MatrInfo(), request, response, model);
        }catch (Exception e2){
            addMessage(model, getText("前往审批页失败，系统错误"));
            logger.error(e2.getMessage());
            return toAppr(conditionOrder, new T01MatrInfo(), request, response, model);
        }
        request.getSession().setAttribute("view","redirect:"+adminPath+"/gsp/t01matrinfo/t01MatrInfo/toAppr");
        return "forward:" + Global.getAdminPath() + "/act/task/form?"
                + "taskId=" + t01MatrInfo.getAct().getTaskId()
                + "&taskName=" + t01MatrInfo.getAct().getTaskName()
                + "&taskDefKey=" + t01MatrInfo.getAct().getTaskDefKey()
                + "&procInsId=" + t01MatrInfo.getAct().getProcInsId()
                + "&procDefId=" + t01MatrInfo.getAct().getProcDefId()
                + "&status=todo";
    }


    @RequestMapping(
            value="get-all-matr",
            name="get_all_matr",
            method = RequestMethod.GET
    )
    @ResponseBody
    public List<Map<String, Object>> getAllMatr(){
        return t01MatrInfoService.findList(new T01MatrInfo())
                .stream()
                .filter( b -> true ) // TODO 过滤已经被变更过的记录
                .map(matr -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", matr.getId());
                    map.put("pId", null);
                    // TODO 这里可能要考虑给出更多详细信息方便用户选择
                    if (matr.getMatrNmCn() != null) {
                        map.put("name", matr.getMatrNmCn());
                    } else {
                        map.put("name", matr.getId());
                    }
                    return map;
                })
                .collect(Collectors.toList());
    }

    /**
     * 判断物料号是否唯一
     *
     * @param matrNbr 物料号
     * @return 检查结果
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:edit")
    @RequestMapping("/checkOnly")
    @ResponseBody
    public Object checkOnly(@RequestParam(value = "matrNbr") String matrNbr) {
        Map<String, String> resultMessage;

        try {
            if (StringUtils.isBlank(matrNbr)) {
                resultMessage = createJsonResponse(NOT_EXISTED);
            } else {
                List<T01MatrInfo> list = t01MatrInfoExtService.findByMatrNbr(matrNbr);

                if (list.isEmpty()) {
                    resultMessage = createJsonResponse(NOT_EXISTED);
                } else {
                    resultMessage = createJsonResponse(EXISTED);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            resultMessage = createJsonResponse(ERROR);
        }
        return resultMessage;
    }

    /**
     * 删除指定数据
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:delete")
    @RequestMapping(value = "deletelist")
    public String deleteList(
            @RequestParam(value = "ids") String ids,
            RedirectAttributes redirectAttributes) {
        try {
            List<String> idList = Arrays.asList(ids.split(","));

            t01MatrInfoExtService.deleteList(idList);

            addMessage(redirectAttributes, i18nHelper.getText("删除物料信息成功"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toDelete?repage";
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("删除物料信息失败，请稍后再试！"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toDelete?repage";
        }
    }

    /**
     * 删除物料
     * @param t01MatrInfo entity
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequestMapping("deleteMatrInfo")
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:delete")
    public String deleteMatrInfo(
            T01MatrInfo t01MatrInfo,
            RedirectAttributes redirectAttributes) {
        String result;
        try{
            result=t01MatrInfoExtService.deleteMatrInfo(t01MatrInfo);
        }catch (BusinessException|NullPointerException e1){
            addMessage(redirectAttributes, getText(e1.getMessage()));
            return "redirect:"+Global.getAdminPath()+"/gsp/t01matrinfo/t01MatrInfo/toDelete?repage";
        }catch (Exception e2){
            addMessage(redirectAttributes, "删除失败,系统错误");
            return "redirect:"+Global.getAdminPath()+"/gsp/t01matrinfo/t01MatrInfo/toDelete?repage";
        }
        addMessage(redirectAttributes, getText(result));
        return "redirect:"+Global.getAdminPath()+"/gsp/t01matrinfo/t01MatrInfo/toDelete?repage";
    }

    /**
     * 启动物料信息审批流畅
     *
     * @param id                 物料信息ID
     * @param redirectAttributes 重定向信息
     * @return 跳转地址
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:appr")
    @RequestMapping(value = "/startAudit")
    public String startAudit(@RequestParam(value = "id") String id,
                             RedirectAttributes redirectAttributes) {
        try {
            t01MatrInfoExtService.startProcess(id.trim(), "");
            addMessage(redirectAttributes, i18nHelper.getText("审批提交成功！"));
        } catch (ConstraintViolationException cvExc) {//捕获验证异常
            List<String> list = new ArrayList<>();
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                list.add(violation.getMessage());
            }
            list.add(0, "数据验证失败，提交审批前请完善物料信息：");
            addMessage(redirectAttributes, list.toArray(new String[]{}));
        } catch (NullPointerException | ApprStatusException e1) {
            addMessage(redirectAttributes, i18nHelper.getText(e1.getMessage()));
        } catch (Exception e2) {
            logger.error(e2.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("审批提交失败，请稍后再试！"));
        }
        return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toAppr/?repage";
    }

    /**
     * 物料信息审批
     *
     * @param t01MatrInfo 物料信息实体
     * @param request 请求
     * @param response 响应
     * @param model view model
     * @return 视图
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:appr")
    @RequestMapping("/toAppr")
    public String toAppr(
            @RequestParam(required = false) String conditionOrder,
            T01MatrInfo t01MatrInfo,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        //审批页面，只能查询到未审批的数据
        t01MatrInfo.setApprStat(ApprStatus.NOAPPR.toString());
        try {
            Page<T01MatrInfo> page = t01MatrInfoService.findPage(new Page<>(request, response), t01MatrInfo);
            model.addAttribute("page", page);
            //保存上次查询条件
            model.addAttribute("conditionOrder", conditionOrder);
        } catch (Exception e) {
            logger.error("查询发生错误" + e.getMessage());
            model.addAttribute("message", getText("查询失败，请输入正确查询条件"));
        }
        return "modules/gsp/t01matrinfo/t01MatrInfoApprList";
    }

    /**
     * 物料信息删除
     *
     * @param t01MatrInfo 物料信息实体
     * @param request 请求
     * @param response 对象
     * @param model view model
     * @return view
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:delete")
    @RequestMapping("/toDelete")
    public String toDelete(
            T01MatrInfo t01MatrInfo,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model,
            @RequestParam(required = false) String conditionOrder) {
        //删除页面，只能删除未提交审批的数据 0：未提交
        //t01MatrInfo.setApprStat(UNCOMMITTED);
        try {
            Page<T01MatrInfo> page = t01MatrInfoService.findPage(new Page<>(request, response), t01MatrInfo);
            model.addAttribute("page", page);
            //保存上次查询条件
            model.addAttribute("conditionOrder", conditionOrder);
        } catch (Exception e) {
            logger.error("查询发生错误" + e.getMessage());
            model.addAttribute("message", getText("查询失败，请输入正确查询条件"));
        }
        return "modules/gsp/t01matrinfo/t01MatrInfoDeleteList";
    }


    @RequestMapping("/toDetail")
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:view")
    public String toDetail(
            T01MatrInfo t01MatrInfo,
            Model model) {
        model.addAttribute("t01MatrInfo", t01MatrInfo);
        return "modules/gsp/t01matrinfo/t01MatrInfoDetail";
    }

    /**
     * 物料信息导入
     *
     * @return view
     */
    @RequestMapping("/toImport")
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:import")
    public String toImport(
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        T01MatrSync t01MatrSync = new T01MatrSync();
        t01MatrSync.setBatch("fromexcel_" + UserUtils.getUser().getId());
        Page<T01MatrSync> page = t01MatrSyncService.findPage(new Page<>(request, response), t01MatrSync);
        model.addAttribute("page", page);
        return "modules/gsp/t01matrinfo/t01MatrInfoImport";
    }

    /**
     * 导入指定数据
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:import")
    @RequestMapping(value = "syncImport")
    public String SyncImport(
            @RequestParam(value = "ids") String ids,
            RedirectAttributes redirectAttributes) {
        try {
            List<String> idList = Arrays.asList(ids.split(","));

            t01MatrInfoExtService.SyncImport(idList);

            addMessage(redirectAttributes, i18nHelper.getText("操作成功,请查看同步结果"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toImport?repage";
        } catch (NullPointerException e) {
            addMessage(redirectAttributes, i18nHelper.getText(e.getMessage()));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toImport?repage";
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("操作失败"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toImport?repage";
        }
    }

    /**
     * 下载批量导入物料信息模板
     *
     * @param response 响应
     */
    @RequestMapping("/downMod")
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:import")
    public void downMod(HttpServletResponse response) {
        try {
            List<String> listHeaders=new ArrayList<>();
            listHeaders.add("物料号:最多250字符【必填】");
            listHeaders.add("物料名称（中文）:最多250字符【必填】");
            listHeaders.add("物料名称（英文）:最多250字符");
            listHeaders.add("描述:最多1000字符");
            listHeaders.add("物料分类:0 医疗器械 1 非医疗器械 请填写0或1【必填】");
            listHeaders.add("货币单位:最多250字符【必填】");
            listHeaders.add("物料单价:数字【必填】");
//            listHeaders.add("备注:最多1000字符");
            new ExportExcel("", listHeaders)
                    .write(response, "物料信息导入模板.xlsx")
                    .dispose();
        } catch (IOException e) {
            logger.error("物流信息导入模板失败");
        }
    }

    /**
     * 批量导入物料信息
     *
     * @param file               上传的文件
     * @param redirectAttributes 重定向信息
     * @return 重定向地址
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:import")
    @RequestMapping("/importExcel")
    public String importExcel(
            @RequestParam(value = "excelFile") MultipartFile file,
            RedirectAttributes redirectAttributes) {

        InputStream fileStream;
        try {
            fileStream = file.getInputStream();

            t01MatrInfoExtService.ImportExcelToSync(fileStream);
            addMessage(redirectAttributes, i18nHelper.getText("导入成功"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toImport?repage";
        } catch (ConstraintViolationException cvExc) {//捕获验证异常
            addMessage(redirectAttributes, getText("导入失败:" + getValidatorExceptionMessage(cvExc, "</br>")));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toImport?repage";
        } catch (NullPointerException e) {
            addMessage(redirectAttributes, i18nHelper.getText("导入失败:" + e.getMessage()));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toImport?repage";
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("导入失败"));
            return "redirect:" + Global.getAdminPath() + "/gsp/t01matrinfo/t01MatrInfo/toImport?repage";
        }

    }

    /**
     * 导出指定物料信息
     *
     * @param t01MatrInfo        物料信息实体
     * @param request 请求
     * @param response 响应
     * @param redirectAttributes 重定向信息
     * @return view
     */
    @RequiresPermissions("gsp:t01matrinfo:t01MatrInfo:view")
    @RequestMapping(value = "export", method = RequestMethod.POST)
    public String exportExcel(
            @RequestParam(value = "fromUrl", required = false) String fromUrl,
            @RequestParam(value = "ids", required = false) String ids,
            T01MatrInfo t01MatrInfo,
            HttpServletRequest request,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {

        String backUrl = "/";

        try {
            if (StringUtils.isNotBlank(fromUrl)) {
                backUrl = backUrl + fromUrl.trim();
            }

            List<T01MatrInfo> list;

            // 如果指定了物料信息则导出指定数据，没有则导出筛选条件下的全部数据
            if (StringUtils.isNotBlank(ids)) {

                List<String> idList = Arrays.asList(ids.trim().split(","));

                list = t01MatrInfoExtService.findSelectedList(idList);
            } else {
                list =t01MatrInfoService.findList(t01MatrInfo);
            }

            String fileName = "物料信息" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            new ExportExcel("物料信息", T01MatrInfo.class)
                    .setDataList(list)
                    .write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, i18nHelper.getText("导出用户失败！失败信息：" + e.getMessage()));
        }

        return "redirect:" + adminPath + "/gsp/t01matrinfo/t01MatrInfo" + backUrl + "?repage";
    }

    /**
     * @param status 状态
     * @return 相应数据
     */
    private Map<String, String> createJsonResponse(ImportStatus status) {
        Map<String, String> response = new HashMap<>();
        response.put("code", status.getValue());
        response.put("message", i18nHelper.getText(status.toString()));
        return response;
    }
}
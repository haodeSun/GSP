/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01compinfonew;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew.T01CompInfoNew;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfonew.T01CompInfoNewHelperService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfonew.T01CompInfoNewService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 企业信息Controller
 *
 * @author XXS
 * @version 2016-12-05
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01compinfonew/t01CompInfoNew")
public class T01CompInfoNewController extends BaseController {

    @Autowired
    private T01CompInfoNewService t01CompInfoNewService;
    @Autowired
    private T01CompInfoNewHelperService t01CompInfoNewHelperService;

    @ModelAttribute
    public T01CompInfoNew get(@RequestParam(required = false) String id) {
        T01CompInfoNew entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = t01CompInfoNewService.get(id);
        }
        if (entity == null) {
            entity = new T01CompInfoNew();
        }
        return entity;
    }

    @RequiresPermissions("gsp:t01compinfo:t01CompInfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(
            @RequestParam(required = false) String conditionOrder,
            T01CompInfoNew t01CompInfo,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01CompInfoNew> page = t01CompInfoNewService.findPage(new Page<>(request, response), t01CompInfo);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        if(page.getList()==null||page.getList().isEmpty()) {
            addMessage(model, getText("很抱歉，未查出符合查询条件的数据。"));
        }
        return "modules/gsp/t01compinfonew/t01CompInfoList";
    }

    @RequiresPermissions("gsp:t01compinfo:t01CompInfo:view")
    @RequestMapping(value = "form")
    public String form(T01CompInfoNew t01CompInfo, Model model, String view) {
        model.addAttribute("t01CompInfoNew", t01CompInfo);
        if (view != null && !view.isEmpty()) {
            return view;
        }
        return "modules/gsp/t01compinfonew/t01CompInfoForm";
    }

    @RequiresPermissions("gsp:t01compinfo:t01CompInfo:view")
    @RequestMapping(value = "toDetail")
    public String toDetail(T01CompInfoNew t01CompInfo, Model model, String view) {
        model.addAttribute("t01CompInfoNew", t01CompInfo);
        model.addAttribute("detail", "true");
        if (view != null && !view.isEmpty()) {
            return view;
        }
        return "modules/gsp/t01compinfonew/t01CompInfoForm";
    }

    @RequiresPermissions("gsp:t01compinfo:t01CompInfo:edit")
    @RequestMapping(value = "save")
    public String save(
            T01CompInfoNew t01CompInfo,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, t01CompInfo)) {
            return form(t01CompInfo, model, null);
        }
        try {
            t01CompInfo.setApprStat(ApprStatus.NOSUBMIT.toString());
            t01CompInfoNewService.save(t01CompInfo);
        } catch (Exception e) {
            String message = e.getMessage();
            if (message != null && !message.isEmpty()) {
                String[] mess = message.split(",");
                if (mess.length >= 2) {
                    message = mess[0];
                }
                addMessage(redirectAttributes, message);
            }
            return form(t01CompInfo, model, null);
        }
        addMessage(redirectAttributes, "保存企业信息成功");
        return "redirect:" + Global.getAdminPath() + "/gsp/t01compinfonew/t01CompInfoNew/?repage";
    }

    @RequiresPermissions("gsp:t01compinfo:t01CompInfo:edit")
    @RequestMapping(value = "delete")
    public String delete(
            T01CompInfoNew t01CompInfo,
            RedirectAttributes redirectAttributes) {
        try {
            t01CompInfoNewService.delete(t01CompInfo);
        } catch (BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "删除企业信息成功");
        return "redirect:" + Global.getAdminPath() + "/gsp/t01compinfonew/t01CompInfoNew/?repage";
    }

    @ResponseBody
    @RequestMapping(value = "checkStatusBeforeHandle")
    public Object checkStatusBeforeHandle(
            @RequestParam String handle,
            T01CompInfoNew t01CompInfoNew) {

        String code;
        String message;
        int data = 0;
        try {
            t01CompInfoNewHelperService.checkStatusBeforeHandle(handle, t01CompInfoNew);
            code = "100";
            message = "可以操作";
        } catch (BusinessException e) {
            code = "101";
            message = e.getMessage();
        } catch (Exception e) {
            logger.error("处理前的状态检查发生错误" + e.getMessage());
            code = "102";
            message = "检查错误";
        }
        return JsonResponse.create(code, message, data).getResult();
    }

    @RequestMapping(value = "export")
    @RequiresPermissions("gsp:t01compinfo:t01CompInfo:view")
    public String export(
            @RequestParam(value = "ids", required = false) String ids,
            T01CompInfoNew t01CompInfoNew,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {

        try {
            List<T01CompInfoNew> list;

            // 如果指定了id列表则导出指定数据，没有则导出筛选条件下的全部数据
            if (StringUtils.isNotBlank(ids)) {

                List<String> idList = Arrays.asList(ids.trim().split(","));

                list = t01CompInfoNewService.findSelectedList(idList);
            } else {
                list = t01CompInfoNewService.findList(t01CompInfoNew);
            }

            String fileName = "企业信息" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            List<String> headerList = new ArrayList<>();
            headerList.add("企业名称（中文）");
            headerList.add("企业名称（英文）");
            headerList.add("简称");
            headerList.add("企业类型");
            headerList.add("成立日期");
            headerList.add("有效期至");
            headerList.add("企业状态");
            headerList.add("审批状态");
            headerList.add("最后操作时间");
            headerList.add("描述");
            headerList.add("经营范围");
            headerList.add("境内/境外");
            headerList.add("统一社会信息代码");
            headerList.add("注册号");
            headerList.add("组织机构代码证号");
            headerList.add("税务登记证号");
            headerList.add("企业唯一编码");
            headerList.add("备注");
            headerList.add("附件");

            ExportExcel ee = new ExportExcel("企业信息", headerList);
            if (list != null && !list.isEmpty()) {
                for (T01CompInfoNew item : list) {
                    Row row = ee.addRow();
                    List<Object> cellList = new ArrayList<>();
                    cellList.add(item.getCompNameCn());
                    cellList.add(item.getCompNameEn());
                    cellList.add(item.getShortName());
                    StringBuilder buyerOrSupl = new StringBuilder();
                    if (StringUtils.isNotBlank(item.getBuyerId())) {
                        buyerOrSupl.append("购货者");
                    }
                    if (StringUtils.isNotBlank(item.getBuyerId())
                            && StringUtils.isNotBlank(item.getSuplId())) {
                        buyerOrSupl.append(",");
                    }
                    if (StringUtils.isNotBlank(item.getSuplId())) {
                        buyerOrSupl.append("供货者");
                    }
                    cellList.add(buyerOrSupl.toString());
                    if ("0".equals(item.getAbroad())) {
                        cellList.add(item.getT01CompCert0().getEffecDate());
                        cellList.add(item.getT01CompCert0().getValidDate());
                        cellList.add(DictUtils.getDictLabel(item.getT01CompCert0().getCertStat(), "t01_certStat", ""));
                    }
                    if ("1".equals(item.getAbroad())) {
                        cellList.add(item.getT01CompCert3().getEffecDate());
                        cellList.add(item.getT01CompCert3().getValidDate());
                        cellList.add(DictUtils.getDictLabel(item.getT01CompCert3().getCertStat(), "t01_certStat", ""));
                    }

                    cellList.add(DictUtils.getDictLabel(item.getApprStat(), "t01_matr_info_appr_stat", ""));
                    cellList.add(DateUtils.formatDate(item.getUpdateDate(),"yyyy-MM-dd HH:mm:ss"));
                    cellList.add(item.getCompDesc());

                    if ("0".equals(item.getAbroad())) {
                        cellList.add(item.getT01CompCert0().getCertScop());
                    }
                    if ("1".equals(item.getAbroad())) {
                        cellList.add(item.getT01CompCert3().getCertScop());
                    }
                    cellList.add(DictUtils.getDictLabel(item.getAbroad(), "abroad", ""));
                    cellList.add(item.getUniCretNbr());
                    cellList.add(item.getRegiNbr());
                    cellList.add(item.getOrgCertNbr());
                    cellList.add(item.getTaxNbr());
                    cellList.add(item.getCompUniNbr());
                    cellList.add(item.getRemarks());
                    if ("0".equals(item.getAbroad())) {
                        cellList.add(UserUtils.getAttachCount(item.getT01CompCert0().getAttachment()));
                    }
                    if ("1".equals(item.getAbroad())) {
                        cellList.add(UserUtils.getAttachCount(item.getT01CompCert3().getAttachment()));
                    }

                    for (int i = 0; i < cellList.size(); i++) {
                        ee.addCell(row, i, cellList.get(i));
                    }
                }
            }
            ee.write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("导出企业信息失败！失败信息：" + e.getMessage()));
        }
        return "redirect:" + adminPath + "/gsp/t01compinfonew/t01CompInfoNew?repage";
    }

    @RequestMapping(value = "getAllComps")
    @ResponseBody
    public List<Map<String, Object>> getAllComps() {

        // 获取所有的企业记录
        return t01CompInfoNewService
                .findList(new T01CompInfoNew())
                .stream()
                .filter(item -> !"1".equals(item.getBuyerIsChanged())&& !"1".equals(item.getSuplIsChanged())) // 过滤变更后的数据
                .map(a -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", a.getId());
                    map.put("pId", null);
                    map.put("name", a.getCompNameCn());
                    return map;
                })
                .collect(Collectors.toList());
    }

    @RequestMapping(value = "getCompsForBuyer")
    @ResponseBody
    public List<Map<String, Object>> getCompsForBuyer() {

        // 获取所有的购货者企业记录
        return t01CompInfoNewService
                .findList(new T01CompInfoNew())
                .stream()
                .filter(item ->StringUtils.isBlank(item.getBuyerId()))
                .map(a -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", a.getId());
                    map.put("pId", null);
                    map.put("name", a.getCompNameCn());
                    return map;
                })
                .collect(Collectors.toList());
    }


    @RequestMapping(value = "getCompsForSupl")
    @ResponseBody
    public List<Map<String, Object>> getCompsForSupl() {

        // 获取所有的供货者企业记录
        return t01CompInfoNewService
                .findList(new T01CompInfoNew())
                .stream()
                .filter(item ->StringUtils.isBlank(item.getSuplId()))
                .map(a -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", a.getId());
                    map.put("pId", null);
                    map.put("name", a.getCompNameCn());
                    return map;
                })
                .collect(Collectors.toList());
    }

    @RequestMapping(value = "getCompInfo")
    @ResponseBody
    public Object getCompInfo(T01CompInfoNew t01CompInfoNew) {

        StringBuilder buyerOrSupl = new StringBuilder();
        if (StringUtils.isNotBlank(t01CompInfoNew.getBuyerId())) {
            buyerOrSupl.append("购货者");
        }
        if (StringUtils.isNotBlank(t01CompInfoNew.getBuyerId())
                && StringUtils.isNotBlank(t01CompInfoNew.getSuplId())) {
            buyerOrSupl.append(",");
        }
        if (StringUtils.isNotBlank(t01CompInfoNew.getSuplId())) {
            buyerOrSupl.append("供货者");
        }
        t01CompInfoNew.setBuyerId(buyerOrSupl.toString());

        if ("0".equals(t01CompInfoNew.getAbroad())) {
            t01CompInfoNew.getT01CompCert0().setCertStat(DictUtils.getDictLabel(t01CompInfoNew.getT01CompCert0().getCertStat(), "t01_certStat", ""));
        }
        if ("1".equals(t01CompInfoNew.getAbroad())) {
            t01CompInfoNew.getT01CompCert0().setCertStat(DictUtils.getDictLabel(t01CompInfoNew.getT01CompCert3().getCertStat(), "t01_certStat", ""));
        }
        t01CompInfoNew.setApprStat(DictUtils.getDictLabel(t01CompInfoNew.getApprStat(), "t01_matr_info_appr_stat", ""));
        return t01CompInfoNew;
    }

}
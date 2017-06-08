/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01salescert;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01salescert.T01SalesCertService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 管理销售人员授权Controller
 *
 * @author greg.song
 * @version 2016-12-21
 */
public class T01SalesCertController extends BaseController {

    @SuppressWarnings("WeakerAccess")
    T01SalesCertService t01SalesCertService;

    @Autowired
    private SystemService systemService;

    @Autowired
    public T01SalesCertController(T01SalesCertService t01SalesCertService) {
        Assert.notNull(t01SalesCertService);
        this.t01SalesCertService = t01SalesCertService;
    }

    @ModelAttribute
    public T01SalesCert get(@RequestParam(required = false) String id) {
        T01SalesCert entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = t01SalesCertService.get(id);
        }
        if (entity == null) {
            entity = new T01SalesCert();
        }
        return entity;
    }

    @RequiresPermissions("gsp:t01salescert:t01SalesCert:view")
    @RequestMapping(value = {"list", ""})
    public String list(
            @RequestParam(required = false) String conditionOrder,
            T01SalesCert t01SalesCert,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01SalesCert> page = t01SalesCertService.findPage(new Page<>(request, response), t01SalesCert);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        if(page.getList()==null||page.getList().isEmpty()) {
            addMessage(model, getText("很抱歉，未查出符合查询条件的数据。"));
        }
        return "modules/gsp/t01salescert/t01SalesCertList";
    }

    @RequiresPermissions("gsp:t01salescert:t01SalesCert:view")
    @RequestMapping(value = "form")
    public String form(T01SalesCert t01SalesCert, Model model, String view) {
        model.addAttribute("t01SalesCert", t01SalesCert);
        if (view != null && !view.isEmpty()) {
            return view;
        }
        model.addAttribute("certScopList", systemService.findAllCertScop());
        return "modules/gsp/t01salescert/t01SalesCertForm";
    }

    @RequiresPermissions("gsp:t01salescert:t01SalesCert:view")
    @RequestMapping(value = "toDetail")
    public String toDetail(T01SalesCert t01SalesCert, Model model, String view) {
        model.addAttribute("t01SalesCert", t01SalesCert);
        model.addAttribute("detail", "true");
        model.addAttribute("certScopList", systemService.findAllCertScop());
        if (view != null && !view.isEmpty()) {
            return view;
        }
        return "modules/gsp/t01salescert/t01SalesCertForm";
    }

    @RequiresPermissions("gsp:t01salescert:t01SalesCert:edit")
    @RequestMapping(value = "save")
    public String save(
            T01SalesCert t01SalesCert,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, t01SalesCert)) {
            return form(t01SalesCert, model, null);
        }
        try {
            t01SalesCertService.save(t01SalesCert);
        } catch (Exception e) {
            String message = e.getMessage();
            handleErrorMessage(model, message);
            return form(t01SalesCert, model, null);
        }
        addMessage(redirectAttributes, "保存销售人员成功");
        return "redirect:" + Global.getAdminPath() + "/gsp/t01salescert/t01SalesCert/?repage";
    }

    @RequiresPermissions("gsp:t01salescert:t01SalesCert:edit")
    @RequestMapping(value = "delete")
    public String delete(
            T01SalesCert t01SalesCert,
            RedirectAttributes redirectAttributes) {
        try {
            t01SalesCertService.delete(t01SalesCert);
        } catch (BusinessException e) {
            e.printStackTrace();
        }
        addMessage(redirectAttributes, "删除销售人员成功");
        return "redirect:" + Global.getAdminPath() + "/gsp/t01salescert/t01SalesCert/toDelete?repage";
    }

    @RequestMapping(value = "export")
    @RequiresPermissions("gsp:t01salescert:t01SalesCert:view")
    public String export(
            @RequestParam(value = "ids", required = false) String ids,
            T01SalesCert t01SalesCert,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {

        try {
            List<T01SalesCert> list;

            // 如果指定了id列表则导出指定数据，没有则导出筛选条件下的全部数据
            if (StringUtils.isNotBlank(ids)) {

                List<String> idList = Arrays.asList(ids.trim().split(","));

                list = t01SalesCertService.findSelectedList(idList);
            } else {
                list = t01SalesCertService.findList(t01SalesCert);
            }

            String fileName = "销售人员授权" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            List<String> headerList = new ArrayList<>();

            headerList.add("销售人员姓名");
            headerList.add("所在企业");
            headerList.add("销售人员授权状态");
            headerList.add("证件类型");
            headerList.add("证件号");
            headerList.add("销售区域");
//            headerList.add("授权产品范围");
            headerList.add("授权书编号");
            headerList.add("生效日期");
            headerList.add("有效期至");
            headerList.add("附件");
            headerList.add("更新时间");

            ExportExcel ee = new ExportExcel("销售人员授权", headerList);
            if (list != null && !list.isEmpty()) {
                for (T01SalesCert item : list) {
                    Row row = ee.addRow();
                    List<Object> cellList = new ArrayList<>();
					cellList.add(item.getSalesName());
					cellList.add(item.getComp().getCompNameCn());
                    cellList.add(DictUtils.getDictLabel(item.getCertStat(), "t01_certStat", ""));
                    cellList.add(DictUtils.getDictLabel(item.getIdType(), "t01_SalesIDType", ""));
                    cellList.add(item.getIdNbr());
                    cellList.add(item.getSalesArea());
//                    cellList.add(item.getSalesScop());
                    cellList.add(item.getSalesCertNbr());
                    cellList.add(item.getEffecDate());
                    cellList.add(item.getValidDate());
                    cellList.add(UserUtils.getAttachCount(item.getAttachment()));
                    cellList.add(DateUtils.formatDate(item.getUpdateDate(),"yyyy-MM-dd HH:mm:ss"));

                    for (int i = 0; i < cellList.size(); i++) {
                        ee.addCell(row, i, cellList.get(i));
                    }
                }
            }
            ee.write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("导出销售人员授权失败！失败信息：" + e.getMessage()));
        }
        return "redirect:" + adminPath + "/gsp/t01salescert/t01SalesCert?repage";
    }

}
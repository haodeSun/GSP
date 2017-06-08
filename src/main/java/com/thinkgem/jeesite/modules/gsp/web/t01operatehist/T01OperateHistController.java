/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01operatehist;

import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01operatehist.T01OperateHist;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01operatehist.T01OperateHistHelperService;
import com.thinkgem.jeesite.modules.gsp.service.t01operatehist.T01OperateHistService;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 操作历史Controller
 *
 * @author xuxiaoshuo
 * @version 2017-03-22
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01operatehist/T01OperateHist")
public class T01OperateHistController extends BaseController {
    @Autowired
    private T01OperateHistService t01OperateHistService;
    @Autowired
    private T01OperateHistHelperService t01OperateHistHelperService;

    @ResponseBody
    @RequestMapping(value = {"list", ""})
    public Object list(T01OperateHist t01OperateHist) {

        String code;
        String message;
        List<T01OperateHist> data = null;

        try {
            data = t01OperateHistService.findList(t01OperateHist);
            if (data == null || data.isEmpty()) {
                code = "101";
                message = "未查询到结果";
            } else {
                code = "100";
                message = "查询成功";
            }
        } catch (Exception e) {
            logger.error("查询发生错误" + e.getMessage());
            code = "102";
            message = "查询发生错误";
        }
        return JsonResponse.create(code, message, data).getResult();
    }

    @ResponseBody
    @RequestMapping(value = "save")
    public Object save(T01OperateHist t01OperateHist) {

        String code;
        String message;
        int data = 0;
        try {
            t01OperateHistService.save(t01OperateHist);
            code = "100";
            message = "保存成功";
        } catch (BusinessException e) {
            code = "101";
            message = e.getMessage();
        } catch (Exception e) {
            logger.error("保存错误" + e.getMessage());
            code = "102";
            message = "保存错误";
        }
        return JsonResponse.create(code, message, data).getResult();
    }

    @ResponseBody
    @RequestMapping(value = "checkBeforeHandleStatus")
    public Object checkBeforeHandleStatus(
            @RequestParam String handle,
            T01OperateHist t01OperateHist) {

        String code;
        String message;
        int data = 0;
        try {
            t01OperateHistHelperService.checkBeforeHandleStatus(handle, t01OperateHist);
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
    public String export(
            T01OperateHist t01OperateHist,
            HttpServletResponse response) {


        try {
            List<T01OperateHist> list;

            list = t01OperateHistService.findList(t01OperateHist);

            String fileName = "操作历史" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            List<String> headerList = new ArrayList<>();
            headerList.add("序号");
            headerList.add("操作内容");
            headerList.add("操作说明");
            headerList.add("操作人");
            headerList.add("操作时间");

            ExportExcel ee = new ExportExcel("操作历史", headerList);
            if (list != null && !list.isEmpty()) {
                for (T01OperateHist item : list) {
                    Row row = ee.addRow();
                    List<Object> cellList = new ArrayList<>();
                    cellList.add(list.indexOf(item) + 1);
                    cellList.add(item.getOperateType());
                    cellList.add(item.getDescription());
                    cellList.add(item.getUpdateBy().getLoginName());
                    cellList.add(DateUtils.formatDate(item.getUpdateDate(), "yyyy-MM-dd HH:mm:ss"));

                    for (int i = 0; i < cellList.size(); i++) {
                        ee.addCell(row, i, cellList.get(i));
                    }
                }
            }
            ee.write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
        }
        return null;
    }

}
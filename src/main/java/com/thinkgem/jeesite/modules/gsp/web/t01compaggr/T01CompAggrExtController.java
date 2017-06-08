package com.thinkgem.jeesite.modules.gsp.web.t01compaggr;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggrRelateMatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompInfoSB;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew.T01CompInfoNew;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compaggr.T01CompAggrExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfonew.T01CompInfoNewService;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplExtService;
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
import com.thinkgem.jeesite.modules.sys.service.SysConfigService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.EntityUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Row;
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
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Greg Song
 * @since 20/12/2016
 */
@SuppressWarnings("MVCPathVariableInspection")
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01compaggr/t01CompAggr")
public class T01CompAggrExtController extends T01CompAggrController {
    private static final String CONFIG_COMPANY_KEY = "config_company_id";

    private T01CompInfoService t01CompInfoService;

    @Autowired
    private T01CompInfoNewService t01CompInfoNewService;

    private SysConfigService sysConfigService;

    @Autowired
    public T01CompAggrExtController(
            T01CompAggrExtService t01CompAggrService,
            T01ComplBuyerExtService t01ComplBuyerExtService,
            T01ComplSuplExtService t01ComplSuplExtService,
            T01CompInfoService t01CompInfoService,
            SysConfigService sysConfigService) {
        super(t01CompAggrService, t01ComplBuyerExtService, t01ComplSuplExtService);
        assert t01CompInfoService != null;
        assert sysConfigService != null;
        this.t01CompInfoService = t01CompInfoService;
        this.sysConfigService = sysConfigService;
    }

    /**
     * 审批页
     *
     * @param conditionOrder 保存查询条件
     * @param t01CompAggr    entity实例
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:appr")
    @RequestMapping(value = {"toAppr"})
    public String toAppr(
            @RequestParam(required = false) String conditionOrder,
            T01CompAggr t01CompAggr,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        t01CompAggr.setApprStat(ApprStatus.NOAPPR.toString());
        Page<T01CompAggr> page = t01CompAggrService.findPage(new Page<>(request, response), t01CompAggr);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01compaggr/t01CompAggrList_Appr";
    }

    /**
     * 删除列表页
     *
     * @param conditionOrder 查询条件
     * @param t01CompAggr    entity
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:delete")
    @RequestMapping(value = {"toDelete"})
    public String toDelete(
            @RequestParam(required = false) String conditionOrder,
            T01CompAggr t01CompAggr,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01CompAggr> page = t01CompAggrService.findPage(new Page<>(request, response), t01CompAggr);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01compaggr/t01CompAggrList_Delete";
    }

    /**
     * 协议详情页
     *
     * @param t01CompAggr entity
     * @param model       model
     * @return view
     */
    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:view")
    @RequestMapping(value = "toDetail")
    public String toDetail(T01CompAggr t01CompAggr, Model model) {
        model.addAttribute("t01CompAggr", t01CompAggr);
        model.addAttribute("detail", "true");
        model.addAttribute("certScopList", systemService.findAllCertScop());
        return "modules/gsp/t01compaggr/t01CompAggrForm";
    }

    /**
     * 获取物料信息列表
     *
     * @return object
     */
    @ResponseBody
    @RequestMapping(value = "matrInfoList")
    public Object matrInfoList(
            @RequestParam(value = "ids", required = false, defaultValue = "") String ids) {

        List<T01CompAggrRelateMatrInfo> t01CompAggrRelateMatrInfoList = new ArrayList<>();
        String code;
        String message;
        try {
            t01CompAggrRelateMatrInfoList = t01CompAggrService.getCompAggrRelateMatrInfoList()
                    .stream().filter(item -> !ids.contains(item.getId())).collect(Collectors.toList());
            if (t01CompAggrRelateMatrInfoList != null && !t01CompAggrRelateMatrInfoList.isEmpty()) {
                code = "100";
                message = getText("获取数据成功");
            } else {
                code = "101";
                message = getText("暂无数据");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            code = "102";
            message = getText("获取数据失败");
        }

        return JsonResponse.create(code, message, t01CompAggrRelateMatrInfoList).getResult();
    }

    /**
     * 获取范围
     *
     * @return object
     */
    @ResponseBody
    @RequestMapping(value = "getScopes")
    public Object getScopes(
            @RequestParam(value = "supplierId", required = false, defaultValue = "") String supplierId,
            @RequestParam(value = "buyerId", required = false, defaultValue = "") String buyerId,
            @RequestParam String salesCertId) {

        String code;
        String message;
        Map<String, String> result = new HashMap<>();

        try {
            code = "100";
            message = "获取数据成功";
            if (StringUtils.isNotBlank(supplierId)) {

                result = t01CompAggrService.getScopeBySupplierId(supplierId, salesCertId);

            } else if (StringUtils.isNotBlank(buyerId)) {
                result = t01CompAggrService.getScopeByBuyerId(buyerId, salesCertId);
            } else {
                throw new NullPointerException("没有指定数据");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            code = "101";
            message = getText("获取数据失败");
        }

        return JsonResponse.create(code, message, result).getResult();
    }

    /**
     * 获取销售人员授权
     *
     * @return object
     */
    @ResponseBody
    @RequestMapping(value = "getSalesCertList")
    public Object getSalesCertList(
            @RequestParam(value = "supplierId", required = false, defaultValue = "") String supplierId,
            @RequestParam(value = "buyerId", required = false, defaultValue = "") String buyerId) {

        String code;
        String message;
        Map<String, Object> result = new HashMap<>();

        try {
            code = "100";
            message = "获取数据成功";
            if (StringUtils.isNotBlank(supplierId)) {

                result = t01CompAggrService.getSalesCertListBySupplierId(supplierId);

            } else if (StringUtils.isNotBlank(buyerId)) {
                result = t01CompAggrService.getSalesCertListByBuyerId();
            } else {
                throw new NullPointerException("没有指定数据");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            code = "101";
            message = getText("获取数据失败");
        }

        return JsonResponse.create(code, message, result).getResult();
    }

    /**
     * 判断协议编号是否唯一
     *
     * @param agreementNo 协议编号
     * @return 检查结果
     */
    @RequestMapping("/checkOnly")
    @ResponseBody
    public Object checkOnly(@RequestParam(value = "agreementNo") String agreementNo) {

        String code;
        String message;

        try {
            if (StringUtils.isBlank(agreementNo)) {
                code = "102";
                message = getText("参数不能为空");
            } else {
                T01CompAggr t01CompAggr = new T01CompAggr();
                t01CompAggr.setAgreementNo(agreementNo);
                List<T01CompAggr> list = t01CompAggrService.findList(t01CompAggr);

                if (list == null || list.isEmpty()) {
                    code = "100";
                    message = getText("可以添加");
                } else {
                    code = "101";
                    message = getText("协议编号以存在，不可添加");
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            code = "103";
            message = getText("获取数据失败");
        }
        return JsonResponse.create(code, message, null).getResult();
    }

    /**
     * 获取所有协议，这个是给需要协议的地方使用的
     *
     * @return 购货者列表
     */
    @RequestMapping(
            value = "get-all-agreements",
            name = "get_all_compliance_agreements",
            method = RequestMethod.GET
    )
    @ResponseBody
//    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:view")
    public List<Map<String, Object>> getAllBuyers(
            @RequestParam String extId
    ) {
        T01CompAggr agreement = new T01CompAggr();

        // 获取所有的购货者记录
        return t01CompAggrService
                .findList(agreement) // TODO 需要一个方法能够过滤掉子节点，防止创建循环的协议关系
                .stream()
                .filter(a -> !StringUtils.equals(a.getId(), extId)) // 过滤自身
                .map(a -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", a.getId());
                    map.put("pId", null);
                    if (a.getAgreementNo() != null) {
                        map.put("name", a.getAgreementNo());
                    } else {
                        map.put("name", a.getId());
                    }
                    return map;
                })
                .collect(Collectors.toList());
    }

    @RequestMapping(
            value = "get-all-prodComps",
            name = "get_all_compliance_prodComps",
            method = RequestMethod.GET
    )

    @ResponseBody
    public List<Map<String, Object>> getAllProdComps() {
        T01CompInfo t01CompInfo = new T01CompInfo();
        t01CompInfo.setApprStat(ApprStatus.PASS.toString());

        // 获取所有的企业记录
        return t01CompInfoService
                .findList(t01CompInfo)
                .stream()
                .filter(a -> true) // 过滤自身
                .map(a -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", a.getCompNameCn());
                    map.put("pId", null);
                    map.put("name", a.getCompNameCn());
                    return map;
                })
                .collect(Collectors.toList());
    }

    /**
     * 获取所有企业信息
     *
     * @return 企业信息
     */
    @RequestMapping(
            value = "get-all-comps",
            name = "get_all_compliance_comps",
            method = RequestMethod.GET
    )
    @ResponseBody
    public List<Map<String, Object>> getAllComps() {
        T01CompInfo t01CompInfo = new T01CompInfo();
        t01CompInfo.setApprStat(ApprStatus.PASS.toString());

        // 获取所有的企业记录
        return t01CompInfoService
                .findList(t01CompInfo)
                .stream()
                .filter(a -> true) // 过滤自身
                .map(a -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", a.getId());
                    map.put("pId", null);
                    map.put("name", a.getCompNameCn());
                    return map;
                })
                .collect(Collectors.toList());
    }

    /**
     * 获取供货者/购货者信息
     *
     * @param compId 企业id
     * @return 供货者/购货者信息
     */
    @ResponseBody
    @RequestMapping(value = "getCompInfoSB")
    public Object getCompInfoSB(@RequestParam(value = "compId") String compId) {

        String code;
        String message;
        T01CompInfoSB t01CompInfoSB = null;
        try {
            code = "100";
            message = "获取数据成功";
            if (StringUtils.isNotBlank(compId)) {
                t01CompInfoSB = t01CompAggrService.getCompInfoSB(compId);
            } else {
                throw new NullPointerException("没有指定数据");
            }
        } catch (NullPointerException e) {
            code = "101";
            message = getText(e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage());
            code = "101";
            message = getText("获取数据失败");
        }

        return JsonResponse.create(code, message, t01CompInfoSB).getResult();
    }

    /**
     * 本企业编辑页
     *
     * @param model model
     * @return view
     */
    @RequestMapping(value = "configCompanyForm")
    public String configCompanyForm(Model model) {
        SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigName(CONFIG_COMPANY_KEY);
        T01CompInfoNew t01CompInfoNew = new T01CompInfoNew();
        List<SysConfig> sysConfigList = sysConfigService.findList(sysConfig);
        if (sysConfigList != null && !sysConfigList.isEmpty()) {

            t01CompInfoNew = t01CompInfoNewService.get(sysConfigList.get(0).getConfigValue());

        }
        model.addAttribute("certScopList", systemService.findAllCertScop());
        model.addAttribute("t01CompInfoNew", t01CompInfoNew);
        return "modules/gsp/t01compaggr/Config_Company";
    }

    /**
     * 保存本企业配置
     *
     * @param compId             企业id
     * @param redirectAttributes redirectAttributes
     * @return view
     */
    @RequestMapping(value = "saveConfigCompany")
    public String saveConfigCompany(
            @RequestParam String compId,
            RedirectAttributes redirectAttributes) {
        SysConfig sysConfig = new SysConfig();
        sysConfig.setConfigName(CONFIG_COMPANY_KEY);

        List<SysConfig> sysConfigList = sysConfigService.findList(sysConfig);
        try {
            if (sysConfigList != null && !sysConfigList.isEmpty()) {
                SysConfig sysConfig1 = sysConfigList.get(0);
                sysConfig1.setConfigValue(compId);
                sysConfigService.save(sysConfig1);
            } else {
                sysConfig.setConfigValue(compId);
                sysConfigService.save(sysConfig);
            }
            addMessage(redirectAttributes, getText("保存成功"));
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, getText("保存失败，系统错误"));
        }
        return "redirect:" + Global.getAdminPath() + "/gsp/t01compaggr/t01CompAggr/configCompanyForm";
    }

    /**
     * 协议管理信息导出
     *
     * @param fromUrl            导出来源页
     * @param ids                指定的导出数据
     * @param t01CompAggr        entity
     * @param response           response
     * @param redirectAttributes redirectAttributes
     * @return 成功：文件流；失败：来源页view
     */
    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:view")
    @RequestMapping(value = "export")
    public String exportExcel(
            @RequestParam(value = "fromUrl", required = false) String fromUrl,
            @RequestParam(value = "ids", required = false) String ids,
            T01CompAggr t01CompAggr,
            HttpServletResponse response,
            RedirectAttributes redirectAttributes) {

        String backUrl = "/";

        try {
            if (StringUtils.isNotBlank(fromUrl)) {
                backUrl = backUrl + fromUrl.trim();
            }

            List<T01CompAggr> list;

            // 如果指定了id列表则导出指定数据，没有则导出筛选条件下的全部数据
            if (StringUtils.isNotBlank(ids)) {

                List<String> idList = Arrays.asList(ids.trim().split(","));

                list = t01CompAggrService.findSelectedList(idList);
            } else {
                list = t01CompAggrService.findList(t01CompAggr);
            }

            String fileName = "协议信息" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";

            List<String> headerList = new ArrayList<>();
            headerList.add("协议编号");
            headerList.add("协议类别");
            headerList.add("供货者");
            headerList.add("购货者");
            headerList.add("生效日期");
            headerList.add("有效期至");
            headerList.add("协议状态");
            headerList.add("审批状态");
            headerList.add("最后操作时间");
            headerList.add("销售授权人");
            headerList.add("销售区域");
            headerList.add("生产企业");
            headerList.add("协议金额");
            headerList.add("附件");


            ExportExcel ee = new ExportExcel("协议信息", headerList);
            if (list != null && !list.isEmpty()) {
                for (T01CompAggr item : list) {
                    Row row = ee.addRow();

                    List<Object> cellList = new ArrayList<>();
                    cellList.add(item.getAgreementNo());
                    cellList.add(DictUtils.getDictLabel(item.getAggrType(), "t01_comp_aggr_type", ""));
                    cellList.add(item.getBuyer().getT01CompInfo().getCompNameCn());
                    cellList.add(item.getSupplier().getT01CompInfo().getCompNameCn());
                    cellList.add(item.getEffecDate());
                    cellList.add(item.getValidDate());
                    cellList.add(DictUtils.getDictLabel(item.getAggrStat(), "t01_certStat", ""));
                    cellList.add(DictUtils.getDictLabel(item.getApprStat(), "t01_apprStat", ""));
                    cellList.add(DateUtils.formatDate(item.getUpdateDate(), "yyyy-MM-dd HH:mm:ss"));
                    cellList.add(item.getAuthorName());
                    cellList.add(item.getLocation());
                    cellList.add(item.getProdComp());
                    cellList.add(item.getAggrAmnt());
                    cellList.add(UserUtils.getAttachCount(item.getAttachment()));


                    for (int i = 0; i < cellList.size(); i++) {
                        ee.addCell(row, i, cellList.get(i));
                    }
                }
            }
            ee.write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            logger.error(e.getMessage());
            addMessage(redirectAttributes, i18nHelper.getText("导出协议信息失败！失败信息：" + e.getMessage()));
        }
        return "redirect:" + adminPath + "/gsp/t01compaggr/t01CompAggr" + backUrl + "?repage";
    }

    /**
     * 跳转审批详情页
     *
     * @param conditionOrder conditionOrder
     * @param t01CompAggr    entity
     * @param request        request
     * @param response       response
     * @param model          model
     * @return view
     */
    @RequiresPermissions("gsp:t01compaggr:t01CompAggr:appr")
    @RequestMapping(value = {"toApprDetail"})
    public String toApprDetail(
            @RequestParam(required = false) String conditionOrder,
            T01CompAggr t01CompAggr,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {

        try {
            t01CompAggrService.getTaskInfo(t01CompAggr);
        } catch (NullPointerException | BusinessException e) {
            addMessage(model, getText(e.getMessage()));
            return toAppr(conditionOrder, new T01CompAggr(), request, response, model);
        } catch (Exception e2) {
            addMessage(model, getText("前往审批页失败，系统错误"));
            logger.error(e2.getMessage());
            return toAppr(conditionOrder, new T01CompAggr(), request, response, model);
        }
        request.getSession().setAttribute("view", "redirect:" + adminPath + "/gsp/t01compaggr/t01CompAggr/toAppr");
        return "forward:" + Global.getAdminPath() + "/act/task/form?"
                + "taskId="
                + t01CompAggr.getAct().getTaskId()
                + "&taskName=" + t01CompAggr.getAct().getTaskName()
                + "&taskDefKey=" + t01CompAggr.getAct().getTaskDefKey()
                + "&procInsId=" + t01CompAggr.getAct().getProcInsId()
                + "&procDefId=" + t01CompAggr.getAct().getProcDefId()
                + "&status=todo";
    }
}

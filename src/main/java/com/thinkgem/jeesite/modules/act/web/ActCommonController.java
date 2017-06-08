package com.thinkgem.jeesite.modules.act.web;

import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.act.entity.Act;
import com.thinkgem.jeesite.modules.act.entity.BaseActEntity;
import com.thinkgem.jeesite.modules.act.service.ActCommonService;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author JOKING
 * @since 2016/11/6
 */
@Controller
@RequestMapping("${adminPath}/gsp/act/")
public class ActCommonController extends BaseController {

    private static final String VIEW = "modules/gsp/audit/commonAudit";

    private final ActCommonService actCommonService;

    @Autowired
    private ActTaskService actTaskService;

    @Autowired
    public ActCommonController(ActCommonService actCommonService) {
        this.actCommonService = actCommonService;
    }

    @RequestMapping("form")
    public String form(BaseActEntity baseActEntity,
                       String viewName,
                       String id,
                       Model model,
                       HttpServletRequest request) {
        Act act = baseActEntity.getAct();
        String formPropertiesStr = "";
        String content = "";
        String approveStatus = "";
        String view = (String)request.getSession().getAttribute("view");
        //获取之后清除，否则每次都会进这个页面
        request.getSession().removeAttribute("view");
        try {
            //获取到模型中配置的formProperty 渲染之后的String
            formPropertiesStr = actCommonService.getFormPropertiesStr(act);

            //获取要渲染的jsp模板
            String templatePath = actCommonService.getTemplatePath(request,act,viewName);

            //反射回调Service 的get方法，获得要渲染的数据
            Object dataModel = actCommonService.getBusinessDataModel(act,id);

            //用freemarker的方式渲染并获得业务模板的String
            content = actCommonService.getContent(templatePath,act,dataModel);

            //获取审批状态（【同意】，【驳回】）
            approveStatus = actCommonService.getApproveStatus(act);

        } catch (Exception e) {
            logger.error("错误信息：" + e.getMessage());
            model.addAttribute("message", "系统内部错误！");
        }
        ProcessInstance instance = actTaskService.getProcIns(act.getProcInsId());
        if(instance!=null){
            List<HistoricVariableInstance> list = actTaskService.getProcessEngine().getHistoryService()
                    .createHistoricVariableInstanceQuery().processInstanceId(act.getProcInsId()).list();
            final String[] values = {"",""};
            list.forEach(hvi -> {
                if("startUser".equals(hvi.getVariableName())){
                    values[0] = (String)hvi.getValue();
                }
                if("sourceUrl".equals(hvi.getVariableName())){
                    values[1] = (String)hvi.getValue();
                }
            });
            if(values[1] != null && act.getCurrentUser().getLoginName().equals(values[0])){
                Object value = values[1];
                model.addAttribute("sourceUrl",value);
                actTaskService.getProcIns(act.getProcInsId()).getProcessVariables().remove("sourceUrl");
            }
        }
        model.addAttribute("approveStatus", approveStatus);
        model.addAttribute("content", content);
        model.addAttribute("formProperties", formPropertiesStr);
        model.addAttribute("act", act);
        model.addAttribute("id", id);
        model.addAttribute("view",view);
        return VIEW;
    }


    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(
            Act act,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        String returnPath = "redirect:" + adminPath + "/act/task/todo";
        String view = request.getParameter("view");
        if(StringUtils.isNotBlank(view)){
            returnPath = view;
        }
        try {
            actCommonService.saveProcess(act, request);
            addMessage(redirectAttributes, "流程审批成功！");
        } catch (Exception e) {
            logger.error("流程提交失败：", e);
            addMessage(redirectAttributes, "流程审批失败！");
            return returnPath;
        }
        return returnPath;
    }

}



package com.thinkgem.jeesite.modules.act.service;


import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.common.utils.functions.FreeMarkerAttachHandler;
import com.thinkgem.jeesite.common.utils.functions.FreeMarkerDictHandler;
import com.thinkgem.jeesite.modules.act.ActActionInvoke;
import com.thinkgem.jeesite.modules.act.dao.ActDao;
import com.thinkgem.jeesite.modules.act.entity.Act;
import com.thinkgem.jeesite.modules.gen.entity.GenTableColumn;
import com.thinkgem.jeesite.modules.gsp.entity.t01operatehist.T01OperateHist;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import org.activiti.engine.FormService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.form.FormType;
import org.activiti.engine.history.HistoricDetail;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.persistence.entity.HistoricFormPropertyEntity;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.commons.io.Charsets;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 基本审批Service
 *
 * @author yohu
 * @version 2016-11-3
 */
@Service
@Transactional(readOnly = true)
public class ActCommonService extends BaseService{

    private final String ACT_STATUS_YES="yes";
    private final ActDao actDao;
    private final ActTaskService actTaskService;
    //当前流程业务数据   id
    //private String id;
    //当前流程处理的业务实体名
    //private String entityName;
    //当前流程的业务表
    //private String businessTable;


    @Autowired
    public ActCommonService(ActTaskService actTaskService, ActDao actDao) {
        this.actTaskService = actTaskService;
        this.actDao = actDao;
    }
    //渲染后的form property字符串

    /**
     * 获取业务表数据
     *
     * @param id 业务表记录  id
     * @return 返回数据
     */
    public Object getBusinessDataModel(Act act,String id) {
        if (!StringUtils.isNotEmpty(id)) {
            id = getBusinessId(act.getProcInsId());
        }
        //得到对应的Service来查询数据
        String serviceBeanId = StringUtils.uncapitalize(getEntityName(act.getProcInsId()) + "Service");
        Object bean = SpringContextHolder.getBean(serviceBeanId);
        Object data = Reflections.invokeMethod(bean, "get", new Class[]{String.class}, new Object[]{id});
        //去掉了自动转换字典类型数据的方法调用，将处理逻辑放到freemarker渲染的时候，可控性更好一点。
        return data;
    }

    /**
     * 获取formProperties String
     *
     * @param act 工作流程对象
     * @return 返回渲染之后的字符串
     */
    public String getFormPropertiesStr(Act act) {
        String formPropertiesStr = "";
        Task task = actTaskService.getTask(act.getTaskId());
        //取到上一步填写的信息
        formPropertiesStr += renderHistoryForm(act);

        if (null != task) {
            //任务存在，流程还没结束
            //获取当前task 中配置的表单
            FormService formService = actTaskService.getProcessEngine().getFormService();
            // Object formData = formService.getRenderedTaskForm(act.getTaskId());
            List<FormProperty> formProperties = formService.getTaskFormData(act.getTaskId()).getFormProperties();
            for (FormProperty formProperty : formProperties) {
                formPropertiesStr += renderForm(
                        formProperty.getId(),
                        formProperty.getName(),
                        formProperty.getType(),
                        null, false,
                        formProperty.isRequired());
            }
        }
        return formPropertiesStr;
    }

    public String getApproveStatus(Act act) {
        String approveStatus = "";
        List<Comment> commentList = actTaskService.getProcessEngine().getTaskService()
                .getProcessInstanceComments(act.getProcInsId());
        if (commentList.size() > 0) {
            Comment comment = commentList.get(0);
            approveStatus = comment.getFullMessage();
        }
        return approveStatus;
    }

    public String getContent(String templatePath,Act act,Object dataModel) throws Exception {
        /*
         * 每次进来先通过文件路径到缓存中去找，如果不存在，再去磁盘读取
         */
        String templateString;
        String keyStr = templatePath.substring(templatePath.lastIndexOf(File.separator)+1);
        templateString = (String) CacheUtils.get(keyStr);
        if(StringUtils.isBlank(templateString)){
            templateString = FileUtils.readFileToString(new File(templatePath), Charsets.toCharset("utf-8"));
            CacheUtils.put(keyStr,templateString);
        }
        Map<String, Object> context = new HashMap<>();
        context.put("getDictLabel",new FreeMarkerDictHandler());
        context.put("getAttachLabel",new FreeMarkerAttachHandler());
        context.put(StringUtils.uncapitalize(getEntityName(act.getProcInsId())), dataModel);

        return FreeMarkers.renderString("Activiti form", templateString, context);
    }

    @Transactional
    public void saveProcess(Act act, HttpServletRequest request) throws Exception {
        FormService formService = actTaskService.getProcessEngine().getFormService();
        Map<String, Object> variables = new HashMap<>();
        variables.put("pass", ACT_STATUS_YES.equals(act.getFlag()) ? "1" : "0");
        List<FormProperty> list = formService.getTaskFormData(act.getTaskId()).getFormProperties();
        Map<String, String> formValues = new HashMap<>();
        for (FormProperty fp : list) {
            String value = request.getParameter(fp.getId());
            formValues.put(fp.getId() + "_" + fp.getName(), value);
            formValues.put(fp.getId(),value);
            formService.saveFormData(act.getTaskId(), formValues);
        }
        variables.put("status", ACT_STATUS_YES.equals(act.getFlag()) ? "同意" : "驳回");
        String entityName = getEntityName(act.getProcInsId());
        if("no".equals(act.getFlag())){
            String id = getBusinessId(act.getProcInsId());
            String sourceUrl = "/gsp/"+ entityName.toLowerCase()+"/"+StringUtils.uncapitalize(entityName)+"/form?id="+id;
            HistoricVariableInstance sourceUrl2 = actTaskService.getProcessEngine().getHistoryService().createHistoricVariableInstanceQuery()
                    .processInstanceId(act.getProcInsId()).variableName("sourceUrl").singleResult();
            if(null == sourceUrl2 || "".equals(sourceUrl2.getValue())){
                variables.put("sourceUrl",sourceUrl);
            }else {
                variables.put("sourceUrl","");
            }
        }
        actTaskService.complete(act.getTaskId(), act.getProcInsId(), "yes".equals(act.getFlag()) ? "【同意】" : "【驳回】", variables);
        //更新业务表状态
        String id = getBusinessId(act.getProcInsId());
        String businessTable = getBusinessTable(act.getProcInsId());
        if (businessTable!= null && !businessTable.equals ("")
                && id!= null && !id.equals (""))
        {
            actActionInvoke(act,id);

            Act act1 = new Act();
            act1.setBusinessTable(businessTable);// 业务表名
            act1.setBusinessId(id);  // 业务表ID
            act1.setStatus(isPassed(act));
            actDao.updateStatusByBusinessId(act1);
        }
        T01OperateHist t01OperateHist = new T01OperateHist();
        t01OperateHist.setModule(getModuleFromTable(businessTable));
        t01OperateHist.setDataId(id);
        t01OperateHist.setDescription(request.getParameter("apprOpin"));
        //当审批通过时调用
        if (ACT_STATUS_YES.equals(act.getFlag())) {
            t01OperateHist.setOperateType("3");
        } else {
            t01OperateHist.setOperateType("4");
        }
        t01OperateHist.preInsert();
        commonDao.insertT01OperateHist(t01OperateHist);
    }

    private String isPassed(Act act) {
        return ACT_STATUS_YES.equals(act.getFlag()) ? ApprStatus.PASS.toString() : ApprStatus.NOPASS.toString();
    }

    /**
     * 调用actActionInvoke接口的方法
     * @param act 工作流对象
     * @param businessId 业务表ID
     */
    public void actActionInvoke(Act act,String businessId) throws Exception {
        //得到对应的业务Service
        String serviceBeanId = StringUtils.uncapitalize(getEntityName(act.getProcInsId()) + "Service");
        Object bean = SpringContextHolder.getBean(serviceBeanId);

        //当业务service实现了ActActionInvoke接口则调用
        if (bean instanceof ActActionInvoke) {
            ActActionInvoke actActionInvoke = (ActActionInvoke) bean;
            //当审批通过时调用
            if (ACT_STATUS_YES.equals(act.getFlag())) {
                actActionInvoke.actPassInvoke(businessId);
            }else {
                actActionInvoke.actNoPassInvoke(businessId);
            }
        }
    }

    /**
     * 获取业务模板路径
     *
     * @param request  请求对象
     * @param viewName 视图名(要跳转的jsp名称)
     * @return 返回业务数据展示模板的地址
     */
    public String getTemplatePath(HttpServletRequest request,Act act,String viewName) {
        String entityName = getEntityName(act.getProcInsId());
        if (viewName == null || viewName.isEmpty())
            viewName = entityName + "ShowForm";

        String path = request.getSession().getServletContext().getRealPath("/");
        String templatePath = new StringBuilder().append(path).append("WEB-INF/views/modules/gsp").append("/")
                .append(StringUtils.lowerCase(entityName))
                .append("/").append(viewName).append(".jsp").toString();

        templatePath = templatePath.replace("/", File.separator);
        logger.info("文件地址："+templatePath);
        return templatePath;
    }

    /**
     * 手动渲染配置的formproperty
     *
     * @param name     form 表单的name属性值
     * @param label    form 表单的显示值
     * @param type     form 表单的类型（type属性值）
     * @param value    form 表单的值
     * @param disabled 是否可编辑
     * @return 返回渲染后的表单String 字符串
     */
    private String renderForm(String name, String label, FormType type, Object value, boolean disabled, boolean isRequried) {
        StringBuilder formSb = new StringBuilder();
        formSb.append("<label class=\"control-label\">");
        if(isRequried){
            formSb.append("<span class=\"help-inline\"><font color=\"red\">*</font></span>");
        }
        formSb.append(label).append("：").append("</label>");
        String inputType = "";
        if (null != type) {
            inputType = type.getName();
        }
        if ("string".equals(inputType)) {
            formSb.append("<div class=\"controls\">");
            formSb.append("<textarea maxlength=\"250\" ");
            if(isRequried){
                formSb.append(" class=\"required\"");
            }
            formSb.append(" name=\"").append(name).append("\"").append(disabled ? " disabled" : "").append(">").append(value==null ? "" : value).append("</textarea>");
            formSb.append("</div>");
        } else if ("date".equals(inputType)) {
            formSb.append(" <input type=\"date\" ");
            if(isRequried){
                formSb.append(" required=\"required\"");
            }
            formSb.append("value=").append(value==null ? "" : value).append("\"");
            formSb.append(" name=\"").append(name).append("\"").append(disabled ? " disabled" : "").append("/>");
        } else if("enum".equals(inputType)){
        	
        	formSb.append("<select>");
        	 
        	Map<String, String> values;
            values = (Map<String, String>) type.getInformation("values");
            if (values != null) {
                for (Map.Entry<String, String> enumEntry : values.entrySet()){
                	formSb.append("<option value ="+enumEntry.getKey()+">"+enumEntry.getValue()+"</option>)");
                }
            }
            formSb.append("</select>");
        }else {
            formSb.append("<div  class=\"controls\">");
            formSb.append("<textarea ");
            if(isRequried){
                formSb.append(" required=\"required\"");
            }
            formSb.append(" name=\"").append(name).append("\"").append(disabled ? " disabled" : "").append(">").append(value==null ? "" : value).append("</textarea>");
            formSb.append("</div>");
        }
        formSb.append("<br/>");
        return formSb.toString();
    }

    /**
     * 获取历史表单信息
     *
     * @return formPropertiesStr
     */
    private String renderHistoryForm(Act act) {
        String formPropertiesStr = "";
        //取到上一步填写的信息
        List<HistoricDetail> list = actTaskService.getProcessEngine().getHistoryService().createHistoricDetailQuery()
                .processInstanceId(act.getProcInsId())
                .formProperties().orderByTime().asc().list();
        for (HistoricDetail hd : list) {
            HistoricFormPropertyEntity hpe = (HistoricFormPropertyEntity) hd;
            String[] names = hpe.getPropertyId().split("_");
            String value = hpe.getPropertyValue();
            if (names.length > 1) {
                formPropertiesStr += renderOnlyFormString(names[0], names[1], value);
            }
        }
        return formPropertiesStr;
    }

    /**
     * 渲染只读的form表单数据
     *
     * @param name  form表单name属性值
     * @param label form表单的显示 名称
     * @param value form表单的值
     * @return 返回渲染后的只读的form表单String
     */
    private String renderOnlyFormString(String name, String label, Object value) {
        return renderForm(name, label, null, value, true, false);
    }

    /**
     * 将实体数据中的字典项转换为显示内容
     *
     * 暂时不用
     * 已经用freemarker 的自定义方法代替了
     *
     * @param obj 实体数据
     * @return 转换后的实体数据
     */
    private Object translateDictEntity(Object obj) {
        Class<?> tClass = obj.getClass();
        String className = tClass.getSimpleName();
        String tableName = StringUtils.toUnderScoreCase(StringUtils.uncapitalize(className));
        List<GenTableColumn> tableColumns = actDao.getDictTypeFields(tableName);
        for(GenTableColumn tc : tableColumns){
            String dictType = tc.getDictType();
            String fieldName = StringUtils.toCamelCase(tc.getName());
            String dictStr = (String)Reflections.invokeGetter(obj, fieldName);
            if(StringUtils.isNotEmpty(dictStr)){
                String label = DictUtils.getDictLabels(dictStr,dictType,"");
                Reflections.invokeSetter(obj,fieldName,label);
            }
        }
        return obj;
    }

    /**
     * 获取业务表表名
     * @param procInsId 流程id
     * @return 业务表表名
     */
    private String getBusinessTable(String procInsId){
        String entityName = "";
        String businessKey = actTaskService.getProcessEngine().getHistoryService().createHistoricProcessInstanceQuery()
                .processInstanceId(procInsId).singleResult().getBusinessKey();
        if(StringUtils.isNotEmpty(businessKey)){
            String[] split = businessKey.split(":");
            if(split.length>1){
                entityName = split[0];
            }
        }
        return  entityName;
    }

    /**
     * 获取业务记录 id
     * @param procInsId 流程id
     * @return 流程id
     */
    private String getBusinessId(String procInsId){
        String id = "";
        String businessKey = actTaskService.getProcessEngine().getHistoryService().createHistoricProcessInstanceQuery()
                .processInstanceId(procInsId).singleResult().getBusinessKey();
        if(StringUtils.isNotEmpty(businessKey)){
            String[] split = businessKey.split(":");
            if(split.length>1){
                id = split[1];
            }
        }
        return  id;
    }

    /**
     * 获取业务entity名称
     * @param procInsId 流程id
     * @return  业务entity名称
     */
    private String getEntityName(String procInsId){
        return StringUtils.toCamelCase(getBusinessTable(procInsId));
    }
}

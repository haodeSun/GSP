package com.thinkgem.jeesite.modules.gen.entity;

import com.thinkgem.jeesite.common.mapper.adapters.MapAdapter;

import javax.xml.bind.annotation.*;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 暂时只考虑模板覆盖，不考虑引入新的Type
 * @author Greg Song
 * @since 04/11/2016
 */
@XmlRootElement(name = "config")
public class GenOverrideConfig implements Serializable{
    private List<TableConf> tableList = new ArrayList<>();    // 要覆盖的表
    public void addTable(TableConf table){
        tableList.add(table);
    }

    @XmlElementWrapper(name = "tables")
    @XmlElement(name = "table")
    public List<TableConf> getTableList() {
        return tableList;
    }

    public void setTableList(List<TableConf> tableList) {
        this.tableList = tableList;
    }

    @XmlRootElement(name = "table")
    static public class TableConf {
        private String name = "";
        private Boolean workflow=false;

        private List<CategoryConf> categoryConfList = new ArrayList<>();	// 代码模板分类
        public void addCategory(CategoryConf category){
            categoryConfList.add(category);
        }

        @XmlAttribute
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @XmlElementWrapper(name = "categories")
        @XmlElement(name = "category")
        public List<CategoryConf> getCategoryConfList() {
            return categoryConfList;
        }

        public void setCategoryConfList(List<CategoryConf> categoryConfList) {
            this.categoryConfList = categoryConfList;
        }

        @XmlAttribute
        public Boolean getWorkflow() {
            return workflow;
        }

        public void setWorkflow(Boolean workflow) {
            this.workflow = workflow;
        }
    }
    @XmlRootElement(name = "category")
    static public class CategoryConf{
        private String name="";

        private List<TemplateConf> templateConfList = new ArrayList<>();

        public void addTemplateConf(TemplateConf template){
            templateConfList.add(template);
        }

        @XmlAttribute
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @XmlElement(name = "template")
        public List<TemplateConf> getTemplateConfList() {
            return templateConfList;
        }

        public void setTemplateConfList(List<TemplateConf> templateConfList) {
            this.templateConfList = templateConfList;
        }
    }
    @XmlRootElement(name = "template")
    static public class TemplateConf{
        private String path;
        private String type;
        private Map<String, String> context = new HashMap<>();
        private List<ActionConf> actions = new ArrayList<>();

        public void addContext(String key, String value){
            context.put(key, value);
        }

        @XmlElement
        public String getPath() {
            return path;
        }

        public void setPath(String path) {
            this.path = path;
        }

        @XmlAttribute
        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        @XmlJavaTypeAdapter(MapAdapter.class)
        public Map<String, String> getContext() {
            return context;
        }

        public void setContext(Map<String, String> context) {
            this.context = context;
        }

        @XmlElementWrapper(name="actions")
        @XmlElement(name="action")
        public List<ActionConf> getActions() {
            return actions;
        }

        public void setActions(List<ActionConf> actions) {
            this.actions = actions;
        }
    }

    @XmlRootElement(name = "action")
    static public class ActionConf{
        private String name;
        private String icon;
        private String displayValue;
        private String permission;
        private String method="GET";

        @XmlAttribute(name = "name")
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @XmlAttribute(name = "icon")
        public String getIcon() {
            return icon;
        }

        public void setIcon(String icon) {
            this.icon = icon;
        }

        @XmlAttribute(name="display")
        public String getDisplayValue() {
            return displayValue;
        }

        public void setDisplayValue(String displayValue) {
            this.displayValue = displayValue;
        }

        @XmlAttribute(name="permission")
        public String getPermission() {
            return permission;
        }

        public void setPermission(String permission) {
            this.permission = permission;
        }

        @XmlAttribute(name="method")
        public String getMethod() {
            return method;
        }

        public void setMethod(String method) {
            this.method = method;
        }
    }
}

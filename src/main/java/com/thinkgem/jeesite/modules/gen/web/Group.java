package com.thinkgem.jeesite.modules.gen.web;

import com.thinkgem.jeesite.modules.gen.entity.GenTableColumn;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Greg Song
 * @since 02/11/2016
 */
public class Group {
    private Integer priority = -1;
    private List<GenTableColumn> columns = new ArrayList<>();
    private String groupName = "";

    public Group(Integer priority, List<GenTableColumn> columns, String groupName) {
        this.priority = priority;
        this.columns = columns;
        this.groupName = groupName;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public List<GenTableColumn> getColumns() {
        return columns;
    }

    public void setColumns(List<GenTableColumn> columns) {
        this.columns = columns;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
}

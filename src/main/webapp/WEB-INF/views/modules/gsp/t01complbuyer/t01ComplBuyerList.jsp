<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>首营购货者管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="Part_ListHeadJS.jsp" %>
    <script>
        $(document).ready(function(){
            setTableDefault("t01ComplBuyer","${ctx}/sys/user/getSysUserConfig");
            holdTable("t01ComplBuyer","${ctx}/sys/user/setSysUserConfig");
        })
    </script>
</head>
<body>

<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>首营购货者<span class="divider">&gt;</span></li>
    <li class="active">首营购货者查询</li>
</ul>

<div id="topTitle">首营购货者查询</div>

<form:form id="searchForm" modelAttribute="t01ComplBuyer" action="${ctx}/gsp/t01complbuyer/t01ComplBuyer/" method="post"
           class="breadcrumb form-search">
    <%@include file="Part_ListForm.jsp" %>
</form:form>
<sys:message content="${message}"/>
<shiro:hasPermission name="gsp:t01complbuyer:t01ComplBuyer:edit">
    <a href="${ctx}/gsp/t01complbuyer/t01ComplBuyer/form"><span class="modifySpan newBtn btn btn-primary">新增</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complbuyer:t01ComplBuyer:edit">
    <a href="javascript:void(0)" onclick="toEdit()"><span class="modifySpan newBtn btn btn-primary">修改</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complbuyer:t01ComplBuyer:delete">
    <a href="javascript:void(0)" onclick="toDelete()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complbuyer:t01ComplBuyer:change">
    <a href="javascript:void(0)" onclick="toChange()"><span class="modifySpan newBtn btn btn-primary">变更</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complbuyer:t01ComplBuyer:appr">
    <a href="javascript:void(0)" onclick="toAppr()"><span class="modifySpan newBtn btn btn-primary">审批</span></a>
</shiro:hasPermission>

<sys:operateButton module="t01ComplBuyer" forward="${ctx}/gsp/t01complbuyer/t01ComplBuyer/toDetail"/>

<%@include file="Part_ListTable.jsp" %>

<input id="exportUrl" type="hidden" value="${ctx}/gsp/t01complbuyer/t01ComplBuyer/export">
<script>
    function toEdit() {
        oneDataEdit(function (id) {
            var checkUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/checkStatusBeforeHandle";
            var editUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/form";
            baseEditFunction(checkUrl, id, editUrl);
        })
    }
    function toDelete() {
        oneDataDelete(function (id) {
            var checkUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/checkStatusBeforeHandle";
            var deleteUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/delete";
            baseDeleteFunction(checkUrl, id, deleteUrl);
        })
    }
    function toChange() {
        oneDataChange(function (id) {
            var checkUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/checkStatusBeforeHandle";
            var changeUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/formChange";
            baseChangeFunction(checkUrl, id, changeUrl);
        })
    }
    function toAppr() {
        oneDataAppr(function (id) {
            var checkUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/checkStatusBeforeHandle";
            var apprUrl = "${ctx}/gsp/t01complbuyer/t01ComplBuyer/toApprDetail";
            baseApprFunction(checkUrl, id, apprUrl);
        })
    }
</script>
</body>
</html>
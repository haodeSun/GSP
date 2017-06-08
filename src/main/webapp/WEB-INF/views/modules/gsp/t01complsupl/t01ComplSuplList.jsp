<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营供货者管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="Part_ListHeadJS.jsp" %>
	<script>
		$(document).ready(function(){
			setTableDefault("t01ComplSupl","${ctx}/sys/user/getSysUserConfig");
			holdTable("t01ComplSupl","${ctx}/sys/user/setSysUserConfig");
		})
	</script>
</head>
<body>

<ul class="breadcrumb">
	<li>首页<span class="divider">&gt;</span></li>
	<li>首营供货者<span class="divider">&gt;</span></li>
	<li class="active">首营供货者查询</li>
</ul>

<div id="topTitle">首营供货者查询</div>

<form:form id="searchForm" modelAttribute="t01ComplSupl" action="${ctx}/gsp/t01complsupl/t01ComplSupl/" method="post" class="breadcrumb form-search">
	<%@include file="Part_ListForm.jsp" %>
</form:form>
<sys:message content="${message}"/>
<shiro:hasPermission name="gsp:t01complsupl:t01ComplSupl:edit">
<a href="${ctx}/gsp/t01complsupl/t01ComplSupl/form"><span class="modifySpan newBtn btn btn-primary">新增</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complsupl:t01ComplSupl:edit">
	<a href="javascript:void(0)" onclick="toEdit()"><span class="modifySpan newBtn btn btn-primary">修改</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complsupl:t01ComplSupl:delete">
	<a href="javascript:void(0)" onclick="toDelete()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complsupl:t01ComplSupl:change">
	<a href="javascript:void(0)" onclick="toChange()"><span class="modifySpan newBtn btn btn-primary">变更</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01complsupl:t01ComplSupl:appr">
	<a href="javascript:void(0)" onclick="toAppr()"><span class="modifySpan newBtn btn btn-primary">审批</span></a>
</shiro:hasPermission>

<sys:operateButton module="t01ComplSupl" forward="${ctx}/gsp/t01complsupl/t01ComplSupl/toDetail"/>

<%@include file="Part_ListTable.jsp" %>

<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01complsupl/t01ComplSupl/export" >
<script>
	function toEdit() {
		oneDataEdit(function (id) {
			var checkUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/checkStatusBeforeHandle";
			var editUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/form";
			baseEditFunction(checkUrl, id, editUrl);
		})
	}
	function toDelete() {
		oneDataDelete(function (id) {
			var checkUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/checkStatusBeforeHandle";
			var deleteUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/delete";
			baseDeleteFunction(checkUrl, id, deleteUrl);
		})
	}
	function toChange() {
		oneDataChange(function (id) {
			var checkUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/checkStatusBeforeHandle";
			var changeUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/formChange";
			baseChangeFunction(checkUrl, id, changeUrl);
		})
	}
	function toAppr() {
		oneDataAppr(function (id) {
			var checkUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/checkStatusBeforeHandle";
			var apprUrl = "${ctx}/gsp/t01complsupl/t01ComplSupl/toApprDetail";
			baseApprFunction(checkUrl, id, apprUrl);
		})
	}
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营购货者管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="Part_ListHeadJS.jsp" %>
	<script>
		$(document).ready(function(){
			setTableDefault("t01ComplBuyerAppr","${ctx}/sys/user/getSysUserConfig");
			holdTable("t01ComplBuyerAppr","${ctx}/sys/user/setSysUserConfig");
		})
	</script>
</head>
<body>

<ul class="breadcrumb">
	<li>首页<span class="divider">&gt;</span></li>
	<li>首营购货者<span class="divider">&gt;</span></li>
	<li class="active">首营购货者审批</li>
</ul>

<div id="topTitle">首营购货者审批</div>

<form:form id="searchForm" modelAttribute="t01ComplBuyer" action="${ctx}/gsp/t01complbuyer/t01ComplBuyer/toAppr" method="post" class="breadcrumb form-search">
	<%@include file="Part_ListForm.jsp" %>
</form:form>
<sys:message content="${message}"/>
	<a href="javascript:void(0)" onclick="toAppr()"><span class="modifySpan newBtn btn btn-primary">审批</span></a>

<%@include file="Part_ListTable.jsp" %>

<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01complbuyer/t01ComplBuyer/export?fromUrl=toAppr" >

<form id="apprForm" style="display:none;" action="${ctx}/gsp/t01complbuyer/t01ComplBuyer/toApprDetail" method="post">
	<input id="apprId" name="id" type="hidden" >
</form>
<script>
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
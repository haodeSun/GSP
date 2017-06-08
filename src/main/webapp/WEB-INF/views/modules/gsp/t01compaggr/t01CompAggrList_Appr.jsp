<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>协议管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="Part_ListHeadJS.jsp" %>
	<script>
		$(document).ready(function(){
			setTableDefault("t01CompAggrAppr","${ctx}/sys/user/getSysUserConfig");
			holdTable("t01CompAggrAppr","${ctx}/sys/user/setSysUserConfig");
		})
	</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>协议管理<span class="divider">&gt;</span></li>
		<li class="active">协议管理审批</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">协议管理审批</div>
	<!--20161113-->
	<form:form id="searchForm" modelAttribute="t01CompAggr" action="${ctx}/gsp/t01compaggr/t01CompAggr/toAppr" method="post" class="breadcrumb form-search">
		<%@include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>
	<shiro:hasPermission name="gsp:t01complprod:t01ComplProd:edit">
		<a href="javascript:void(0)" onclick="toAppr()"><span class="modifySpan newBtn btn btn-primary">审批</span></a>
	</shiro:hasPermission>

	<%@include file="Part_ListTable.jsp" %>

	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01compaggr/t01CompAggr/export?fromUrl=toAppr" >

	<form id="apprForm" style="display:none;" action="${ctx}/gsp/t01compaggr/t01CompAggr/toApprDetail" method="post">
		<input id="apprId" name="id" type="hidden" >
	</form>
	<script>
		function toAppr() {
			oneDataAppr(function (id) {
				var checkUrl = "${ctx}/gsp/t01compaggr/t01CompAggr/checkStatusBeforeHandle";
				var apprUrl = "${ctx}/gsp/t01compaggr/t01CompAggr/toApprDetail";
				baseApprFunction(checkUrl, id, apprUrl);
			})
		}
	</script>
</body>
</html>
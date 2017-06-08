<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售人员管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="Part_ListHeadJS.jsp"%>
	<script>
		$(document).ready(function(){
			setTableDefault("t01SalesCert","${ctx}/sys/user/getSysUserConfig");
			holdTable("t01SalesCert","${ctx}/sys/user/setSysUserConfig");
		})
	</script>
</head>
<body>
	<ul class="breadcrumb">
	  <li>首页<span class="divider">&gt;</span></li>
	  <li>销售人员授权<span class="divider">&gt;</span></li>
	  <li class="active">销售人员授权查询</li>
	</ul>
	<div id="topTitle">销售人员授权查询</div>
	
	<form:form id="searchForm" modelAttribute="t01SalesCert" action="${ctx}/gsp/t01salescert/t01SalesCert/" method="post" class="breadcrumb form-search">
		<%@include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>

	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">
		<a href="${ctx}/gsp/t01salescert/t01SalesCert/form"><span class="modifySpan newBtn btn btn-primary">新增</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">
		<a href="javascript:void(0)" onclick="toEdit()"><span class="modifySpan newBtn btn btn-primary">修改</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">
		<a href="javascript:void(0)" onclick="toDelete()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
	</shiro:hasPermission>

	<%@include file="Part_ListTable.jsp" %>
	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01salescert/t01SalesCert/export" >
	<script>
		function toEdit() {
			oneDataEdit(function (id) {
				var checkUrl = "${ctx}/gsp/t01salescert/t01SalesCert/checkStatusBeforeHandle";
				var editUrl = "${ctx}/gsp/t01salescert/t01SalesCert/form";
				baseEditFunction(checkUrl, id, editUrl);
			})
		}
		function toDelete() {
			oneDataDelete(function (id) {
				var checkUrl = "${ctx}/gsp/t01salescert/t01SalesCert/checkStatusBeforeHandle";
				var deleteUrl = "${ctx}/gsp/t01salescert/t01SalesCert/delete";
				baseDeleteFunction(checkUrl, id, deleteUrl);
			})
		}
	</script>
</body>
</html>
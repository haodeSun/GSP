<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售人员管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<ul class="breadcrumb">
	<li>首页<span class="divider">&gt;</span></li>
	<li>销售人员授权<span class="divider">&gt;</span></li>
	<li class="active">销售人员授权删除</li>
</ul>
	<div id="topTitle">销售人员授权删除</div>

	<form:form id="searchForm" modelAttribute="t01SalesCert" action="${ctx}/gsp/t01salescert/t01SalesCert/" method="post" class="breadcrumb form-search">
		<%@include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>

	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">
		<a href="javascript:void(0)" onclick="toDelete()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
	</shiro:hasPermission>

	<%@include file="Part_ListTable.jsp" %>
	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01salescert/t01SalesCert/export" >
	<script>
		function toDelete() {
			var editId = "";
			var selectedNum = 0;
			$('#contentTable tbody input[type="checkbox"]').each(function () {
				if (this.checked == true) {
					editId = $(this).attr("data-id").trim();
					selectedNum++;
				}
			});

			if (selectedNum > 1) {
				alertx("只能选择一条数据修改！");
				return false;
			} else if (selectedNum == 0) {
				alertx("请选择一条数据修改！");
				return false;
			} else {
				window.location.href = "${ctx}/gsp/t01salescert/t01SalesCert/delete?id=" + editId;
			}
		}
	</script>
</body>
</html>
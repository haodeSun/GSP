<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>物料信息管理</title>
	<meta name="decorator" content="default"/>
	<%--HeadJS模块--%>
	<%@ include file="Part_ListHeadJS.jsp" %>
</head>
<body>

	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>物料信息<span class="divider">&gt;</span></li>
		<li class="active">物料信息审批</li>
	</ul>

	<div id="topTitle">物料信息审批</div>

	
	<%--Form模块--%>
	<form:form id="searchForm" modelAttribute="t01MatrInfo" action="${ctx}/gsp/t01matrinfo/t01MatrInfo/toAppr" method="post"
			   class="breadcrumb form-search">
	<%@ include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>

	<%--审批--%>
	<a href="javascript:void(0)" onclick="apprSelected()"><span class="modifySpan newBtn btn btn-primary">审批</span></a>

	<%--Table模块--%>
	<%@ include file="Part_ListTable.jsp" %>

	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01matrinfo/t01MatrInfo/export?fromUrl=toAppr" >
	<form id="apprForm" style="display:none;" action="${ctx}/gsp/t01matrinfo/t01MatrInfo/toApprDetail" method="post">
	<input id="apprId" name="id" type="hidden" >
	</form>
	<script>
		function apprSelected() {
			var apprId = "";
			var selectedNum = 0;
			$('#contentTable tbody input[type="checkbox"]').each(function () {
				if (this.checked == true) {
					apprId = $(this).attr("data-id").trim();
					selectedNum++;
				}
			});

			if (selectedNum > 1) {
				alertx("只能选择一条数据审批！");
				return false;
			} else if (selectedNum == 0) {
				alertx("请选择一条数据审批！");
				return false;
			} else {
				$("#apprId").val(apprId);
				$("#apprForm").submit();
			}
		}
	</script>
</body>
</html>
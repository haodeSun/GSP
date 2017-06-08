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
		<li class="active">物料信息删除</li>
	</ul>

	<div id="topTitle">物料信息删除</div>
	
	<%--Form模块--%>
	<form:form id="searchForm" modelAttribute="t01MatrInfo" action="${ctx}/gsp/t01matrinfo/t01MatrInfo/toDelete" method="post"
			   class="breadcrumb form-search">
	<%@ include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>
	<%--删除--%>
	<shiro:hasPermission name="gsp:t01matrinfo:t01MatrInfo:delete">
		<a href="javascript:void(0)" onclick="deleteSelected()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
	</shiro:hasPermission>

	<%--Table模块--%>
	<%@ include file="Part_ListTable.jsp" %>

	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01matrinfo/t01MatrInfo/export?fromUrl=toDelete" >
	<form id="deleteForm" style="display:none;" action="${ctx}/gsp/t01matrinfo/t01MatrInfo/deleteMatrInfo" method="post">
	<input id="deleteId" name="id" type="hidden" >
	</form>
	<script>
		function deleteSelected() {
			var seletedIds = "";
			var selectedNum = 0;
			$('#contentTable tbody input[type="checkbox"]').each(function () {
				if (this.checked == true) {
					seletedIds = $(this).attr("data-id").trim();
					selectedNum++;
				}
			});
			if (selectedNum > 1) {
				alertx("只能选择一条数据删除！");
				return false;
			} else if (selectedNum == 0) {
				alertx("请选择一条数据删除！");
				return false;
			} else {
				confirmx('一旦删除数据将无法恢复，请确认是否删除？', function () {
					$("#deleteId").val(seletedIds);
					$("#deleteForm").submit();
				})
			}
		}
	</script>
</body>
</html>
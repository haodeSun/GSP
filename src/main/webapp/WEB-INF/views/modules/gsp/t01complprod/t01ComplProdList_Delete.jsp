<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>首营产品管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="Part_ListHeadJS.jsp" %>
</head>
<body>

<ul class="breadcrumb">
	<li>首页<span class="divider">&gt;</span></li>
	<li>首营产品<span class="divider">&gt;</span></li>
	<li class="active">首营产品删除</li>
</ul>

	<div id="topTitle">首营产品删除</div>
	
	<form:form id="searchForm" modelAttribute="t01ComplProd" action="${ctx}/gsp/t01complprod/t01ComplProd/toDelete" method="post" class="breadcrumb form-search">
    <%@include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>

	<a href="javascript:void(0)" onclick="deleteSelected()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
    
    <%@include file="Part_ListTable.jsp" %>

	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01complprod/t01ComplProd/export?fromUrl=toDelete" >
	<form id="deleteForm" style="display:none;" action="${ctx}/gsp/t01complprod/t01ComplProd/deleteComplProd" method="post">
		<input id="deleteId" name="complProdCertId" type="hidden" >
	</form>
	<form id="deleteForm2" style="display:none;" action="${ctx}/gsp/t01complprod/t01ComplProd/deleteComplProd" method="post">
		<input name="id" type="hidden" >
	</form>
	<script>
		function deleteSelected() {
			var seletedIds = "";
			var selectedNum = 0;
			$('#contentTable tbody input[type="checkbox"]').each(function () {
				if (this.checked == true) {
					seletedIds = $(this).attr("data-deleteId").trim();
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
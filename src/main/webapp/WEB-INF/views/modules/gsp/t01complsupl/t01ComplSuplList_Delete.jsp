<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营供货者管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="Part_ListHeadJS.jsp" %>
</head>
<body>

<ul class="breadcrumb">
	<li>首页<span class="divider">&gt;</span></li>
	<li>首营供货者<span class="divider">&gt;</span></li>
	<li class="active">首营供货者删除</li>
</ul>

<div id="topTitle">首营供货者删除</div>

<form:form id="searchForm" modelAttribute="t01ComplSupl" action="${ctx}/gsp/t01complsupl/t01ComplSupl/toDelete" method="post" class="breadcrumb form-search">
	<%@include file="Part_ListForm.jsp" %>
</form:form>
<sys:message content="${message}"/>

	<a href="javascript:void(0)" onclick="toDelete()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>

<%@include file="Part_ListTable.jsp" %>

<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01complsupl/t01ComplSupl/export?fromUrl=toDelete" >
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
			alertx("只能选择一条数据记录！");
			return false;
		} else if (selectedNum == 0) {
			alertx("请选择一条数据记录！");
			return false;
		} else {
			confirmx('一旦删除数据将无法恢复，请确认是否删除？',function(){
			window.location.href = "${ctx}/gsp/t01complsupl/t01ComplSupl/delete?id=" + editId;
			});
		}
	}
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>首营产品管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="Part_ListHeadJS.jsp" %>
	<script>
        $(document).ready(function(){
            setTableDefault("t01ComplProd","${ctx}/sys/user/getSysUserConfig");
            holdTable("holdTable","t01ComplProd","${ctx}/sys/user/setSysUserConfig");
        })
	</script>
</head>
<body>

	<ul class="breadcrumb">
	  <li>首页<span class="divider">&gt;</span></li>
	  <li>首营产品<span class="divider">&gt;</span></li>
	  <li class="active">首营产品查询</li>
	</ul>

	<div id="topTitle">首营产品查询</div>

	<form:form id="searchForm" modelAttribute="t01ComplProd" action="${ctx}/gsp/t01complprod/t01ComplProd/" method="post" class="breadcrumb form-search">
    <%@include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>
	<shiro:hasPermission name="gsp:t01complprod:t01ComplProd:edit">
		<a href="javascript:void(0)" onclick="toEdit()"><span class="modifySpan newBtn btn btn-primary">修改</span></a>
	</shiro:hasPermission>

    <%@include file="Part_ListTable.jsp" %>

	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01complprod/t01ComplProd/export" >
<script>
	function toEdit() {
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
			window.location.href = "${ctx}/gsp/t01complprod/t01ComplProd/form?id=" + editId;
		}
	}
</script>
</body>
</html>
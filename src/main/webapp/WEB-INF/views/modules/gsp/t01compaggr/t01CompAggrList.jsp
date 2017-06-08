<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>协议管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="Part_ListHeadJS.jsp" %>
	<script>
        $(document).ready(function(){
            setTableDefault("t01CompAggr","${ctx}/sys/user/getSysUserConfig");
            holdTable("t01CompAggr","${ctx}/sys/user/setSysUserConfig");
        })
	</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
	  <li>首页<span class="divider">&gt;</span></li>
	  <li>协议管理<span class="divider">&gt;</span></li>
	  <li class="active">协议管理查询</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">协议管理查询</div>
	<!--20161113-->
	
	<form:form id="searchForm" modelAttribute="t01CompAggr" action="${ctx}/gsp/t01compaggr/t01CompAggr/" method="post" class="breadcrumb form-search">
		<%@include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>
	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">
		<a href="${ctx}/gsp/t01compaggr/t01CompAggr/form"><span class="modifySpan newBtn btn btn-primary">新增</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">
		<a href="javascript:void(0)" onclick="toEdit()"><span class="modifySpan newBtn btn btn-primary">修改</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:delete">
		<a href="javascript:void(0)" onclick="toDelete()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:appr">
		<a href="javascript:void(0)" onclick="toAppr()"><span class="modifySpan newBtn btn btn-primary">审批</span></a>
	</shiro:hasPermission>
	<sys:operateButton module="t01CompAggr" forward="${ctx}/gsp/t01compaggr/t01CompAggr/toDetail"/>

	<%@include file="Part_ListTable.jsp" %>
	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01compaggr/t01CompAggr/export" >
	<script>
		function toEdit() {
			oneDataEdit(function (id) {
				var checkUrl = "${ctx}/gsp/t01compaggr/t01CompAggr/checkStatusBeforeHandle";
				var editUrl = "${ctx}/gsp/t01compaggr/t01CompAggr/form";
				baseEditFunction(checkUrl, id, editUrl);
			})
		}
		function toDelete() {
			oneDataDelete(function (id) {
				var checkUrl = "${ctx}/gsp/t01compaggr/t01CompAggr/checkStatusBeforeHandle";
				var deleteUrl = "${ctx}/gsp/t01compaggr/t01CompAggr/delete";
				baseDeleteFunction(checkUrl, id, deleteUrl);
			})
		}
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
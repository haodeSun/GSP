<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>预警过滤配置管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
	  <li><a href="#">首页</a> <span class="divider">/</span></li>
	  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
	  <li class="active">预警过滤配置删除</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">预警过滤配置删除</div>
	<!--20161113-->
	<div id="selectGroup" class="accordion-group">
		<span>查询条件</span>
		<select name='' aria-required=true' class='form-control' id='querySelect' style="width:200px;margin-left:15px;"></select>
		<button id="addCondition" class="btn btn-primary" style="margin-left:40px;" onclick="addCondition()">添加条件</button>
		<button id="btnSubmit" class="btn btn-primary" style="margin-left:40px;" onclick="submitThisForm()">查询</button>
	</div>
	<form:form id="searchForm" modelAttribute="sysAlarmFilter" action="${ctx}/sys/sysAlarmFilter/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="conditionOrder" name="conditionOrder" type="hidden" value="${conditionOrder}">
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div id="foldList" class="accordion-group">
		    <div class="accordion-heading">
		      	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
		        	折叠列表
		      	</a>
		    </div>
		    <div id="collapseOne" class="accordion-body collapse in">
		      	<div class="accordion-inner">
					<ul  id="conditionOrderUl" class="ul-form">
					
					</ul>
				</div>
		    </div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<!-- 表单上部的按钮组，左侧的按键如修改、删除、审批的href的id值可以留空，前台会传入数据 (新的class：newBtn)-->
	<shiro:hasPermission name="sys:sysAlarmFilter:edit">
		<a href="javascript:void(0);" onclick="delteItem('${ctx}/sys/sysAlarmFilter/delete');"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
		<a href="${ctx}/sys/sysAlarmFilter/form"><span class="newBtn btn btn-primary">添加</span></a>
	</shiro:hasPermission>
	<!-- 表单的列名称下拉项以及导出按钮 -->
	<span class="checkOut newBtn btn btn-primary" onclick="exportThis()">导出</span>
	<span class="printSpan newBtn btn btn-primary" onclick="printThis(this)">打印</span>
	<div id="columnNameDiv" class="btn-group">
	  	<a class="newBtn btn dropdown-toggle" data-toggle="dropdown" href="#">
	   		 列名称<span class="caret"></span>
	  	</a>
	 	<ul id="columnName" class="dropdown-menu">
	 	</ul>
	</div>
  <!----------------------------------->
  <div id="borderScroll" style="width:99%; overflow: auto;">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
				<th>过滤规则</th>
				<th>包含关系</th>
				<!--<shiro:hasPermission name="sys:sysAlarmFilter:edit"><th>操作</th></shiro:hasPermission>-->
			</tr>
		</thead>
		<tbody>
		<%!
			int count = 1;
		%>

		<c:forEach items="${page.list}" var="sysAlarmFilter">
			<%
                count++;
            %>
			<tr>
				<td><input id="checkbox_a<%= count %>" class="chk_1" type="checkbox" onchange="checkAll()" data-id="${sysAlarmFilter.id}"/><label for="checkbox_a<%= count %>"></label></td>
				<td><a href="${ctx}/sys/sysAlarmFilter/form?id=${sysAlarmFilter.id}">
					${sysAlarmFilter.role}
				</a></td>
				<td>
					${sysAlarmFilter.included}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
	<div class="pagination">${page}</div>
</body>
</html>
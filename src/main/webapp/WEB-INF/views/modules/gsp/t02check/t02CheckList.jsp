<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/gsp/t02check/t02Check/">检查信息列表</a></li>
		<shiro:hasPermission name="gsp:t02check:t02Check:edit"><li><a href="${ctx}/gsp/t02check/t02Check/form">检查信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02Check" action="${ctx}/gsp/t02check/t02Check/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>id：</label>
				<form:input path="id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>创建人：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Check.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Check.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>库房：</label>
				<form:input path="inventory" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>时间：</label>
				<form:input path="time" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>项目：</label>
				<form:input path="item" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>结论：</label>
				<form:input path="conclusion" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>处理措施：</label>
				<form:input path="handMeas" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>操作人：</label>
				<form:input path="operator" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>id</th>
				<th>创建人</th>
				<th>创建时间</th>
				<th>更新人</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>流程实例ID</th>
				<th>库房</th>
				<th>时间</th>
				<th>项目</th>
				<th>结论</th>
				<th>处理措施</th>
				<th>操作人</th>
				<shiro:hasPermission name="gsp:t02check:t02Check:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02Check">
			<tr>
				<td><a href="${ctx}/gsp/t02check/t02Check/form?id=${t02Check.id}">
					${t02Check.id}
				</a></td>
				<td>
					${t02Check.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Check.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Check.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Check.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Check.remarks}
				</td>
				<td>
					${t02Check.procInsId}
				</td>
				<td>
					${t02Check.inventory}
				</td>
				<td>
					${t02Check.time}
				</td>
				<td>
					${t02Check.item}
				</td>
				<td>
					${t02Check.conclusion}
				</td>
				<td>
					${t02Check.handMeas}
				</td>
				<td>
					${t02Check.operator}
				</td>
				<shiro:hasPermission name="gsp:t02check:t02Check:edit"><td>
    				<a href="${ctx}/gsp/t02check/t02Check/form?id=${t02Check.id}">修改</a>
					<a href="${ctx}/gsp/t02check/t02Check/delete?id=${t02Check.id}" onclick="return confirmx('确认要删除该检查信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
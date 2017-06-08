<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品审核管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t01prodrevi/t01ProdRevi/">产品审核列表</a></li>
		<shiro:hasPermission name="gsp:t01prodrevi:t01ProdRevi:edit"><li><a href="${ctx}/gsp/t01prodrevi/t01ProdRevi/form">产品审核添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t01ProdRevi" action="${ctx}/gsp/t01prodrevi/t01ProdRevi/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t01ProdRevi.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t01ProdRevi.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>删除标志：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>物料号：</label>
				<form:input path="mateNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>物料名称：</label>
				<form:input path="mateName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>注册证编号：</label>
				<form:input path="regiCertNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>产品名称：</label>
				<form:input path="prodName" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>删除标志</th>
				<th>流程实例ID</th>
				<th>物料号</th>
				<th>物料名称</th>
				<th>注册证编号</th>
				<th>产品名称</th>
				<shiro:hasPermission name="gsp:t01prodrevi:t01ProdRevi:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t01ProdRevi">
			<tr>
				<td><a href="${ctx}/gsp/t01prodrevi/t01ProdRevi/form?id=${t01ProdRevi.id}">
					${t01ProdRevi.id}
				</a></td>
				<td>
					${t01ProdRevi.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01ProdRevi.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01ProdRevi.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01ProdRevi.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01ProdRevi.remarks}
				</td>
				<td>
					${fns:getDictLabel(t01ProdRevi.delFlag, 'del_flag', '')}
				</td>
				<td>
					${t01ProdRevi.procInsId}
				</td>
				<td>
					${t01ProdRevi.mateNumb}
				</td>
				<td>
					${t01ProdRevi.mateName}
				</td>
				<td>
					${t01ProdRevi.regiCertNo}
				</td>
				<td>
					${t01ProdRevi.prodName}
				</td>
				<shiro:hasPermission name="gsp:t01prodrevi:t01ProdRevi:edit"><td>
    				<a href="${ctx}/gsp/t01prodrevi/t01ProdRevi/form?id=${t01ProdRevi.id}">修改</a>
					<a href="${ctx}/gsp/t01prodrevi/t01ProdRevi/delete?id=${t01ProdRevi.id}" onclick="return confirmx('确认要删除该产品审核吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t01company/t01Company/">企业信息列表</a></li>
		<shiro:hasPermission name="gsp:t01company:t01Company:edit"><li><a href="${ctx}/gsp/t01company/t01Company/form">企业信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t01Company" action="${ctx}/gsp/t01company/t01Company/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t01Company.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t01Company.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
			<li><label>编号：</label>
				<form:input path="compNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>企业名称（中文）：</label>
				<form:input path="compNameCn" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>企业名称（英文）：</label>
				<form:input path="compNameEn" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>简称：</label>
				<form:input path="abbreviation" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>描述：</label>
				<form:input path="description" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>注册号：</label>
				<form:input path="regiNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>编号</th>
				<th>企业名称（中文）</th>
				<th>企业名称（英文）</th>
				<th>简称</th>
				<th>描述</th>
				<th>注册号</th>
				<shiro:hasPermission name="gsp:t01company:t01Company:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t01Company">
			<tr>
				<td><a href="${ctx}/gsp/t01company/t01Company/form?id=${t01Company.id}">
					${t01Company.id}
				</a></td>
				<td>
					${t01Company.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01Company.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01Company.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01Company.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01Company.remarks}
				</td>
				<td>
					${t01Company.procInsId}
				</td>
				<td>
					${t01Company.compNumb}
				</td>
				<td>
					${t01Company.compNameCn}
				</td>
				<td>
					${t01Company.compNameEn}
				</td>
				<td>
					${t01Company.abbreviation}
				</td>
				<td>
					${t01Company.description}
				</td>
				<td>
					${t01Company.regiNumb}
				</td>
				<shiro:hasPermission name="gsp:t01company:t01Company:edit"><td>
    				<a href="${ctx}/gsp/t01company/t01Company/form?id=${t01Company.id}">修改</a>
					<a href="${ctx}/gsp/t01company/t01Company/delete?id=${t01Company.id}" onclick="return confirmx('确认要删除该企业信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
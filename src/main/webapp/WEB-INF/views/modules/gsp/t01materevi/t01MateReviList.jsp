<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营审核管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t01materevi/t01MateRevi/">首营审核列表</a></li>
		<shiro:hasPermission name="gsp:t01materevi:t01MateRevi:edit"><li><a href="${ctx}/gsp/t01materevi/t01MateRevi/form">首营审核添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t01MateRevi" action="${ctx}/gsp/t01materevi/t01MateRevi/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t01MateRevi.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t01MateRevi.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
			<li><label>企业编号：</label>
				<form:input path="compNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>企业名称：</label>
				<form:input path="compName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>证书编号：</label>
				<form:input path="certNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>证书名称：</label>
				<form:input path="certName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>变更情况：</label>
				<form:input path="chanSitu" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>查看资质：</label>
				<form:input path="viewQual" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>企业编号</th>
				<th>企业名称</th>
				<th>证书编号</th>
				<th>证书名称</th>
				<th>变更情况</th>
				<th>查看资质</th>
				<shiro:hasPermission name="gsp:t01materevi:t01MateRevi:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t01MateRevi">
			<tr>
				<td><a href="${ctx}/gsp/t01materevi/t01MateRevi/form?id=${t01MateRevi.id}">
					${t01MateRevi.id}
				</a></td>
				<td>
					${t01MateRevi.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01MateRevi.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01MateRevi.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01MateRevi.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01MateRevi.remarks}
				</td>
				<td>
					${fns:getDictLabel(t01MateRevi.delFlag, 'del_flag', '')}
				</td>
				<td>
					${t01MateRevi.procInsId}
				</td>
				<td>
					${t01MateRevi.compNumb}
				</td>
				<td>
					${t01MateRevi.compName}
				</td>
				<td>
					${t01MateRevi.certNumb}
				</td>
				<td>
					${t01MateRevi.certName}
				</td>
				<td>
					${t01MateRevi.chanSitu}
				</td>
				<td>
					${t01MateRevi.viewQual}
				</td>
				<shiro:hasPermission name="gsp:t01materevi:t01MateRevi:edit"><td>
    				<a href="${ctx}/gsp/t01materevi/t01MateRevi/form?id=${t01MateRevi.id}">修改</a>
					<a href="${ctx}/gsp/t01materevi/t01MateRevi/delete?id=${t01MateRevi.id}" onclick="return confirmx('确认要删除该首营审核吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
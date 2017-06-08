<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>物料信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t01materiel/t01Materiel/">物料信息列表</a></li>
		<shiro:hasPermission name="gsp:t01materiel:t01Materiel:edit"><li><a href="${ctx}/gsp/t01materiel/t01Materiel/form">物料信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t01Materiel" action="${ctx}/gsp/t01materiel/t01Materiel/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t01Materiel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t01Materiel.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>物料名：</label>
				<form:input path="mateName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>描述：</label>
				<form:input path="description" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>长描述：</label>
				<form:input path="longDesc" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:input path="type" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>储存条件：</label>
				<form:input path="storCond" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>储存条件_温度：</label>
				<form:input path="storCondTemp" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>储存条件_湿度：</label>
				<form:input path="storCondHumi" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>运输条件：</label>
				<form:input path="tranCond" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>运输条件_温度：</label>
				<form:input path="tranCondTemp" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>运输条件_湿度：</label>
				<form:input path="tranCondHumi" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>备注：</label>
				<form:input path="comments" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>物料名</th>
				<th>描述</th>
				<th>长描述</th>
				<th>类型</th>
				<th>储存条件</th>
				<th>储存条件_温度</th>
				<th>储存条件_湿度</th>
				<th>运输条件</th>
				<th>运输条件_温度</th>
				<th>运输条件_湿度</th>
				<th>备注</th>
				<shiro:hasPermission name="gsp:t01materiel:t01Materiel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t01Materiel">
			<tr>
				<td><a href="${ctx}/gsp/t01materiel/t01Materiel/form?id=${t01Materiel.id}">
					${t01Materiel.id}
				</a></td>
				<td>
					${t01Materiel.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01Materiel.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01Materiel.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01Materiel.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01Materiel.remarks}
				</td>
				<td>
					${t01Materiel.procInsId}
				</td>
				<td>
					${t01Materiel.mateName}
				</td>
				<td>
					${t01Materiel.description}
				</td>
				<td>
					${t01Materiel.longDesc}
				</td>
				<td>
					${t01Materiel.type}
				</td>
				<td>
					${t01Materiel.storCond}
				</td>
				<td>
					${t01Materiel.storCondTemp}
				</td>
				<td>
					${t01Materiel.storCondHumi}
				</td>
				<td>
					${t01Materiel.tranCond}
				</td>
				<td>
					${t01Materiel.tranCondTemp}
				</td>
				<td>
					${t01Materiel.tranCondHumi}
				</td>
				<td>
					${t01Materiel.comments}
				</td>
				<shiro:hasPermission name="gsp:t01materiel:t01Materiel:edit"><td>
    				<a href="${ctx}/gsp/t01materiel/t01Materiel/form?id=${t01Materiel.id}">修改</a>
					<a href="${ctx}/gsp/t01materiel/t01Materiel/delete?id=${t01Materiel.id}" onclick="return confirmx('确认要删除该物料信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
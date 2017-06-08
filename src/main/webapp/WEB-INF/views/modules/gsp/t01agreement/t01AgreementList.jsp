<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>协议信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t01agreement/t01Agreement/">协议信息列表</a></li>
		<shiro:hasPermission name="gsp:t01agreement:t01Agreement:edit"><li><a href="${ctx}/gsp/t01agreement/t01Agreement/form">协议信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t01Agreement" action="${ctx}/gsp/t01agreement/t01Agreement/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t01Agreement.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t01Agreement.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>协议编号：</label>
				<form:input path="agreNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>产品名称：</label>
				<form:input path="prodName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>规格型号：</label>
				<form:input path="specModel" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>注册证号：</label>
				<form:input path="regiCertNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产企业：</label>
				<form:input path="manuEnte" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>供货者：</label>
				<form:input path="supplier" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>单价：</label>
				<form:input path="unitPrice" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>金额：</label>
				<form:input path="amount" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生效日期：</label>
				<form:input path="effeDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>有效期至：</label>
				<form:input path="validPeriTo" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>协议编号</th>
				<th>产品名称</th>
				<th>规格型号</th>
				<th>注册证号</th>
				<th>生产企业</th>
				<th>供货者</th>
				<th>单价</th>
				<th>金额</th>
				<th>生效日期</th>
				<th>有效期至</th>
				<shiro:hasPermission name="gsp:t01agreement:t01Agreement:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t01Agreement">
			<tr>
				<td><a href="${ctx}/gsp/t01agreement/t01Agreement/form?id=${t01Agreement.id}">
					${t01Agreement.id}
				</a></td>
				<td>
					${t01Agreement.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01Agreement.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01Agreement.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t01Agreement.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01Agreement.remarks}
				</td>
				<td>
					${fns:getDictLabel(t01Agreement.delFlag, 'del_flag', '')}
				</td>
				<td>
					${t01Agreement.procInsId}
				</td>
				<td>
					${t01Agreement.agreNumb}
				</td>
				<td>
					${t01Agreement.prodName}
				</td>
				<td>
					${t01Agreement.specModel}
				</td>
				<td>
					${t01Agreement.regiCertNumb}
				</td>
				<td>
					${t01Agreement.manuEnte}
				</td>
				<td>
					${t01Agreement.supplier}
				</td>
				<td>
					${t01Agreement.unitPrice}
				</td>
				<td>
					${t01Agreement.amount}
				</td>
				<td>
					${t01Agreement.effeDate}
				</td>
				<td>
					${t01Agreement.validPeriTo}
				</td>
				<shiro:hasPermission name="gsp:t01agreement:t01Agreement:edit"><td>
    				<a href="${ctx}/gsp/t01agreement/t01Agreement/form?id=${t01Agreement.id}">修改</a>
					<a href="${ctx}/gsp/t01agreement/t01Agreement/delete?id=${t01Agreement.id}" onclick="return confirmx('确认要删除该协议信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
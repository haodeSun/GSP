<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收货-物料信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02recemart/t02ReceMart/">收货-物料信息列表</a></li>
		<shiro:hasPermission name="gsp:t02recemart:t02ReceMart:edit"><li><a href="${ctx}/gsp/t02recemart/t02ReceMart/form">收货-物料信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02ReceMart" action="${ctx}/gsp/t02recemart/t02ReceMart/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02ReceMart.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02ReceMart.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>物料号：</label>
				<form:input path="mateNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>描述：</label>
				<form:input path="described" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>产品名称：</label>
				<form:input path="prodName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>注册证号：</label>
				<form:input path="regiCertNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>订货数量：</label>
				<form:input path="orderQuan" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>到货数量：</label>
				<form:input path="arriQuan" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产批号：</label>
				<form:input path="prodBatch" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产日期：</label>
				<form:input path="prodDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>失效日期：</label>
				<form:input path="disaDate" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>物料号</th>
				<th>描述</th>
				<th>产品名称</th>
				<th>注册证号</th>
				<th>订货数量</th>
				<th>到货数量</th>
				<th>生产批号</th>
				<th>生产日期</th>
				<th>失效日期</th>
				<shiro:hasPermission name="gsp:t02recemart:t02ReceMart:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02ReceMart">
			<tr>
				<td><a href="${ctx}/gsp/t02recemart/t02ReceMart/form?id=${t02ReceMart.id}">
					${t02ReceMart.id}
				</a></td>
				<td>
					${t02ReceMart.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02ReceMart.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02ReceMart.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02ReceMart.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02ReceMart.remarks}
				</td>
				<td>
					${t02ReceMart.procInsId}
				</td>
				<td>
					${t02ReceMart.mateNumb}
				</td>
				<td>
					${t02ReceMart.described}
				</td>
				<td>
					${t02ReceMart.prodName}
				</td>
				<td>
					${t02ReceMart.regiCertNo}
				</td>
				<td>
					${t02ReceMart.orderQuan}
				</td>
				<td>
					${t02ReceMart.arriQuan}
				</td>
				<td>
					${t02ReceMart.prodBatch}
				</td>
				<td>
					${t02ReceMart.prodDate}
				</td>
				<td>
					${t02ReceMart.disaDate}
				</td>
				<shiro:hasPermission name="gsp:t02recemart:t02ReceMart:edit"><td>
    				<a href="${ctx}/gsp/t02recemart/t02ReceMart/form?id=${t02ReceMart.id}">修改</a>
					<a href="${ctx}/gsp/t02recemart/t02ReceMart/delete?id=${t02ReceMart.id}" onclick="return confirmx('确认要删除该收货-物料信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退回-物料信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02rejemate/t02RejeMate/">退回-物料信息列表</a></li>
		<shiro:hasPermission name="gsp:t02rejemate:t02RejeMate:edit"><li><a href="${ctx}/gsp/t02rejemate/t02RejeMate/form">退回-物料信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02RejeMate" action="${ctx}/gsp/t02rejemate/t02RejeMate/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02RejeMate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02RejeMate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>商品编码：</label>
				<form:input path="commCode" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>商品条码：</label>
				<form:input path="commBarCode" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>商品名称：</label>
				<form:input path="commName" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>单位：</label>
				<form:input path="unit" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>单位含量：</label>
				<form:input path="unitCont" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>原单数量：</label>
				<form:input path="origCoun" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>数量：</label>
				<form:input path="count" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>挑批次：</label>
				<form:input path="pickBatc" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>最后售价：</label>
				<form:input path="soldPric" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>含税成交单价：</label>
				<form:input path="taxTranPric" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>含税金额：</label>
				<form:input path="taxAmou" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>活动类型：</label>
				<form:input path="actiType" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>促销活动号：</label>
				<form:input path="promNo" htmlEscape="false" maxlength="11" class="input-medium"/>
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
				<th>商品编码</th>
				<th>商品条码</th>
				<th>商品名称</th>
				<th>单位</th>
				<th>单位含量</th>
				<th>原单数量</th>
				<th>数量</th>
				<th>挑批次</th>
				<th>最后售价</th>
				<th>含税成交单价</th>
				<th>含税金额</th>
				<th>活动类型</th>
				<th>促销活动号</th>
				<shiro:hasPermission name="gsp:t02rejemate:t02RejeMate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02RejeMate">
			<tr>
				<td><a href="${ctx}/gsp/t02rejemate/t02RejeMate/form?id=${t02RejeMate.id}">
					${t02RejeMate.id}
				</a></td>
				<td>
					${t02RejeMate.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02RejeMate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02RejeMate.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02RejeMate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02RejeMate.remarks}
				</td>
				<td>
					${t02RejeMate.procInsId}
				</td>
				<td>
					${t02RejeMate.commCode}
				</td>
				<td>
					${t02RejeMate.commBarCode}
				</td>
				<td>
					${t02RejeMate.commName}
				</td>
				<td>
					${t02RejeMate.unit}
				</td>
				<td>
					${t02RejeMate.unitCont}
				</td>
				<td>
					${t02RejeMate.origCoun}
				</td>
				<td>
					${t02RejeMate.count}
				</td>
				<td>
					${t02RejeMate.pickBatc}
				</td>
				<td>
					${t02RejeMate.soldPric}
				</td>
				<td>
					${t02RejeMate.taxTranPric}
				</td>
				<td>
					${t02RejeMate.taxAmou}
				</td>
				<td>
					${t02RejeMate.actiType}
				</td>
				<td>
					${t02RejeMate.promNo}
				</td>
				<shiro:hasPermission name="gsp:t02rejemate:t02RejeMate:edit"><td>
    				<a href="${ctx}/gsp/t02rejemate/t02RejeMate/form?id=${t02RejeMate.id}">修改</a>
					<a href="${ctx}/gsp/t02rejemate/t02RejeMate/delete?id=${t02RejeMate.id}" onclick="return confirmx('确认要删除该退回-物料信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
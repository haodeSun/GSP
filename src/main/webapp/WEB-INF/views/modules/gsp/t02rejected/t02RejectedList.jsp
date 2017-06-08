<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退回信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02rejected/t02Rejected/">退回信息列表</a></li>
		<shiro:hasPermission name="gsp:t02rejected:t02Rejected:edit"><li><a href="${ctx}/gsp/t02rejected/t02Rejected/form">退回信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02Rejected" action="${ctx}/gsp/t02rejected/t02Rejected/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02Rejected.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Rejected.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>来源单号：</label>
				<form:input path="sourNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>组织编码：</label>
				<form:input path="orgaCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>客户号：</label>
				<form:input path="custNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>销售代表编码：</label>
				<form:input path="saleReprCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>仓库编码：</label>
				<form:input path="wareCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>自动单号：</label>
				<form:input path="autoNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>退货方式：</label>
				<form:input path="retuMeth" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>退货原因：</label>
				<form:input path="retuReas" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>ALF：</label>
				<form:input path="alf" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>备注：</label>
				<form:input path="comm" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>开单日期：</label>
				<input name="billDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Rejected.billDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>单据有效日：</label>
				<input name="billEffeDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Rejected.billEffeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>含税金额：</label>
				<form:input path="taxAmou" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>退货总箱数：</label>
				<form:input path="totaBoxCoun" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>退货总支数：</label>
				<form:input path="totaBranCoun" htmlEscape="false" maxlength="11" class="input-medium"/>
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
				<th>来源单号</th>
				<th>组织编码</th>
				<th>客户号</th>
				<th>销售代表编码</th>
				<th>仓库编码</th>
				<th>自动单号</th>
				<th>退货方式</th>
				<th>退货原因</th>
				<th>ALF</th>
				<th>备注</th>
				<th>开单日期</th>
				<th>单据有效日</th>
				<th>含税金额</th>
				<th>退货总箱数</th>
				<th>退货总支数</th>
				<shiro:hasPermission name="gsp:t02rejected:t02Rejected:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02Rejected">
			<tr>
				<td><a href="${ctx}/gsp/t02rejected/t02Rejected/form?id=${t02Rejected.id}">
					${t02Rejected.id}
				</a></td>
				<td>
					${t02Rejected.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Rejected.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Rejected.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Rejected.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Rejected.remarks}
				</td>
				<td>
					${t02Rejected.procInsId}
				</td>
				<td>
					${t02Rejected.sourNo}
				</td>
				<td>
					${t02Rejected.orgaCode}
				</td>
				<td>
					${t02Rejected.custNo}
				</td>
				<td>
					${t02Rejected.saleReprCode}
				</td>
				<td>
					${t02Rejected.wareCode}
				</td>
				<td>
					${t02Rejected.autoNo}
				</td>
				<td>
					${t02Rejected.retuMeth}
				</td>
				<td>
					${t02Rejected.retuReas}
				</td>
				<td>
					${t02Rejected.alf}
				</td>
				<td>
					${t02Rejected.comm}
				</td>
				<td>
					<fmt:formatDate value="${t02Rejected.billDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${t02Rejected.billEffeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Rejected.taxAmou}
				</td>
				<td>
					${t02Rejected.totaBoxCoun}
				</td>
				<td>
					${t02Rejected.totaBranCoun}
				</td>
				<shiro:hasPermission name="gsp:t02rejected:t02Rejected:edit"><td>
    				<a href="${ctx}/gsp/t02rejected/t02Rejected/form?id=${t02Rejected.id}">修改</a>
					<a href="${ctx}/gsp/t02rejected/t02Rejected/delete?id=${t02Rejected.id}" onclick="return confirmx('确认要删除该退回信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
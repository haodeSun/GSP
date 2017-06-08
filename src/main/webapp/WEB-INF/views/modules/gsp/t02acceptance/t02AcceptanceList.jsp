<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>验收信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02acceptance/t02Acceptance/">验收信息列表</a></li>
		<shiro:hasPermission name="gsp:t02acceptance:t02Acceptance:edit"><li><a href="${ctx}/gsp/t02acceptance/t02Acceptance/form">验收信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02Acceptance" action="${ctx}/gsp/t02acceptance/t02Acceptance/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02Acceptance.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Acceptance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>验收单号：</label>
				<form:input path="apprNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>到货日期：</label>
				<form:input path="arriDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>收货单号：</label>
				<form:input path="receNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>运输温度的核实：</label>
				<form:input path="veriTemp" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>验收人员签字：</label>
				<form:input path="acceSign" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>验收人员姓名：</label>
				<form:input path="accePersName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>签字：</label>
				<form:input path="signature" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>验收单号</th>
				<th>到货日期</th>
				<th>收货单号</th>
				<th>运输温度的核实</th>
				<th>验收人员签字</th>
				<th>验收人员姓名</th>
				<th>签字</th>
				<shiro:hasPermission name="gsp:t02acceptance:t02Acceptance:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02Acceptance">
			<tr>
				<td><a href="${ctx}/gsp/t02acceptance/t02Acceptance/form?id=${t02Acceptance.id}">
					${t02Acceptance.id}
				</a></td>
				<td>
					${t02Acceptance.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Acceptance.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Acceptance.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Acceptance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Acceptance.remarks}
				</td>
				<td>
					${t02Acceptance.procInsId}
				</td>
				<td>
					${t02Acceptance.apprNumb}
				</td>
				<td>
					${t02Acceptance.arriDate}
				</td>
				<td>
					${t02Acceptance.receNumb}
				</td>
				<td>
					${t02Acceptance.veriTemp}
				</td>
				<td>
					${t02Acceptance.acceSign}
				</td>
				<td>
					${t02Acceptance.accePersName}
				</td>
				<td>
					${t02Acceptance.signature}
				</td>
				<shiro:hasPermission name="gsp:t02acceptance:t02Acceptance:edit"><td>
    				<a href="${ctx}/gsp/t02acceptance/t02Acceptance/form?id=${t02Acceptance.id}">修改</a>
					<a href="${ctx}/gsp/t02acceptance/t02Acceptance/delete?id=${t02Acceptance.id}" onclick="return confirmx('确认要删除该验收信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
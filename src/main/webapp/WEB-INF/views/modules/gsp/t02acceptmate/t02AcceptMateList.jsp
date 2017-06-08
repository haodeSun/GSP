<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>验收-物料信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02acceptmate/t02AcceptMate/">验收-物料信息列表</a></li>
		<shiro:hasPermission name="gsp:t02acceptmate:t02AcceptMate:edit"><li><a href="${ctx}/gsp/t02acceptmate/t02AcceptMate/form">验收-物料信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02AcceptMate" action="${ctx}/gsp/t02acceptmate/t02AcceptMate/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02AcceptMate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02AcceptMate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>物料编号：</label>
				<form:input path="mateNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>产品名称（中文）：</label>
				<form:input path="prodNameCn" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>注册证号：</label>
				<form:input path="regiCertNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产批号：</label>
				<form:input path="batchNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产日期：</label>
				<form:input path="manuDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>失效日期：</label>
				<form:input path="disaDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>有效期：</label>
				<form:input path="valiPeri" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产企业：</label>
				<form:input path="manuEnte" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>供货者：</label>
				<form:input path="supplier" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>收货数量：</label>
				<form:input path="receQuan" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>验收合格数：</label>
				<form:input path="acceNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>验收结果：</label>
				<form:input path="checkResu" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>不合格数：</label>
				<form:input path="unquNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>不合格事项及处理措施：</label>
				<form:input path="unquHandMeas" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>物料编号</th>
				<th>产品名称（中文）</th>
				<th>注册证号</th>
				<th>生产批号</th>
				<th>生产日期</th>
				<th>失效日期</th>
				<th>有效期</th>
				<th>生产企业</th>
				<th>供货者</th>
				<th>收货数量</th>
				<th>验收合格数</th>
				<th>验收结果</th>
				<th>不合格数</th>
				<th>不合格事项及处理措施</th>
				<shiro:hasPermission name="gsp:t02acceptmate:t02AcceptMate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02AcceptMate">
			<tr>
				<td><a href="${ctx}/gsp/t02acceptmate/t02AcceptMate/form?id=${t02AcceptMate.id}">
					${t02AcceptMate.id}
				</a></td>
				<td>
					${t02AcceptMate.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02AcceptMate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02AcceptMate.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02AcceptMate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02AcceptMate.remarks}
				</td>
				<td>
					${t02AcceptMate.procInsId}
				</td>
				<td>
					${t02AcceptMate.mateNo}
				</td>
				<td>
					${t02AcceptMate.prodNameCn}
				</td>
				<td>
					${t02AcceptMate.regiCertNo}
				</td>
				<td>
					${t02AcceptMate.batchNumb}
				</td>
				<td>
					${t02AcceptMate.manuDate}
				</td>
				<td>
					${t02AcceptMate.disaDate}
				</td>
				<td>
					${t02AcceptMate.valiPeri}
				</td>
				<td>
					${t02AcceptMate.manuEnte}
				</td>
				<td>
					${t02AcceptMate.supplier}
				</td>
				<td>
					${t02AcceptMate.receQuan}
				</td>
				<td>
					${t02AcceptMate.acceNumb}
				</td>
				<td>
					${t02AcceptMate.checkResu}
				</td>
				<td>
					${t02AcceptMate.unquNumb}
				</td>
				<td>
					${t02AcceptMate.unquHandMeas}
				</td>
				<shiro:hasPermission name="gsp:t02acceptmate:t02AcceptMate:edit"><td>
    				<a href="${ctx}/gsp/t02acceptmate/t02AcceptMate/form?id=${t02AcceptMate.id}">修改</a>
					<a href="${ctx}/gsp/t02acceptmate/t02AcceptMate/delete?id=${t02AcceptMate.id}" onclick="return confirmx('确认要删除该验收-物料信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
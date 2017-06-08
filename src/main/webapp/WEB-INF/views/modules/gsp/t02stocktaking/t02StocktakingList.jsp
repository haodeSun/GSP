<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>盘点信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02stocktaking/t02Stocktaking/">盘点信息列表</a></li>
		<shiro:hasPermission name="gsp:t02stocktaking:t02Stocktaking:edit"><li><a href="${ctx}/gsp/t02stocktaking/t02Stocktaking/form">盘点信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02Stocktaking" action="${ctx}/gsp/t02stocktaking/t02Stocktaking/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02Stocktaking.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Stocktaking.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>库房/地点：</label>
				<form:input path="warehouse" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>质量状态/区域：</label>
				<form:input path="qualStat" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>盘点编号：</label>
				<form:input path="inveCount" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>盘点人姓名：</label>
				<form:input path="inveName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>组织编码：</label>
				<form:input path="orgaCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>仓库编码：</label>
				<form:input path="wareCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>盘点日期：</label>
				<input name="inveDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Stocktaking.inveDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>临期天数：</label>
				<form:input path="nearDays" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产商编码：</label>
				<form:input path="manuCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>品类编码：</label>
				<form:input path="cateCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>品牌编码：</label>
				<form:input path="brandCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>备注：</label>
				<form:input path="comments" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>销售开始日期：</label>
				<form:input path="salesStartDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>销售截止日期：</label>
				<form:input path="salesEndDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>临其商品：</label>
				<form:input path="nearGood" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>库房/地点</th>
				<th>质量状态/区域</th>
				<th>盘点编号</th>
				<th>盘点人姓名</th>
				<th>组织编码</th>
				<th>仓库编码</th>
				<th>盘点日期</th>
				<th>临期天数</th>
				<th>生产商编码</th>
				<th>品类编码</th>
				<th>品牌编码</th>
				<th>备注</th>
				<th>销售开始日期</th>
				<th>销售截止日期</th>
				<th>临其商品</th>
				<shiro:hasPermission name="gsp:t02stocktaking:t02Stocktaking:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02Stocktaking">
			<tr>
				<td><a href="${ctx}/gsp/t02stocktaking/t02Stocktaking/form?id=${t02Stocktaking.id}">
					${t02Stocktaking.id}
				</a></td>
				<td>
					${t02Stocktaking.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Stocktaking.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Stocktaking.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Stocktaking.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Stocktaking.remarks}
				</td>
				<td>
					${t02Stocktaking.procInsId}
				</td>
				<td>
					${t02Stocktaking.warehouse}
				</td>
				<td>
					${t02Stocktaking.qualStat}
				</td>
				<td>
					${t02Stocktaking.inveCount}
				</td>
				<td>
					${t02Stocktaking.inveName}
				</td>
				<td>
					${t02Stocktaking.orgaCode}
				</td>
				<td>
					${t02Stocktaking.wareCode}
				</td>
				<td>
					<fmt:formatDate value="${t02Stocktaking.inveDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Stocktaking.nearDays}
				</td>
				<td>
					${t02Stocktaking.manuCode}
				</td>
				<td>
					${t02Stocktaking.cateCode}
				</td>
				<td>
					${t02Stocktaking.brandCode}
				</td>
				<td>
					${t02Stocktaking.comments}
				</td>
				<td>
					${t02Stocktaking.salesStartDate}
				</td>
				<td>
					${t02Stocktaking.salesEndDate}
				</td>
				<td>
					${t02Stocktaking.nearGood}
				</td>
				<shiro:hasPermission name="gsp:t02stocktaking:t02Stocktaking:edit"><td>
    				<a href="${ctx}/gsp/t02stocktaking/t02Stocktaking/form?id=${t02Stocktaking.id}">修改</a>
					<a href="${ctx}/gsp/t02stocktaking/t02Stocktaking/delete?id=${t02Stocktaking.id}" onclick="return confirmx('确认要删除该盘点信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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
		function approveThis(obj){
			var backstageStr = $($(obj).parent().siblings()[0]).text().replace(/(^\s*)|(\s*$)/g, "") + ",";
			backstageStr += $("#approvalOpinion").val() + ",";
			for(var i=0,checkLen=$("input[type='radio']").length;i<checkLen;i++){
				if($($("input[type='radio']")[i]).is(':checked') == true){
					console.log(i);
					backstageStr += $($("input[type='radio']")[i]).parent().text();
				}
			}
			console.log(backstageStr);
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/test/testData/">单表列表</a></li>
		<shiro:hasPermission name="test:testData:edit"><li><a href="${ctx}/test/testData/form">单表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testData" action="${ctx}/test/testData/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tr>
			<td>
				<label>审批意见：</label><input id="approvalOpinion" name="approvalOpinion" class="input-medium" type="text" value="" maxlength="100">
				<label class="radio"><input type="radio" name="optionsRadios" style="margin-top:5px;">同意</label>
				<label class="radio"><input type="radio" name="optionsRadios" style="margin-top:5px;">不同意</label>
			</td>
		</tr>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>归属用户</th>
				<th>归属部门</th>
				<th>归属区域</th>
				<th>名称</th>
				<th>性别</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="test:testData:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="testData">
			<tr>
				<td><a href="${ctx}/test/testData/form?id=${testData.id}">
					${testData.user.name}
				</a></td>
				<td>
					${testData.office.name}
				</td>
				<td>
					${testData.area.name}
				</td>
				<td>
					${testData.name}
				</td>
				<td>
					${fns:getDictLabel(testData.sex, 'sex', '')}
				</td>
				<td>
					<fmt:formatDate value="${testData.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${testData.remarks}
				</td>
				<shiro:hasPermission name="test:testData:edit"><td>
    				<a href="javascript:void(0)" onclick="approveThis(this)">审批</a>
					<a href="${ctx}/test/testData/delete?id=${testData.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户notice表管理</title>
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
		<li class="active"><a href="${ctx}/gsp/sysusernotice/sysUserNotice/">用户notice表列表</a></li>
		<shiro:hasPermission name="gsp:sysusernotice:sysUserNotice:edit"><li><a href="${ctx}/gsp/sysusernotice/sysUserNotice/form">用户notice表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysUserNotice" action="${ctx}/gsp/sysusernotice/sysUserNotice/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${sysUserNotice.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${sysUserNotice.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>消息标题：</label>
				<form:input path="noticeTitle" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>消息类型：</label>
				<form:input path="noticeType" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>消息内容：</label>
				<form:input path="content" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>消息状态：</label>
				<form:input path="noticeStatus" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>推送对象：</label>
				<form:input path="pushUser" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>附件：</label>
				<form:input path="attach" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>消息标题</th>
				<th>消息类型</th>
				<th>消息内容</th>
				<th>消息状态</th>
				<th>推送对象</th>
				<th>附件</th>
				<shiro:hasPermission name="gsp:sysusernotice:sysUserNotice:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysUserNotice">
			<tr>
				<td><a href="${ctx}/gsp/sysusernotice/sysUserNotice/form?id=${sysUserNotice.id}">
					${sysUserNotice.id}
				</a></td>
				<td>
					${sysUserNotice.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${sysUserNotice.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysUserNotice.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${sysUserNotice.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysUserNotice.remarks}
				</td>
				<td>
					${sysUserNotice.procInsId}
				</td>
				<td>
					${sysUserNotice.noticeTitle}
				</td>
				<td>
					${sysUserNotice.noticeType}
				</td>
				<td>
					${sysUserNotice.content}
				</td>
				<td>
					${sysUserNotice.noticeStatus}
				</td>
				<td>
					${sysUserNotice.pushUser}
				</td>
				<td>
					${sysUserNotice.attach}
				</td>
				<shiro:hasPermission name="gsp:sysusernotice:sysUserNotice:edit"><td>
    				<a href="${ctx}/gsp/sysusernotice/sysUserNotice/form?id=${sysUserNotice.id}">修改</a>
					<a href="${ctx}/gsp/sysusernotice/sysUserNotice/delete?id=${sysUserNotice.id}" onclick="return confirmx('确认要删除该用户notice表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
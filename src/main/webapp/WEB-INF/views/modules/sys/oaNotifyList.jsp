<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		//已在外部引入js，名称暂定为t01QualificationsDelete.js 
	</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
	  <li><a href="#">首页</a> <span class="divider">/</span></li>
	  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
	  <li class="active">产品资质删除</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">产品资质删除</div>
	<!-- 查询条件下拉部分（style样式不用加在模板内，此处仅为测试用） -->
	<div class="accordion-group">
		<select name='' aria-required=true' class='form-control' id='querySelect' style="width:200px;margin-left:15px;"></select>
		<button id="addCondition" class="btn btn-primary" style="margin-left:40px;" onclick="addCondition()">添加查询条件</button>
		<button id="btnSubmit" class="btn btn-primary" style="margin-left:40px;" onclick="submitThisForm()">查询</button>
	</div>
	<!-- 查询条件折叠列表（注意lable中的":"号，此处在处理数据时有用到，模板内请加上） -->
	<form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="accordion-group">
		    <div class="accordion-heading">
		      	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
		        	折叠列表
		      	</a>
		    </div>
		    <div id="collapseOne" class="accordion-body collapse in">
		      	<div class="accordion-inner">
		        	<ul class="ul-form">
						<li style="display:none;"><label>标题：</label>
							<form:input path="title" htmlEscape="false" maxlength="200" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:block;"><label>类型：</label>
							<form:select path="type" class="input-medium">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:block;"><label>类型1：</label>
							<form:select path="type" class="input-medium">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>类型2：</label>
							<form:select path="type" class="input-medium">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<c:if test="${!requestScope.oaNotify.self}"><li style="display:none;"><label>状态：</label>
							<form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</li></c:if>
					</ul>
		      	</div>
		    </div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<!-- 表单上部的按钮组，左侧的按键如修改、删除、审批的href的id值可以留空，前台会传入数据 -->
	<c:if test="${!requestScope.oaNotify.self}">
		<shiro:hasPermission name="oa:oaNotify:edit">
			<a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)"><span class="btn btn-primary">删除</span></a>
			<span class="btn btn-primary" onclick="printThis(this)">打印</span>
		</shiro:hasPermission>
	</c:if>
	<!-- 表单的列名称下拉项以及导出按钮 -->
	<div class="btn-group">
	  	<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
	   		 列名称<span class="caret"></span>
	  	</a>
	 	<ul id="columnName" class="dropdown-menu">
	 	</ul>
	</div>
	<span class="btn btn-primary" onclick="exportThis()">导出</span>
	<!-- table中的th和td均在第一位加入了多选框 -->
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" onchange="chooseAll(this)"/></th>
				<th>标题</th>
				<th>类型</th>
				<th>状态</th>
				<th>查阅状态</th>
				<th>更新时间</th>
				<!--<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><th>操作</th></shiro:hasPermission></c:if>-->
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaNotify">
			<tr>
				<td><input type="checkbox" onchange="checkAll()"/></td>
				<td><a href="${ctx}/oa/oaNotify/${requestScope.oaNotify.self?'view':'form'}?id=${oaNotify.id}">
					${fns:abbr(oaNotify.title,50)}
				</a></td>
				<td>
					${fns:getDictLabel(oaNotify.type, 'oa_notify_type', '')}
				</td>
				<td>
					${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
				</td>
				<td>
					<c:if test="${requestScope.oaNotify.self}">
						${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}
					</c:if>
					<c:if test="${!requestScope.oaNotify.self}">
						${oaNotify.readNum} / ${oaNotify.readNum + oaNotify.unReadNum}
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${oaNotify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<!--<c:if test="${!requestScope.oaNotify.self}">
				<shiro:hasPermission name="oa:oaNotify:edit">
				<td>
    				<a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">修改</a>
					<a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
				</c:if>-->
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<!-- 表单底部的页签 -->
	<div class="pagination">${page}</div>
</body>
</html>
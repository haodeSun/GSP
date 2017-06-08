<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发货信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02ship/t02Ship/">发货信息列表</a></li>
		<shiro:hasPermission name="gsp:t02ship:t02Ship:edit"><li><a href="${ctx}/gsp/t02ship/t02Ship/form">发货信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02Ship" action="${ctx}/gsp/t02ship/t02Ship/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02Ship.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Ship.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>发货单号：</label>
				<form:input path="invoNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>运单号：</label>
				<form:input path="wayBillNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>供货者编号/代码：</label>
				<form:input path="suppCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>采购单号：</label>
				<form:input path="purcOrderNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>到货日期：</label>
				<input name="arriDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02Ship.arriDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>运输条件是是一致：</label>
				<form:input path="tranAgree" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>有无随货同行单：</label>
				<form:input path="havePeerList" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>送货人：</label>
				<form:input path="deliMan" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>上述随货同行单是是一致：</label>
				<form:input path="peerListAgree" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>接收人：</label>
				<form:input path="reciMan" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>审核：</label>
				<form:input path="toExam" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>发货单号</th>
				<th>运单号</th>
				<th>供货者编号/代码</th>
				<th>名称</th>
				<th>采购单号</th>
				<th>到货日期</th>
				<th>运输条件是是一致</th>
				<th>有无随货同行单</th>
				<th>送货人</th>
				<th>上述随货同行单是是一致</th>
				<th>接收人</th>
				<th>审核</th>
				<shiro:hasPermission name="gsp:t02ship:t02Ship:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02Ship">
			<tr>
				<td><a href="${ctx}/gsp/t02ship/t02Ship/form?id=${t02Ship.id}">
					${t02Ship.id}
				</a></td>
				<td>
					${t02Ship.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Ship.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Ship.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02Ship.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Ship.remarks}
				</td>
				<td>
					${t02Ship.procInsId}
				</td>
				<td>
					${t02Ship.invoNo}
				</td>
				<td>
					${t02Ship.wayBillNo}
				</td>
				<td>
					${t02Ship.suppCode}
				</td>
				<td>
					${t02Ship.name}
				</td>
				<td>
					${t02Ship.purcOrderNo}
				</td>
				<td>
					<fmt:formatDate value="${t02Ship.arriDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02Ship.tranAgree}
				</td>
				<td>
					${t02Ship.havePeerList}
				</td>
				<td>
					${t02Ship.deliMan}
				</td>
				<td>
					${t02Ship.peerListAgree}
				</td>
				<td>
					${t02Ship.reciMan}
				</td>
				<td>
					${t02Ship.toExam}
				</td>
				<shiro:hasPermission name="gsp:t02ship:t02Ship:edit"><td>
    				<a href="${ctx}/gsp/t02ship/t02Ship/form?id=${t02Ship.id}">修改</a>
					<a href="${ctx}/gsp/t02ship/t02Ship/delete?id=${t02Ship.id}" onclick="return confirmx('确认要删除该发货信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
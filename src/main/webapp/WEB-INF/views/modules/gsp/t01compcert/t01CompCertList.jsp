<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业资质管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
	  <li><a href="#">首页</a> <span class="divider">/</span></li>
	  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
	  <li class="active">企业资质删除</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">企业资质删除</div>
	<!--20161113-->
	<form:form id="searchForm" modelAttribute="t01CompCert" action="${ctx}/gsp/t01compcert/t01CompCert/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="conditionOrder" name="conditionOrder" type="hidden" value="${conditionOrder}">
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div id="foldList" class="accordion-group">
		    <div class="accordion-heading">
		      	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
		        	折叠列表
		      	</a>
		    </div>
		    <div id="collapseOne" class="accordion-body collapse in">
		      	<div class="accordion-inner">
		      		   <div id="selectGroup" class="accordion-group">
						<span>查询条件</span>
						<select name='' aria-required=true' class='form-control' id='querySelect' style="width:200px;margin-left:15px;"></select>
						<a id="addCondition" class="btn btn-primary"  onclick="addCondition()">添加条件</a>
					</div>
					<ul  id="conditionOrderUl" class="ul-form">
						<li style="display:none;"><label>企业id：</label>
							<form:input path="compId" htmlEscape="false" maxlength="128" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>资质证号：</label>
							<form:input path="certNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>资质类型：</label>
							<form:input path="certType" htmlEscape="false" maxlength="16" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>机构名称/销售人员姓名：</label>
							<form:input path="certName" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>生产/经营/销售范围/诊疗科目：</label>
							<form:input path="certScop" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>生效日期/发证日期：</label>
							<input name="effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								value="<fmt:formatDate value="${t01CompCert.effecDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>有效期至：</label>
							<input name="validDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								value="<fmt:formatDate value="${t01CompCert.validDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>资质状态：</label>
							<form:input path="certStat" htmlEscape="false" maxlength="16" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>审批状态：</label>
							<form:input path="apprStat" htmlEscape="false" maxlength="16" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>附件：</label>
							<form:input path="attachment" htmlEscape="false" maxlength="2048" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>备注信息：</label>
							<form:input path="remarks" htmlEscape="false" maxlength="512" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>更新时间：</label>
							<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								value="<fmt:formatDate value="${t01CompCert.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
					</ul>
					<a id="btnSubmit" class="btn btn-primary"  onclick="submitThisForm()">查询</a>
				</div>
		    </div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<!-- 表单上部的按钮组，左侧的按键如修改、删除、审批的href的id值可以留空，前台会传入数据 (新的class：newBtn)-->
	<shiro:hasPermission name="gsp:t01compcert:t01CompCert:edit">
		<a href="${ctx}/gsp/t01compcert/t01CompCert/delete?id=${t01CompCert.id}" onclick="return confirmx('确认要删除该企业资质吗？', this.href)"><span class="newBtn btn btn-primary">删除</span></a>
	</shiro:hasPermission>
	<!-- 表单的列名称下拉项以及导出按钮 -->
	<span class="checkOut newBtn btn btn-primary" onclick="exportThis()">导出</span>
	<span class="printSpan newBtn btn btn-primary" onclick="printThis(this)">打印</span>
	<div id="columnNameDiv" class="btn-group">
	  	<a class="newBtn btn dropdown-toggle" data-toggle="dropdown" href="#">
	   		 列名称<span class="caret"></span>
	  	</a>
	 	<ul id="columnName" class="dropdown-menu">
	 	</ul>
	</div>
  <!----------------------------------->
  <div id="borderScroll" style="width:99%; overflow: auto;">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
				<th>企业id</th>
				<th>资质证号</th>
				<th>资质类型</th>
				<th>机构名称/销售人员姓名</th>
				<th>生产/经营/销售范围/诊疗科目</th>
				<th>生效日期/发证日期</th>
				<th>有效期至</th>
				<th>资质状态</th>
				<th>审批状态</th>
				<th>附件</th>
				<th>备注信息</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<%!
			int count = 1;
		%>

		<c:forEach items="${page.list}" var="t01CompCert">
			<%
                count++;
            %>
			<tr>
				<td><input id="checkbox_a<%= count %>" class="chk_1" type="checkbox" onchange="checkAll()"/><label for="checkbox_a<%= count %>"></label></td>
				<td><a href="${ctx}/gsp/t01compcert/t01CompCert/form?id=${t01CompCert.id}">
					${t01CompCert.compId}
				</a></td>
				<td>
					${t01CompCert.certNbr}
				</td>
				<td>
					${t01CompCert.certType}
				</td>
				<td>
					${t01CompCert.certName}
				</td>
				<td>
					${t01CompCert.certScop}
				</td>
				<td>
					<fmt:formatDate value="${t01CompCert.effecDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${t01CompCert.validDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t01CompCert.certStat}
				</td>
				<td>
					${t01CompCert.apprStat}
				</td>
				<td>
					${t01CompCert.attachment}
				</td>
				<td>
					${t01CompCert.remarks}
				</td>
				<td>
					<fmt:formatDate value="${t01CompCert.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
	<div class="pagination">${page}</div>
</body>
</html>
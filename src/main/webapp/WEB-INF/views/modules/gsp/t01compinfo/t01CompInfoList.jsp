<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业信息管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
	  <li><a href="#">首页</a> <span class="divider">/</span></li>
	  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
	  <li class="active">企业信息删除</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">企业信息删除</div>
	<!--20161113-->
	<form:form id="searchForm" modelAttribute="t01CompInfo" action="${ctx}/gsp/t01compinfo/t01CompInfo/" method="post" class="breadcrumb form-search">
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
						<li style="display:none;"><label>企业类型：</label>
							<form:input path="compType" htmlEscape="false" maxlength="16" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>注册证号：</label>
							<form:input path="regiNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>组织机构代码证号：</label>
							<form:input path="orgCertNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>税务登记证号：</label>
							<form:input path="taxNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>经营方式：</label>
							<form:input path="busiMode" htmlEscape="false" maxlength="16" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>经营场所：</label>
							<form:input path="busiLoca" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>库房地址：</label>
							<form:input path="storLoca" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>企业名称（中文）：</label>
							<form:input path="compNameCn" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>企业名称（英文）：</label>
							<form:input path="compNameEn" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>简称：</label>
							<form:input path="shortName" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>描述：</label>
							<form:input path="compDesc" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>注册地址：</label>
							<form:input path="regiLoca" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>年检状态：</label>
							<form:input path="annuCheckStat" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>法人姓名：</label>
							<form:input path="legalPers" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>生产能力评价：</label>
							<form:input path="prodAbliEval" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>质量管理评价：</label>
							<form:input path="qualMgrEval" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>仓储能力评价：</label>
							<form:input path="storAbliEval" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>交付能力评价：</label>
							<form:input path="deliAbliEval" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>售后服务能力评价：</label>
							<form:input path="afteSaleAbliEval" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>拼音：</label>
							<form:input path="phonetic" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>邮编：</label>
							<form:input path="code" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>区号：</label>
							<form:input path="areaCode" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>电话：</label>
							<form:input path="telephone" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>传真：</label>
							<form:input path="fax" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>电报：</label>
							<form:input path="telegraph" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>联系人：</label>
							<form:input path="contPers" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>联系人电话：</label>
							<form:input path="contPersTel" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>邮箱：</label>
							<form:input path="email" htmlEscape="false" maxlength="250" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>备注信息：</label>
							<form:input path="remarks" htmlEscape="false" maxlength="1000" class="input-medium"/>
							<span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
						</li>
						<li style="display:none;"><label>更新时间：</label>
							<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								value="<fmt:formatDate value="${t01CompInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
	<shiro:hasPermission name="gsp:t01compinfo:t01CompInfo:edit">
		<a href="${ctx}/gsp/t01compinfo/t01CompInfo/delete?id=${t01CompInfo.id}" onclick="return confirmx('确认要删除该企业信息吗？', this.href)"><span class="newBtn btn btn-primary">删除</span></a>
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
				<th>企业类型</th>
				<th>注册证号</th>
				<th>组织机构代码证号</th>
				<th>税务登记证号</th>
				<th>经营方式</th>
				<th>经营场所</th>
				<th>库房地址</th>
				<th>企业名称（中文）</th>
				<th>企业名称（英文）</th>
				<th>简称</th>
				<th>描述</th>
				<th>注册地址</th>
				<th>年检状态</th>
				<th>法人姓名</th>
				<th>生产能力评价</th>
				<th>质量管理评价</th>
				<th>仓储能力评价</th>
				<th>交付能力评价</th>
				<th>售后服务能力评价</th>
				<th>拼音</th>
				<th>邮编</th>
				<th>区号</th>
				<th>电话</th>
				<th>传真</th>
				<th>电报</th>
				<th>联系人</th>
				<th>联系人电话</th>
				<th>邮箱</th>
				<th>备注信息</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<%!
			int count = 1;
		%>

		<c:forEach items="${page.list}" var="t01CompInfo">
			<%
                count++;
            %>
			<tr>
				<td><input id="checkbox_a<%= count %>" class="chk_1" type="checkbox" onchange="checkAll()"/><label for="checkbox_a<%= count %>"></label></td>
				<td><a href="${ctx}/gsp/t01compinfo/t01CompInfo/form?id=${t01CompInfo.id}">
					${t01CompInfo.compType}
				</a></td>
				<td>
					${t01CompInfo.regiNbr}
				</td>
				<td>
					${t01CompInfo.orgCertNbr}
				</td>
				<td>
					${t01CompInfo.taxNbr}
				</td>
				<td>
					${t01CompInfo.busiMode}
				</td>
				<td>
					${t01CompInfo.busiLoca}
				</td>
				<td>
					${t01CompInfo.storLoca}
				</td>
				<td>
					${t01CompInfo.compNameCn}
				</td>
				<td>
					${t01CompInfo.compNameEn}
				</td>
				<td>
					${t01CompInfo.shortName}
				</td>
				<td>
					${t01CompInfo.compDesc}
				</td>
				<td>
					${t01CompInfo.regiLoca}
				</td>
				<td>
					${t01CompInfo.annuCheckStat}
				</td>
				<td>
					${t01CompInfo.legalPers}
				</td>
				<td>
					${t01CompInfo.prodAbliEval}
				</td>
				<td>
					${t01CompInfo.qualMgrEval}
				</td>
				<td>
					${t01CompInfo.storAbliEval}
				</td>
				<td>
					${t01CompInfo.deliAbliEval}
				</td>
				<td>
					${t01CompInfo.afteSaleAbliEval}
				</td>
				<td>
					${t01CompInfo.phonetic}
				</td>
				<td>
					${t01CompInfo.code}
				</td>
				<td>
					${t01CompInfo.areaCode}
				</td>
				<td>
					${t01CompInfo.telephone}
				</td>
				<td>
					${t01CompInfo.fax}
				</td>
				<td>
					${t01CompInfo.telegraph}
				</td>
				<td>
					${t01CompInfo.contPers}
				</td>
				<td>
					${t01CompInfo.contPersTel}
				</td>
				<td>
					${t01CompInfo.email}
				</td>
				<td>
					${t01CompInfo.remarks}
				</td>
				<td>
					<fmt:formatDate value="${t01CompInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
	<div class="pagination">${page}</div>
</body>
</html>
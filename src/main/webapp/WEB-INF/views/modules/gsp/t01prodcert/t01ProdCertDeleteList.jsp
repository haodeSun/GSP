<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品资质管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/modules/gsp/t01ProdCert.js?version=1.0.3" type="text/javascript"></script>
</head>
<body>
<!-- 面包屑导航（文字以及链接应换为变量）  -->
<ul class="breadcrumb">
	<li>首页<span class="divider">></span></li>
	<li>首营产品<span class="divider">></span></li>
	<li class="active">产品资质删除</li>
</ul>
<!-- 每页的title（文字换为变量） -->
<div id="topTitle">产品资质删除</div>
<!--20161113-->

<form:form id="searchForm" modelAttribute="t01ProdCert" action="${ctx}/gsp/t01prodcert/t01ProdCert/toDelete" method="post" class="breadcrumb form-search">
	<input id="conditionOrder" name="conditionOrder" type="hidden" value="${conditionOrder}">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
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
				<a id="emptyValue" class="btn btn-primary" onclick="emptyThisForm()">清空数值</a>
			</div>
				<ul id="conditionOrderUl" class="ul-form">
					<li style="display:block;"><label>注册证/备案凭证编号：</label>
						<form:input path="regiCertNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>原注册证/备案凭证编号：</label>
						<form:input path="origRegiCertNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>风险分类：</label>
						<form:select path="riskClass" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('t01_riskClass')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>技术分类-名称：</label>
						<form:select path="techCateCd" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('t01_tech_cate_cd')}" itemLabel="label" itemValue="value"
										  htmlEscape="false"/>
						</form:select>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>资质类型：</label>
						<form:select path="certType" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('t01_certType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>资质状态：</label>
						<form:select path="certStat" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>审批状态：</label>
						<form:select path="apprStat" class="input-medium">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('t01_apprStat')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>批准日期：</label>
						<input name="apprDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
							   value="<fmt:formatDate value="${t01ProdCert.apprDate}" pattern="yyyy-MM-dd"/>"
							   />
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>生效日期：</label>
						<input name="effeDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
							   value="<fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd"/>"
							   />
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>有效期至：</label>
						<input name="validPeri" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
							   value="<fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd"/>"
							   />
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>更新时间：</label>
						<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
							   value="<fmt:formatDate value="${t01ProdCert.updateDate}" pattern="yyyy-MM-dd"/>"
							   />
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>

					<li style="display:none;"><label>产品名称（中文）：</label>
						<form:input path="prodNameCn" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>产品名称（英文）：</label>
						<form:input path="prodNameEn" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
						<%--<li style="display:none;"><label>国内/进口：</label>
                            <form:input path="isImport" htmlEscape="false" maxlength="2" class="input-medium"/>
                            <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                        </li>--%>
					<li style="display:none;"><label>型号规格：</label>
						<form:input path="modelSpec" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>结构及组成：</label>
						<form:input path="struComp" htmlEscape="false" maxlength="1000" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>主要组成成分：</label>
						<form:input path="mainMnt" htmlEscape="false" maxlength="1000" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>预期用途：</label>
						<form:input path="expeUsage" htmlEscape="false" maxlength="1000" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>适用范围：</label>
						<form:input path="useScope" htmlEscape="false" maxlength="1000" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>产品有效期（月）：</label>
						<form:input path="effiDate" htmlEscape="false" type="number" min="1" max="9999" step="1" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>储存条件：</label>
						<form:input path="storCond" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>运输条件：</label>
						<form:input path="tranCond" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>注册人/备案人名称(原文)：</label>
						<form:input path="regiPersName" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>注册人/备案人名称(翻译)：</label>
						<form:input path="regiPersNameTran" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>注册人/备案人住所：</label>
						<form:input path="regiPersAddr" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>注册人/备案人联系方式：</label>
						<form:input path="regiPersCont" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>生产地址：</label>
						<form:input path="produAddr" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>生产国或地区（中文）：</label>
						<form:input path="produAreaCn" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>生产国或地区（英文）：</label>
						<form:input path="produAreaEn" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>生产厂商名称（中文）：</label>
						<form:input path="produFactCn" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>代理人名称：</label>
						<form:input path="agentName" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>代理人住所：</label>
						<form:input path="agentAddr" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>代理人联系方式：</label>
						<form:input path="agentCont" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>售后服务单位：</label>
						<form:input path="saledServOrg" htmlEscape="false" maxlength="250" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>

					<li style="display:none;"><label>说明：</label>
						<form:input path="explanation" htmlEscape="false" maxlength="1000" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
					<li style="display:none;"><label>备注：</label>
						<form:input path="remarks" htmlEscape="false" maxlength="1000" class="input-medium"/>
						<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
					</li>
				</ul>
				<a id="btnSubmit" class="btn btn-primary"  onclick="submitThisForm()">查询</a>
			</div>
		</div>
	</div>
</form:form>
<sys:message content="${message}"/>
<!-- 表单上部的按钮组，左侧的按键如修改、删除、审批的href的id值可以留空，前台会传入数据 (新的class：newBtn)-->
<shiro:hasPermission name="gsp:t01prodcert:t01ProdCert:edit">
	<a href="javascript:void(0);" onclick="deleteCert();"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
</shiro:hasPermission>
<!-- 表单的列名称下拉项以及导出按钮 加class-->
<span class="checkOut newBtn btn btn-primary" onclick="exportThis()">导出</span>
<span class="printSpan newBtn btn btn-primary" onclick="printThis(this)">打印</span>
<div id="columnNameDiv" class="btn-group">
	<a class="newBtn btn dropdown-toggle" data-toggle="dropdown" href="#">
		列名称
	</a>
	<ul id="columnName" class="dropdown-menu">
	</ul>
</div>
<!----------------------------------->
<%!
	int count = 1;
%>
<div id="borderScroll" style="width:98.5%; overflow: auto;">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
			<th>注册证/备案凭证编号</th>
			<th>原注册证/备案凭证编号</th>
			<th>风险分类</th>
			<th>技术分类-名称</th>
			<th>批准日期</th>
			<th>生效日期</th>
			<th>有效期至</th>
			<th>更新时间</th>
			<th>产品名称（中文）</th>
			<th>产品名称（英文）</th>
			<th>型号规格</th>
			<th>结构及组成</th>
			<th>主要组成成分</th>
			<th>预期用途</th>
			<th>适用范围</th>
			<th>产品有效期（月）</th>
			<th>储存条件</th>
			<th>运输条件</th>
			<th>注册人/备案人名称(原文)</th>
			<th>注册人/备案人名称(翻译)</th>
			<th>注册人/备案人住所</th>
			<th>注册人/备案人联系方式</th>
			<th>生产地址</th>
			<th>生产国或地区（中文）</th>
			<th>生产厂商名称（中文）</th>
			<th>生产国或地区（英文）</th>
			<th>代理人名称</th>
			<th>代理人住所</th>
			<th>代理人联系方式</th>
			<th>售后服务单位</th>
			<th>审批状态</th>
			<th>资质状态</th>
			<th>资质类型</th>
			<th>备注</th>
			<th>说明</th>
			<th>附件</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t01ProdCert">
			<%
				count++;
			%>
			<tr>
				<td><input id="checkbox_a<%= count %>" class="chk_1" type="checkbox" onchange="checkAll()"  data-id="${t01ProdCert.id}"/><label for="checkbox_a<%= count %>"></label></td>
				<td class="hoverChange ">
					<a class="${t01ProdCert.certStat=='0' && t01ProdCert.apprStat=='2'?'highlight0':''}
				${t01ProdCert.certStat=='1' && t01ProdCert.apprStat=='2'?'highlight3':''}
				${t01ProdCert.certStat=='2' && t01ProdCert.apprStat=='2'?'highlight1':''}
				${t01ProdCert.certStat=='3' && t01ProdCert.apprStat=='2'?'highlight2':''} "
					   href="${ctx}/gsp/t01prodcert/t01ProdCert/details?id=${t01ProdCert.id}">
							${t01ProdCert.regiCertNbr}
					</a></td>
				<td>
						${t01ProdCert.origRegiCertNbr}
				</td>
				<td>
						${fns:getDictLabel(t01ProdCert.riskClass, 't01_riskClass', '')}
				</td>
				<td>
						${fns:getDictLabel(t01ProdCert.techCateCd, 't01_tech_cate_cd', '')}
				</td>
				<td>
					<fmt:formatDate value="${t01ProdCert.apprDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${t01ProdCert.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${t01ProdCert.prodNameCn}
				</td>
				<td>
						${t01ProdCert.prodNameEn}
				</td>
				<td>
						${t01ProdCert.modelSpec}
				</td>
				<td>
						${t01ProdCert.struComp}
				</td>
				<td>
						${t01ProdCert.mainMnt}
				</td>
				<td>
						${t01ProdCert.expeUsage}
				</td>
				<td>
						${t01ProdCert.useScope}
				</td>
				<td>
						${t01ProdCert.effiDate}
				</td>
				<td>
						${t01ProdCert.storCond}
				</td>
				<td>
						${t01ProdCert.tranCond}
				</td>
				<td>
						${t01ProdCert.regiPersName}
				</td>
				<td>
						${t01ProdCert.regiPersNameTran}
				</td>
				<td>
						${t01ProdCert.regiPersAddr}
				</td>
				<td>
						${t01ProdCert.regiPersCont}
				</td>
				<td>
						${t01ProdCert.produAddr}
				</td>
				<td>
						${t01ProdCert.produAreaCn}
				</td>
				<td>
						${t01ProdCert.produFactCn}
				</td>
				<td>
						${t01ProdCert.produAreaEn}
				</td>
				<td>
						${t01ProdCert.agentName}
				</td>
				<td>
						${t01ProdCert.agentAddr}
				</td>
				<td>
						${t01ProdCert.agentCont}
				</td>
				<td>
						${t01ProdCert.saledServOrg}
				</td>
				<td>
						${fns:getDictLabel(t01ProdCert.apprStat, 't01_apprStat', '')}
				</td>
				<td>
					<span class="${t01ProdCert.certStat=='0' && t01ProdCert.apprStat=='2'?'bgLight0':''}
				${t01ProdCert.certStat=='1' && t01ProdCert.apprStat=='2'?'bgLight3':''}
				${t01ProdCert.certStat=='2' && t01ProdCert.apprStat=='2'?'bgLight1':''}
				${t01ProdCert.certStat=='3' && t01ProdCert.apprStat=='2'?'bgLight2':''} ">
							${fns:getDictLabel(t01ProdCert.certStat, 't01_certStat', '')}
					</span>
				</td>
				<td>
						${fns:getDictLabel(t01ProdCert.certType, 't01_certType', '')}
				</td>
				<td>
						${t01ProdCert.remarks}
				</td>
				<td>
						${t01ProdCert.explanation}
				</td>
				<td>
						${fns:getAttachLabel(t01ProdCert.attachment)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<div class="pagination">${page}</div>
<script>
	/**
	 * 删除资质
	 */
	function deleteCert(){
		var checks = $("#contentTable input:checkbox").not(":first").filter(":checked");
		if(checks.size()<1){
			alertx("你必须选择一条记录删除！");
			return null;
		}else if(checks.size()>1){
			alertx("你只能选择一条记录删除！");
			return null;
		}
		confirmx('一旦删除数据将无法恢复，请确认是否删除？', function () {
			var dataId = checks.attr("data-id");
			window.location.href = "${ctx}/gsp/t01prodcert/t01ProdCert/deleteProdCert?id=" + dataId;
		});
	};
</script>
</body>
</html>

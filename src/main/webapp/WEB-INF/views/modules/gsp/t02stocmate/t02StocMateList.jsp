<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>盘点-物料信息管理</title>
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
		<li class="active"><a href="${ctx}/gsp/t02stocmate/t02StocMate/">盘点-物料信息列表</a></li>
		<shiro:hasPermission name="gsp:t02stocmate:t02StocMate:edit"><li><a href="${ctx}/gsp/t02stocmate/t02StocMate/form">盘点-物料信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="t02StocMate" action="${ctx}/gsp/t02stocmate/t02StocMate/" method="post" class="breadcrumb form-search">
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
					value="<fmt:formatDate value="${t02StocMate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新人：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>更新时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${t02StocMate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注信息：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>流程实例ID：</label>
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>库位：</label>
				<form:input path="location" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>物料号：</label>
				<form:input path="mateNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>描述：</label>
				<form:input path="description" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>产品名称：</label>
				<form:input path="prodName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>规格型号：</label>
				<form:input path="modelSpec" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>注册证号：</label>
				<form:input path="regiCertNo" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>单位：</label>
				<form:input path="unit" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产企业名称：</label>
				<form:input path="prodEnteName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>生产批号/序列号：</label>
				<form:input path="seriNumb" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>有效期：</label>
				<form:input path="valiPeri" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>失效日期：</label>
				<form:input path="disaDate" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>入库时间：</label>
				<form:input path="storTime" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>库存数量：</label>
				<form:input path="stockQuan" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>实际盘点数量：</label>
				<form:input path="actuInveQuan" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>商品条码：</label>
				<form:input path="commBarCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>商品名称：</label>
				<form:input path="commName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>供应商编码：</label>
				<form:input path="suppCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>品类：</label>
				<form:input path="prodClas" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>品牌：</label>
				<form:input path="brand" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>转换因子：</label>
				<form:input path="convFact" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>外箱因子：</label>
				<form:input path="outerBoxFact" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>零售价：</label>
				<form:input path="retaPrice" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>其中整件：</label>
				<form:input path="whichWhole" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>其中零散：</label>
				<form:input path="whichScat" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>实盘整件：</label>
				<form:input path="whole" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>零散：</label>
				<form:input path="scattered" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>总数：</label>
				<form:input path="total" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>差异：</label>
				<form:input path="variance" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>当前库存成本：</label>
				<form:input path="currInveCost" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>库位</th>
				<th>物料号</th>
				<th>描述</th>
				<th>产品名称</th>
				<th>规格型号</th>
				<th>注册证号</th>
				<th>单位</th>
				<th>生产企业名称</th>
				<th>生产批号/序列号</th>
				<th>有效期</th>
				<th>失效日期</th>
				<th>入库时间</th>
				<th>库存数量</th>
				<th>实际盘点数量</th>
				<th>商品条码</th>
				<th>商品名称</th>
				<th>供应商编码</th>
				<th>品类</th>
				<th>品牌</th>
				<th>转换因子</th>
				<th>外箱因子</th>
				<th>零售价</th>
				<th>其中整件</th>
				<th>其中零散</th>
				<th>实盘整件</th>
				<th>零散</th>
				<th>总数</th>
				<th>差异</th>
				<th>当前库存成本</th>
				<shiro:hasPermission name="gsp:t02stocmate:t02StocMate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02StocMate">
			<tr>
				<td><a href="${ctx}/gsp/t02stocmate/t02StocMate/form?id=${t02StocMate.id}">
					${t02StocMate.id}
				</a></td>
				<td>
					${t02StocMate.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02StocMate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02StocMate.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${t02StocMate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${t02StocMate.remarks}
				</td>
				<td>
					${t02StocMate.procInsId}
				</td>
				<td>
					${t02StocMate.location}
				</td>
				<td>
					${t02StocMate.mateNumb}
				</td>
				<td>
					${t02StocMate.description}
				</td>
				<td>
					${t02StocMate.prodName}
				</td>
				<td>
					${t02StocMate.modelSpec}
				</td>
				<td>
					${t02StocMate.regiCertNo}
				</td>
				<td>
					${t02StocMate.unit}
				</td>
				<td>
					${t02StocMate.prodEnteName}
				</td>
				<td>
					${t02StocMate.seriNumb}
				</td>
				<td>
					${t02StocMate.valiPeri}
				</td>
				<td>
					${t02StocMate.disaDate}
				</td>
				<td>
					${t02StocMate.storTime}
				</td>
				<td>
					${t02StocMate.stockQuan}
				</td>
				<td>
					${t02StocMate.actuInveQuan}
				</td>
				<td>
					${t02StocMate.commBarCode}
				</td>
				<td>
					${t02StocMate.commName}
				</td>
				<td>
					${t02StocMate.suppCode}
				</td>
				<td>
					${t02StocMate.prodClas}
				</td>
				<td>
					${t02StocMate.brand}
				</td>
				<td>
					${t02StocMate.convFact}
				</td>
				<td>
					${t02StocMate.outerBoxFact}
				</td>
				<td>
					${t02StocMate.retaPrice}
				</td>
				<td>
					${t02StocMate.whichWhole}
				</td>
				<td>
					${t02StocMate.whichScat}
				</td>
				<td>
					${t02StocMate.whole}
				</td>
				<td>
					${t02StocMate.scattered}
				</td>
				<td>
					${t02StocMate.total}
				</td>
				<td>
					${t02StocMate.variance}
				</td>
				<td>
					${t02StocMate.currInveCost}
				</td>
				<shiro:hasPermission name="gsp:t02stocmate:t02StocMate:edit"><td>
    				<a href="${ctx}/gsp/t02stocmate/t02StocMate/form?id=${t02StocMate.id}">修改</a>
					<a href="${ctx}/gsp/t02stocmate/t02StocMate/delete?id=${t02StocMate.id}" onclick="return confirmx('确认要删除该盘点-物料信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
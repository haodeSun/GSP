<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>物料信息导入</title>
<meta name="decorator" content="default" />
<script>

	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	function importSelected() {

		var importIds = "";
		var selectedNum = 0;
		$('#contentTable tbody input[type="checkbox"]').each(function() {
			if (this.checked == true) {
				importIds += $(this).attr("data-id").trim() + ",";
				selectedNum++;
			}
		});
		$("#importIds").val(importIds);
		if (selectedNum == 0) {
			alertx("请至少选择一条数据同步");
			return false;
		} else {
			$("#syncImportForm").submit();
		}
	}
	$(document).ready(function () {
		top.$.jBox.tip.mess=0;
		document.getElementById("excelFile").onchange = function () {
			document.getElementById("excelFileName").value = document.getElementById("excelFile").value;
		}
		$("#btnSubmit").click(function () {
			if($("#excelFileName").val()==""){

				alertx("请选择文件");
			}else {
				$("#importExcel").submit();
			}
		});
	});

</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>物料信息<span class="divider">&gt;</span></li>
		<li class="active">物料信息导入</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">物料信息导入</div>
	<sys:message content="${message}"/>
	<form id="importExcel" action="${ctx}/gsp/t01matrinfo/t01MatrInfo/importExcel"
		method="post" enctype="multipart/form-data">
		<a href="javascript:void(0)">
			<input type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" style="opacity: 0; position: absolute;width: 240px;cursor:pointer;" name="excelFile" id="excelFile">
			<input type="text" style="width: 240px; margin: 0;height: 32px;" id="excelFileName">
		</a>
		<input id="btnSubmit" type="button" value="上传">
	</form>
	<a  href="${ctx}/gsp/t01matrinfo/t01MatrInfo/downMod"><span class=" newBtn btn btn-primary">模板下载</span></a>

	<form id="syncImportForm"
		action="${ctx}/gsp/t01matrinfo/t01MatrInfo/syncImport" method="post">
		<input id="importIds" name="ids" type="hidden">
		<a id="toEdit" href="javascript:void(0)" onclick="importSelected()"><span class="newBtn btn btn-primary">同步</span></a>
	</form>
	
	<form:form id="searchForm" modelAttribute="t01MatrSync" action="${ctx}/gsp/t01matrinfo/t01MatrInfo/toImport" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<%!
		int count = 1;
	%>
	<div id="borderScroll" style="width: 99%; overflow: auto;">
		<table id="contentTable"
			class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
					<th>物料号</th>
					<th>物料名称（中文）</th>
					<th>物料名称（英文）</th>
					<th>描述</th>
					<th>物料分类</th>
					<th>货币单位</th>
					<th>物料单价</th>
					<%--<th>备注</th>--%>
					<th>同步状态</th>
					<th>同步结果</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.list}" var="t01MatrSync">
					<%
						count++;
					%>
					<tr>
						<td><input type="checkbox" id="checkbox_a<%= count %>" class="chk_1" onchange="checkAll()"
							data-id="${t01MatrSync.id}" /><label for="checkbox_a<%= count %>"></label></td>
						<td>${t01MatrSync.matrNbr}</td>
						<td>${t01MatrSync.matrNmCn}</td>
						<td>${t01MatrSync.matrNmEn}</td>
						<td>${t01MatrSync.matrDesc}</td>
						<td>${fns:getDictLabel(t01MatrSync.matrType, 't01_matr_info_matr_type', '')}
						</td>
						<td>${t01MatrSync.priceUnit}</td>
						<td>${t01MatrSync.matrPrice}</td>
						<%--<td>${t01MatrSync.remarks}</td>--%>
						<td>${fns:getDictLabel(t01MatrSync.syncStat, 't01_matr_sync_sync_Stat', '')}
						</td>
						<td>${t01MatrSync.syncRslt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>物料信息详情</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.tip.mess=0;
		});
	</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>物料信息<span class="divider">&gt;</span></li>
		<li class="active">物料信息详情</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">物料信息详情</div>
	<form:form id="inputForm" modelAttribute="t01MatrInfo"
		action="${ctx}/gsp/t01matrinfo/t01MatrInfo/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<input id="taskId" name="taskId" type="hidden" value="${taskId}">
		<input id="startAudit" name="startAudit" type="hidden" value="0">
		<sys:message content="${message}" />
		<div id="pagingDiv" class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#p0" role="tab"
					data-toggle="tab"> 基本信息 </a></li>
				<li role="presentation"><a href="#p1" role="tab"
					data-toggle="tab"> 价格信息 </a></li>
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="p0">

					<div class="control-group">
						<label class="control-label">物料号：</label>
						<div class="controls">
							<form:input path="matrNbr" htmlEscape="false" maxlength="128"
								class="input-xlarge required" disabled="true" />
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">物料名称（中文）：</label>
						<div class="controls">
							<form:input path="matrNmCn" htmlEscape="false" maxlength="128"
								class="input-xlarge required" disabled="true" />
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">物料名称（英文）：</label>
						<div class="controls">
							<form:input path="matrNmEn" htmlEscape="false" maxlength="128"
								class="input-xlarge required" disabled="true" />
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">描述：</label>
						<div class="controls">
							<form:input path="matrDesc" htmlEscape="false" maxlength="500"
								class="input-xlarge required" disabled="true" />
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">物料分类：</label>
						<div class="controls">
							<form:select path="matrType" class="input-xlarge required" disabled="true">
								<form:option value="" label="" />
								<form:options
									items="${fns:getDictList('t01_matr_info_matr_type')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">备注：</label>
						<div class="controls">
							<form:input path="remarks" maxlength="100"
								class="textarea-xlarge" disabled="true" />
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">物料状态：</label>
						<div class="controls">
							<form:select path="martStat" class="input-xlarge required" disabled="true">
								<form:option value="" label="" />
								<form:options
										items="${fns:getDictList('t01_matr_info_mart_stat')}"
										itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">审批状态：</label>
						<div class="controls">
							<form:select path="apprStat" class="input-xlarge required" disabled="true">
								<form:option value="" label="" />
								<form:options
										items="${fns:getDictList('t01_matr_info_appr_stat')}"
										itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane fade" id="p1">

					<div class="control-group">
						<label class="control-label">货币单位：</label>
						<div class="controls">
							<form:input path="priceUnit" htmlEscape="false" maxlength="64"
								class="input-xlarge required" disabled="true" />
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">物料单价：</label>
						<div class="controls">
							<form:input path="matrPrice" htmlEscape="false"
								class="input-xlarge required" disabled="true" />
						</div>
					</div>

				</div>
			</div>
		</div>
	</form:form>
	<div id="borderScroll" style="width: 99%; overflow: auto;">

	</div>
	<iframe id="prodListFrame" name="prodListFrame" style="width: 99%;"  frameborder="0"></iframe>

	<div id="footBtnDiv" class="form-actions" style="width: 99%;">
		<input id="btnCancel" class="btn" type="button" value="返 回"
			   onclick="history.go(-1)" />
	</div>

	<form id="prodListForm" style="display:none;" action="${ctx}/gsp/t01complprod/t01ComplProd/prodList" method="post" target="prodListFrame">
		<input id="idsCertNbrForm" name="ids" value="<c:forEach items="${t01MatrInfo.prodCertIdList}" var="item">${item},</c:forEach>" type="hidden" >
		<input id="detailView" name="detailView" value="true">
	</form>
	<script>
		$(document).ready(function () {
			$("#prodListForm").submit();
			$("#prodListFrame").load(function(){
				var height = $(this).contents().find("body").height() + 40;
				$(this).height( height);
			});
		});
	</script>
	<sys:operateSave/>
	<sys:operateHistory module="t01MatrInfo" dataId="${t01MatrInfo.id}" />
</body>
</html>
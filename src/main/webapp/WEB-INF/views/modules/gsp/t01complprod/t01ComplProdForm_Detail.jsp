<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营产品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#prodListForm").submit();

			$("#prodListFrame").load(function(){
				var height = $(this).contents().find("body").height() + 40;
				$(this).height( height);
			});
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element.siblings("span:last"));
					}
				}
			});


			$("#getMatrInfo").click(function () {
				if ($("#matrNbr").val().trim() == "") {
					alertx("请填写物料号关联物料")
				} else {
					$.ajax({
						type: "post",
						dataType: "json",
						url: '${ctx}/gsp/t01complprod/t01ComplProd/getMatrInfo',
						data: {matrNbr: $("#matrNbr").val()},
						success: function (data) {
							if(data!=null){
								alertx("关联物料成功");
								$("#matrId").val(data.id);
								$("#matrNmCn").val(data.matrNmCn);
								$("#matrNmEn").val(data.matrNmEn);
								$("#matrDesc").val(data.matrDesc);
								var matrType= data.matrType;
								var matrTypeText=$("#matrType").find("option[value = '"+matrType+"']").text();
								$("#matrType").siblings("div").find(".select2-chosen").text(matrTypeText);
								$("#priceUnit").val(data.priceUnit);
								$("#matrPrice").val(data.matrPrice);
							}else {
								alertx("关联物料失败，未找到相关信息");
							}
						},
						error: function () {
							alertx("请求服务器数据失败");
						}
					});
				}
			});

			$("#getProdList").click(function () {
				if ($("#regiCertNbr").val().trim() == "") {
					alertx("请填写资质证号")
				} else {
					$("#idsCertNbrForm").val("");
					$("#regiCertNbrForm").val($("#regiCertNbr").val());

					$("#prodListForm").submit();
				}
			});
		});

	</script>
</head>
<body>
	<form id="prodListForm" style="display:none;" action="${ctx}/gsp/t01complprod/t01ComplProd/prodList" method="post" target="prodListFrame">
		<input id="regiCertNbrForm" name="regiCertNbrs" type="hidden" >

		<input id="detailView" name="detailView" value="true">
		<input id="idsCertNbrForm" name="ids" value="<c:forEach items="${t01ComplProd.prodCertIdList}" var="item">${item},</c:forEach>" type="hidden" >
	</form>

	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>首营产品<span class="divider">&gt;</span></li>
		<li class="active">首营产品详情</li>
	</ul>

	<div id="topTitle">首营产品详情</div>

	<form:form id="inputForm" modelAttribute="t01ComplProd" action="${ctx}/gsp/t01complprod/t01ComplProd/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="matrId"/>
		<input id="prodCertIds" name="prodCertIds" value="<c:forEach items="${t01ComplProd.prodCertIdList}" var="item">${item},</c:forEach>" type="hidden" >
		<sys:message content="${message}"/>
		<div id="pagingDiv" class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="p0">

					<div class="control-group">
						<label class="control-label"> 物料号：</label>
						<div class="controls">
							<form:input disabled="true" path="matrNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>

						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 物料名称（中文）：</label>
						<div class="controls">
							<form:input disabled="true" path="matrNmCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 物料名称（英文）：</label>
						<div class="controls">
							<form:input disabled="true" path="matrNmEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 描述：</label>
						<div class="controls">
							<form:input disabled="true" path="matrDesc" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
							
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 物料分类：</label>
						<div class="controls">
							<form:select disabled="true" path="matrType" class="input-xlarge ">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('t01_matr_info_matr_type')}" itemLabel="label"
											  itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"></span>
							存储条件_温度：</label>
						<div class="controls">
							<form:input disabled="true" cssStyle="width:194px" path="storTemp" htmlEscape="false" class="input-xlarge required"/>
							<span style="width: 10px;" >-</span>
							<form:input disabled="true" cssStyle="width:194px" path="storTemp2" htmlEscape="false" class="input-xlarge required"/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"></span>
							存储条件_湿度：</label>
						<div class="controls">
							<form:input disabled="true" cssStyle="width:194px" path="storWet" htmlEscape="false" class="input-xlarge required"/>
							<span style="width: 10px;" >-</span>
							<form:input disabled="true" cssStyle="width:194px" path="storWet2" htmlEscape="false" class="input-xlarge required"/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"></span>
							运输条件_温度：</label>
						<div class="controls">
							<form:input disabled="true" cssStyle="width:194px" path="tranTemp" htmlEscape="false" class="input-xlarge required"/>
							<span style="width: 10px;" >-</span>
							<form:input disabled="true" cssStyle="width:194px" path="tranTemp2" htmlEscape="false" class="input-xlarge required"/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"></span>
							运输条件_湿度：</label>
						<div class="controls">
							<form:input disabled="true" cssStyle="width:194px" path="tranWet" htmlEscape="false" class="input-xlarge required"/>
							<span style="width: 10px;" >-</span>
							<form:input disabled="true" cssStyle="width:194px" path="tranWet2" htmlEscape="false" class="input-xlarge required"/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"></span>
							物料单位：</label>
						<div class="controls">
							<form:input disabled="true" path="martUnit" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 货币单位：</label>
						<div class="controls">
							<form:input disabled="true" path="priceUnit" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 物料单价：</label>
						<div class="controls">
							<form:input disabled="true" path="matrPrice" htmlEscape="false" class="input-xlarge "/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"></span>
							物料规格：</label>
						<div class="controls">
							<form:input disabled="true" path="specType" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"></span>
							产品有效期（月）：</label>
						<div class="controls">
							<form:input disabled="true" path="validMonths" htmlEscape="false" maxlength="11"
										class="input-xlarge required"/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 备注：</label>
						<div class="controls">
							<form:input disabled="true" path="remarks" htmlEscape="false" rows="4" maxlength="512"
										   class="input-xxlarge "/>
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
			</div>
		</div>

		<div style="width: 100%">
			<br>
		</div>

		<iframe id="prodListFrame" name="prodListFrame" style="width: 100%;"  frameborder="0"  ></iframe>


		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

<script>

</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营产品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.tip.mess=0;

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
				ignore: ".ignore",
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
			jQuery.validator.addMethod("notNegative", function (value, element) {
				return this.optional(element) || /^[0-9]+\.?[0-9]*$/.test(value);
			}, "必须为数字且为非负数");
            jQuery.validator.addMethod("mustBig", function (value, element) {
                return this.optional(element) || parseInt(value)>=parseInt($("#"+element.id).siblings("input:first").val());
            }, "最高值不能小于最低值");



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
								if (data.apprStat != "2") {
									alertx("关联失败！只有审核通过的物料信息才可关联");
								} else if (data.martStat == "2") {
									alertx("关联失败！相关信息在冻结状态无法进行关联保存");
								} else if ("1"==data.matrType ) {
									alertx("关联失败！非医疗器械物料信息无法进行关联保存");
								} else {
									alertx("关联物料成功");
									$("#matrId").val(data.id);
									$("#matrNmCn").val(data.matrNmCn);
									$("#matrNmEn").val(data.matrNmEn);
									$("#matrDesc").val(data.matrDesc);
									var matrType = data.matrType;
									var matrTypeText = $("#matrType").find("option[value = '" + matrType + "']").text();
									$("#matrType").siblings("div").find(".select2-chosen").text(matrTypeText);
									$("#priceUnit").val(data.priceUnit);
									$("#matrPrice").val(data.matrPrice);
								}
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

			$("#btnSubmit").click(function () {
				if ($("#matrId").val().trim() == "" ||
						$("#prodCertIds").val().trim() == "") {
					alertx("需要关联物料信息和产品资质信息");
				} else {
//					$(".required").addClass("ignore");
//					$(".number").removeClass("required");
//					$(".number").removeClass("ignore");
					$("#inputForm").submit();
				}
			});
			$("#btnSubmitAndAppr").click(function(){
				if ($("#matrId").val().trim() == "" ||
						$("#prodCertIds").val().trim() == "") {
					alertx("需要关联物料信息和产品资质信息");
				} else {
//					$(".required").removeClass("ignore");
					$("#startAudit").val("startAudit");
					$("#inputForm").submit();
				}
			});
		});

	</script>
</head>
<body>
	<form id="prodListForm" style="display:none;" action="${ctx}/gsp/t01complprod/t01ComplProd/prodList" method="post" target="prodListFrame">
		<input id="regiCertNbrForm" name="regiCertNbr" type="hidden" >

		<input id="idsCertNbrForm" name="ids" value="<c:forEach items="${t01ComplProd.prodCertIdList}" var="item">${item},</c:forEach>" type="hidden" >
	</form>

	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>首营产品<span class="divider">&gt;</span></li>
		<li class="active">首营产品${not empty t01ComplProd.id?'修改':'新增'}</li>
	</ul>

	<div id="topTitle">首营产品${not empty t01ComplProd.id?'修改':'新增'}</div>

	<form:form id="inputForm" modelAttribute="t01ComplProd" action="${ctx}/gsp/t01complprod/t01ComplProd/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="matrId"/>
		<form:hidden path="act.taskId"/>
		<input id="startAudit" name="startAudit" type="hidden" value="0">
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
							<form:input path="matrNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
							<span class="promptPic"></span>
							<button id="getMatrInfo" class="newBtnNoFloat btn btn-primary" type="button">关联物料</button>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 物料名称（中文）：</label>
						<div class="controls">
							<form:input disabled="true" path="matrNmCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 物料名称（英文）：</label>
						<div class="controls">
							<form:input disabled="true" path="matrNmEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 描述：</label>
						<div class="controls">
							<form:input disabled="true" path="matrDesc" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
							<span class="promptPic"></span>
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
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							存储条件_温度：</label>
						<div class="controls">
							<form:input path="storTemp" cssStyle="width:194px" htmlEscape="false" class="input-small required number"/>
                            <span style="width: 10px;" >-</span>
                            <form:input path="storTemp2" cssStyle="width:194px" htmlEscape="false" class="input-small required number mustBig"/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							存储条件_湿度：</label>
						<div class="controls">
							<form:input path="storWet" cssStyle="width:194px" htmlEscape="false" class="input-small required number"/>
                            <span style="width: 10px;" >-</span>
                            <form:input path="storWet2" cssStyle="width:194px" htmlEscape="false" class="input-small required number mustBig"/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							运输条件_温度：</label>
						<div class="controls">
							<form:input path="tranTemp" cssStyle="width:194px" htmlEscape="false" class="input-small required number"/>
                            <span style="width: 10px;" >-</span>
                            <form:input path="tranTemp2" cssStyle="width:194px" htmlEscape="false" class="input-small required number mustBig"/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							运输条件_湿度：</label>
						<div class="controls">
							<form:input path="tranWet" cssStyle="width:194px"  htmlEscape="false" class="input-small required number"/>
                            <span style="width: 10px;" >-</span>
                            <form:input path="tranWet2" cssStyle="width:194px" htmlEscape="false" class="input-small required number mustBig"/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							物料单位：</label>
						<div class="controls">
							<form:input path="martUnit" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 货币单位：</label>
						<div class="controls">
							<form:input disabled="true" path="priceUnit" htmlEscape="false" maxlength="250" class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 物料单价：</label>
						<div class="controls">
							<form:input disabled="true" path="matrPrice"  htmlEscape="false" class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
                            物料规格：</label>
						<div class="controls">
							<form:input path="specType" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							产品有效期（月）：</label>
						<div class="controls">
							<form:input path="validMonths" htmlEscape="false" maxlength="11"
										class="input-xlarge required notNegative"/>
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"> 备注：</label>
						<div class="controls">
							<form:input path="remarks" htmlEscape="false" rows="4" maxlength="512"
										   class="input-xxlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>

				</div>
			</div>
		</div>

		<div style="width: 100%">
			<br>
			<label class="control-label"> 资质证号：</label>
			<div class="controls">
				<form:input path="regiCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
				<button id="getProdList" class="newBtnNoFloat btn btn-primary" type="button" >查 询</button>
			</div>
		</div>

		<iframe id="prodListFrame" name="prodListFrame" style="width: 100%;"  frameborder="0"></iframe>


		<div id="footBtnDiv" class="form-actions">
			<input id="btnSubmitAndAppr" type="button"  style="width:82px; height:34px;" class="btn btn-primary btnSubmit" value="提 交"/>&nbsp;
			<input id="btnSubmit" type="button" class="btn btn-primary" style="width:82px; height:34px;"  value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="window.location='${ctx}/gsp/t01complprod/t01ComplProd'"/>
		</div>
	</form:form>

<script>

</script>
</body>
</html>
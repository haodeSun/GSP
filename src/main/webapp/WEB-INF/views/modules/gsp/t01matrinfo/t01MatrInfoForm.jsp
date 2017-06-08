<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>物料信息管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.tip.mess=0;
			$(".controls input").blur(function(){
				setTimeout('$("#messageBox").fadeOut("500")',4000);
			});
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				ignore: ".ignore",
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					setTimeout('$("#messageBox").fadeOut("500")',4000);
					$("#errorInfo").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element.siblings("span:last"));
					}
				}
			});
			$("#btnSubmit").click(function(){
//				$( ".required" ).addClass("ignore");
//				$(".number").removeClass("required");
//				$(".number").removeClass("ignore");
				$("#inputForm").submit();
			});
			$("#btnSubmitAndAppr").click(function(){
//				$(".number").addClass("required");
//				$( ".required" ).removeClass("ignore");
				$("#startAudit").val("startAudit");
				$("#inputForm").submit();
			});
			$("#matrNbr").change(function(){
				$.ajax({
					type: "post",
					dataType: "json",
					url: '${ctx}/gsp/t01matrinfo/t01MatrInfo/checkOnly',
					data: {matrNbr:$(this).val()},
					success: function (data) {
						if (data.code == "101") {
							alertx(data.message);
						}else if(data.code == "102"){
							alertx(data.message);
						}else {

						}
					},
					error:function () {
						alertx("请求服务器数据失败");
					}
				});
			});
		});
	</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>物料信息<span class="divider">&gt;</span></li>
		<li class="active">物料信息${not empty t01MatrInfo.id?'修改':'新增'}</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">物料信息${not empty t01MatrInfo.id?'修改':'新增'}</div>
	<form:form id="inputForm" modelAttribute="t01MatrInfo"
		action="${ctx}/gsp/t01matrinfo/t01MatrInfo/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<input id="taskId" name="act.taskId" type="hidden" value="${t01MatrInfo.act.taskId}">
		<input id="startAudit" name="startAudit" type="hidden" value="0">
		<sys:message content="${message}" />
		<div  id="messageBox" class="alert alert-error hide" style="position: absolute;top: 0px;right: 0px;width: 300px;background: rgba(44,52,60,0.80) !important;border: 0px;">
			<label id="errorInfo"></label>
			<button data-dismiss="alert"  class="close" style="color:#fff;">×</button>
		</div>
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
						<label class="control-label"><span class="help-inline"><font color="red">*</font> </span>物料号：</label>
						<div class="controls">
							<form:input path="matrNbr" htmlEscape="false" maxlength="250"
								class="input-xlarge required" />
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"><span class="help-inline"><font color="red">*</font> </span>物料名称（中文）：</label>
						<div class="controls">
							<form:input path="matrNmCn" htmlEscape="false" maxlength="250"
								class="input-xlarge required" />
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">物料名称（英文）：</label>
						<div class="controls">
							<form:input path="matrNmEn" htmlEscape="false" maxlength="250"
								class="input-xlarge" />
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">描述：</label>
						<div class="controls">
							<form:input path="matrDesc" htmlEscape="false" maxlength="1000"
								class="input-xlarge" />
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"><span class="help-inline"><font color="red">*</font> </span>物料分类：</label>
						<div class="controls">
							<form:select path="matrType" class="input-xlarge required">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('t01_matr_info_matr_type')}"
									itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">备注：</label>
						<div class="controls">
							<form:input path="remarks" maxlength="1000"
								class="textarea-xlarge" />
							<span class="promptPic"></span>
						</div>
					</div>

				</div>
				<div role="tabpanel" class="tab-pane fade" id="p1">

					<div class="control-group">
						<label class="control-label"><span class="help-inline"><font color="red">*</font> </span>货币单位：</label>
						<div class="controls">
							<form:input path="priceUnit" htmlEscape="false" maxlength="250"
								class="input-xlarge required" />
							<span class="promptPic"></span>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label"><span class="help-inline"><font color="red">*</font> </span>物料单价：</label>
						<div class="controls">
							<form:input path="matrPrice" htmlEscape="false" maxlength="250"
								class="input-xlarge required number"  />
							<span class="promptPic"></span>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div id="footBtnDiv" class="form-actions">
			<shiro:hasPermission name="gsp:t01matrinfo:t01MatrInfo:edit">
				<input id="btnSubmitAndAppr" class="btn btn-primary btnSubmit" value="提 交" />&nbsp;</shiro:hasPermission>
			<shiro:hasPermission name="gsp:t01matrinfo:t01MatrInfo:edit">
				<input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button"
					   value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				   onclick="window.location='${ctx}/gsp/t01matrinfo/t01MatrInfo'" />
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>验收-物料信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/gsp/t02acceptmate/t02AcceptMate/">验收-物料信息列表</a></li>
		<li class="active"><a href="${ctx}/gsp/t02acceptmate/t02AcceptMate/form?id=${t02AcceptMate.id}">验收-物料信息<shiro:hasPermission name="gsp:t02acceptmate:t02AcceptMate:edit">${not empty t02AcceptMate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="gsp:t02acceptmate:t02AcceptMate:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="t02AcceptMate" action="${ctx}/gsp/t02acceptmate/t02AcceptMate/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">流程实例ID：</label>
			<div class="controls">
				<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">物料编号：</label>
			<div class="controls">
				<form:input path="mateNo" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">产品名称（中文）：</label>
			<div class="controls">
				<form:input path="prodNameCn" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">注册证号：</label>
			<div class="controls">
				<form:input path="regiCertNo" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生产批号：</label>
			<div class="controls">
				<form:input path="batchNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生产日期：</label>
			<div class="controls">
				<form:input path="manuDate" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">失效日期：</label>
			<div class="controls">
				<form:input path="disaDate" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">有效期：</label>
			<div class="controls">
				<form:input path="valiPeri" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生产企业：</label>
			<div class="controls">
				<form:input path="manuEnte" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">供货者：</label>
			<div class="controls">
				<form:input path="supplier" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货数量：</label>
			<div class="controls">
				<form:input path="receQuan" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">验收合格数：</label>
			<div class="controls">
				<form:input path="acceNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">验收结果：</label>
			<div class="controls">
				<form:input path="checkResu" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">不合格数：</label>
			<div class="controls">
				<form:input path="unquNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">不合格事项及处理措施：</label>
			<div class="controls">
				<form:input path="unquHandMeas" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="gsp:t02acceptmate:t02AcceptMate:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
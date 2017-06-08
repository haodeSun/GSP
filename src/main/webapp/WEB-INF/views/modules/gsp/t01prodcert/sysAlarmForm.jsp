<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>预警表管理</title>
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
		<li><a href="${ctx}/gsp/sysalarm/sysAlarm/">预警表列表</a></li>
		<li class="active"><a href="${ctx}/gsp/sysalarm/sysAlarm/form?id=${sysAlarm.id}">预警表<shiro:hasPermission name="gsp:sysalarm:sysAlarm:edit">${not empty sysAlarm.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="gsp:sysalarm:sysAlarm:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysAlarm" action="${ctx}/gsp/sysalarm/sysAlarm/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#p1" role="tab" data-toggle="tab">人人</a></li>
								<li role="presentation"><a href="#p2" role="tab" data-toggle="tab">哈哈</a></li>
								<li role="presentation"><a href="#p3" role="tab" data-toggle="tab">啦啦</a></li>
								<li role="presentation"><a href="#p4" role="tab" data-toggle="tab">网王</a></li>
			</ul>
			<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade in active" id="p1">
										<div class="control-group">
											<label class="control-label">预警内容：</label>
											<div class="controls">
												<form:input path="warnCont" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</div>
										</div>
							</div>
						<div role="tabpanel" class="tab-pane fade in active" id="p2">
										<div class="control-group">
											<label class="control-label">流程实例ID：</label>
											<div class="controls">
												<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</div>
										</div>
							</div>
						<div role="tabpanel" class="tab-pane fade in active" id="p3">
										<div class="control-group">
											<label class="control-label">判断方式：</label>
											<div class="controls">
												<form:input path="judgMethod" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</div>
										</div>
							</div>
						<div role="tabpanel" class="tab-pane fade in active" id="p4">
										<div class="control-group">
											<label class="control-label">预警状态：</label>
											<div class="controls">
												<form:input path="warnStatus" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">预警类型：</label>
											<div class="controls">
												<form:input path="warnType" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">预警级别：</label>
											<div class="controls">
												<form:hidden id="warnLevel" path="warnLevel" htmlEscape="false" maxlength="100" class="input-xlarge"/>
												<sys:ckfinder input="warnLevel" type="files" uploadPath="/gsp/sysalarm/sysAlarm" selectMultiple="true"/>
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">关联表_记录id：</label>
											<div class="controls">
												<form:input path="recordId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</div>
										</div>
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="gsp:sysalarm:sysAlarm:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
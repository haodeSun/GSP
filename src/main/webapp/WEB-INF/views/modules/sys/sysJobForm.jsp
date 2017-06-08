<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务表管理</title>
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
		<li><a href="${ctx}/sys/sysJob/">任务表列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysJob/form?id=${sysJob.id}">任务表<shiro:hasPermission name="sys:sysJob:edit">${not empty sysJob.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysJob:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysJob" action="${ctx}/sys/sysJob/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
			</ul>
			<div class="tab-content">
				<div role="tabpanel"  class=
					"tab-pane fade in active"
				
				 id="p0">
							
								<div class="control-group">
									<label class="control-label">任务名称：</label>
									<div class="controls">
										<form:input path="jobName" htmlEscape="false" maxlength="50" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">trigger名称：</label>
									<div class="controls">
										<form:input path="targgerName" htmlEscape="false" maxlength="50" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">job_group：</label>
									<div class="controls">
										<form:input path="jobGroup" htmlEscape="false" maxlength="50" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">trigger_group：</label>
									<div class="controls">
										<form:input path="triggerGroup" htmlEscape="false" maxlength="50" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">任务执行类：</label>
									<div class="controls">
										<form:input path="clazzName" htmlEscape="false" maxlength="2048" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">任务状态：</label>
									<div class="controls">
										<form:input path="jobStatus" htmlEscape="false" maxlength="50" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">上次运行时间：</label>
									<div class="controls">
										<form:input path="lastRunTime" htmlEscape="false" maxlength="50" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">表达式：</label>
									<div class="controls">
										<form:input path="expression" htmlEscape="false" maxlength="200" class="input-xlarge "/>
									</div>
								</div>
							
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:sysJob:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
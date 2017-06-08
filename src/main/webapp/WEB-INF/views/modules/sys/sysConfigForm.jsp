<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统配置表管理</title>
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
		<li><a href="${ctx}/sys/sysConfig/">系统配置表列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysConfig/form?id=${sysConfig.id}">系统配置表<shiro:hasPermission name="sys:sysConfig:edit">${not empty sysConfig.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysConfig:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysConfig" action="${ctx}/sys/sysConfig/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div id="pagingDiv" class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
			</ul>
			<div class="tab-content">
				<div role="tabpanel"  class=
					"tab-pane fade in active"
				
				 id="p0">
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									数据值：</label>
									<div class="controls">
										<form:input path="configValue" htmlEscape="false" maxlength="2048" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									配置名称：</label>
									<div class="controls">
										<form:input path="configName" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									排序（升序）：</label>
									<div class="controls">
										<form:input path="sort" htmlEscape="false" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									Java Type：</label>
									<div class="controls">
										<form:input path="type" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									备注信息：</label>
									<div class="controls">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
									</div>
								</div>
							
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:sysConfig:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
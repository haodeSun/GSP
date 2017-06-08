<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>预警过滤配置管理</title>
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
		<li><a href="${ctx}/sys/sysAlarmFilter/">预警过滤配置列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysAlarmFilter/form?id=${sysAlarmFilter.id}">预警过滤配置<shiro:hasPermission name="sys:sysAlarmFilter:edit">${not empty sysAlarmFilter.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysAlarmFilter:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysAlarmFilter" action="${ctx}/sys/sysAlarmFilter/save" method="post" class="form-horizontal">
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
									<label class="control-label">									过滤规则：</label>
									<div class="controls">
										<form:input path="role" htmlEscape="false" maxlength="500" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									包含关系：</label>
									<div class="controls">
										<form:checkbox path="included" />
									</div>
								</div>
							
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:sysAlarmFilter:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
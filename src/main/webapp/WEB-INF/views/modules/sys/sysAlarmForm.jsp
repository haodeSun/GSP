<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>预警信息管理</title>
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
		<li><a href="${ctx}/sys/sysAlarm/">预警信息列表</a></li>
		<li class="active"><a href="${ctx}/sys/sysAlarm/form?id=${sysAlarm.id}">预警信息<shiro:hasPermission name="sys:sysAlarm:edit">${not empty sysAlarm.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:sysAlarm:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysAlarm" action="${ctx}/sys/sysAlarm/save" method="post" class="form-horizontal">
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
									<label class="control-label">									备注信息：</label>
									<div class="controls">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									关联类：</label>
									<div class="controls">
										<form:input path="className" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									预警内容：</label>
									<div class="controls">
										<form:input path="warnCont" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									提前时间（按月计算）：</label>
									<div class="controls">
										<form:input path="aheadTime" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									提醒频率（几天一次）：</label>
									<div class="controls">
										<form:input path="alarmFreq" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									预警开关：</label>
									<div class="controls">
										<form:checkbox path="sendFlag" />
										<!-- <input type="checkbox" name="sendFlag" value="true"/> -->
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									资质类型：</label>
									<div class="controls">
										<form:select path="qualifyType" class="input-medium">
											<form:options items="${fns:getDictList('sys_qualify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									上次提醒时间：</label>
									<div class="controls">
										<input name="lastAlarmTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
											value="<fmt:formatDate value="${sysAlarm.lastAlarmTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
									</div>
								</div>
							
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:sysAlarm:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
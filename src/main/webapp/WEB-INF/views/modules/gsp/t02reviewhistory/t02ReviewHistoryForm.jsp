<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审核记录管理</title>
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
		<li><a href="${ctx}/gsp/t02reviewhistory/t02ReviewHistory/">审核记录列表</a></li>
		<li class="active"><a href="${ctx}/gsp/t02reviewhistory/t02ReviewHistory/form?id=${t02ReviewHistory.id}">审核记录<shiro:hasPermission name="gsp:t02reviewhistory:t02ReviewHistory:edit">${not empty t02ReviewHistory.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="gsp:t02reviewhistory:t02ReviewHistory:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="t02ReviewHistory" action="${ctx}/gsp/t02reviewhistory/t02ReviewHistory/save" method="post" class="form-horizontal">
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
									<label class="control-label">备注信息：</label>
									<div class="controls">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">审核分类：</label>
									<div class="controls">
										<form:input path="reivewType" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
										<span class="help-inline"><font color="red">*</font> </span>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">审核结果：</label>
									<div class="controls">
										<form:select path="reviewResult" class="input-xlarge required">
											<form:option value="" label=""/>
											<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
										</form:select>
										<span class="help-inline"><font color="red">*</font> </span>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">审核对象：</label>
									<div class="controls">
										<form:input path="reviewInst" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
										<span class="help-inline"><font color="red">*</font> </span>
									</div>
								</div>
							
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="gsp:t02reviewhistory:t02ReviewHistory:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>协议与物料的关联信息管理</title>
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
		<li><a href="${ctx}/gsp/t01aggrmatr/t01AggrMatr/">协议与物料的关联信息列表</a></li>
		<li class="active"><a href="${ctx}/gsp/t01aggrmatr/t01AggrMatr/form?id=${t01AggrMatr.id}">协议与物料的关联信息<shiro:hasPermission name="gsp:t01aggrmatr:t01AggrMatr:edit">${not empty t01AggrMatr.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="gsp:t01aggrmatr:t01AggrMatr:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="t01AggrMatr" action="${ctx}/gsp/t01aggrmatr/t01AggrMatr/save" method="post" class="form-horizontal">
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
									<label class="control-label">									流程实例ID：</label>
									<div class="controls">
										<form:input path="procInsId" htmlEscape="false" maxlength="128" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									协议id：</label>
									<div class="controls">
										<form:input path="aggrId" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									物料id：</label>
									<div class="controls">
										<form:input path="matrId" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									单价：</label>
									<div class="controls">
										<form:input path="price" htmlEscape="false" maxlength="128" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									数量：</label>
									<div class="controls">
										<form:input path="count" htmlEscape="false" maxlength="128" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									备注信息：</label>
									<div class="controls">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="512" class="input-xxlarge "/>
									</div>
								</div>
							
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="gsp:t01aggrmatr:t01AggrMatr:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
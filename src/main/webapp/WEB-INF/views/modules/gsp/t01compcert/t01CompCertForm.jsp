<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业资质管理</title>
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
		<li><a href="${ctx}/gsp/t01compcert/t01CompCert/">企业资质列表</a></li>
		<li class="active"><a href="${ctx}/gsp/t01compcert/t01CompCert/form?id=${t01CompCert.id}">企业资质<shiro:hasPermission name="gsp:t01compcert:t01CompCert:edit">${not empty t01CompCert.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="gsp:t01compcert:t01CompCert:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="t01CompCert" action="${ctx}/gsp/t01compcert/t01CompCert/save" method="post" class="form-horizontal">
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
									企业id：</label>
									<div class="controls">
										<form:input path="compId" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									资质证号：</label>
									<div class="controls">
										<form:input path="certNbr" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									资质类型：</label>
									<div class="controls">
										<form:input path="certType" htmlEscape="false" maxlength="16" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									机构名称/销售人员姓名：</label>
									<div class="controls">
										<form:input path="certName" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									生产/经营/销售范围/诊疗科目：</label>
									<div class="controls">
										<form:input path="certScop" htmlEscape="false" maxlength="1000" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									生效日期/发证日期：</label>
									<div class="controls">
										<input name="effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
											value="<fmt:formatDate value="${t01CompCert.effecDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									有效期至：</label>
									<div class="controls">
										<input name="validDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
											value="<fmt:formatDate value="${t01CompCert.validDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									资质状态：</label>
									<div class="controls">
										<form:input path="certStat" htmlEscape="false" maxlength="16" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									审批状态：</label>
									<div class="controls">
										<form:input path="apprStat" htmlEscape="false" maxlength="16" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									附件：</label>
									<div class="controls">
										<form:input path="attachment" htmlEscape="false" maxlength="2048" class="input-xlarge required"/>
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
			<shiro:hasPermission name="gsp:t01compcert:t01CompCert:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业信息管理</title>
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
		<li><a href="${ctx}/gsp/t01compinfo/t01CompInfo/">企业信息列表</a></li>
		<li class="active"><a href="${ctx}/gsp/t01compinfo/t01CompInfo/form?id=${t01CompInfo.id}">企业信息<shiro:hasPermission name="gsp:t01compinfo:t01CompInfo:edit">${not empty t01CompInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="gsp:t01compinfo:t01CompInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="t01CompInfo" action="${ctx}/gsp/t01compinfo/t01CompInfo/save" method="post" class="form-horizontal">
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
									企业类型：</label>
									<div class="controls">
										<form:input path="compType" htmlEscape="false" maxlength="16" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									注册证号：</label>
									<div class="controls">
										<form:input path="regiNbr" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									组织机构代码证号：</label>
									<div class="controls">
										<form:input path="orgCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									税务登记证号：</label>
									<div class="controls">
										<form:input path="taxNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									经营方式：</label>
									<div class="controls">
										<form:input path="busiMode" htmlEscape="false" maxlength="16" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									经营场所：</label>
									<div class="controls">
										<form:input path="busiLoca" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									库房地址：</label>
									<div class="controls">
										<form:input path="storLoca" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									企业名称（中文）：</label>
									<div class="controls">
										<form:input path="compNameCn" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									企业名称（英文）：</label>
									<div class="controls">
										<form:input path="compNameEn" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									简称：</label>
									<div class="controls">
										<form:input path="shortName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									描述：</label>
									<div class="controls">
										<form:input path="compDesc" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									注册地址：</label>
									<div class="controls">
										<form:input path="regiLoca" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									年检状态：</label>
									<div class="controls">
										<form:input path="annuCheckStat" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									
										<span class="help-inline"><font color="red">*</font> </span>
									法人姓名：</label>
									<div class="controls">
										<form:input path="legalPers" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									生产能力评价：</label>
									<div class="controls">
										<form:input path="prodAbliEval" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									质量管理评价：</label>
									<div class="controls">
										<form:input path="qualMgrEval" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									仓储能力评价：</label>
									<div class="controls">
										<form:input path="storAbliEval" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									交付能力评价：</label>
									<div class="controls">
										<form:input path="deliAbliEval" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									售后服务能力评价：</label>
									<div class="controls">
										<form:input path="afteSaleAbliEval" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									拼音：</label>
									<div class="controls">
										<form:input path="phonetic" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									邮编：</label>
									<div class="controls">
										<form:input path="code" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									区号：</label>
									<div class="controls">
										<form:input path="areaCode" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									电话：</label>
									<div class="controls">
										<form:input path="telephone" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									传真：</label>
									<div class="controls">
										<form:input path="fax" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									电报：</label>
									<div class="controls">
										<form:input path="telegraph" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									联系人：</label>
									<div class="controls">
										<form:input path="contPers" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									联系人电话：</label>
									<div class="controls">
										<form:input path="contPersTel" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									邮箱：</label>
									<div class="controls">
										<form:input path="email" htmlEscape="false" maxlength="250" class="input-xlarge "/>
									</div>
								</div>
							
							
								<div class="control-group">
									<label class="control-label">									备注信息：</label>
									<div class="controls">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000" class="input-xxlarge "/>
									</div>
								</div>
							
							</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="gsp:t01compinfo:t01CompInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>
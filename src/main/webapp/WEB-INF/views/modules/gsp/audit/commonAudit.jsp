<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批流程</title>
	<meta name="decorator" content="default"/>

	<%@ include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#auditForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
				    var clz = element.attr("class");
				    if(clz.indexOf("required") != -1){
						alertx("必填项必须填写！");
					}
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
	<%--<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
		<li>首页<span class="divider">/</span></li>
		<li>首营产品<span class="divider">/</span></li>
		<li class="active">产品资质审批</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">产品资质审批</div>--%>

	${content}
	<form id="auditForm" action="${ctx}/gsp/act/save" method="post"  class="form-horizontal approvalForm">
		<sys:message content="${message}"/>
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<input name="view" type="hidden" value="${view}"/>
		<input type="hidden" id="pass" value="0"/>
		<%--<div>
			<div>
				<c:if test="${!empty sourceUrl}">
				  <a class = "btn" href="${ctx}${sourceUrl}&act.taskId=${act.taskId}">编辑</a>
				</c:if>
			</div>
			&lt;%&ndash;审批状态不要了&ndash;%&gt;
&lt;%&ndash;			<div style="text-align: right;height: 100px">
				<label>审批状态：</label>
				<input style="border:#CCC solid 1px;border-radius:15px;" type="text" disabled value="${approveStatus}">
			</div>&ndash;%&gt;
		</div>--%>

			<!-- 此处加id,两按钮互换位置 -->
		<div id="footBtnDiv" class="form-actions">
			${formProperties}
			<%--<input type="textarea"/>--%>
			<input id="btnBack" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<input id="btnNo" class="btn" type="submit" value="未通过" onclick="$('#flag').val('no')"/>
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="通 过"
				   onclick="$('#flag').val('yes')"/>
		</div>
		</form>
		<%--<div class="container-fluid">
			${formProperties}
		</div>

		&lt;%&ndash;<textarea id="comment" name="comment" style="width:500px" maxlength="200" class="required" rows="5"></textarea>&ndash;%&gt;
		<div class="form-actions">
			<c:if test="${approveStatus eq '【同意】' || empty approveStatus}">
				<input id="btnSubmitYes" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
				<input id="btnSubmitNo" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>--%>
<%--		<c:if test="${not empty id}">
			<act:histoicFlow procInsId="${act.procInsId}" />
		</c:if>--%>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var optionsCN = $(".ul-form").find("label").text();
			var newOptionsCN = optionsCN.split("：");
			for(var i=0,newOptionsCNLen=newOptionsCN.length;i<newOptionsCNLen-1;i++){
				$("#querySelect").append("<option value ='"+newOptionsCN[i]+"'>"+newOptionsCN[i]+"</option>")
			}
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        
        function deleteSelf(obj){
			$(obj).parent("li").css({"display":"none"});
		}
		function submitThisForm(){
			$("#searchForm").submit();
		}
		function addCondition(){
			var optionsText = $(".ul-form").find("label").text();
			var newOptionsText = optionsText.split("：");
			var chooseValue = $("#querySelect").val();
			var copyHtml = "";
			for(var k=0,newOptionsTextLen=newOptionsText.length;k<newOptionsTextLen;k++){
				var liDisplay = $($(".ul-form").find("li")[k]).css("display");
				if(chooseValue == newOptionsText[k]){
					if(liDisplay == "block"){
						alert("选项已存在");
					}
					else{
						$($(".ul-form").find("label")[k]).parent().css({"display":"block"});
						copyHtml = $($(".ul-form").find("label")[k]).parent().prop("outerHTML");
						$($(".ul-form").find("label")[k]).parent().remove();
						$(".ul-form li:last").after(copyHtml);
					}
				}
			}
		}
	</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
<!-- 	<ul class="breadcrumb">
	  <li><a href="#">首页</a> <span class="divider">/</span></li>
	  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
	  <li class="active">任务表删除</li>
	</ul> -->
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">任务列表</div>
	<!--20161113-->
	<div id="selectGroup" class="accordion-group">
		<span>查询条件</span>
		<select name='' aria-required=true' class='form-control' id='querySelect' style="width:200px;margin-left:15px;"></select>
		<button id="addCondition" class="btn btn-primary" style="margin-left:40px;" onclick="addCondition()">添加条件</button>
		<button id="btnSubmit" class="btn btn-primary" style="margin-left:40px;" onclick="submitThisForm()">查询</button>
	</div>
	<form:form id="searchForm" modelAttribute="sysJob" action="${ctx}/sys/sysJob/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div id="foldList" class="accordion-group">
		    <div class="accordion-heading">
		      	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
		        	折叠列表
		      	</a>
		    </div>
		    <div id="collapseOne" class="accordion-body collapse in">
		      	<div class="accordion-inner">
					<ul class="ul-form">
					
					</ul>
				</div>
		    </div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<!-- 表单上部的按钮组，左侧的按键如修改、删除、审批的href的id值可以留空，前台会传入数据 (新的class：newBtn)-->
	<shiro:hasPermission name="sys:sysJob:edit">
		<a href="${ctx}/sys/sysJob/delete?id=${sysJob.id}" onclick="return confirmx('确认要删除该任务表吗？', this.href)"><span class="newBtn btn btn-primary">删除</span></a>
		<a href="${ctx}/sys/sysJob/form"><span class="newBtn btn btn-primary">添加</span></a>
		<span class="newBtn btn btn-primary" onclick="printThis(this)">打印</span>
	</shiro:hasPermission>
	<!-- 表单的列名称下拉项以及导出按钮 -->
	<span class="checkOut newBtn btn btn-primary" onclick="exportThis()">导出</span>
	<div id="columnNameDiv" class="btn-group">
	  	<a class="newBtn btn dropdown-toggle" data-toggle="dropdown" href="#">
	   		 列名称<span class="caret"></span>
	  	</a>
	 	<ul id="columnName" class="dropdown-menu">
	 	</ul>
	</div>
  <!----------------------------------->
  <div id="borderScroll" style="width:99%; overflow: auto;">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" onchange="chooseAll(this)"/></th>
				<th>任务名称</th>
				<th>trigger名称</th>
				<th>job_group</th>
				<th>trigger_group</th>
				<th>任务执行类</th>
				<th>任务状态</th>
				<th>上次运行时间</th>
				<th>表达式</th>
				<shiro:hasPermission name="sys:sysJob:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysJob">
			<tr>
				<td><input type="checkbox" onchange="checkAll()"/></td>
				<td><a href="${ctx}/sys/sysJob/form?id=${sysJob.id}">
					${sysJob.jobName}
				</a></td>
				<td>
					${sysJob.targgerName}
				</td>
				<td>
					${sysJob.jobGroup}
				</td>
				<td>
					${sysJob.triggerGroup}
				</td>
				<td>
					${sysJob.clazzName}
				</td>
				<td>
					<c:choose>
						<c:when test="${sysJob.jobStatus== 'NORMAL'}">
   							正常
 						 </c:when>
 						 <c:when test="${sysJob.jobStatus== 'PAUSED'}">
   							暂停
 						 </c:when>
 						<c:otherwise>
 							异常
 						</c:otherwise>
					</c:choose> 
				</td>
				<td>
					${sysJob.lastRunTime}
				</td>
				<td>
					${sysJob.expression}
				</td>
				<td>
					<c:choose>
   						<c:when test="${sysJob.jobStatus== 'NORMAL'}">
   							<a href="${ctx}/sys/sysJob/pauseJob?id=${sysJob.id}"><span class="newBtn btn btn-primary">暂停</span></a> 
   						 </c:when>
   						 <c:when test="${sysJob.jobStatus== 'PAUSED'}">
   							<a href="${ctx}/sys/sysJob/resumeJob?id=${sysJob.id}"><span class="newBtn btn btn-primary">恢复</span></a> 
   						 </c:when>
   						<c:otherwise>
   						</c:otherwise>
					</c:choose>  
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
	<div class="pagination">${page}</div>
</body>
</html>
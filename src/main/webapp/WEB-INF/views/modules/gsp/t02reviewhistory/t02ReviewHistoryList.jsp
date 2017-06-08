<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审核记录管理</title>
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
	<ul class="breadcrumb">
	  <li><a href="#">首页</a> <span class="divider">/</span></li>
	  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
	  <li class="active">审核记录删除</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">审核记录删除</div>
	<!--20161113-->
	
	<form:form id="searchForm" modelAttribute="t02ReviewHistory" action="${ctx}/gsp/t02reviewhistory/t02ReviewHistory/" method="post" class="breadcrumb form-search">
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
			      	<div id="selectGroup" class="accordion-group">
						<span>查询条件</span>
						<select name='' aria-required=true' class='form-control' id='querySelect' style="width:200px;margin-left:15px;"></select>
						<a id="addCondition" class="btn btn-primary" onclick="addCondition()">添加条件</a>
					</div>
					<ul class="ul-form">
					</ul>
					<a id="btnSubmit" class="btn btn-primary" onclick="submitThisForm()">查询</a>
				</div>
		    </div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<!-- 表单上部的按钮组，左侧的按键如修改、删除、审批的href的id值可以留空，前台会传入数据 (新的class：newBtn)-->
	<shiro:hasPermission name="gsp:t02reviewhistory:t02ReviewHistory:edit">
		<a href="${ctx}/gsp/t02reviewhistory/t02ReviewHistory/delete?id=${t02ReviewHistory.id}" onclick="return confirmx('确认要删除该审核记录吗？', this.href)"><span class="newBtn btn btn-primary">删除</span></a>
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
				<th>更新时间</th>
				<th>备注信息</th>
				<th>审核结果</th>
				<shiro:hasPermission name="gsp:t02reviewhistory:t02ReviewHistory:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="t02ReviewHistory">
			<tr>
				<td><input type="checkbox" onchange="checkAll()"/></td>
				<td><a href="${ctx}/gsp/t02reviewhistory/t02ReviewHistory/form?id=${t02ReviewHistory.id}">
					<fmt:formatDate value="${t02ReviewHistory.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${t02ReviewHistory.remarks}
				</td>
				<td>
					${fns:getDictLabel(t02ReviewHistory.reviewResult, '', '')}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
	<div class="pagination">${page}</div>
</body>
</html>
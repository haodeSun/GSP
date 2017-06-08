<%@ page contentType="text/html;charset=UTF-8" %>
        <%@ include file="/WEB-INF/views/include/taglib.jsp"%>
        <html>
        <head>
            <title>售出信息管理</title>
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
			var testArray = ${fns:toJson(fields)};
			for(var j=0,inputLen=$("#inputForm").find(".controls").length;j<inputLen;j++){
				var inputId = $($("#inputForm").find(".controls")[j]).children().attr("name");
				if($.inArray(inputId,testArray) == -1){
					$($("#inputForm").find(".controls")[j]).append('<span class="newBtnNoFloat btn btn-primary" onclick="changeAs(this)">变更为</span>');
				}
				else if(inputId == "regiCertNo"){
					$($("#inputForm").find(".controls")[j]).append('<span class="help-inline"><font color="red">*</font> </span> <span class="newBtnNoFloat btn btn-primary" onclick="queryThisForm()">查 询</span>');
				}
				else{
					$($("#inputForm").find(".controls")[j]).append('<span class="help-inline"><font color="red">*</font> </span>');
				}
			}
			$(".changeDiv").find(".controls").find("span:last-child").remove();
		});
			function addRow(list, idx, tpl, row){
				$(list).append(Mustache.render(tpl, {
					idx: idx, delBtn: true, row: row
				}));
				$(list+idx).find("select").each(function(){
					$(this).val($(this).attr("data-value"));
				});
				$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
					var ss = $(this).attr("data-value").split(',');
					for (var i=0; i<ss.length; i++){
						if($(this).val() == ss[i]){
							$(this).attr("checked","checked");
						}
					}
				});
			}
			function delRow(obj, prefix){
				var id = $(prefix+"_id");
				var delFlag = $(prefix+"_delFlag");
				if (id.val() == ""){
					$(obj).parent().parent().remove();
				}else if(delFlag.val() == "0"){
					delFlag.val("1");
					$(obj).html("&divide;").attr("title", "撤销删除");
					$(obj).parent().parent().addClass("error");
				}else if(delFlag.val() == "1"){
					delFlag.val("0");
					$(obj).html("&times;").attr("title", "删除");
					$(obj).parent().parent().removeClass("error");
				}
			}
	function changeAs(obj){
		var nextDiv = $(obj).parent().parent().next(".changeDiv");
		if(nextDiv.css("display") == "none"){
			nextDiv.css({"display":"block"});
		}
		else{
			nextDiv.css({"display":"none"});
		}
	}
	function saveTest(){
		var removeArr = [];
		for(var i=0,changeDivLen=$(".changeDiv").length;i<changeDivLen;i++){
			if($($(".changeDiv")[i]).css("display") == "none"){
				removeArr.push($($(".changeDiv")[i]));
			}
		}
		for(var n=0,arrLen=removeArr.length;n<arrLen;n++){
			removeArr[n].remove();
		}
		for(var j=0,changeNameLen=$(".changeDiv").find(".controls").length/2;j<changeNameLen;j++){
			for(var k=0,trueInpurLen=1;k<trueInpurLen;k++){
				if($($($(".changeDiv")[j]).find(".controls").children()[k]).attr("name").indexOf("{{idx}}") != "-1"){
					var replaceName = $($($(".changeDiv")[j]).find(".controls").children()[k]).attr("name").replace("{{idx}}","["+j+"]");
					var replaceHideName = $($(".changeDiv")[j]).find(".hideVlue").attr("name").replace("{{idx}}","["+j+"]");
					$($($(".changeDiv")[j]).find(".controls").children()[k]).attr("name",replaceName);
					$($(".changeDiv")[j]).find(".hideVlue").attr("name",replaceHideName);
				}
			}
		}
		$("form").submit();
	}
	function queryThisForm(){
		$.ajax({
			url:"${ctx}/gsp/t02sales/t02Sales/getRecord",
			type:"get",
			data:{regiCertNo:$("#regiCertNo").val()},
			success:function(data) {
				for(key in data){
				    $("input[name="+key+"]").val(data[key]);
				}
			},error:function(){
				alert("错误");
			}
		});
	}
	</script>
</head>
<body>
	<!-- 面包屑导航（文字以及链接应换为变量）  -->
	<ul class="breadcrumb">
	  <li><a href="#">首页</a> <span class="divider">/</span></li>
	  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
	  <li class="active">售出信息变更</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">售出信息变更</div>

	<form:form id="inputForm" modelAttribute="t02Sales" action="${ctx}/gsp/t02sales/t02Sales/save" method="post" class="form-horizontal">
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
									<label class="control-label">备注信息：</label>
			<div class="controls">
							<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">流程实例ID：</label>
			<div class="controls">
							<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">销售编号：</label>
			<div class="controls">
							<form:input path="salesNumb" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="salesNumb" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="salesNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">销售日期：</label>
			<div class="controls">
							<input name="salesDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
								value="<fmt:formatDate value="${t02Sales.salesDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
		                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
		                    <span class="datePic"></span>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<input name="salesDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${t02Sales.salesDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="salesDate" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">购货者id：</label>
			<div class="controls">
							<form:input path="custCompanyId" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="custCompanyId" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="custCompanyId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">联系方式：</label>
			<div class="controls">
							<form:input path="contMeth" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="contMeth" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="contMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">发货日期：</label>
			<div class="controls">
							<input name="deliDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
								value="<fmt:formatDate value="${t02Sales.deliDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
		                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
		                    <span class="datePic"></span>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<input name="deliDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${t02Sales.deliDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="deliDate" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">运输方式：</label>
			<div class="controls">
							<form:input path="tranMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="tranMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="tranMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">单据：</label>
			<div class="controls">
							<form:input path="bill" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="bill" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="bill" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">备注：</label>
			<div class="controls">
							<form:input path="comments" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="comments" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="comments" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">订单总价：</label>
			<div class="controls">
							<form:input path="totalOrderPrice" htmlEscape="false" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="totalOrderPrice" htmlEscape="false" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="totalOrderPrice" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">部门：</label>
			<div class="controls">
							<form:input path="department" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="department" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="department" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">客户：</label>
			<div class="controls">
							<form:input path="customer" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="customer" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="customer" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">销售代表：</label>
			<div class="controls">
							<form:input path="salesRepr" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="salesRepr" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="salesRepr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">发货仓库：</label>
			<div class="controls">
							<form:input path="deliWare" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="deliWare" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="deliWare" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">贸易结算方式：</label>
			<div class="controls">
							<form:input path="settMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="settMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="settMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">送货地址：</label>
			<div class="controls">
							<form:input path="deliAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="deliAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="deliAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">自动单号：</label>
			<div class="controls">
							<form:input path="autoNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="autoNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="autoNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">手工单号：</label>
			<div class="controls">
							<form:input path="manuNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="manuNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="manuNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">ALF：</label>
			<div class="controls">
							<form:input path="alf" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="alf" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="alf" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">出单地址：</label>
			<div class="controls">
							<form:input path="issueAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="issueAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="issueAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">预付款金额：</label>
			<div class="controls">
							<form:input path="prePayAmou" htmlEscape="false" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="prePayAmou" htmlEscape="false" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="prePayAmou" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">含税金额：</label>
			<div class="controls">
							<form:input path="taxAmou" htmlEscape="false" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="taxAmou" htmlEscape="false" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="taxAmou" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">总箱数：</label>
			<div class="controls">
							<form:input path="totalBoxNumb" htmlEscape="false" maxlength="11" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="totalBoxNumb" htmlEscape="false" maxlength="11" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="totalBoxNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">总支数：</label>
			<div class="controls">
							<form:input path="totalNumb" htmlEscape="false" maxlength="11" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="totalNumb" htmlEscape="false" maxlength="11" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="totalNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">付运方式：</label>
			<div class="controls">
							<form:input path="shipMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="shipMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="shipMeth" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">零售额合计：</label>
			<div class="controls">
							<form:input path="totalRetaSales" htmlEscape="false" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="totalRetaSales" htmlEscape="false" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="totalRetaSales" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>
			</div>

                <input id="hideName" type="hidden" value="t02SalesMateList">
			<div class="control-group">
				<label class="control-label">销售-物料信息：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>备注信息</th>
								<th>流程实例ID</th>
								<th>物料号</th>
								<th>销售单价</th>
								<th>销售数量</th>
								<th>单位</th>
								<th>金额</th>
								<th>商品编码</th>
								<th>商品条码</th>
								<th>转换码</th>
								<th>外箱含量</th>
								<th>订单数量</th>
								<th>供应商商品编码</th>
								<th>库存单品成本</th>
								<th>售价扣率</th>
								<th>含税金额</th>
								<th>不含税金额</th>
								<th>活动类型</th>
								<th>促销单号</th>
								<th>基价</th>
								<th>零售金额</th>
								<th>标准箱数量</th>
								<th>单品成本</th>
								<shiro:hasPermission name="gsp:t02sales:t02Sales:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="t02SalesMateList">
						</tbody>
						<shiro:hasPermission name="gsp:t02sales:t02Sales:edit"><tfoot>
							<tr><td colspan="25"><a href="javascript:" onclick="addRow('#t02SalesMateList', t02SalesMateRowIdx, t02SalesMateTpl);t02SalesMateRowIdx = t02SalesMateRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="t02SalesMateTpl">//<!--
						<tr id="t02SalesMateList{{idx}}">
							<td class="hide">
								<input id="t02SalesMateList{{idx}}_id" name="t02SalesMateList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="t02SalesMateList{{idx}}_delFlag" name="t02SalesMateList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
                            <td>
                            <textarea id="t02SalesMateList{{idx}}_remarks" name="t02SalesMateList[{{idx}}].remarks" rows="4" maxlength="100" class="input-small ">{{row.remarks}}</textarea>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_procInsId" name="t02SalesMateList[{{idx}}].procInsId" type="text" value="{{row.procInsId}}" maxlength="100" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_mateId" name="t02SalesMateList[{{idx}}].mateId" type="text" value="{{row.mateId}}" maxlength="100" class="input-small required"/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_salePrice" name="t02SalesMateList[{{idx}}].salePrice" type="text" value="{{row.salePrice}}" class="input-small required"/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_saleCount" name="t02SalesMateList[{{idx}}].saleCount" type="text" value="{{row.saleCount}}" maxlength="11" class="input-small required"/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_unit" name="t02SalesMateList[{{idx}}].unit" type="text" value="{{row.unit}}" maxlength="100" class="input-small required"/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_amount" name="t02SalesMateList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-small required"/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_commCode" name="t02SalesMateList[{{idx}}].commCode" type="text" value="{{row.commCode}}" maxlength="100" class="input-small required"/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_commBarCode" name="t02SalesMateList[{{idx}}].commBarCode" type="text" value="{{row.commBarCode}}" maxlength="100" class="input-small required"/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_convCode" name="t02SalesMateList[{{idx}}].convCode" type="text" value="{{row.convCode}}" maxlength="100" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_outerBoxCont" name="t02SalesMateList[{{idx}}].outerBoxCont" type="text" value="{{row.outerBoxCont}}" maxlength="100" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_orderQuan" name="t02SalesMateList[{{idx}}].orderQuan" type="text" value="{{row.orderQuan}}" maxlength="11" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_suppCommCode" name="t02SalesMateList[{{idx}}].suppCommCode" type="text" value="{{row.suppCommCode}}" maxlength="100" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_inveCost" name="t02SalesMateList[{{idx}}].inveCost" type="text" value="{{row.inveCost}}" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_priceDisc" name="t02SalesMateList[{{idx}}].priceDisc" type="text" value="{{row.priceDisc}}" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_taxAmou" name="t02SalesMateList[{{idx}}].taxAmou" type="text" value="{{row.taxAmou}}" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_noTaxAmou" name="t02SalesMateList[{{idx}}].noTaxAmou" type="text" value="{{row.noTaxAmou}}" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_actiType" name="t02SalesMateList[{{idx}}].actiType" type="text" value="{{row.actiType}}" maxlength="3" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_promSaleNo" name="t02SalesMateList[{{idx}}].promSaleNo" type="text" value="{{row.promSaleNo}}" maxlength="100" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_basePrice" name="t02SalesMateList[{{idx}}].basePrice" type="text" value="{{row.basePrice}}" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_retaAmou" name="t02SalesMateList[{{idx}}].retaAmou" type="text" value="{{row.retaAmou}}" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_stanBoxQuan" name="t02SalesMateList[{{idx}}].stanBoxQuan" type="text" value="{{row.stanBoxQuan}}" maxlength="11" class="input-small "/>
                            </td>
                            <td>
                            <input id="t02SalesMateList{{idx}}_singProdCost" name="t02SalesMateList[{{idx}}].singProdCost" type="text" value="{{row.singProdCost}}" class="input-small "/>
                            </td>
                                <shiro:hasPermission name="gsp:t02sales:t02Sales:edit"><td class="text-center" width="10">
                                    {{#delBtn}}<span class="close" onclick="delRow(this, '#t02SalesMateList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
                                </td></shiro:hasPermission>
                            </tr>//-->
                        </script>
                        <script type="text/javascript">
                            var t02SalesMateRowIdx = 0, t02SalesMateTpl = $("#t02SalesMateTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                            $(document).ready(function() {
                                var data = ${fns:toJson(t02Sales.t02SalesMateList)};
                                for (var i=0; i<data.length; i++){
                                    addRow('#t02SalesMateList', t02SalesMateRowIdx, t02SalesMateTpl, data[i]);
                                    t02SalesMateRowIdx = t02SalesMateRowIdx + 1;
                                }
                            });
                        </script>
                    </div>
                </div>

		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<shiro:hasPermission name="gsp:t02sales:t02Sales:edit"><input id="btnSubmit" class="btn btn-primary" type="button" onclick="saveTest()" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
    <script>
            var hideInput = $("#hideName").val();
            var arrCol = ["chanCol","chanValue","chanReason"];
            for(var p=0,changeInputLen=$(".changeDiv").length;p<changeInputLen;p++){
                var nameStr = hideInput + "{{idx}}." + arrCol[0];
                var valStr = $($(".changeDiv")[p]).prev().find(".controls").children().attr("name");
                $($(".changeDiv")[p]).find(".hideVlue").attr("name",nameStr);
                $($(".changeDiv")[p]).find(".hideVlue").val(valStr);
            }
            for(var m=0,changeInputSubLen=$(".changeDiv").find(".controls").length;m<changeInputSubLen;m++){
                if(m%2 == 0){
                    var valueStr = hideInput + "{{idx}}." + arrCol[1];
                    for(var z=0,childLen=$($(".changeDiv").find(".controls")[m]).children().length;z<childLen;z++){
                        $($($(".changeDiv").find(".controls")[m]).children()[0]).attr("name",valueStr);
                    }
                }
                else{
                    var nameStr = hideInput + "{{idx}}." + arrCol[2];
                    for(var x=0,childLen=$($(".changeDiv").find(".controls")[m]).children().length;x<childLen;x++){
                        $($($(".changeDiv").find(".controls")[m]).children()[1]).attr("name",nameStr);
                    }
                }
            }
        </script>
</body>
</html>
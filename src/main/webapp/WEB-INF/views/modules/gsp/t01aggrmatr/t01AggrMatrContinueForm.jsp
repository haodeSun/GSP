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
			url:"${ctx}/gsp/t01aggrmatr/t01AggrMatr/getRecord",
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
	  <li class="active">协议与物料的关联信息变更</li>
	</ul>
	<!-- 每页的title（文字换为变量） -->
	<div id="topTitle">协议与物料的关联信息变更</div>

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
									<label class="control-label">流程实例ID：</label>
			<div class="controls">
							<form:input path="procInsId" htmlEscape="false" maxlength="128" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="procInsId" htmlEscape="false" maxlength="128" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">协议id：</label>
			<div class="controls">
							<form:input path="aggrId" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="aggrId" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="aggrId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">物料id：</label>
			<div class="controls">
							<form:input path="matrId" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
                                <span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="matrId" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="matrId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">单价：</label>
			<div class="controls">
							<form:input path="price" htmlEscape="false" maxlength="128" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="price" htmlEscape="false" maxlength="128" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="price" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">数量：</label>
			<div class="controls">
							<form:input path="count" htmlEscape="false" maxlength="128" class="input-xlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:input path="count" htmlEscape="false" maxlength="128" class="input-xlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="count" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>

		<div class="control-group">
									<label class="control-label">备注信息：</label>
			<div class="controls">
							<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="512" class="input-xxlarge "/>
					</div>
				</div>


			<div class="control-group changeDiv" style="display:none">
			<input class="hideVlue" type="hidden" value="">
			<label class="control-label">变更为：</label>
			<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="512" class="input-xxlarge "/>
				</div>
				<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
				    <label class="control-label">备注：</label>
					<form:input path="remarks" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				</div>
			</div>
			</div>


		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<shiro:hasPermission name="gsp:t01aggrmatr:t01AggrMatr:edit"><input id="btnSubmit" class="btn btn-primary" type="button" onclick="saveTest()" value="保 存"/>&nbsp;</shiro:hasPermission>
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
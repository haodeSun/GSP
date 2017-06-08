<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营供货者管理</title>
	<meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style>
		.contentTable tr th {
			-webkit-box-sizing: border-box;
			background-image:none;
			background:#1fb5ac;
			height:40px;
			font-size:12px;
			font-weight:bold;
			color:#ffffff;
			text-align:center;
			vertical-align: middle;
			white-space: nowrap;
		}
		.contentTable tr td {
			-webkit-box-sizing: border-box;
			height:40px;
			font-size:12px;
			color:#3c3c3c;
			text-align:center;
			white-space: nowrap;
		}
		.input-append a.btn {
			margin-left:-80px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.tip.mess=0;
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				ignore: ".ignore",
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element.siblings("span:last"));
					}
				}
			});


			var testArray = ${fns:toJson(fields)};
			for (var j = 0, inputLen = $("#inputForm").find(".controls").length; j < inputLen; j++) {
				var inputId = '';
				if($($("#inputForm").find(".controls")[j]).children("select").length != 0){
					inputId = $($("#inputForm").find(".controls")[j]).children("select").attr("name");
				}
				else{
					inputId = $($("#inputForm").find(".controls")[j]).children().attr("name");
				}
				if ($.inArray(inputId, testArray) == -1) {
					if((inputId+"").indexOf("attachment")==-1
							&&inputId!="toggleCertNbr"
							&&inputId!="relateT01ComplBuyerID2"
							&&inputId!="t01CompInfo.regiNbr"
							&&inputId!="t01CompInfo.uniCretNbr"
							&&inputId!="t01CompCert2.certNbr"
							&&inputId!="t01CompCert1.certNbr"){
						$($("#inputForm").find(".controls")[j]).append('<span class="newBtnNoFloat btn btn-primary" onclick="changeAs(this)">变更为</span>');
					}
				}
				else if (inputId == "regiCertNbr") {
					$($("#inputForm").find(".controls")[j]).siblings("label").prepend('<span class="help-inline"><font color="red">*</font> </span> ');
					$($("#inputForm").find(".controls")[j]).append(' <span class="newBtnNoFloat btn btn-primary" onclick="queryThisForm()">查 询</span>');
				}
				else {
					$($("#inputForm").find(".controls")[j]).siblings("label").prepend('<span class="help-inline"><font color="red">*</font> </span>');
				}
			}
			$(".changeDiv").find(".controls").find("span:last-child").remove();

			$("#btnSubmit").click(function () {
                setCertScopIds();
				saveSalesCertIDs();
				ignoreSome();
				saveTest();

				//$(".required").addClass("ignore");
				$("#inputForm").submit();
			});
			$("#btnSubmitAndAppr").click(function () {
                setCertScopIds();
				saveSalesCertIDs();
				ignoreSome();
				saveTest();

				//$(".required").removeClass("ignore");
				$("#startAudit").val("startAudit");
				$("#inputForm").submit();
			});
			function ignoreSome(){
				var id=$("a[data-toggle='tab disabled']").attr("href");

				$(""+id+" .required").addClass("ignore");
			}

            function setCertScopIds() {
                var ids = [], nodes = tree2.getCheckedNodes(true);
                for(var i=0; i<nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#t01CompCert1\\.certScop:eq(1)").val(ids);
            }

            //经营范围数据展示 begin
			var setting = {
				check: {enable: true, nocheckInherit: true},
				view: {selectedMulti: false},
				data: {simpleData: {enable: true}},
				callback: {
					beforeClick: function (id, node) {
						tree.checkNode(node, !node.checked, true, true);
						return false;
					},
					beforeCheck: function(){
						return false;
					}
				}
			};

            // 用户-菜单
            var zNodes=[
                    <c:forEach items="${t01ComplSupl.certScopList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
                </c:forEach>];
            // 初始化树结构
            var tree = $.fn.zTree.init($("#certScopTree"), setting, zNodes);
            // 不选择父节点
            tree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
            // 默认选择节点

            var ids = "${t01ComplSupl.t01CompCert1.certScop}".split(",");
            for(var i=0; i<ids.length; i++) {
                var node = tree.getNodeByParam("id", ids[i]);
                try{tree.checkNode(node, true, false);}catch(e){}
            }
            // 默认展开全部节点
            tree.expandAll(true);

			var setting2 = {
				check: {enable: true, nocheckInherit: true},
				view: {selectedMulti: false},
				data: {simpleData: {enable: true}},
				callback: {
					beforeClick: function (id, node) {
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}
				}
			};

            var tree2 = $.fn.zTree.init($("#certScopTree2"), setting2, zNodes);
            // 不选择父节点
            tree2.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };

            // 默认展开全部节点
            tree2.expandAll(true);
            //经营范围数据展示 end


            var hideInput = $("#hideName").val();
            var arrCol = ["chanCol", "chanValue", "chanReason"];
            for (var p = 0, changeInputLen = $(".changeDiv").length; p < changeInputLen; p++) {
                var nameStr = hideInput + "{{idx}}." + arrCol[0];
                var valStr = $($(".changeDiv")[p]).prev().find(".controls").children().attr("name");
                $($(".changeDiv")[p]).find(".hideVlue").attr("name", nameStr);
                $($(".changeDiv")[p]).find(".hideVlue").val(valStr);
            }
            for (var m = 0, changeInputSubLen = $(".changeDiv").find(".controls").length; m < changeInputSubLen; m++) {
                if (m % 2 == 0) {
                    var valueStr = hideInput + "{{idx}}." + arrCol[1];
                    for (var z = 0, childLen = $($(".changeDiv").find(".controls")[m]).children().length; z < childLen; z++) {
                        $($($(".changeDiv").find(".controls")[m]).children()[0]).attr("name", valueStr);
                    }
                }
                else {
                    var nameStr = hideInput + "{{idx}}." + arrCol[2];
                    for (var x = 0, childLen = $($(".changeDiv").find(".controls")[m]).children().length; x < childLen; x++) {
                        $($($(".changeDiv").find(".controls")[m]).children()[1]).attr("name", nameStr);
                    }
                }
            }

            <!--***************************处理变更记录回显 BEGIN**********************************-->
            //拿到变更记录，并显示到页面
            var sysChanInfoList = ${fns:toJson(t01ComplSupl.sysChanInfoList)};
            //遍历变更记录list，将变更过的记录显示到页面
            $.each(sysChanInfoList,function(index,value){
                var col = value['chanCol'];
                //获取到当前字段下面的隐藏div
                var $hideNode = $("#"+col).parents('.control-group').next(".changeDiv:first");
                if($hideNode.length === 0){
                    $hideNode = $("input[name='"+col+"']").parents('.control-group').next(".changeDiv:first");
                }
                //显示
                if("attachment" != col){
                    $hideNode.css("display","block");
                }

                if("t01SalesCertIDs"==col){
                    $("#"+col+":first").parents('.changeDiv:first').css("display","block");
                    setSalesCertList(value['chanValue']);
                }
                if("t01CompCert1.certScop"==col) {
                    var ids = value['chanValue'].split(",");
                    for(var i=0; i<ids.length; i++) {
                        var node = tree2.getNodeByParam("id", ids[i]);
                        try{tree2.checkNode(node, true, false);}catch(e){}
                    }
                    $("#"+col+":eq(1)").parents('.changeDiv:first').css("display","block");
                }

                //赋值
                $hideNode.find(".controls:first input[name='sysChanInfoList{{idx}}.chanValue']").val(value['chanValue']);
                $hideNode.find(".remarkDiv input[name='sysChanInfoList{{idx}}.chanReason']").val(value['chanReason']);
            });
            <!--***************************处理变更记录回显 END**********************************-->

		});
		function saveSalesCertIDs(){
			var ids=getSalesCertIDList();
			$("#t01SalesCertIDs:first").val(ids);
		}

		function changeAs(obj) {
			var nextDiv = $(obj).parent().parent().next(".changeDiv");
			if (nextDiv.css("display") == "none") {
				nextDiv.css({"display": "block"});
				//清除修改变更时候的回显数据
				nextDiv.find("input[type!='hidden']").val("");
				nextDiv.find("select").val("");
			}
			else {
				nextDiv.css({"display": "none"});
			}
		}
		function saveTest() {
			var removeArr = [];
			for (var i = 0, changeDivLen = $(".changeDiv").length; i < changeDivLen; i++) {
				if ($($(".changeDiv")[i]).css("display") == "none") {
					removeArr.push($($(".changeDiv")[i]));
				}
			}
			for (var n = 0, arrLen = removeArr.length; n < arrLen; n++) {
				removeArr[n].remove();
			}

			for (var j = 0, changeNameLen = $(".changeDiv").find(".controls").length / 2; j < changeNameLen; j++) {
				for (var k = 0, trueInpurLen = 1; k < trueInpurLen; k++) {
					var childNode = '';
					if($($($(".changeDiv")[j]).find(".controls")[k]).children("select").length != "0"){
						childNode = "select";
					}
					else{
						childNode = "input";
					}
					if ($($($(".changeDiv")[j]).find(".controls")[k]).children(childNode).attr("name").indexOf("{{idx}}") != "-1") {
						var replaceName = $($($(".changeDiv")[j]).find(".controls")[k]).children(childNode).attr("name").replace("{{idx}}", "[" + j + "]");
						var replaceHideName = $($(".changeDiv")[j]).find(".hideVlue").attr("name").replace("{{idx}}", "[" + j + "]");
						var changeName = $($(".changeDiv")[j]).find(".remarkDiv").children("input").attr("name").replace("{{idx}}", "[" + j + "]");
						$($($(".changeDiv")[j]).find(".controls")[k]).children(childNode).attr("name", replaceName);
						$($(".changeDiv")[j]).find(".hideVlue").attr("name", replaceHideName);
						console.log($($(".changeDiv")[j]).find(".hideVlue").val());

						$($(".changeDiv")[j]).find(".remarkDiv").children("input").attr("name", changeName);
					}
				}
			}
			$("form").submit();
		}
		function queryThisForm() {
			var value = $("#regiCertNbr").val();
			if (!value) {
				alertx("请填写资质证号！");
				return;
			}
			//window.location.href="${ctx}/gsp/t01prodcert/t01ProdCert/getRecord?method=chan&regiCertNo="+value;
			$.ajax({
				url: "${ctx}/gsp/t01prodcert/t01ProdCert/getRecord",
				type: "get",
				data: {regiCertNbr: $("#regiCertNbr").val()},
				success: function (result) {
					if(result.code == '1'){
						var data = result.data;
						for (key in data) {
							if($("input[name=" + key + "]")){
								$("input[name=" + key + "]").val(data[key]);
							}
						}
						$("select").each(function(){
							var name = $(this).attr('name');
							$(this).val(data[name]).change();
						});
						//显示文件
						attachmentPreview();
						$("#btnCancel").removeAttr("disabled");
						$("#btnSubmit").removeAttr("disabled");
					}else if(result.code == '0'){
						alertx(result.message);
					}
				}, error: function () {
					alert("错误");
				}
			});
		}
	</script>
</head>
<body>

	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>首营供货者<span class="divider">&gt;</span></li>
		<li class="active">首营供货者变更修改</li>
	</ul>

	<div id="topTitle">首营供货者变更修改</div>

	<form:form id="inputForm" modelAttribute="t01ComplSupl" action="${ctx}/gsp/t01complsupl/t01ComplSupl/saveChangeEdit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="t01CompInfo.id"/>
		<form:hidden path="t01CompCert0.id"/>
		<form:hidden path="t01CompCert1.id"/>
		<form:hidden path="t01CompCert2.id"/>
		<input id="startAudit" name="startAudit" type="hidden" value="0">
		<sys:message content="${message}"/>
		<div id="pagingDiv" class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active">
					<a href="#p0" role="tab" data-toggle="tab"> 基本信息 </a>
				</li>
				<li role="presentation">
					<a href="#p1" role="tab" data-toggle="tab"> 营业执照 </a>
				</li>
				<li role="presentation"
						<c:if test="${t01ComplSupl.certType=='1'}">
							style="border-color: #adacac;"
						</c:if>
				>
					<a href="#p2" role="tab" data-toggle="tab<c:if test="${t01ComplSupl.certType=='1'}"> disabled</c:if>"

							<c:if test="${t01ComplSupl.certType=='1'}">
								style="background: #adacac;"
							</c:if>
					> 生产资质 </a>
				</li>
				<li role="presentation"
						<c:if test="${t01ComplSupl.certType=='0'}">
							style="border-color: #adacac;"
						</c:if>
				>
					<a href="#p3" role="tab" data-toggle="tab<c:if test="${t01ComplSupl.certType=='0'}"> disabled</c:if>"
							<c:if test="${t01ComplSupl.certType=='0'}">
								style="background: #adacac;"
							</c:if>
					> 经营资质 </a>
				</li>
				<li role="presentation">
					<a href="#p4" role="tab" data-toggle="tab"> 销售人员授权书 </a>
				</li>
				<li role="presentation">
					<a href="#p5" role="tab" data-toggle="tab"> 质量能力 </a>
				</li>
				<li role="presentation">
					<a href="#p6" role="tab" data-toggle="tab"> 资质上传 </a>
				</li>
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="p0">

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							供货者编号：
						</label>
						<div class="controls">
							<input disabled="disabled" id="relateT01ComplBuyerID2" name="relateT01ComplBuyerID2" class="input-xlarge"type="text" value="${t01ComplSupl.t01CompInfo.id}" maxlength="250">
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							供货者名称（中文）：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.compNameCn" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.compNameCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.compNameCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							供货者名称（英文）：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.compNameEn" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.compNameEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.compNameEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							简称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.shortName" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.shortName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.shortName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							描述：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.compDesc" htmlEscape="false" maxlength="1000"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.compDesc" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.compDesc" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							备注：
						</label>
						<div class="controls">
							<form:input disabled="true" path="remarks" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="remarks" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="remarks" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p1">
					<c:if test="${empty t01ComplSupl.t01CompInfo.uniCretNbr}">
					<div class="control-group">
						<div class="controls">
							<input id="toggleCertNbr" name="toggleCertNbr" type="checkbox" style="width: 30px;"> 是否选择三证合一
						</div>
					</div>
					</c:if>
					<div class="control-group" <c:if test="${empty t01ComplSupl.t01CompInfo.uniCretNbr}">  style="display: none;" </c:if>>
						<label class="control-label">
							统一社会信用代码：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.uniCretNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.uniCretNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.uniCretNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<c:if test="${empty t01ComplSupl.t01CompInfo.uniCretNbr}">

					<div class="control-group">
						<label class="control-label">
							注册号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.regiNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.regiNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.regiNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							组织机构代码证号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.orgCertNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.orgCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.orgCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							税务登记证号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.taxNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompInfo.taxNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompInfo.taxNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					</c:if>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							名称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert0.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompCert0.certName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert0.certName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							经营范围：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert0.certScop" htmlEscape="false" maxlength="1000"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompCert0.certScop" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert0.certScop" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							成立日期：
						</label>
						<div class="controls">
							<input disabled="disabled" name="t01CompCert0.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<input name="t01CompCert0.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert0.effecDate" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							营业期限至：
						</label>
						<div class="controls">
							<input disabled="disabled" name="t01CompCert0.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<input name="t01CompCert0.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert0.validDate" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font></span>
							营业执照上传：
						</label>
						<div class="controls">
							<form:hidden id="attachmentt01CompCert0" path="t01CompCert0.attachment" htmlEscape="false" maxlength="2048"
										 class="input-xlarge required"/>
							<sys:ckfinder input="attachmentt01CompCert0" type="files" uploadPath="/gsp/t01complsupl/t01CompCert0"
										  selectMultiple="true"/>
						</div>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p2">

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							编号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert2.certNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompCert2.certNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert2.certNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							企业名称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert2.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompCert2.certName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert2.certName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							生产范围：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert2.certScop" htmlEscape="false" maxlength="1000"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompCert2.certScop" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert2.certScop" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							发证日期：
						</label>
						<div class="controls">
							<input disabled="disabled" name="t01CompCert2.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<input name="t01CompCert2.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert2.effecDate" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							有效期至：
						</label>
						<div class="controls">
							<input disabled="disabled" name="t01CompCert2.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<input name="t01CompCert2.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert2.validDate" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font></span>
							生产资质上传：
						</label>
						<div class="controls">
							<form:hidden id="attachmentt01CompCert2" path="t01CompCert2.attachment" htmlEscape="false" maxlength="2048"
										 class="input-xlarge required"/>
							<sys:ckfinder input="attachmentt01CompCert2" type="files" uploadPath="/gsp/t01complsupl/t01CompCert2"
										  selectMultiple="true"/>
						</div>
					</div>


				</div>

				<div role="tabpanel" class="tab-pane fade" id="p3">

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							经营许可证号/备案凭证号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input  path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							企业名称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							经营方式：
						</label>
						<div class="controls">
							<form:select disabled="true" path="t01CompInfo.busiMode" class="input-xlarge">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('t01_busiMode')}"
											  itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:select path="t01CompInfo.busiMode" class="input-xlarge">
								<form:option value="" label="" />
								<form:options items="${fns:getDictList('t01_busiMode')}"
											  itemLabel="label" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.busiMode" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							经营场所：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							库房地址：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.storLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompInfo.storLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.storLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
							经营范围：
						</label>
						<div class="controls">
                            <form:hidden path="t01CompCert1.certScop" maxlength="1000" class="required"/>
                            <div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                            <form:hidden path="t01CompCert1.certScop" maxlength="1000" class="required"/>
                            <div id="certScopTree2" class="ztree" style="margin-top:3px;float:left;"></div>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompCert1.certScop" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							发证时间：
						</label>
						<div class="controls">
							<input disabled="disabled" name="t01CompCert1.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<input name="t01CompCert1.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert1.effecDate" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							有效期至：
						</label>
						<div class="controls">
							<input disabled="disabled" name="t01CompCert1.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<input name="t01CompCert1.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input  path="t01CompCert1.validDate" htmlEscape="false" maxlength="250" class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font></span>
							经营资质上传：
						</label>
						<div class="controls">
							<form:hidden id="attachmentt01CompCert1" path="t01CompCert1.attachment" htmlEscape="false" maxlength="2048"
										 class="input-xlarge required"/>
							<sys:ckfinder input="attachmentt01CompCert1" type="files" uploadPath="/gsp/t01complsupl/t01CompCert1"
										  selectMultiple="true"/>
						</div>
					</div>

				</div>


				<div role="tabpanel" class="tab-pane fade" id="p4">

					<div id="borderScroll" style="width:100%; overflow: auto;">
						<div class="controls" style="display: none;">
							<input type="hidden" name="t01SalesCertIDs" >
						</div>
						<table  class="table table-striped table-bordered table-condensed contentTable">
							<thead>
							<tr>
								<th>销售人员姓名</th>
								<th>证件号</th>
								<th>授权产品范围</th>
								<th>销售区域</th>
								<th>生效日期</th>
								<th>有效期至</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${t01ComplSupl.t01SalesCertList}" var="t01SalesCert">
								<tr>
									<td>${t01SalesCert.salesName}</td>
									<td>${t01SalesCert.idNbr}</td>
									<td>${t01SalesCert.salesScop}</td>
									<td>${t01SalesCert.salesArea}</td>
									<td><fmt:formatDate value="${t01SalesCert.effecDate}" pattern="yyyy-MM-dd"/></td>
									<td><fmt:formatDate value="${t01SalesCert.validDate}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<div>
							<span class="newBtnNoFloat btn btn-primary" onclick="changeAs(this)">变更为</span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">

						<div>
							<button id="addSalesCert"  type="button"  style="margin-top: 10px; margin-left: 20px;" class="btn btn-primary btnSubmit" >添加</button>
						</div>
						<div id="borderScroll" style="width:100%; overflow: auto;">
							<table id="salesCertTable" class="table table-striped table-bordered table-condensed contentTable">
								<thead>
								<tr>
									<th>销售人员姓名</th>
									<th>证件号</th>
									<th>授权产品范围</th>
									<th>销售区域</th>
									<th>生效日期</th>
									<th>有效期至</th>
									<th>操作</th>
								</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="controls" style="display:none; float:left; margin-left:20px;">
							<form:input path="t01SalesCertIDs" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style=" float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01SalesCertIDs" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>
				</div>

				<div role="tabpanel" class="tab-pane fade" id="p5">
					<div class="control-group">
						<label class="control-label">
							生产能力评价：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.prodAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompInfo.prodAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.prodAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							质量管理评价：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.qualMgrEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompInfo.qualMgrEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.qualMgrEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							仓储能力评价：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.storAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompInfo.storAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.storAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							交付能力评价：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.deliAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompInfo.deliAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.deliAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							售后服务能力评价：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.afteSaleAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group changeDiv" style="display:none">
						<input class="hideVlue" type="hidden" value="">
						<label class="control-label">变更为：</label>
						<div class="controls" style="display:inline-block; float:left; margin-left:20px;">
							<form:input path="t01CompInfo.afteSaleAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
						<div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
							<label class="control-label">备注：</label>
							<form:input path="t01CompInfo.afteSaleAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
						</div>
					</div>

				</div>


				<div role="tabpanel" class="tab-pane fade" id="p6">

					<div class="control-group">
						<label class="control-label">
							其他附件：
						</label>
						<div class="controls">
							<form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
										 class="input-xlarge"/>
							<sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01complsupl/t01complsupl"
										  selectMultiple="true"/>
						</div>
					</div>

				</div>

			</div>
		</div>

		<div id="footBtnDiv" class="form-actions">

			<input id="btnSubmitAndAppr" class="btn btn-primary btnSubmit" value="提 交"/>&nbsp;

			<input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button"
				   value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				   onclick="window.location='${ctx}/gsp/t01complsupl/t01ComplSupl'"/>
		</div>
	</form:form>
	<input id="hideName" type="hidden" value="sysChanInfoList">

	<%--<form id="relateT01ComplBuyerForm" style="display: none" action="/a/gsp/t01complsupl/t01ComplSupl/formChange" method="post">--%>
		<%--<input id="relateT01ComplBuyerID" name="t01CompInfo.id" class="input-xlarge"type="hide"  maxlength="250">--%>
	<%--</form>--%>
	<%@include file="Part_FormCommon.jsp" %>
<script>
	$(document).ready(function () {
		$("#toggleCertNbr").click(function () {
			$("#p1>.control-group:lt(9):not(:first):not([class*='changeDiv'])").toggle("fade");
		});

//		$("#relateT01ComplBuyer").click(function(){
//			$("#relateT01ComplBuyerID").val($("#relateT01ComplBuyerID2").val());
//
//			$("#relateT01ComplBuyerForm").submit();
//		});
	});

	function setSalesCertList(needIds) {
		if(needIds!=null&&needIds!=""){
		$("#topSalesCertListDiv").html("")
		$.ajax({
			url: "${ctx}/gsp/t01complsupl/t01ComplSupl/salesCertList",
			type: "post",
			data: {needIds:needIds},
			success: function (result) {
				if (result.code == '100') {
					$("#salesCertTable tbody").html("");
					for (var i = 0; i < result.data.length; i++) {
						var tr = $("#template2>table>tbody").html();
						tr = tr.replace("{id}", result.data[i].id);
						tr = tr.replace("{salesName}", result.data[i].salesName);
						tr = tr.replace("{idNbr}", result.data[i].idNbr);
						tr = tr.replace("{salesScop}", result.data[i].salesScop);
						tr = tr.replace("{salesArea}", result.data[i].salesArea);
						tr = tr.replace("{effecDate}", result.data[i].effecDate);
						tr = tr.replace("{validDate}", result.data[i].validDate);
						tr = tr.replace("{operate}", "<span style=\"cursor: pointer;\" onclick='deleteTr(this)'>删除</span>");
						$("#salesCertTable tbody").append(tr);
					}
					$("#salesCertTable tbody").find(".noneTd").each(function () {
						$(this).css("display","")
					})
				} else {
					alertx(result.message);
				}
			}, error: function () {
				alertx("请求服务器信息失败");
			}
		});
	}
	}

</script>
</body>
</html>
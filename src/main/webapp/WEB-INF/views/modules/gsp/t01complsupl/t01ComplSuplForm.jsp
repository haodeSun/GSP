<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营供货者管理</title>
	<meta name="decorator" content="default"/>
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
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.tip.mess=0;
			$(".controls input").blur(function(){
				setTimeout('$("#messageBox").fadeOut("500")',4000);
			});
			jQuery.validator.addMethod("dateCheck0", function(value,element) {
				var result=true;
				var eftDt=$("#t01CompCert0\\.effecDate").val()+"";
				var nvldDt=$("#t01CompCert0\\.validDate").val()+"";

				if(eftDt.length>0&&nvldDt.length>0){
					var d1 = new Date(eftDt.replace(/\-/g, "\/"));
					var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
					if(d1 >d2){
						result=false;
					}
				}
				return this.optional(element) || result;
			}, "营业期限至日期需晚于成立日期");
			jQuery.validator.addMethod("dateCheck1", function(value,element) {
				var result=true;
				var eftDt=$("#t01CompCert1\\.effecDate").val()+"";
				var nvldDt=$("#t01CompCert1\\.validDate").val()+"";

				if(eftDt.length>0&&nvldDt.length>0){
					var d1 = new Date(eftDt.replace(/\-/g, "\/"));
					var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
					if(d1 >d2){
						result=false;
					}
				}
				return this.optional(element) || result;
			}, "有效期至日期需晚于发证日期");
			jQuery.validator.addMethod("dateCheck2", function(value,element) {
				var result=true;
				var eftDt=$("#t01CompCert2\\.effecDate").val()+"";
				var nvldDt=$("#t01CompCert2\\.validDate").val()+"";

				if(eftDt.length>0&&nvldDt.length>0){
					var d1 = new Date(eftDt.replace(/\-/g, "\/"));
					var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
					if(d1 >d2){
						result=false;
					}
				}
				return this.optional(element) || result;
			}, "有效期至日期需晚于发证日期");


			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				ignore: ".ignore",
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					setTimeout('$("#messageBox").fadeOut("500")',4000);
					$("#errorInfo").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element.siblings("span:last"));
					}
				}
			});


			$("#btnSubmit").click(function () {
				setCertScopIds();
				setSalesCertIDs()
				ignoreSome();
				$("#inputForm").submit();
			});
			$("#btnSubmitAndAppr").click(function () {
				setCertScopIds();
				setSalesCertIDs()
				ignoreSome();
				$("#startAudit").val("startAudit");
				$("#inputForm").submit();
			});
			function ignoreSome(){
				if($("#certType0").attr("checked")){
					$("#p2 .required").removeClass("ignore");
				}else{
					$("#p2 .required").addClass("ignore");
				}
				if($("#certType1").attr("checked")){
					$("#p3 .required").removeClass("ignore");
				}else{
					$("#p3 .required").addClass("ignore");
				}
				$("div[style='display: none;'] .required").addClass("ignore");
				$(".control-group[style='display: none;'] .required").addClass("ignore");
			}

			function setSalesCertIDs() {
				if($("#salesCertTable>tbody>tr")!=null&&$("#salesCertTable>tbody>tr").length>0){
					$("#salesCertIDs").val("notEmpty");
				}else {
					$("#salesCertIDs").val("");
				}
			}

			function setCertScopIds() {

				//设置经营范围
				var ids = [], nodes = tree.getCheckedNodes(true);
				for(var i=0; i<nodes.length; i++) {
					ids.push(nodes[i].id);
				}
				$("#t01CompCert1\\.certScop").val(ids);

				//设置生产范围
				var ids2 = [], nodes2 = tree2.getCheckedNodes(true);
				for(var i=0; i<nodes2.length; i++) {
					ids2.push(nodes2[i].id);
				}
				$("#t01CompCert2\\.certScop").val(ids2);
			}

			//经营范围数据展示 begin
			var setting = {
				check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
				data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
					tree.checkNode(node, !node.checked, true, true);
					return false;
				}}};

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
			//经营范围数据展示 end

			// 初始化树结构
			var tree2 = $.fn.zTree.init($("#certScop2Tree"), setting, zNodes);
			// 不选择父节点
			tree2.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
			// 默认选择节点

			var ids = "${t01ComplSupl.t01CompCert2.certScop}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree2.getNodeByParam("id", ids[i]);
				try{tree2.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree2.expandAll(true);
			//生产范围数据展示 end

			<c:if test="${'0'== t01ComplSupl.t01CompInfo.abroad}">
			$("#abroad0").attr('checked', 'checked');
			$("#abroad1Div").hide();
			</c:if>
			<c:if test="${'1'== t01ComplSupl.t01CompInfo.abroad}">
			$("#abroad1").attr('checked', 'checked');
			$("#abroad0Div").hide();
			</c:if>

		});
	</script>
</head>
<body>

	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>首营供货者<span class="divider">&gt;</span></li>
        <c:if test="${empty detail}">
            <li class="active">首营供货者${not empty t01ComplSupl.id?'修改':'新增'}</li>
        </c:if>
        <c:if test="${not empty detail}">
            <li class="active">首营供货者详情</li>
        </c:if>
	</ul>

    <c:if test="${empty detail}">
        <div id="topTitle">首营供货者${not empty t01ComplSupl.id?'修改':'新增'}</div>
    </c:if>
    <c:if test="${not empty detail}">
        <div id="topTitle">首营供货者详情</div>
    </c:if>

	<form:form id="inputForm" modelAttribute="t01ComplSupl" action="${ctx}/gsp/t01complsupl/t01ComplSupl/save" method="post" class="form-horizontal">
		<input id="sysChanInfoList"  value="<c:forEach items="${t01ComplSupl.sysChanInfoList}" var="item">${item.chanCol},</c:forEach>" type="hidden" >
		<form:hidden path="id"/>
		<%--<form:hidden path="t01CompInfo.id"/>--%>
		<form:hidden path="t01CompCert0.id"/>
		<form:hidden path="t01CompCert3.id"/>
		<form:hidden path="t01CompCert1.id"/>
		<form:hidden path="t01CompCert2.id"/>
		<input id="startAudit" name="startAudit" type="hidden" value="0">
		<sys:message content="${message}"/>
		<div  id="messageBox" class="alert alert-error hide" style="position: absolute;top: 0px;right: 0px;width: 300px;background: rgba(44,52,60,0.80) !important;border: 0px;">
			<label id="errorInfo"></label>
			<button data-dismiss="alert"  class="close" style="color:#fff;">×</button>
		</div>
		<div id="pagingDiv" class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active">
					<a href="#p0" role="tab" data-toggle="tab"> 基本信息 </a>
				</li>
				<li role="presentation">
					<a href="#p1" role="tab" data-toggle="tab"> 营业执照 </a>
				</li>
				<li role="presentation">
					<a href="#p2" role="tab" data-toggle="tab"> 生产资质 </a>
				</li>
				<li role="presentation">
					<a href="#p3" role="tab" data-toggle="tab"> 经营资质 </a>
				</li>
				<li role="presentation">
					<a href="#p4" role="tab" data-toggle="tab"> 销售人员授权书 </a>
				</li>
				<li role="presentation">
					<a href="#p5" role="tab" data-toggle="tab"> 质量能力 </a>
				</li>
				<li role="presentation">
					<a href="#p6" role="tab" data-toggle="tab"> 其他证明文件 </a>
				</li>
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="p0">

					<div class="control-group">
						<label class="control-label">
											<span class="help-inline"><font
													color="red">*</font> </span>
							企业名称（中文）：</label>
						<div class="controls">
							<sys:treeselect id="comp" name="t01CompInfo.id"
											value="${t01ComplSupl.t01CompInfo.id}"
											labelName="t01CompInfo.compNameCn"
											labelValue="${t01ComplSupl.t01CompInfo.compNameCn}"
											title="企业"
											url="/gsp/t01compinfonew/t01CompInfoNew/getCompsForSupl"
											cssClass="required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							企业名称（英文）：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.compNameEn" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							简称：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.shortName" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							描述：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.compDesc" htmlEscape="false" maxlength="1000"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							备注：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.remarks" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							境内/境外：
						</label>
						<div class="controls">
							<input id="abroad0" disabled="disabled" style="width: 30px;" type="radio"
								   name="t01CompInfo.abroad" value="0"> 境内企业
							<input id="abroad1" disabled="disabled" style="width: 30px;" type="radio"
								   name="t01CompInfo.abroad" value="1"> 境外企业
						</div>
					</div>


					<div class="control-group">
						<div class="controls">
							<input id="certType" type="hidden" name="certType" class="required"  value="${t01ComplSupl.certType}">
							<input id="certType0" style="width: 30px;"  type="checkbox">  生产资质
							<input id="certType1" style="width: 30px;"  type="checkbox">  经营资质
						</div>
					</div>

                    <c:if test="${not empty detail}">
                        <div class="control-group">
                            <label class="control-label">
                                供货者状态：
                            </label>
                            <div class="controls">
                                <form:select path="suplStat" class="input-xlarge required" disabled="true">
                                    <form:option value="" label="" />
                                    <form:options
                                            items="${fns:getDictList('t01_certStat')}"
                                            itemLabel="label" itemValue="value" htmlEscape="false" />
                                </form:select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                审批状态：
                            </label>
                            <div class="controls">
                                <form:select path="apprStat" class="input-xlarge required" disabled="true">
                                    <form:option value="" label="" />
                                    <form:options
                                            items="${fns:getDictList('t01_matr_info_appr_stat')}"
                                            itemLabel="label" itemValue="value" htmlEscape="false" />
                                </form:select>
                            </div>
                        </div>
                    </c:if>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p1">
					<div id="abroad0Div">
					<div class="control-group" style="display: none;">
						<div class="controls">
							<input id="toggleCertNbr" type="checkbox" style="width: 30px;"> 是否选择三证合一
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							统一社会信用代码：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.uniCretNbr" disabled="true" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							注册号：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.regiNbr" disabled="true" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							组织机构代码证号：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.orgCertNbr" disabled="true" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							税务登记证号：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.taxNbr" disabled="true" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							名称：
						</label>
						<div class="controls">
							<form:input path="t01CompCert0.certName" disabled="true" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							经营范围：
						</label>
						<div class="controls">
							<form:input path="t01CompCert0.certScop" disabled="true" htmlEscape="false" maxlength="1000"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							成立日期：
						</label>
						<div class="controls">
							<input id="t01CompCert0.effecDate" disabled="disabled" name="t01CompCert0.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							营业期限至：
						</label>
						<div class="controls">
							<input id="t01CompCert0.validDate" disabled="disabled" name="t01CompCert0.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required dateCheck0"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font></span>
							营业执照上传：
						</label>
						<div class="controls" id="t01CompCert0.attachment">
								${fns:getAttachLabel(t01ComplSupl.t01CompCert0.attachment)}
						</div>
					</div>
					</div>
					<div id="abroad1Div">

						<div class="control-group">
							<label class="control-label">
								<span class="help-inline"><font color="red">*</font> </span>
								企业唯一编码：
							</label>
							<div class="controls">
								<form:input path="t01CompInfo.compUniNbr" disabled="true" htmlEscape="false" maxlength="250"
											class="input-xlarge required"/>
								<span class="promptPic"></span>
							</div>
						</div>


						<div class="control-group">
							<label class="control-label">
								<span class="help-inline"><font color="red">*</font> </span>
								经营范围：
							</label>
							<div class="controls">
								<form:input path="t01CompCert3.certScop" disabled="true" htmlEscape="false" maxlength="1000"
											class="input-xlarge required"/>
								<span class="promptPic"></span>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">
								<span class="help-inline"><font color="red">*</font> </span>
								成立日期：
							</label>
							<div class="controls">
								<input id="t01CompCert3.effecDate" disabled="disabled" name="t01CompCert3.effecDate"
									   type="text"
									   readonly="readonly" maxlength="20" class="input-medium datepicker required"
									   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>"
								/>
								<span class="datePic"></span>
								<span class="promptPic"></span>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">
								<span class="help-inline"><font color="red">*</font> </span>
								营业期限至：
							</label>
							<div class="controls">
								<input id="t01CompCert3.validDate" disabled="disabled" name="t01CompCert3.validDate"
									   type="text"
									   readonly="readonly" maxlength="20"
									   class="input-medium datepicker required dateCheck0"
									   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>"
								/>
								<span class="datePic"></span>
								<span class="promptPic"></span>
							</div>
						</div>

						<div class="control-group">
							<label class="control-label">
								<span class="help-inline"><font color="red">*</font></span>
								营业执照上传：
							</label>
							<div class="controls" id="t01CompCert3.attachment">
									${fns:getAttachLabel(t01ComplSupl.t01CompCert3.attachment)}
							</div>
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
							<form:input path="t01CompCert2.certNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							企业名称：
						</label>
						<div class="controls">
							<form:input path="t01CompCert2.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							生产范围：
						</label>
						<div class="controls">
							<div id="certScop2Tree" class="ztree" style="margin-top:3px;float:left;"></div>
							<form:hidden path="t01CompCert2.certScop" maxlength="1000" class="required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							发证日期：
						</label>
						<div class="controls">
							<input id="t01CompCert2.effecDate" name="t01CompCert2.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							有效期至：
						</label>
						<div class="controls">
							<input id="t01CompCert2.validDate" name="t01CompCert2.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required dateCheck2"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font></span>
							生产资质上传：
						</label>
						<div class="controls">
                            <c:if test="${not empty detail}">
                                ${fns:getAttachLabel(t01ComplSupl.t01CompCert2.attachment)}
                            </c:if>
                            <c:if test="${empty detail}">
							<form:hidden id="attachmentt01CompCert2" path="t01CompCert2.attachment" htmlEscape="false" maxlength="2048"
										 class="input-xlarge required"/>
							<sys:ckfinder input="attachmentt01CompCert2" type="files" uploadPath="/gsp/t01CompCert2"
										  selectMultiple="true"/>
                            </c:if>
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
							<form:input path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							企业名称：
						</label>
						<div class="controls">
							<form:input path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							经营方式：
						</label>
						<div class="controls">
                            <form:select path="t01CompInfo.busiMode" class="input-xlarge">
                                <form:option value="" label="" />
                                <form:options items="${fns:getDictList('t01_busiMode')}"
                                              itemLabel="label" itemValue="value" htmlEscape="false" />
                            </form:select>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							经营场所：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							库房地址：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.storLoca" htmlEscape="false" maxlength="250"
										class="input-xlarge "/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
							经营范围：
						</label>
						<div class="controls">
							<div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>
							<form:hidden path="t01CompCert1.certScop" maxlength="1000" class="required"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							发证时间：
						</label>
						<div class="controls">
							<input id="t01CompCert1.effecDate" name="t01CompCert1.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							有效期至：
						</label>
						<div class="controls">
							<input id="t01CompCert1.validDate" name="t01CompCert1.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required dateCheck1"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font></span>
							经营资质上传：
						</label>
						<div class="controls">
                            <c:if test="${not empty detail}">
                                ${fns:getAttachLabel(t01ComplSupl.t01CompCert1.attachment)}
                            </c:if>
                            <c:if test="${empty detail}">
							<form:hidden id="attachmentt01CompCert1" path="t01CompCert1.attachment" htmlEscape="false" maxlength="2048"
										 class="input-xlarge required"/>
							<sys:ckfinder input="attachmentt01CompCert1" type="files" uploadPath="/gsp/t01CompCert1"
										  selectMultiple="true"/>
                            </c:if>
						</div>
					</div>
				</div>

				<div role="tabpanel" class="tab-pane fade" id="p4">
					<%--<div class="control-group">--%>
                        <%--<label class="control-label" >--%>
							<%--<span class="help-inline"><font color="red">*</font> </span>--%>
							<%--关联销售人员授权：--%>
						<%--</label>--%>
						<%--<div class="controls">--%>
							<%--<input id="addSalesCert" style="width:82px;" class="btn btn-primary btnSubmit"--%>
								   <%--value="添加">--%>
							<%--<input id="salesCertIDs" style="display: none;" class="required" >--%>
							<%--<span class="promptPic"></span>--%>
						<%--</div>--%>
                    <%--</div>--%>
					<div id="borderScroll" style=" overflow: auto;">
						<table id="salesCertTable" class="table table-striped table-bordered table-condensed contentTable">
							<thead>
							<tr>
								<th>销售人员姓名</th>
								<th>证件号</th>
								<th>授权产品范围</th>
								<th>销售区域</th>
								<th>生效日期</th>
								<th>有效期至</th>
                                <%--<th>操作</th>--%>
							</tr>
							</thead>
							<tbody>
							<c:forEach items="${t01ComplSupl.t01SalesCertList}" var="t01SalesCert">
								<tr onclick='deleteTr(this)'>
									<td style="display: none">
										<input class="salesCertID" type="hidden" name="t01SalesCertIDList" value="${t01SalesCert.id}">
									</td>
									<td>${t01SalesCert.salesName}</td>
									<td>${t01SalesCert.idNbr}</td>
									<td>${t01SalesCert.salesScop}</td>
									<td>${t01SalesCert.salesArea}</td>
									<td><fmt:formatDate value="${t01SalesCert.effecDate}" pattern="yyyy-MM-dd"/></td>
									<td><fmt:formatDate value="${t01SalesCert.validDate}" pattern="yyyy-MM-dd"/></td>
                                    <%--<td>--%>
                                        <%--<span style="cursor: pointer;" onclick='deleteTr(this)'>删除</span>--%>
                                    <%--</td>--%>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p5">
					<div class="control-group">
						<label class="control-label">
							生产能力评价：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.prodAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							质量管理评价：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.qualMgrEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							仓储能力评价：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.storAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							交付能力评价：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.deliAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							售后服务能力评价：
						</label>
						<div class="controls">
							<form:input path="t01CompInfo.afteSaleAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							<span class="promptPic"></span>
						</div>
					</div>
				</div>

				<div role="tabpanel" class="tab-pane fade" id="p6">

					<div class="control-group">
						<label class="control-label">
							其他附件：
						</label>
						<div class="controls">
                            <c:if test="${not empty detail}">
                                ${fns:getAttachLabel(t01ComplSupl.attachment)}
                            </c:if>
                            <c:if test="${empty detail}">
							<form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
										 class="input-xlarge"/>
							<sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01complsupl"
										  selectMultiple="true"/>
                            </c:if>
						</div>
					</div>
				</div>
			</div>
			<c:if test="${not empty detail}">
				<sys:operateHistory module="t01ComplSupl" dataId="${t01ComplSupl.id}"/>
			</c:if>
		</div>

		<div id="footBtnDiv" class="form-actions">

			<input id="btnSubmitAndAppr" class="btn btn-primary btnSubmit" value="提 交"/>&nbsp;

			<input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button"
				   value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回"
				   onclick="window.location='${ctx}/gsp/t01complsupl/t01ComplSupl'"/>
		</div>
	</form:form>
	<c:if test="${not empty detail}">
		<sys:operateSave/>
	</c:if>

	<%@include file="Part_FormCommon.jsp" %>

	<script>
		$(document).ready(function () {

            var sysChanInfos = $("#sysChanInfoList").val().split(",");
			for (var i = 0; i < sysChanInfos.length; i++) {
				if (sysChanInfos[i].length > 0) {
					$(document.getElementById(sysChanInfos[i])).parent("div").siblings("label").css("color","red");
				}
			}

			$("#certType0").click(function () {
				setCertTypeValue();
				if($(this).attr("checked")){
					enableCertType0()
				}else {
					disableCertType0();
				}
			})

			$("#certType1").click(function () {
				setCertTypeValue();
				if($(this).attr("checked")) {
					enableCertType1()
				}else {
					disableCertType1();
				}
			})

			<c:if test="${empty t01ComplSupl.id}">
			disableCertType0();
			disableCertType1();
			beforeCallBack();
			</c:if>
			<c:if test="${'0'== t01ComplSupl.certType}">
			$("#certType0").attr('checked', 'checked');
			setCertTypeValue();
			enableCertType0()
			disableCertType1();
			</c:if>
			<c:if test="${'1'== t01ComplSupl.certType}">
			$("#certType1").attr('checked', 'checked');
			setCertTypeValue();
			disableCertType0();
			enableCertType1()
			</c:if>
			<c:if test="${'2'== t01ComplSupl.certType}">
			$("#certType0").attr('checked', 'checked');
			$("#certType1").attr('checked', 'checked');
			setCertTypeValue();
			enableCertType0()
			enableCertType1()
			</c:if>

			<c:if test="${not empty t01ComplSupl.t01CompInfo.uniCretNbr && ''!=t01ComplSupl.t01CompInfo.uniCretNbr}">
			$("#t01CompInfo\\.uniCretNbr").parents(".control-group:first").show();
			$("#t01CompInfo\\.regiNbr").parents(".control-group:first").hide();
			$("#t01CompInfo\\.orgCertNbr").parents(".control-group:first").hide();
			$("#t01CompInfo\\.taxNbr").parents(".control-group:first").hide();
			</c:if>
			<c:if test="${empty t01ComplSupl.t01CompInfo.uniCretNbr || ''==t01ComplSupl.t01CompInfo.uniCretNbr}">
			$("#t01CompInfo\\.uniCretNbr").parents(".control-group:first").hide();
			$("#t01CompInfo\\.regiNbr").parents(".control-group:first").show();
			$("#t01CompInfo\\.orgCertNbr").parents(".control-group:first").show();
			$("#t01CompInfo\\.taxNbr").parents(".control-group:first").show();
			</c:if>

			if ($("#compId").val() != "") {
				compTreeselectCallBack();
			}

            <c:if test="${not empty detail}">
            $("input").attr("disabled","disabled");
            $(".help-inline").hide();
            $("#btnSubmit").hide();
            $("#btnSubmitAndAppr").hide();
            $("#btnCancel").removeAttr("disabled")
			$("#operateSaveDiv *").removeAttr("disabled")
			$("#operateHistoryDiv *").removeAttr("disabled")
            </c:if>


		});
		function setCertTypeValue() {

			if($("#certType0").attr("checked")&&$("#certType1").attr("checked")){
				$("#certType").val("2")
			}else if($("#certType0").attr("checked")){
				$("#certType").val("0")
			}else if($("#certType1").attr("checked")){
				$("#certType").val("1")
			}else{
				$("#certType").val("")
			}
		}

		function disableCertType0() {
			$("a[href='#p2']").attr("data-toggle","tab disabled");
			$("a[href='#p2']").attr("style","background: #adacac;");
			$("a[href='#p2']").parent().attr("style","border-color: #adacac");
		}
		function enableCertType0() {
			$("a[href='#p2']").attr("data-toggle","tab");
			$("a[href='#p2']").removeAttr("style");
			$("a[href='#p2']").parent().removeAttr("style");
		}
		function disableCertType1() {
			$("a[href='#p3']").attr("data-toggle","tab disabled");
			$("a[href='#p3']").attr("style","background: #adacac;");
			$("a[href='#p3']").parent().attr("style","border-color: #adacac");
		}
		function enableCertType1() {
			$("a[href='#p3']").attr("data-toggle", "tab");
			$("a[href='#p3']").removeAttr("style");
			$("a[href='#p3']").parent().removeAttr("style");
		}

		function beforeCallBack() {
			$("a[href='#p1']").attr("data-toggle", "tab disabled");
			$("a[href='#p1']").attr("style", "background: #adacac;");
			$("a[href='#p1']").parent().attr("style", "border-color: #adacac");
			$("a[href='#p4']").attr("data-toggle", "tab disabled");
			$("a[href='#p4']").attr("style", "background: #adacac;");
			$("a[href='#p4']").parent().attr("style", "border-color: #adacac");
			$("a[href='#p5']").attr("data-toggle", "tab disabled");
			$("a[href='#p5']").attr("style", "background: #adacac;");
			$("a[href='#p5']").parent().attr("style", "border-color: #adacac");
			$("a[href='#p6']").attr("data-toggle", "tab disabled");
			$("a[href='#p6']").attr("style", "background: #adacac;");
			$("a[href='#p6']").parent().attr("style", "border-color: #adacac");
		}
		function afterCallBack() {
			$("a[href='#p1']").attr("data-toggle", "tab");
			$("a[href='#p1']").removeAttr("style");
			$("a[href='#p1']").parent().removeAttr("style");
			$("a[href='#p4']").attr("data-toggle", "tab");
			$("a[href='#p4']").removeAttr("style");
			$("a[href='#p4']").parent().removeAttr("style");
			$("a[href='#p5']").attr("data-toggle", "tab");
			$("a[href='#p5']").removeAttr("style");
			$("a[href='#p5']").parent().removeAttr("style");
			$("a[href='#p6']").attr("data-toggle", "tab");
			$("a[href='#p6']").removeAttr("style");
			$("a[href='#p6']").parent().removeAttr("style");
		}


		function compTreeselectCallBack() {
			$.ajax({
				async: false,
				type: "post",
				dataType: "json",
				url: '${ctx}/gsp/t01compinfonew/t01CompInfoNew/getCompInfo',
				data: {
					id: $("#compId").val()
				},
				success: function (result) {
					if (result != null) {

						<c:if test="${empty t01ComplSupl.id}">
						afterCallBack()
						</c:if>

						$("#t01CompInfo\\.id").val(result.id)
						$("#t01CompCert0\\.id").val(result.t01CompCert0.id)
						$("#t01CompCert3\\.id").val(result.t01CompCert3.id)
						$("#t01CompCert1\\.id").val(result.t01CompCert1.id)

						$("#t01CompInfo\\.compNameEn").val(result.compNameEn)
						$("#t01CompInfo\\.shortName").val(result.shortName)
						$("#t01CompInfo\\.compDesc").val(result.compDesc)
						$("#t01CompInfo\\.remarks").val(result.remarks)

						if ("0" == result.abroad) {
							$("#p2 .control-group").show();
							$("#p3 .control-group").show();

							$("#abroad0").attr('checked', 'checked');
							$("#abroad0Div").show();
							$("#abroad1Div").hide();

							$("#t01CompInfo\\.uniCretNbr").val(result.uniCretNbr)
							$("#t01CompInfo\\.regiNbr").val(result.regiNbr)
							$("#t01CompInfo\\.orgCertNbr").val(result.orgCertNbr)
							$("#t01CompInfo\\.taxNbr").val(result.taxNbr)

							$("#t01CompCert0\\.certName").val(result.t01CompCert0.certName)
							$("#t01CompCert0\\.certScop").val(result.t01CompCert0.certScop)
							$("#t01CompCert0\\.effecDate").val(result.t01CompCert0.effecDate)
							$("#t01CompCert0\\.validDate").val(result.t01CompCert0.validDate)

							if (result.uniCretNbr != null && result.uniCretNbr != "") {
								$("#t01CompInfo\\.uniCretNbr").parents(".control-group:first").show();
								$("#t01CompInfo\\.regiNbr").parents(".control-group:first").hide();
								$("#t01CompInfo\\.orgCertNbr").parents(".control-group:first").hide();
								$("#t01CompInfo\\.taxNbr").parents(".control-group:first").hide();
							} else {
								$("#t01CompInfo\\.uniCretNbr").parents(".control-group:first").hide();
								$("#t01CompInfo\\.regiNbr").parents(".control-group:first").show();
								$("#t01CompInfo\\.orgCertNbr").parents(".control-group:first").show();
								$("#t01CompInfo\\.taxNbr").parents(".control-group:first").show();
							}
							$("#t01CompCert0\\.attachment").html("");
							$("#t01CompCert0\\.attachment").append(getAttachLabel(result.t01CompCert0.attachment))


							if(result.t01CompCert1.id!=null&&result.t01CompCert1.id!="") {
								$("#t01CompCert1\\.certNbr").val(result.t01CompCert1.certNbr)
								$("#t01CompCert1\\.certName").val(result.t01CompCert1.certName)
								$("#t01CompCert1\\.certScop").val(result.t01CompCert1.certScop)

								setTree();

								$("#t01CompCert1\\.effecDate").val(result.t01CompCert1.effecDate)
								$("#t01CompCert1\\.validDate").val(result.t01CompCert1.validDate)

								$("#t01CompInfo\\.busiMode").select2().select2("val",result.busiMode)
								$("#t01CompInfo\\.busiLoca").val(result.busiLoca)
								$("#t01CompInfo\\.storLoca").val(result.storLoca)

								$("#attachmentt01CompCert1").val(result.t01CompCert1.attachment);
								<c:if test="${empty detail}">
								attachmentt01CompCert1Preview();
								</c:if>
							}
						}
						if ("1" == result.abroad) {
							$("#p2 .control-group:not(:last)").hide();
							$("#p3 .control-group:not(:last)").hide();

							$("#abroad1").attr('checked', 'checked');
							$("#abroad0Div").hide();
							$("#abroad1Div").show();

							$("#t01CompInfo\\.compUniNbr").val(result.compUniNbr)
							$("#t01CompCert3\\.certScop").val(result.t01CompCert3.certScop)
							$("#t01CompCert3\\.effecDate").val(result.t01CompCert3.effecDate)
							$("#t01CompCert3\\.validDate").val(result.t01CompCert3.validDate)

							$("#t01CompCert3\\.attachment").html("");
							$("#t01CompCert3\\.attachment").append(getAttachLabel(result.t01CompCert3.attachment))

							if(result.t01CompCert1.id!=null&&result.t01CompCert1.id!="") {
								$("#attachmentt01CompCert1").val(result.t01CompCert1.attachment);
								attachmentt01CompCert1Preview();
							}
						}
						//设置销售人员授权书
						if(result.t01SalesCertList!=null&&result.t01SalesCertList.length>0){
							$("#salesCertTable>tbody").html("");
							for (var i = 0; i < result.t01SalesCertList.length; i++) {
								var tr = $("#template2>table>tbody").html();
								tr = tr.replace("{id}", result.t01SalesCertList[i].id);
								tr = tr.replace("{salesName}", result.t01SalesCertList[i].salesName);
								tr = tr.replace("{idNbr}", result.t01SalesCertList[i].idNbr);
								tr = tr.replace("{salesScop}", result.t01SalesCertList[i].salesScop);
								tr = tr.replace("{salesArea}", result.t01SalesCertList[i].salesArea);
								tr = tr.replace("{effecDate}", result.t01SalesCertList[i].effecDate);
								tr = tr.replace("{validDate}", result.t01SalesCertList[i].validDate);
//								tr = tr.replace("{operate}", "<span style=\"cursor: pointer;\" onclick='deleteTr(this)'>删除</span>");
								$("#salesCertTable>tbody").append(tr);
							}
						}
					} else {
						alertx("未查询到相关数据");
					}
				},
				error: function () {
					alertx("请求服务器数据失败");
					return null;
				}
			})
		}
		function setTree() {
			var tree = $.fn.zTree.getZTreeObj("certScopTree");

			var ids = $("#t01CompCert1\\.certScop").val().split(",");
			for (var i = 0; i < ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try {
					tree.checkNode(node, true, false);
				} catch (e) {
				}
			}
		}
	</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>首营购货者管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.tip.mess=0;
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

			$("#btnSubmit").click(function () {
				$(".required").addClass("ignore");
				$("#inputForm").submit();
			});
			$("#btnSubmitAndAppr").click(function () {
				$(".required").removeClass("ignore");
				$("#startAudit").val("startAudit");
				$("#inputForm").submit();
			});

			//经营范围数据展示 begin
			var setting = {
				check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
				data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
					tree.checkNode(node, !node.checked, true, true);
					return false;
				},
					beforeCheck: function(){
						return false;
					}}};

			// 用户-菜单
			var zNodes=[
					<c:forEach items="${t01ComplBuyer.certScopList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
				</c:forEach>];
			// 初始化树结构
			var tree = $.fn.zTree.init($("#certScopTree"), setting, zNodes);
			// 不选择父节点
			tree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
			// 默认选择节点

			var ids = "${t01ComplBuyer.t01CompCert1.certScop}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree.expandAll(true);
			//经营范围数据展示 end
		});
	</script>
</head>
<body>

	<ul class="breadcrumb">
		<li>首页<span class="divider">&gt;</span></li>
		<li>首营购货者<span class="divider">&gt;</span></li>
		<li class="active">首营购货者详情</li>
	</ul>

	<div id="topTitle">首营购货者详情</div>

	<form:form id="inputForm" modelAttribute="t01ComplBuyer" action="${ctx}/gsp/t01complbuyer/t01ComplBuyer/save" method="post" class="form-horizontal">
		<input id="sysChanInfoList"  value="<c:forEach items="${t01ComplBuyer.sysChanInfoList}" var="item">${item.chanCol},</c:forEach>" type="hidden" >
		<form:hidden path="id"/>
		<form:hidden path="t01CompCert0.id"/>
		<form:hidden path="t01CompCert1.id"/>
		<form:hidden path="t01CompCert4.id"/>
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
						<c:if test="${t01ComplBuyer.certType=='1'}">
							style="border-color: #adacac;"
						</c:if>
				>
					<a href="#p2" role="tab" data-toggle="tab<c:if test="${t01ComplBuyer.certType=='1'}"> disabled</c:if>"

							<c:if test="${t01ComplBuyer.certType=='1'}">
						style="background: #adacac;"
					</c:if>
					> 医疗机构执业许可 </a>
				</li>
				<li role="presentation"
						<c:if test="${t01ComplBuyer.certType=='0'}">
							style="border-color: #adacac;"
						</c:if>
				>
					<a href="#p3" role="tab" data-toggle="tab<c:if test="${t01ComplBuyer.certType=='0'}"> disabled</c:if>"
					<c:if test="${t01ComplBuyer.certType=='0'}">
					   style="background: #adacac;"
					</c:if>
					> 经营资质 </a>
				</li>
				<li role="presentation">
					<a href="#p4" role="tab" data-toggle="tab"> 资质上传 </a>
				</li>
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="p0">


					<div class="control-group">
						<label class="control-label">
							
							购货者名称（中文）：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.compNameCn" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							购货者名称（英文）：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.compNameEn" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							简称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.shortName" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							描述：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.compDesc" htmlEscape="false" maxlength="1000"
										class="input-xlarge"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							备注：
						</label>
						<div class="controls">
							<form:input disabled="true" path="remarks" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>

						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							资质状态：
						</label>
						<div class="controls">
							<form:select path="buyerStat" class="input-xlarge required" disabled="true">
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

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p1">

					<c:choose>
					<c:when test="${!empty t01ComplBuyer.t01CompInfo.uniCretNbr}">
					<div class="control-group">
						<label class="control-label">
							统一社会信用代码：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.uniCretNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							 
						</div>
					</div>

					</c:when>

					<c:otherwise>
					<div class="control-group">
						<label class="control-label">
							注册号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.regiNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							 
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							组织机构代码证号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.orgCertNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							 
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							税务登记证号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.taxNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
							 
						</div>
					</div>
					</c:otherwise>
					</c:choose>
					<div class="control-group">
						<label class="control-label">
							
							名称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert0.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							经营范围：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert0.certScop" htmlEscape="false" maxlength="1000"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							成立日期：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert0.effecDate" name="t01CompCert0.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							营业期限至：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert0.validDate" name="t01CompCert0.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							营业执照上传：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplBuyer.t01CompCert0.attachment)}
						</div>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p2">

					<div class="control-group">
						<label class="control-label">
							
							登记号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert4.certNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							机构名称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert4.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							诊疗科目：
						</label>
						<div class="controls">
							<form:input disabled="true"  path="t01CompCert4.certScop" htmlEscape="false" maxlength="1000"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							发证日期：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert4.effecDate" name="t01CompCert4.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert4.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							有效期至：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert4.validDate" name="t01CompCert4.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert4.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							医疗机构执业许可上传：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplBuyer.t01CompCert4.attachment)}
						</div>
					</div>


				</div>

				<div role="tabpanel" class="tab-pane fade" id="p3">

					<div class="control-group">
						<label class="control-label">
							
							经营许可证号/备案凭证号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							
							企业名称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
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
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							经营场所：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
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
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							经营范围：
						</label>
						<div class="controls">
							<div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							发证时间：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert1.effecDate" name="t01CompCert1.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							有效期至：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert1.validDate" name="t01CompCert1.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							经营资质上传：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplBuyer.t01CompCert1.attachment)}
						</div>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p4">

					<div class="control-group">
						<label class="control-label">
							其他附件：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplBuyer.attachment)}
						</div>
					</div>

				</div>
			</div>
		</div>
		<div id="pagingDiv" class="table-scrollable">
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active">
				<a href="#p8" role="tab" data-toggle="tab">
					操作历史
				</a>
			</li>
			<li role="presentation">
				<a href="#p9" role="tab" data-toggle="tab">
					变更历史
				</a>
			</li>
		</ul>
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane fade in active" id="p8">
				<sys:operateHistory module="t01ComplBuyer" dataId="${t01ComplBuyer.id}"/>
			</div>
			<div role="tabpanel" class="tab-pane fade" id="p9">
				<div id="borderScroll" style="width:99%; overflow: auto; margin-left:1%;">
					<%--<%@include file="part_metrInfoListTable.jsp"%>--%>
				</div>
			</div>
		</div>
		</div>

		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" />
		</div>
	</form:form>
	<sys:operateSave/>


	<script>
		$(document).ready(function () {
			var sysChanInfos = $("#sysChanInfoList").val().split(",");
			for (var i = 0; i < sysChanInfos.length; i++) {
				if (sysChanInfos[i].length > 0) {
					$(document.getElementById(sysChanInfos[i])).parent("div").siblings("label").css("color","red");
				}
			}
		});
	</script>
</body>
</html>
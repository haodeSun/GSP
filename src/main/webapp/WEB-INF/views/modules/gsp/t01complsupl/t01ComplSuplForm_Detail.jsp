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
			function beforeCheck(treeId, treeNode) {
				return (treeNode.doCheck !== false);
			}
			var ids = "${t01ComplSupl.t01CompCert1.certScop}".split(",");
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
		<li>首营供货者<span class="divider">&gt;</span></li>
		<li class="active">首营供货者详情</li>
	</ul>

	<div id="topTitle">首营供货者详情</div>

	<form:form id="inputForm" modelAttribute="t01ComplSupl" action="${ctx}/gsp/t01complsupl/t01ComplSupl/save" method="post" class="form-horizontal">
		<input id="sysChanInfoList"  value="<c:forEach items="${t01ComplSupl.sysChanInfoList}" var="item">${item.chanCol},</c:forEach>" type="hidden" >
		<form:hidden path="id"/>
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
					<a href="#p2" role="tab"
					   data-toggle="tab<c:if test="${t01ComplSupl.certType=='1'}"> disabled</c:if>"

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

							供货者名称（中文）：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompInfo.compNameCn" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							供货者名称（英文）：
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
				</div>

				<div role="tabpanel" class="tab-pane fade" id="p1">

					<c:choose>
					<c:when test="${!empty t01ComplSupl.t01CompInfo.uniCretNbr}">
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
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
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
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							营业执照上传：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplSupl.t01CompCert0.attachment)}
						</div>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p2">

					<div class="control-group">
						<label class="control-label">

							编号：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert2.certNbr" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">

							企业名称：
						</label>
						<div class="controls">
							<form:input disabled="true" path="t01CompCert2.certName" htmlEscape="false" maxlength="250"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">

							生产范围：
						</label>
						<div class="controls">
							<form:input disabled="true"  path="t01CompCert2.certScop" htmlEscape="false" maxlength="1000"
										class="input-xlarge required"/>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							发证日期：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert2.effecDate" name="t01CompCert2.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.effecDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							
							有效期至：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert2.validDate" name="t01CompCert2.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							生产资质上传：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplSupl.t01CompCert2.attachment)}
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
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
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
								   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
								   />
							<span class="datePic"></span>
							 
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							经营资质上传：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplSupl.t01CompCert1.attachment)}
						</div>
					</div>

				</div>

				<div role="tabpanel" class="tab-pane fade" id="p4">

					<div id="borderScroll" style="width:100%; overflow: auto;">
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
					</div>
				</div>

				<div role="tabpanel" class="tab-pane fade" id="p5">
					<div class="control-group">
						<label class="control-label">
							生产能力评价：
						</label>
						<div class="controls">
							<form:input  readonly="true" path="t01CompInfo.prodAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							质量管理评价：
						</label>
						<div class="controls">
							<form:input  readonly="true" path="t01CompInfo.qualMgrEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							仓储能力评价：
						</label>
						<div class="controls">
							<form:input  readonly="true" path="t01CompInfo.storAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							交付能力评价：
						</label>
						<div class="controls">
							<form:input  readonly="true" path="t01CompInfo.deliAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							售后服务能力评价：
						</label>
						<div class="controls">
							<form:input readonly="true" path="t01CompInfo.afteSaleAbliEval" htmlEscape="false" maxlength="250"
										class="input-xlarge"/>
						</div>
					</div>
				</div>

				<div role="tabpanel" class="tab-pane fade" id="p6">

					<div class="control-group">
						<label class="control-label">
							其他附件：
						</label>
						<div class="controls">
								${fns:getAttachLabel(t01ComplSupl.attachment)}
						</div>
					</div>

				</div>
			</div>
		</div>

		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" />
		</div>
	</form:form>

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
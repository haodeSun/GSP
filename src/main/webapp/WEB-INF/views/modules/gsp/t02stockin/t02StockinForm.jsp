<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入库信息管理</title>
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
	</script>
</head>
<body>

		<!-- 面包屑导航（文字以及链接应换为变量）  -->
		<ul class="breadcrumb">
		  <li><a href="#">首页</a> <span class="divider">/</span></li>
		  <li><a href="#">首营产品</a> <span class="divider">/</span></li>
		  <li class="active">入库信息删除</li>
		</ul>
		<!-- 每页的title（文字换为变量） -->
		<div id="topTitle">入库信息新增</div>

		<form:form id="inputForm" modelAttribute="t02Stockin" action="${ctx}/gsp/t02stockin/t02Stockin/save" method="post" class="form-horizontal">
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
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">流程实例ID：</label>
			<div class="controls">
							<form:input path="procInsId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">入库单号：</label>
			<div class="controls">
							<form:input path="stocNo" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">验收单号：</label>
			<div class="controls">
							<form:input path="checkNo" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">入库时间：</label>
			<div class="controls">
							<input name="stocDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								value="<fmt:formatDate value="${t02Stockin.stocDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="datePic"></span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">审核人：</label>
			<div class="controls">
							<form:input path="auditPers" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">仓库id：</label>
			<div class="controls">
							<form:input path="wareHouseId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">仓库管理员签字：</label>
			<div class="controls">
							<form:input path="wareSign" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>
										</div>
			<div class="control-group">
				<label class="control-label">入库-物料信息：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>物料id</th>
								<th>备注信息</th>
								<th>流程实例ID</th>
								<th>序号</th>
								<th>描述</th>
								<th>入库数量</th>
								<th>质量状态/区域</th>
								<th>备注</th>
								<shiro:hasPermission name="gsp:t02stockin:t02Stockin:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="t02StockinMateList">
						</tbody>
						<shiro:hasPermission name="gsp:t02stockin:t02Stockin:edit"><tfoot>
							<tr><td colspan="10"><a href="javascript:" onclick="addRow('#t02StockinMateList', t02StockinMateRowIdx, t02StockinMateTpl);t02StockinMateRowIdx = t02StockinMateRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="t02StockinMateTpl">//<!--
						<tr id="t02StockinMateList{{idx}}">
							<td class="hide">
								<input id="t02StockinMateList{{idx}}_id" name="t02StockinMateList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="t02StockinMateList{{idx}}_delFlag" name="t02StockinMateList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="t02StockinMateList{{idx}}_mateId" name="t02StockinMateList[{{idx}}].mateId" type="text" value="{{row.mateId}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<textarea id="t02StockinMateList{{idx}}_remarks" name="t02StockinMateList[{{idx}}].remarks" rows="4" maxlength="100" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<td>
								<input id="t02StockinMateList{{idx}}_procInsId" name="t02StockinMateList[{{idx}}].procInsId" type="text" value="{{row.procInsId}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockinMateList{{idx}}_sequence" name="t02StockinMateList[{{idx}}].sequence" type="text" value="{{row.sequence}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockinMateList{{idx}}_description" name="t02StockinMateList[{{idx}}].description" type="text" value="{{row.description}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockinMateList{{idx}}_storQuan" name="t02StockinMateList[{{idx}}].storQuan" type="text" value="{{row.storQuan}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="t02StockinMateList{{idx}}_qualStat" name="t02StockinMateList[{{idx}}].qualStat" type="text" value="{{row.qualStat}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockinMateList{{idx}}_comments" name="t02StockinMateList[{{idx}}].comments" type="text" value="{{row.comments}}" maxlength="100" class="input-small "/>
							</td>
							<shiro:hasPermission name="gsp:t02stockin:t02Stockin:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#t02StockinMateList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var t02StockinMateRowIdx = 0, t02StockinMateTpl = $("#t02StockinMateTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(t02Stockin.t02StockinMateList)};
							for (var i=0; i<data.length; i++){
								addRow('#t02StockinMateList', t02StockinMateRowIdx, t02StockinMateTpl, data[i]);
								t02StockinMateRowIdx = t02StockinMateRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<shiro:hasPermission name="gsp:t02stockin:t02Stockin:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>
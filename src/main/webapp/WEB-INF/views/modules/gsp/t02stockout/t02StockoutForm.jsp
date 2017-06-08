<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>出库信息管理</title>
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
		  <li class="active">出库信息删除</li>
		</ul>
		<!-- 每页的title（文字换为变量） -->
		<div id="topTitle">出库信息新增</div>

		<form:form id="inputForm" modelAttribute="t02Stockout" action="${ctx}/gsp/t02stockout/t02Stockout/save" method="post" class="form-horizontal">
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
				<label class="control-label">出库单号：</label>
			<div class="controls">
							<form:input path="stocNumb" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">验收单号：</label>
			<div class="controls">
							<form:input path="checkNo" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">出库时间：</label>
			<div class="controls">
							<input name="stocDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
								value="<fmt:formatDate value="${t02Stockout.stocDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="datePic"></span>
							<span class="help-inline"><font color="red">*</font> </span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">库房管理员姓名：</label>
			<div class="controls">
							<form:input path="wareName" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">库房管理员签字：</label>
			<div class="controls">
							<form:input path="wareSign" htmlEscape="false" maxlength="100" class="input-xlarge "/>
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
				<label class="control-label">组织编码：</label>
			<div class="controls">
							<form:input path="orgaCode" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">备注：</label>
			<div class="controls">
							<form:input path="comments" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">不含税金额：</label>
			<div class="controls">
							<form:input path="noTaxAmou" htmlEscape="false" maxlength="11" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">箱数：</label>
			<div class="controls">
							<form:input path="boxCount" htmlEscape="false" maxlength="11" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">单品数量：</label>
			<div class="controls">
							<form:input path="singProdCount" htmlEscape="false" maxlength="11" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">出库时间：</label>
			<div class="controls">
							<input name="deliDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								value="<fmt:formatDate value="${t02Stockout.deliDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="datePic"></span>
						<span class="promptPic"></span>
			</div>
		</div>
										</div>
			<div class="control-group">
				<label class="control-label">t02_stockout_mate：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>id</th>
								<th>备注信息</th>
								<th>流程实例ID</th>
								<th>序号</th>
								<th>描述</th>
								<th>出库数量</th>
								<th>单位</th>
								<th>单位含量</th>
								<th>数量</th>
								<th>批次号</th>
								<th>备注</th>
								<shiro:hasPermission name="gsp:t02stockout:t02Stockout:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="t02StockoutMateList">
						</tbody>
						<shiro:hasPermission name="gsp:t02stockout:t02Stockout:edit"><tfoot>
							<tr><td colspan="13"><a href="javascript:" onclick="addRow('#t02StockoutMateList', t02StockoutMateRowIdx, t02StockoutMateTpl);t02StockoutMateRowIdx = t02StockoutMateRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="t02StockoutMateTpl">//<!--
						<tr id="t02StockoutMateList{{idx}}">
							<td class="hide">
								<input id="t02StockoutMateList{{idx}}_id" name="t02StockoutMateList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="t02StockoutMateList{{idx}}_delFlag" name="t02StockoutMateList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_mateId" name="t02StockoutMateList[{{idx}}].mateId" type="text" value="{{row.mateId}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<textarea id="t02StockoutMateList{{idx}}_remarks" name="t02StockoutMateList[{{idx}}].remarks" rows="4" maxlength="100" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_procInsId" name="t02StockoutMateList[{{idx}}].procInsId" type="text" value="{{row.procInsId}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_seriNo" name="t02StockoutMateList[{{idx}}].seriNo" type="text" value="{{row.seriNo}}" maxlength="100" class="input-small required"/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_describe" name="t02StockoutMateList[{{idx}}].describe" type="text" value="{{row.describe}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_outQuan" name="t02StockoutMateList[{{idx}}].outQuan" type="text" value="{{row.outQuan}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_unit" name="t02StockoutMateList[{{idx}}].unit" type="text" value="{{row.unit}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_unitCont" name="t02StockoutMateList[{{idx}}].unitCont" type="text" value="{{row.unitCont}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_count" name="t02StockoutMateList[{{idx}}].count" type="text" value="{{row.count}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_batchNumb" name="t02StockoutMateList[{{idx}}].batchNumb" type="text" value="{{row.batchNumb}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02StockoutMateList{{idx}}_comm" name="t02StockoutMateList[{{idx}}].comm" type="text" value="{{row.comm}}" maxlength="100" class="input-small "/>
							</td>
							<shiro:hasPermission name="gsp:t02stockout:t02Stockout:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#t02StockoutMateList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var t02StockoutMateRowIdx = 0, t02StockoutMateTpl = $("#t02StockoutMateTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(t02Stockout.t02StockoutMateList)};
							for (var i=0; i<data.length; i++){
								addRow('#t02StockoutMateList', t02StockoutMateRowIdx, t02StockoutMateTpl, data[i]);
								t02StockoutMateRowIdx = t02StockoutMateRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<shiro:hasPermission name="gsp:t02stockout:t02Stockout:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>
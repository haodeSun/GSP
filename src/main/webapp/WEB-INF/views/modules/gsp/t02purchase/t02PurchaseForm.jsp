<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购信息管理</title>
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
		  <li class="active">采购信息删除</li>
		</ul>
		<!-- 每页的title（文字换为变量） -->
		<div id="topTitle">采购信息新增</div>

		<form:form id="inputForm" modelAttribute="t02Purchase" action="${ctx}/gsp/t02purchase/t02Purchase/save" method="post" class="form-horizontal">
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
				<label class="control-label">采购编号：</label>
			<div class="controls">
							<form:input path="purcNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">采购日期：</label>
			<div class="controls">
							<input name="purcDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								value="<fmt:formatDate value="${t02Purchase.purcDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="datePic"></span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">联系方式：</label>
			<div class="controls">
							<form:input path="suggVendCont" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">物料id：</label>
			<div class="controls">
							<form:input path="mateId" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">审核状态：</label>
			<div class="controls">
							<form:input path="reviewStatus" htmlEscape="false" maxlength="1" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">运输方式：</label>
			<div class="controls">
							<form:input path="shipViaLookCode" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">单据：</label>
			<div class="controls">
							<form:input path="documents" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">备注：</label>
			<div class="controls">
							<form:input path="comments" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">订单总价：</label>
			<div class="controls">
							<form:input path="totalOrderPrice" htmlEscape="false" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">采购员编码：</label>
			<div class="controls">
							<form:input path="buyerCode" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">订单类型：</label>
			<div class="controls">
							<form:input path="orderType" htmlEscape="false" maxlength="1" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">总箱数：</label>
			<div class="controls">
							<form:input path="totalBoxNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">总支数：</label>
			<div class="controls">
							<form:input path="totalNumb" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">单据日期：</label>
			<div class="controls">
							<input name="billDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								value="<fmt:formatDate value="${t02Purchase.billDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="datePic"></span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">到货日期：</label>
			<div class="controls">
							<input name="arriDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								value="<fmt:formatDate value="${t02Purchase.arriDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							<span class="datePic"></span>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">含税金额：</label>
			<div class="controls">
							<form:input path="taxAmou" htmlEscape="false" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">收货金额：</label>
			<div class="controls">
							<form:input path="receAmou" htmlEscape="false" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>

		<div class="control-group">
				<label class="control-label">提示：</label>
			<div class="controls">
							<form:input path="notification" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						<span class="promptPic"></span>
			</div>
		</div>
										</div>
			<div class="control-group">
				<label class="control-label">采购-物料信息：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>备注信息</th>
								<th>流程实例ID</th>
								<th>物料id</th>
								<th>采购单价</th>
								<th>采购数量</th>
								<th>金额</th>
								<th>配额</th>
								<th>单位</th>
								<th>单位含量</th>
								<th>订货量</th>
								<th>采购余量</th>
								<th>不含税成交单价</th>
								<th>扣率</th>
								<th>不含税金额</th>
								<th>含税成交单价</th>
								<th>含税金额</th>
								<th>税率</th>
								<th>税额</th>
								<th>参考进价（单品）</th>
								<th>单品单位</th>
								<th>单品不含税单价</th>
								<th>标准箱系数</th>
								<th>标准箱数量</th>
								<th>备注</th>
								<th>外箱含量</th>
								<shiro:hasPermission name="gsp:t02purchase:t02Purchase:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="t02PurcMateList">
						</tbody>
						<shiro:hasPermission name="gsp:t02purchase:t02Purchase:edit"><tfoot>
							<tr><td colspan="27"><a href="javascript:" onclick="addRow('#t02PurcMateList', t02PurcMateRowIdx, t02PurcMateTpl);t02PurcMateRowIdx = t02PurcMateRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="t02PurcMateTpl">//<!--
						<tr id="t02PurcMateList{{idx}}">
							<td class="hide">
								<input id="t02PurcMateList{{idx}}_id" name="t02PurcMateList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="t02PurcMateList{{idx}}_delFlag" name="t02PurcMateList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<textarea id="t02PurcMateList{{idx}}_remarks" name="t02PurcMateList[{{idx}}].remarks" rows="4" maxlength="100" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_procInsId" name="t02PurcMateList[{{idx}}].procInsId" type="text" value="{{row.procInsId}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_mateId" name="t02PurcMateList[{{idx}}].mateId" type="text" value="{{row.mateId}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_purcPrice" name="t02PurcMateList[{{idx}}].purcPrice" type="text" value="{{row.purcPrice}}" class="input-small required"/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_purcCount" name="t02PurcMateList[{{idx}}].purcCount" type="text" value="{{row.purcCount}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_amount" name="t02PurcMateList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_quota" name="t02PurcMateList[{{idx}}].quota" type="text" value="{{row.quota}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_measUnit" name="t02PurcMateList[{{idx}}].measUnit" type="text" value="{{row.measUnit}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_unitCont" name="t02PurcMateList[{{idx}}].unitCont" type="text" value="{{row.unitCont}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_orderQuan" name="t02PurcMateList[{{idx}}].orderQuan" type="text" value="{{row.orderQuan}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_purcSurp" name="t02PurcMateList[{{idx}}].purcSurp" type="text" value="{{row.purcSurp}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_tranPriceNoTax" name="t02PurcMateList[{{idx}}].tranPriceNoTax" type="text" value="{{row.tranPriceNoTax}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_fee" name="t02PurcMateList[{{idx}}].fee" type="text" value="{{row.fee}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_noTaxAmou" name="t02PurcMateList[{{idx}}].noTaxAmou" type="text" value="{{row.noTaxAmou}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_taxTranPrice" name="t02PurcMateList[{{idx}}].taxTranPrice" type="text" value="{{row.taxTranPrice}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_taxAmou" name="t02PurcMateList[{{idx}}].taxAmou" type="text" value="{{row.taxAmou}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_taxRates" name="t02PurcMateList[{{idx}}].taxRates" type="text" value="{{row.taxRates}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_tax" name="t02PurcMateList[{{idx}}].tax" type="text" value="{{row.tax}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_refePrice" name="t02PurcMateList[{{idx}}].refePrice" type="text" value="{{row.refePrice}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_prodUnit" name="t02PurcMateList[{{idx}}].prodUnit" type="text" value="{{row.prodUnit}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_prodPriceNoTax" name="t02PurcMateList[{{idx}}].prodPriceNoTax" type="text" value="{{row.prodPriceNoTax}}" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_stanBoxCoef" name="t02PurcMateList[{{idx}}].stanBoxCoef" type="text" value="{{row.stanBoxCoef}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_stanBoxQuan" name="t02PurcMateList[{{idx}}].stanBoxQuan" type="text" value="{{row.stanBoxQuan}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_comments" name="t02PurcMateList[{{idx}}].comments" type="text" value="{{row.comments}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="t02PurcMateList{{idx}}_outerBoxCont" name="t02PurcMateList[{{idx}}].outerBoxCont" type="text" value="{{row.outerBoxCont}}" maxlength="11" class="input-small "/>
							</td>
							<shiro:hasPermission name="gsp:t02purchase:t02Purchase:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#t02PurcMateList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var t02PurcMateRowIdx = 0, t02PurcMateTpl = $("#t02PurcMateTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(t02Purchase.t02PurcMateList)};
							for (var i=0; i<data.length; i++){
								addRow('#t02PurcMateList', t02PurcMateRowIdx, t02PurcMateTpl, data[i]);
								t02PurcMateRowIdx = t02PurcMateRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div id="footBtnDiv" class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<shiro:hasPermission name="gsp:t02purchase:t02Purchase:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>
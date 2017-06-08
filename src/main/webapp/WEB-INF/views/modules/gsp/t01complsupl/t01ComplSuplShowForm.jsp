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

<script>
	$(document).ready(function() {
//经营范围数据展示 begin
		var setting = {
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

		// 用户-菜单
		var zNodes=[<#list t01ComplSupl.certScopList as menu>
		{id:"${menu.id!''}", pId:"${menu.parent.id!''}", name:"${menu.name!''}"},
		</#list>];
		// 初始化树结构
		var tree = $.fn.zTree.init($("#certScopTree"), setting, zNodes);
		// 不选择父节点
		tree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
		// 默认选择节点
		function beforeCheck(treeId, treeNode) {
			return (treeNode.doCheck !== false);
		}
		var ids = "${t01ComplSupl.t01CompCert1.certScop!''}".split(",");
		for(var i=0; i<ids.length; i++) {
			var node = tree.getNodeByParam("id", ids[i]);
			try{tree.checkNode(node, true, false);}catch(e){}
		}
		// 默认展开全部节点
		tree.expandAll(true);
		//经营范围数据展示 end

	});

</script>
<ul class="breadcrumb">
	<li>首页<span class="divider">&gt;</span></li>
	<li>首营供货者<span class="divider">&gt;</span></li>
	<li class="active">首营供货者审批</li>
</ul>
<div id="topTitle">首营供货者审批</div>
<form id="inputForm" class="form-horizontal">

	<div id="pagingDiv" class="table-scrollable">
		<div id="changeThePic" class="
			<#if t01ComplSupl.apprStat=='1'>
				noApproval
			<#elseif t01ComplSupl.apprStat=='2'>
				passApproval
			<#elseif t01ComplSupl.apprStat=='3'>
				rejectApproval
			</#if>"></div>
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active">
				<a href="#p0" role="tab" data-toggle="tab"> 基本信息 </a>
			</li>
			<li role="presentation">
				<a href="#p1" role="tab" data-toggle="tab"> 营业执照 </a>
			</li>
			<li role="presentation">
				<a href="#p2" role="tab" data-toggle="tab" style="background: #adacac;"> 生产资质 </a>
			</li>
			<li role="presentation">
				<a href="#p3" role="tab" data-toggle="tab"style="background: #adacac;"> 经营资质 </a>
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

						企业名称（中文）：
					</label>
					<div class="controls">
						<input id="t01CompInfo.compNameCn" name="t01CompInfo.compNameCn" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.compNameCn!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						企业名称（英文）：
					</label>
					<div class="controls">
						<input id="t01CompInfo.compNameEn" name="t01CompInfo.compNameEn" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.compNameEn!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						简称：
					</label>
					<div class="controls">
						<input id="t01CompInfo.shortName" name="t01CompInfo.shortName" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.shortName!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						描述：
					</label>
					<div class="controls">
						<input id="t01CompInfo.compDesc" name="t01CompInfo.compDesc" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.compDesc!''}" maxlength="1000">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						备注：
					</label>
					<div class="controls">
						<input id="t01CompInfo.remarks" name="t01CompInfo.remarks" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.remarks!''}" maxlength="250">

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
					<label class="control-label">
						供货者状态：
					</label>
					<div class="controls">
						<select disabled="disabled" id="suplStat" name="suplStat"
								class="input-xlarge required select2-offscreen" tabindex="0">
							<option value="" selected="selected">${getDictLabel(t01ComplSupl.suplStat,'t01_certStat','')}</option>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">
						审批状态：
					</label>
					<div class="controls">
						<select disabled="disabled" id="apprStat" name="apprStat"
								class="input-xlarge required select2-offscreen" tabindex="0">
							<option value="" selected="selected">${getDictLabel(t01ComplSupl.apprStat,'t01_matr_info_appr_stat','')}</option>
						</select>
					</div>
				</div>

			</div>

			<div role="tabpanel" class="tab-pane fade" id="p1">
				<div id="abroad0Div">
				<div class="control-group">
					<label class="control-label">
						统一社会信用代码：
					</label>
					<div class="controls">
						<input id="t01CompInfo.uniCretNbr" name="t01CompInfo.uniCretNbr" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.uniCretNbr!''}" maxlength="250">

					</div>
				</div>
				<div class="control-group">
					<label class="control-label">
						注册号：
					</label>
					<div class="controls">
						<input id="t01CompInfo.regiNbr" name="t01CompInfo.regiNbr" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.regiNbr!''}" maxlength="250">

					</div>
				</div>
				<div class="control-group">
					<label class="control-label">
						组织机构代码证号：
					</label>
					<div class="controls">
						<input id="t01CompInfo.orgCertNbr" name="t01CompInfo.orgCertNbr" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.orgCertNbr!''}" maxlength="250">

					</div>
				</div>
				<div class="control-group">
					<label class="control-label">
						税务登记证号：
					</label>
					<div class="controls">
						<input id="t01CompInfo.taxNbr" name="t01CompInfo.taxNbr" class="input-xlarge" disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.taxNbr!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						名称：
					</label>
					<div class="controls">
						<input id="t01CompCert0.certName" name="t01CompCert0.certName" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert0.certName!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						经营范围：
					</label>
					<div class="controls">
						<input id="t01CompCert0.certScop" name="t01CompCert0.certScop" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert0.certScop!''}" maxlength="1000">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						成立日期：
					</label>
					<div class="controls">
						<input disabled="disabled" id="t01CompCert0.effecDate" name="t01CompCert0.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required" value="${(t01ComplSupl.t01CompCert0.effecDate?string("yyyy-MM-dd"))!''}" >
						<span class="datePic"></span>

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						营业期限至：
					</label>
					<div class="controls">
						<input disabled="disabled" id="t01CompCert0.validDate" name="t01CompCert0.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required" value="${(t01ComplSupl.t01CompCert0.validDate?string("yyyy-MM-dd"))!''}" >
						<span class="datePic"></span>

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						<span class="help-inline"><font color="red">*</font></span>
						营业执照上传：
					</label>
					<div class="controls">
						<div>${getAttachLabel(t01ComplSupl.t01CompCert0.attachment)}</div>
					</div>
				</div>
					<div class="control-group">
						<label class="control-label">
							企业状态：
						</label>
						<div class="controls">
							<select disabled="disabled" id="t01CompCert0.certStat" name="t01CompCert0.certStat"
									class="input-xlarge required select2-offscreen" tabindex="0">
								<option value="" selected="selected">${getDictLabel(t01ComplSupl.t01CompCert0.certStat,'t01_certStat','')}</option>
							</select>
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
							<input id="t01CompInfo.compUniNbr" name="t01CompInfo.compUniNbr" class="input-xlarge required"
								   disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.compUniNbr!''}"
								   maxlength="250">
						</div>
					</div>


					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							经营范围：
						</label>
						<div class="controls">
							<input id="t01CompCert3.certScop" name="t01CompCert3.certScop" class="input-xlarge required"
								   disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert3.certScop!''}"
								   maxlength="1000">
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							成立日期：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert3.effecDate" name="t01CompCert3.effecDate"
								   type="text" readonly="readonly" maxlength="20"
								   class="input-medium datepicker required"
								   value="${(t01ComplSupl.t01CompCert3.effecDate?string("yyyy-MM-dd"))!''}">
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font> </span>
							营业期限至：
						</label>
						<div class="controls">
							<input disabled="disabled" id="t01CompCert3.validDate" name="t01CompCert3.validDate"
								   type="text" readonly="readonly" maxlength="20"
								   class="input-medium datepicker required"
								   value="${(t01ComplSupl.t01CompCert3.validDate?string("yyyy-MM-dd"))!''}">
						</div>
					</div>

					<div class="control-group">
						<label class="control-label">
							<span class="help-inline"><font color="red">*</font></span>
							营业执照上传：
						</label>
						<div class="controls" id="t01CompCert3.attachment">
							<div>${getAttachLabel(t01ComplSupl.t01CompCert3.attachment)}</div>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">
							企业状态：
						</label>
						<div class="controls">
							<select disabled="disabled" id="t01CompCert3.certStat" name="t01CompCert3.certStat"
									class="input-xlarge required select2-offscreen" tabindex="0">
								<option value="" selected="selected">${getDictLabel(t01ComplSupl.t01CompCert3.certStat,'t01_certStat','')}</option>
							</select>
						</div>
					</div>
				</div>

			</div>

			<div role="tabpanel" class="tab-pane fade" id="p2">

				<div class="control-group">
					<label class="control-label">

						编号：
					</label>
					<div class="controls">
						<input id="t01CompCert2.certNbr" name="t01CompCert2.certNbr" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert2.certNbr!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						企业名称：
					</label>
					<div class="controls">
						<input id="t01CompCert2.certName" name="t01CompCert2.certName" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert2.certName!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						生产范围：
					</label>
					<div class="controls">
						<input id="t01CompCert2.certScop" name="t01CompCert2.certScop" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert2.certScop!''}" maxlength="1000">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						发证日期：
					</label>
					<div class="controls">
						<input disabled="disabled" id="t01CompCert2.effecDate" name="t01CompCert2.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required" value="${(t01ComplSupl.t01CompCert2.effecDate?string("yyyy-MM-dd"))!''}" >
						<span class="datePic"></span>

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						有效期至：
					</label>
					<div class="controls">
						<input disabled="disabled" id="t01CompCert2.validDate" name="t01CompCert2.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required" value="${(t01ComplSupl.t01CompCert2.validDate?string("yyyy-MM-dd"))!''}" >
						<span class="datePic"></span>

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						<span class="help-inline"><font color="red">*</font></span>
						生产资质上传：
					</label>
					<div class="controls">
						<div>${getAttachLabel(t01ComplSupl.t01CompCert2.attachment)}</div>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						生产资质状态：
					</label>
					<div class="controls">
						<select disabled="disabled" id="t01CompCert2.certStat" name="t01CompCert2.certStat"
								class="input-xlarge required select2-offscreen" tabindex="0">
							<option value="" selected="selected">${getDictLabel(t01ComplSupl.t01CompCert2.certStat,'t01_certStat','')}</option>
						</select>
					</div>
				</div>

			</div>

			<div role="tabpanel" class="tab-pane fade" id="p3">

				<div class="control-group">
					<label class="control-label">

						经营许可证号/备案凭证号：
					</label>
					<div class="controls">
						<input id="t01CompCert1.certNbr" name="t01CompCert1.certNbr" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert1.certNbr!''}" maxlength="250">

					</div>
				</div>
				<div class="control-group">
					<label class="control-label">

						企业名称：
					</label>
					<div class="controls">
						<input id="t01CompCert1.certName" name="t01CompCert1.certName" class="input-xlarge required" disabled="disabled" type="text" value="${t01ComplSupl.t01CompCert1.certName!''}" maxlength="250">

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						经营方式：
					</label>
					<div class="controls">
						<select disabled="disabled" id="t01CompInfo.busiMode" name="t01CompInfo.busiMode"
								class="input-xlarge required select2-offscreen" tabindex="0">
							<option value="" selected="selected">${getDictLabel(t01ComplSupl.t01CompInfo.busiMode,'t01_busiMode','')}</option>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">
						经营场所：
					</label>
					<div class="controls">
						<input id="t01CompInfo.busiLoca" name="t01CompInfo.busiLoca" class="input-xlarge " disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.busiLoca!''}" maxlength="250">

					</div>
				</div>
				<div class="control-group">
					<label class="control-label">
						库房地址：
					</label>
					<div class="controls">
						<input id="t01CompInfo.storLoca" name="t01CompInfo.storLoca" class="input-xlarge " disabled="disabled" type="text" value="${t01ComplSupl.t01CompInfo.storLoca!''}" maxlength="250">

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
						<input disabled="disabled" id="t01CompCert1.effecDate" name="t01CompCert1.effecDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required" value="${(t01ComplSupl.t01CompCert1.effecDate?string("yyyy-MM-dd"))!''}" >
						<span class="datePic"></span>

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">

						有效期至：
					</label>
					<div class="controls">
						<input disabled="disabled" id="t01CompCert1.validDate" name="t01CompCert1.validDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required" value="${(t01ComplSupl.t01CompCert1.validDate?string("yyyy-MM-dd"))!''}" >
						<span class="datePic"></span>

					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						<span class="help-inline"><font color="red">*</font></span>
						经营资质上传：
					</label>
					<div class="controls">
						<div>${getAttachLabel(t01ComplSupl.t01CompCert1.attachment)}</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">
						经营资质状态：
					</label>
					<div class="controls">
						<select disabled="disabled" id="t01CompCert1.certStat" name="t01CompCert1.certStat"
								class="input-xlarge required select2-offscreen" tabindex="0">
							<option value="" selected="selected">${getDictLabel(t01ComplSupl.t01CompCert1.certStat,'t01_certStat','')}</option>
						</select>
					</div>
				</div>

			</div>

			<div role="tabpanel" class="tab-pane fade" id="p4">

				<div id="borderScroll" style="width:99%; overflow: auto;">
					<table  class="table table-striped table-bordered table-condensed contentTable">
						<thead>
						<tr>
							<th>销售人员姓名</th>
							<th>销售人员授权状态</th>
							<th>证件号</th>
							<th>授权产品范围</th>
							<th>销售区域</th>
							<th>生效日期</th>
							<th>有效期至</th>
						</tr>
						</thead>
						<tbody>
						<#list t01ComplSupl.t01SalesCertList as t01SalesCert>
							<tr>
								<td>${t01SalesCert.salesName!''}</td>
								<td>${getDictLabel(t01SalesCert.certStat,'t01_certStat','')}</td>
								<td>${t01SalesCert.idNbr!''}</td>
								<td>${t01SalesCert.salesScop!''}</td>
								<td>${t01SalesCert.salesArea!''}</td>
								<td>${(t01SalesCert.effecDate?string("yyyy-MM-dd"))!''}</td>
								<td>${(t01SalesCert.validDate?string("yyyy-MM-dd"))!''}</td>
							</tr>
						</#list>
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
						<input id="t01CompInfo.prodAbliEval" disabled="disabled" value="${t01ComplSupl.t01CompInfo.prodAbliEval!''}" name="t01CompInfo.prodAbliEval" class="input-xlarge" readonly="readonly" type="text" value="" maxlength="250">
						<span class="promptPic"></span>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						质量管理评价：
					</label>
					<div class="controls">
						<input id="t01CompInfo.qualMgrEval" disabled="disabled" value="${t01ComplSupl.t01CompInfo.qualMgrEval!''}" name="t01CompInfo.qualMgrEval" class="input-xlarge" readonly="readonly" type="text" value="" maxlength="250">
						<span class="promptPic"></span>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						仓储能力评价：
					</label>
					<div class="controls">
						<input id="t01CompInfo.storAbliEval" disabled="disabled" value="${t01ComplSupl.t01CompInfo.storAbliEval!''}" name="t01CompInfo.storAbliEval" class="input-xlarge" readonly="readonly" type="text" value="" maxlength="250">
						<span class="promptPic"></span>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						交付能力评价：
					</label>
					<div class="controls">
						<input id="t01CompInfo.deliAbliEval" disabled="disabled" value="${t01ComplSupl.t01CompInfo.deliAbliEval!''}" name="t01CompInfo.deliAbliEval" class="input-xlarge" readonly="readonly" type="text" value="" maxlength="250">
						<span class="promptPic"></span>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">
						售后服务能力评价：
					</label>
					<div class="controls">
						<input id="t01CompInfo.afteSaleAbliEval" disabled="disabled" value="${t01ComplSupl.t01CompInfo.afteSaleAbliEval!''}" name="t01CompInfo.afteSaleAbliEval" class="input-xlarge" readonly="readonly" type="text" value="" maxlength="250">
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
						<div>${getAttachLabel(t01ComplSupl.attachment)}</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</form>
<#if t01ComplSupl.sysChanInfoList??>
	<script type="text/javascript">
		$(function(){
			var sysChanInfos = [];
			<#list t01ComplSupl.sysChanInfoList as p>
			sysChanInfos.push('${p.chanCol}');
			</#list>
			for (var i = 0; i < sysChanInfos.length; i++) {
				if (sysChanInfos[i].length > 0) {
					$(document.getElementById(sysChanInfos[i])).parent("div").siblings("label").css("color","red");
				}
			}
			<#if t01ComplSupl.certType=='0'>
			$("#certType0").attr('checked', 'checked');
			enableCertType0()
			disableCertType1();
			</#if>
			<#if t01ComplSupl.certType=='1'>
			$("#certType1").attr('checked', 'checked');
			disableCertType0();
			enableCertType1()
			</#if>
			<#if t01ComplSupl.certType=='2'>
			$("#certType0").attr('checked', 'checked');
			$("#certType1").attr('checked', 'checked');
			enableCertType0()
			enableCertType1()
			</#if>

			<#if t01ComplSupl.t01CompInfo.abroad='0'>
			$("#abroad0").attr('checked', 'checked');
			$("#abroad1Div").hide();
			</#if>

			<#if t01ComplSupl.t01CompInfo.abroad=='1'>
			$("#abroad1").attr('checked', 'checked');
			$("#abroad0Div").hide();
			</#if>

		});
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
	</script>
</#if>
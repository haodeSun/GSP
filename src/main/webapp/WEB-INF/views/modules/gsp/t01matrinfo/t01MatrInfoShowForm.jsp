<!-- 面包屑导航（文字以及链接应换为变量）  -->
<ul class="breadcrumb">
	<li>首页<span class="divider">&gt;</span></li>
	<li>物料信息<span class="divider">&gt;</span></li>
	<li class="active">物料信息审批</li>
</ul>
<!-- 每页的title（文字换为变量） -->
<div id="topTitle">物料信息审批</div>
<form method="post" class="form-horizontal">
	<div  id="pagingDiv" class="table-scrollable">
		<div id="changeThePic" class="
			<#if t01MatrInfo.apprStat=='1'>
				noApproval
			<#elseif t01MatrInfo.apprStat=='2'>
				passApproval
			<#elseif t01MatrInfo.apprStat=='3'>
				rejectApproval
			</#if>"></div>
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#p0" role="tab"
				data-toggle="tab"> 基本信息 </a></li>
			<li role="presentation"><a href="#p1" role="tab"
				data-toggle="tab"> 价格信息 </a></li>
		</ul>
		<div class="tab-content">
			<div role="tabpanel" class="tab-pane fade in active" id="p0">

				<div class="control-group">
					<label class="control-label">物料号：</label>
					<div class="controls">
						<input disabled="disabled" id="matrNbr" name="matrNbr" type="text"
							value="${t01MatrInfo.matrNbr!''}" maxlength="128"
							class="input-xlarge required">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">物料名称（中文）：</label>
					<div class="controls">
						<input disabled="disabled" id="matrNmCn" name="matrNmCn"
							type="text" value="${t01MatrInfo.matrNmCn!''}" maxlength="128"
							class="input-xlarge required">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">物料名称（英文）：</label>
					<div class="controls">
						<input disabled="disabled" id="matrNmEn" name="matrNmEn"
							type="text" value="${t01MatrInfo.matrNmEn!''}" maxlength="128"
							class="input-xlarge required">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">描述：</label>
					<div class="controls">
						<input disabled="disabled" id="matrDesc" name="matrDesc"
							type="text" value="${t01MatrInfo.matrDesc!''}" maxlength="500"
							class="input-xlarge required">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">物料分类：</label>
					<div class="controls">
						<select disabled="disabled" id="matrType" name="matrType"
							class="input-xlarge required select2-offscreen" tabindex="0">
							<option value="" selected="selected">${getDictLabel(t01MatrInfo.matrType,'t01_matr_info_matr_type','')}</option>
						</select>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">备注：</label>
					<div class="controls">
						<input disabled="disabled" id="remarks" name="remarks"
							maxlength="100" type="text" class="input-xlarge required" value="${t01MatrInfo.remarks!''}"></input>
					</div>
				</div>

			</div>
			<div role="tabpanel" class="tab-pane fade" id="p1">

				<div class="control-group">
					<label class="control-label">货币单位：</label>
					<div class="controls">
						<input id="priceUnit" name="priceUnit" type="text"
							value="${t01MatrInfo.priceUnit!''}" class="input-xlarge"
							disabled="disabled">
					</div>
				</div>

				<div class="control-group">
					<label class="control-label">物料单价：</label>
					<div class="controls">
						<input disabled="disabled" id="matrPrice" name="matrPrice"
							type="text" value="${t01MatrInfo.matrPrice!''}"
							class="input-xlarge required">
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
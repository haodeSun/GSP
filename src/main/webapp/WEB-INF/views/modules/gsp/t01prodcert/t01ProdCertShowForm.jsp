<!-- 面包屑导航（文字以及链接应换为变量）  -->
<ul class="breadcrumb">
	<li>首页<span class="divider">/</span></li>
	<li>首营产品<span class="divider">/</span></li>
	<li class="active">产品资质审批</li>
</ul>
<!-- 每页的title（文字换为变量） -->
<div id="topTitle">产品资质审批</div>

<form class="form-horizontal">
		<div id="pagingDiv" class="table-scrollable">
			<div id="changeThePic" class="
			<#if t01ProdCert.apprStat=='1'>
				noApproval
			<#elseif t01ProdCert.apprStat=='2'>
				passApproval
			<#elseif t01ProdCert.apprStat=='3'>
				rejectApproval
			</#if>"></div>
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active">
                <a href="#p0" role="tab" data-toggle="tab">
                    基本信息
                </a>
            </li>
            <li role="presentation">
                <a href="#p1" role="tab" data-toggle="tab">
                    产品信息
                </a>
            </li>
            <li role="presentation">
                <a href="#p2" role="tab" data-toggle="tab">
                    企业信息
                </a>
            </li>
            <li role="presentation">
                <a href="#p3" role="tab" data-toggle="tab">
                    资质上传
                </a>
            </li>
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class=
                    "tab-pane fade in active"
                 id="p0">
                <input id="id" type="hidden" value="${t01ProdCert.id}"/>
                <div class="control-group">
                    <label class="control-label">注册证/备案凭证编号：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="regiCertNbr" type="text" disabled="true"
                               value="${t01ProdCert.regiCertNbr}"/>
                    </div>
                </div>

                <#if t01ProdCert.origRegiCertNbr ?? && t01ProdCert.origRegiCertNbr!="">
                    <div class="control-group">
                        <label class="control-label">原注册证/备案凭证编号：</label>
                        <div class="controls">
                            <input class="input-xlarge " name="origRegiCertNbr" type="text" disabled="true"
                                   value="${t01ProdCert.origRegiCertNbr}"/>
                        </div>
                    </div>
                </#if>

                <div class="control-group">
                    <label class="control-label">风险分类：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="riskClass" type="text" disabled="true"
                               value="${getDictLabel(t01ProdCert.riskClass,'t01_riskClass','')}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">技术分类-名称：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="techCateCd" type="text" disabled="true"
                               value="${getDictLabel(t01ProdCert.techCateCd,'t01_tech_cate_cd','')}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">批准日期：</label>
                    <div class="controls">
                        <input class="input-xlarge" name="apprDate" type="text" disabled="true"
                               value="${t01ProdCert.apprDate?string("yyyy-MM-dd")}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">生效日期：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="effeDate" type="text" disabled="true"
                               value="${t01ProdCert.effeDate?string("yyyy-MM-dd")}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">有效期至：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="validPeri" type="text" disabled="true"
                               value="${t01ProdCert.validPeri?string("yyyy-MM-dd")}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">资质类型：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="certType" type="text" disabled="true"
                               value="${getDictLabel(t01ProdCert.certType,'t01_certType','')}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">资质状态：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="certStat" type="text" disabled="true"
                               value="${getDictLabel(t01ProdCert.certStat,'t01_certStat','')}"/>
                    </div>
                </div>

								<div class="control-group">
									<label class="control-label">审批状态：</label>
									<div class="controls">
										<input class="input-xlarge " name="apprStat" type="text" disabled="true" value="${getDictLabel(t01ProdCert.apprStat,'t01_apprStat','')}"/>
									</div>
								</div>

            </div>
            <div role="tabpanel" class=
                    "tab-pane fade"

                 id="p1">

                <div class="control-group">
                    <label class="control-label">产品名称（中文）：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="prodNameCn" type="text" disabled="true"
                               value="${t01ProdCert.prodNameCn}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">产品名称（英文）：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="prodNameEn" type="text" disabled="true"
                               value="${t01ProdCert.prodNameEn}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">型号规格：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="modelSpec" type="text" disabled="true"
                               value="${t01ProdCert.modelSpec}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">结构及组成：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="struComp" type="text" disabled="true"
                               value="${t01ProdCert.struComp}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">主要组成成分：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="mainMnt" type="text" disabled="true"
                               value="${t01ProdCert.mainMnt}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">预期用途：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="expeUsage" type="text" disabled="true"
                               value="${t01ProdCert.expeUsage}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">适用范围：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="useScope" type="text" disabled="true"
                               value="${t01ProdCert.useScope}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">产品有效期（月）：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="effiDate" type="text" disabled="true"
                               value="${t01ProdCert.effiDate}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">储存条件：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="storCond" type="text" disabled="true"
                               value="${t01ProdCert.storCond}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">运输条件：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="tranCond" type="text" disabled="true"
                               value="${t01ProdCert.tranCond}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">备注：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="remarks" type="text" disabled="true"
                               value="${t01ProdCert.remarks}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">说明：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="explanation" type="text" disabled="true"
                               value="${t01ProdCert.explanation}"/>
                    </div>
                </div>

            </div>
            <div role="tabpanel" class=
                    "tab-pane fade"

                 id="p2">

                <div class="control-group">
                    <label class="control-label">注册人/备案人名称(原文)：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="regiPersName" type="text" disabled="true"
                               value="${t01ProdCert.regiPersName}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">注册人/备案人名称(翻译)：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="regiPersNameTran" type="text" disabled="true"
                               value="${t01ProdCert.regiPersNameTran}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">注册人/备案人住所：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="regiPersAddr" type="text" disabled="true"
                               value="${t01ProdCert.regiPersAddr}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">注册人/备案人联系方式：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="regiPersCont" type="text" disabled="true"
                               value="${t01ProdCert.regiPersCont}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">生产地址：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="produAddr" type="text" disabled="true"
                               value="${t01ProdCert.produAddr}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">生产国或地区（中文）：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="produAreaCn" type="text" disabled="true"
                               value="${t01ProdCert.produAreaCn}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">生产国或地区（英文）：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="produAreaEn" type="text" disabled="true"
                               value="${t01ProdCert.produAreaEn}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">生产厂商名称（中文）：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="produFactCn" type="text" disabled="true"
                               value="${t01ProdCert.produFactCn}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">代理人名称：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="agentName" type="text" disabled="true"
                               value="${t01ProdCert.agentName}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">代理人住所：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="agentAddr" type="text" disabled="true"
                               value="${t01ProdCert.agentAddr}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">代理人联系方式：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="agentCont" type="text" disabled="true"
                               value="${t01ProdCert.agentCont}"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">售后服务单位：</label>
                    <div class="controls">
                        <input class="input-xlarge " name="saledServOrg" type="text" disabled="true"
                               value="${t01ProdCert.saledServOrg}"/>
                    </div>
                </div>

            </div>
            <div role="tabpanel" class=
                    "tab-pane fade"

                 id="p3">

                <div class="control-group">
                    <label class="control-label">附件：</label>
                    <div class="controls">
                        <div>${getAttachLabel(t01ProdCert.attachment)}</div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</form>
<#if t01ProdCert.sysChanInfoList??>
    <script type="text/javascript">
        /**
         * 页面加载以后获取变更字段的name并将其高亮显示
         */
        $(function () {
            var fetchUrl = ctx + "/gsp/t01prodcert/t01ProdCert/getChanInfo";
            var dataId = $('#id').val().trim();
            $.ajax({
                url: fetchUrl,
                type: "GET",
                data: {id: dataId},
                success: function (data) {
                    var sysList = data || {};
                    $.each(sysList, function (i, v) {
                        $("input[name=" + v + "]").parent().prev().css("color", "red");
                        $("#" + v).parent().prev().css("color", "red");
                    });
                },
                error: function () {
                }
            });
        });
    </script>
</#if>

<%@ page contentType="text/html;charset=UTF-8" %>
<table id="contentTable" class="table table-striped table-bordered table-condensed table-nowrap">
    <thead>
    <tr>
        <th><input type="checkbox" id="checkbox_a1" style="display:none" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
        <th>注册证/备案凭证编号</th>
        <th>原注册证/备案凭证编号</th>
        <th>风险分类</th>
        <th>技术分类-名称</th>
        <th>批准日期</th>
        <th>生效日期</th>
        <th>有效期至</th>
        <th>更新时间</th>
        <th>产品名称（中文）</th>
        <th>产品名称（英文）</th>
        <th>型号规格</th>
        <th>结构及组成</th>
        <th>主要组成成分</th>
        <th>预期用途</th>
        <th>适用范围</th>
        <th>产品有效期（月）</th>
        <th>储存条件</th>
        <th>运输条件</th>
        <th>注册人/备案人名称(原文)</th>
        <th>注册人/备案人名称(翻译)</th>
        <th>注册人/备案人住所</th>
        <th>注册人/备案人联系方式</th>
        <th>生产地址</th>
        <th>生产国或地区（中文）</th>
        <th>生产厂商名称（中文）</th>
        <th>生产国或地区（英文）</th>
        <th>代理人名称</th>
        <th>代理人住所</th>
        <th>代理人联系方式</th>
        <th>售后服务单位</th>
        <th>审批状态</th>
        <th>资质状态</th>
        <th>资质类型</th>
        <th>备注</th>
        <th>说明</th>
        <th>附件</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${history}" var="t01ProdCert" varStatus="countp">

        <tr>
            <td><input id="checkbox_a${countp.index+1}" style="display:none" class="chk_1" type="checkbox" onchange="checkAll()" data-id="${t01ProdCert.id}"/>
                <label for="checkbox_a${countp.index+1}"></label></td>
            <td class="hoverChange ">
                <a class="${t01ProdCert.certStat=='0' && t01ProdCert.apprStat=='2'?'highlight0':''}
				${t01ProdCert.certStat=='1' && t01ProdCert.apprStat=='2'?'highlight3':''}
				${t01ProdCert.certStat=='2' && t01ProdCert.apprStat=='2'?'highlight1':''}
				${t01ProdCert.certStat=='3' && t01ProdCert.apprStat=='2'?'highlight2':''} "
                   target="_blank" href="${ctx}/gsp/t01prodcert/t01ProdCert/details?id=${t01ProdCert.id}">
                    ${t01ProdCert.regiCertNbr}
                </a></td>
            <td>
                ${t01ProdCert.origRegiCertNbr}
            </td>
            <td>
                ${fns:getDictLabel(t01ProdCert.riskClass, 't01_riskClass', '')}
            </td>
            <td>
                    ${fns:getDictLabel(t01ProdCert.techCateCd, 't01_tech_cate_cd', '')}
            </td>
            <td>
                <fmt:formatDate value="${t01ProdCert.apprDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                <fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                <fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                <fmt:formatDate value="${t01ProdCert.updateDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                ${t01ProdCert.prodNameCn}
            </td>
            <td>
                ${t01ProdCert.prodNameEn}
            </td>
            <td>
                ${t01ProdCert.modelSpec}
            </td>
            <td>
                ${t01ProdCert.struComp}
            </td>
            <td>
                ${t01ProdCert.mainMnt}
            </td>
            <td>
                ${t01ProdCert.expeUsage}
            </td>
            <td>
                ${t01ProdCert.useScope}
            </td>
            <td>
                ${t01ProdCert.effiDate}
            </td>
            <td>
                ${t01ProdCert.storCond}
            </td>
            <td>
                ${t01ProdCert.tranCond}
            </td>
            <td>
                ${t01ProdCert.regiPersName}
            </td>
            <td>
                ${t01ProdCert.regiPersNameTran}
            </td>
            <td>
                ${t01ProdCert.regiPersAddr}
            </td>
            <td>
                ${t01ProdCert.regiPersCont}
            </td>
            <td>
                ${t01ProdCert.produAddr}
            </td>
            <td>
                ${t01ProdCert.produAreaCn}
            </td>
            <td>
                ${t01ProdCert.produFactCn}
            </td>
            <td>
                ${t01ProdCert.produAreaEn}
            </td>
            <td>
                ${t01ProdCert.agentName}
            </td>
            <td>
                ${t01ProdCert.agentAddr}
            </td>
            <td>
                ${t01ProdCert.agentCont}
            </td>
            <td>
                ${t01ProdCert.saledServOrg}
            </td>
            <td>
                ${fns:getDictLabel(t01ProdCert.apprStat, 't01_apprStat', '')}
            </td>
            <td>
					<span class="${t01ProdCert.certStat=='0' && t01ProdCert.apprStat=='2'?'bgLight0':''}
				${t01ProdCert.certStat=='1' && t01ProdCert.apprStat=='2'?'bgLight3':''}
				${t01ProdCert.certStat=='2' && t01ProdCert.apprStat=='2'?'bgLight1':''}
				${t01ProdCert.certStat=='3' && t01ProdCert.apprStat=='2'?'bgLight2':''} ">
                            ${fns:getDictLabel(t01ProdCert.certStat, 't01_certStat', '')}
                    </span>
            </td>
            <td>
                ${fns:getDictLabel(t01ProdCert.certType, 't01_certType', '')}
            </td>
            <td>
                ${t01ProdCert.remarks}
            </td>
            <td>
                ${t01ProdCert.explanation}
            </td>
            <td>
                ${fns:getAttachLabel(t01ProdCert.attachment)}
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
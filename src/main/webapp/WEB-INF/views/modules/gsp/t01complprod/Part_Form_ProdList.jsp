<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <title>产品资质列表</title>
    <meta name="decorator" content="default"/>
    <script>
        $(document).ready(function () {
            ${ edit ==true ?' $("#contentTable").find("input:checkbox").attr("checked", "checked");' :''}
        });
        function getCheckedItem() {

            $("#prodCertIds", parent.document).val("");

            var ids = "";

            $('#contentTable tbody input[type="checkbox"]').each(function () {
                if (this.checked == true) {
                    ids += $(this).attr("data-id").trim() + ",";
                }
            });
            $("#prodCertIds", parent.document).val(ids);

            var allNum = 0;
            $("tbody").find("input:checkbox").each(function(){
                if($(this).attr("checked") == "checked"){
                    allNum++;
                }
            });
            if(allNum == $("tbody").find("input:checkbox").length){
                $("thead").find("input:checkbox").attr("checked","checked");
            }
            else{
                $("thead").find("input:checkbox").attr("checked",false);
            }
        }
        function getCheckedItems(obj) {
            if ($(obj).attr("checked") == "checked") {
                $(obj).parents("thead").siblings("tbody").find("input:checkbox").attr("checked", "checked");
                getCheckedItem()
            }
            else {
                $(obj).parents("thead").siblings("tbody").find("input:checkbox").attr("checked", false);
                getCheckedItem()
            }
        }
    </script>
    <style>
        .hoverChange a:visited,.hoverChange a:active {
            color:#969696 !important;
        }
    </style>
</head>
<body>
<div id="borderScroll" style="width:100%; overflow: auto;">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input ${ detailView ==true ? 'disabled="disabled"':''}   type="checkbox" id="checkbox_a1" class="chk_1" onchange="getCheckedItems(this)"/><label for="checkbox_a1"></label></th>
            <th>注册证/备案凭证编号</th>
            <th>原注册证/备案凭证编号</th>
            <th>风险分类</th>
            <th>技术分类代码</th>
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
        <c:if test="${empty list && !detailView && hasNotInCertScopData}">
            <tr><td colspan="37" style="text-align: left;" >资质必须在本企业资质表生产/经营/销售范围/诊疗科目范围内</td></tr>
        </c:if>
        <c:if test="${empty list && !detailView && !hasNotInCertScopData}">
            <tr><td colspan="37" style="text-align: left;" >暂无结果，请填写已通过审批的资质证号进行查询</td></tr>
        </c:if>
        <c:forEach items="${list}" var="t01ProdCert" varStatus="status">
            <tr>
                <td><input  ${ detailView ? 'disabled="disabled"':''} id="checkbox_a${status.count+1}" class="chk_1" type="checkbox" onchange="getCheckedItem()"  data-id="${t01ProdCert.id}"/><label for="checkbox_a${status.count+1}"></label></td>
                <td class="hoverChange ">
                    <a target="a_blank"  class=" ${t01ProdCert.certStat=='0'?'highlight0':''} ${t01ProdCert.certStat=='1'?'highlight3':''} ${t01ProdCert.certStat=='2'?'highlight1':''} ${t01ProdCert.certStat=='3'?'highlight2':''} " href="${ctx}/gsp/t01prodcert/t01ProdCert/details?id=${t01ProdCert.id}" href="${ctx}/gsp/t01prodcert/t01ProdCert/details?id=${t01ProdCert.id}">
                            ${t01ProdCert.regiCertNbr}
                    </a>
                </td>
                <td>
                        ${t01ProdCert.origRegiCertNbr}
                </td>
                <td>
                        ${fns:getDictLabel(t01ProdCert.riskClass, 't01_riskClass', '')}
                </td>
                <td>
                        ${t01ProdCert.techCateCd}
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
                        <span class="${t01ProdCert.certStat=='0'?'bgLight0':''} ${t01ProdCert.certStat=='1'?'bgLight3':''} ${t01ProdCert.certStat=='2'?'bgLight1':''} ${t01ProdCert.certStat=='3'?'bgLight2':''} ">
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
</div>
</body>
</html>
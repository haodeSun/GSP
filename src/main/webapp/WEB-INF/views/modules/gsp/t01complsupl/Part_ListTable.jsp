<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<span class="checkOut newBtn btn btn-primary" onclick="exportThis()">导出</span>
<span class="printSpan newBtn btn btn-primary" onclick="printThis(this)">打印</span>
<div id="columnNameDiv" class="btn-group">
    <a class="newBtn btn dropdown-toggle" data-toggle="dropdown" href="#">
        列名称
    </a>
    <ul id="columnName" class="dropdown-menu">
    </ul>
</div>

<div id="borderScroll" style="width:99%; overflow: auto;">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
            <th>企业名称（中文）</th>
            <th>企业名称（英文）</th>
            <th>简称</th>
            <th>供货者状态</th>
            <th>企业状态</th>
            <th>生产资质状态</th>
            <th>经营资质状态</th>
            <th>审批状态</th>
            <th>最后操作时间</th>
            <th>描述</th>
            <th>备注</th>
            <th>境内/境外</th>
            <th>统一社会信用代码</th>
            <th>注册号</th>
            <th>组织机构代码证号</th>
            <th>税务登记证号</th>
            <th>企业唯一编码</th>
            <%--<th>名称</th>--%>
            <th>经营范围</th>
            <th>成立日期</th>
            <th>营业期限至</th>
            <%--<th>营业执照上传</th>--%>
            <th>经营许可证号/备案凭证号</th>
            <th>企业名称</th>
            <th>经营方式</th>
            <th>经营场所</th>
            <th>库房地址</th>
            <%--<th>经营范围</th>--%>
            <th>发证时间</th>
            <th>有效期至</th>
            <%--<th>经营资质上传</th>--%>
            <th>编号</th>
            <th>企业名称</th>
            <%--<th>生产范围</th>--%>
            <th>发证日期</th>
            <th>有效期至</th>
            <%--<th>生产资质上传</th>--%>
            <th>生产能力评价</th>
            <th>质量管理评价</th>
            <th>仓储能力评价</th>
            <th>交付能力评价</th>
            <th>售后服务能力评价</th>
            <%--<th>其他附件</th>--%>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="t01ComplSupl" varStatus="varStatus">
            <tr>
                <td>
                    <input id="checkbox_a${varStatus.index+2}" class="chk_1" type="checkbox" onchange="checkAll()"
                           data-id="${t01ComplSupl.id}"/>
                    <label for="checkbox_a${varStatus.index+2}"></label>
                </td>
                <td class="hoverChange">
                    <a class=" ${t01ComplSupl.suplStat=='0' && t01ComplSupl.apprStat=='2'?'highlight0':''}
                            ${t01ComplSupl.suplStat=='1' && t01ComplSupl.apprStat=='2'?'highlight3':''}
                            ${t01ComplSupl.suplStat=='2' && t01ComplSupl.apprStat=='2'?'highlight1':''}
                            ${t01ComplSupl.suplStat=='3' && t01ComplSupl.apprStat=='2'?'highlight2':''} "
                       href="${ctx}/gsp/t01complsupl/t01ComplSupl/toDetail?id=${t01ComplSupl.id}">
                            ${t01ComplSupl.t01CompInfo.compNameCn}
                    </a>
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.compNameEn}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.shortName}
                </td>
                <td>
                    <span class="${t01ComplSupl.suplStat=='0' && t01ComplSupl.apprStat=='2'?'bgLight0':''}
				${t01ComplSupl.suplStat=='1' && t01ComplSupl.apprStat=='2'?'bgLight3':''}
				${t01ComplSupl.suplStat=='2' && t01ComplSupl.apprStat=='2'?'bgLight1':''}
				${t01ComplSupl.suplStat=='3' && t01ComplSupl.apprStat=='2'?'bgLight2':''} ">
                            ${fns:getDictLabel(t01ComplSupl.suplStat, 't01_certStat', '')}
                    </span>
                </td>
                    <%--企业状态--%>
                <td>
                    <c:if test="${'0'==t01ComplSupl.t01CompInfo.abroad}">
                        <span class="${t01ComplSupl.t01CompCert0.certStat=='0' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight0':''}
				${t01ComplSupl.t01CompCert0.certStat=='1' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight3':''}
				${t01ComplSupl.t01CompCert0.certStat=='2' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight1':''}
				${t01ComplSupl.t01CompCert0.certStat=='3' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight2':''} ">
                                ${fns:getDictLabel(t01ComplSupl.t01CompCert0.certStat, 't01_certStat', '')}
                        </span>
                    </c:if>
                    <c:if test="${'1'==t01ComplSupl.t01CompInfo.abroad}">
                    <span class="${t01ComplSupl.t01CompCert3.certStat=='0' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight0':''}
				${t01ComplSupl.t01CompCert3.certStat=='1' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight3':''}
				${t01ComplSupl.t01CompCert3.certStat=='2' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight1':''}
				${t01ComplSupl.t01CompCert3.certStat=='3' && t01ComplSupl.t01CompInfo.apprStat=='2'?'bgLight2':''} ">
                            ${fns:getDictLabel(t01ComplSupl.t01CompCert3.certStat, 't01_certStat', '')}
                    </span>
                    </c:if>
                </td>
                    <%--生产资质状态--%>
                <td>
                     <span class="${t01ComplSupl.t01CompCert2.certStat=='0' ?'bgLight0':''}
				${t01ComplSupl.t01CompCert2.certStat=='1' ?'bgLight3':''}
				${t01ComplSupl.t01CompCert2.certStat=='2' ?'bgLight1':''}
				${t01ComplSupl.t01CompCert2.certStat=='3'?'bgLight2':''} ">
                             ${fns:getDictLabel(t01ComplSupl.t01CompCert2.certStat, 't01_certStat', '')}
                     </span>
                </td>
                    <%--经营资质状态--%>
                <td>
                     <span class="${t01ComplSupl.t01CompCert1.certStat=='0' ?'bgLight0':''}
				${t01ComplSupl.t01CompCert1.certStat=='1' ?'bgLight3':''}
				${t01ComplSupl.t01CompCert1.certStat=='2' ?'bgLight1':''}
				${t01ComplSupl.t01CompCert1.certStat=='3'?'bgLight2':''} ">
                             ${fns:getDictLabel(t01ComplSupl.t01CompCert1.certStat, 't01_certStat', '')}
                     </span>
                </td>
                    <%--审批状态--%>
                <td>
                        ${fns:getDictLabel(t01ComplSupl.apprStat, 't01_matr_info_appr_stat', '')}
                </td>
                    <%--最后操作时间--%>
                <td>
                    <fmt:formatDate value="${t01ComplSupl.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                    <%--描述--%>
                <td>
                        ${t01ComplSupl.t01CompInfo.compDesc}
                </td>
                    <%--备注--%>
                <td>
                        ${t01ComplSupl.t01CompInfo.remarks}
                </td>
                    <%--境内/境外--%>
                <td>
                        ${fns:getDictLabel(t01ComplSupl.t01CompInfo.abroad, 'abroad', '')}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.uniCretNbr}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.regiNbr}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.orgCertNbr}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.taxNbr}
                </td>
                    <%--企业唯一编码--%>
                <td>
                        ${t01ComplSupl.t01CompInfo.compUniNbr}
                </td>
                <%--<td>--%>
                        <%--${t01ComplSupl.t01CompCert0.certName}--%>
                <%--</td>--%>
                <td>
                    <c:if test="${'0'==t01ComplSupl.t01CompInfo.abroad}">
                        ${t01ComplSupl.t01CompCert0.certScop}
                    </c:if>
                    <c:if test="${'1'==t01ComplSupl.t01CompInfo.abroad}">
                        ${t01ComplSupl.t01CompCert3.certScop}
                    </c:if>
                </td>
                <td>
                    <c:if test="${'0'==t01ComplSupl.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                    <c:if test="${'1'==t01ComplSupl.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                </td>
                <td>
                    <c:if test="${'0'==t01ComplSupl.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                    <c:if test="${'1'==t01ComplSupl.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                </td>
                <%--<td>--%>
                        <%--${fns:getAttachLabel(t01ComplSupl.t01CompCert0.attachment)}--%>
                <%--</td>--%>
                <c:if test="${t01ComplSupl.certType=='1' ||t01ComplSupl.certType =='2'}">
                    <td>
                            ${t01ComplSupl.t01CompCert1.certNbr}
                    </td>
                    <td>
                            ${t01ComplSupl.t01CompCert1.certName}
                    </td>
                    <td>
                            ${fns:getDictLabel(t01ComplSupl.t01CompInfo.busiMode, 't01_busiMode', '')}
                    </td>
                    <td>
                            ${t01ComplSupl.t01CompInfo.busiLoca}
                    </td>
                    <td>
                            ${t01ComplSupl.t01CompInfo.storLoca}
                    </td>
                    <%--<td>--%>
                            <%--${t01ComplSupl.t01CompCert1.certScop}--%>
                    <%--</td>--%>
                    <td>
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <%--<td>--%>
                            <%--${fns:getAttachLabel(t01ComplSupl.t01CompCert1.attachment)}--%>
                    <%--</td>--%>
                </c:if>
                <c:if test="${t01ComplSupl.certType !='1' &&t01ComplSupl.certType !='2' }">
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </c:if>
                <c:if test="${t01ComplSupl.certType =='0'||t01ComplSupl.certType =='2'}">
                    <td>
                            ${t01ComplSupl.t01CompCert2.certNbr}
                    </td>
                    <td>
                            ${t01ComplSupl.t01CompCert2.certName}
                    </td>
                    <%--<td>--%>
                            <%--${t01ComplSupl.t01CompCert2.certScop}--%>
                    <%--</td>--%>
                    <td>
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert2.effecDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ComplSupl.t01CompCert2.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <%--<td>--%>
                            <%--${fns:getAttachLabel(t01ComplSupl.t01CompCert2.attachment)}--%>
                    <%--</td>--%>
                </c:if>
                <c:if test="${t01ComplSupl.certType !='0'  &&t01ComplSupl.certType !='2'}">
                    <%--<td></td>--%>
                    <%--<td></td>--%>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </c:if>
                <td>
                        ${t01ComplSupl.t01CompInfo.prodAbliEval}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.qualMgrEval}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.storAbliEval}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.deliAbliEval}
                </td>
                <td>
                        ${t01ComplSupl.t01CompInfo.afteSaleAbliEval}
                </td>
                <%--<td>--%>
                        <%--${fns:getAttachLabel(t01ComplSupl.attachment)}--%>
                <%--</td>--%>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination">${page}</div>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 表单的列名称下拉项以及导出按钮 -->
<span class="checkOut newBtn btn btn-primary" onclick="exportThis()">导出</span>
<span class="printSpan newBtn btn btn-primary" onclick="printThis(this)">打印</span>
<div id="columnNameDiv" class="btn-group">
    <a class="newBtn btn dropdown-toggle" data-toggle="dropdown" href="#">
        列名称
    </a>
    <ul id="columnName" class="dropdown-menu">
    </ul>
</div>
<!----------------------------------->
<div id="borderScroll" style="width:99%; overflow: auto;">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label
                    for="checkbox_a1"></label></th>
            <th>企业名称（中文）</th>
            <th>企业名称（英文）</th>
            <th>简称</th>
            <th>购货者状态</th>
            <th>企业状态</th>
            <th>医疗机构执业许可状态</th>
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
            <th>经营资质发证时间</th>
            <th>经营资质有效期至</th>
            <%--<th>经营资质上传</th>--%>
            <th>登记号</th>
            <th>机构名称</th>
            <th>诊疗科目</th>
            <th>医疗机构执业许可发证日期</th>
            <th>医疗机构执业许可有效期至</th>
            <%--<th>医疗机构执业许可上传</th>--%>
            <%--<th>其他附件</th>--%>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="t01ComplBuyer" varStatus="status">
            <tr>
                <td><input id="checkbox_a${status.count+1}" class="chk_1" type="checkbox" onchange="checkAll()"
                           data-id="${t01ComplBuyer.id}"/><label for="checkbox_a${status.count+1}"></label></td>
                <td class="hoverChange">
                    <a class=" ${t01ComplBuyer.buyerStat=='0' && t01ComplBuyer.apprStat=='2'?'highlight0':''}
                            ${t01ComplBuyer.buyerStat=='1' && t01ComplBuyer.apprStat=='2'?'highlight3':''}
                            ${t01ComplBuyer.buyerStat=='2' && t01ComplBuyer.apprStat=='2'?'highlight1':''}
                            ${t01ComplBuyer.buyerStat=='3' && t01ComplBuyer.apprStat=='2'?'highlight2':''} "
                       href="${ctx}/gsp/t01complbuyer/t01ComplBuyer/toDetail?id=${t01ComplBuyer.id}">
                            ${t01ComplBuyer.t01CompInfo.compNameCn}
                    </a>
                </td>
                <td>
                        ${t01ComplBuyer.t01CompInfo.compNameEn}
                </td>
                <td>
                        ${t01ComplBuyer.t01CompInfo.shortName}
                </td>
                <td>
                     <span class="${t01ComplBuyer.buyerStat=='0' && t01ComplBuyer.apprStat=='2'?'bgLight0':''}
				${t01ComplBuyer.buyerStat=='1' && t01ComplBuyer.apprStat=='2'?'bgLight3':''}
				${t01ComplBuyer.buyerStat=='2' && t01ComplBuyer.apprStat=='2'?'bgLight1':''}
				${t01ComplBuyer.buyerStat=='3' && t01ComplBuyer.apprStat=='2'?'bgLight2':''} ">
                             ${fns:getDictLabel(t01ComplBuyer.buyerStat, 't01_certStat', '')}
                     </span>
                </td>
                    <%--企业状态--%>
                <td>
                    <c:if test="${'0'==t01ComplBuyer.t01CompInfo.abroad}">
                        <span class="${t01ComplBuyer.t01CompCert0.certStat=='0' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight0':''}
				${t01ComplBuyer.t01CompCert0.certStat=='1' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight3':''}
				${t01ComplBuyer.t01CompCert0.certStat=='2' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight1':''}
				${t01ComplBuyer.t01CompCert0.certStat=='3' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight2':''} ">
                                ${fns:getDictLabel(t01ComplBuyer.t01CompCert0.certStat, 't01_certStat', '')}
                        </span>
                    </c:if>
                    <c:if test="${'1'==t01ComplBuyer.t01CompInfo.abroad}">
                    <span class="${t01ComplBuyer.t01CompCert3.certStat=='0' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight0':''}
				${t01ComplBuyer.t01CompCert3.certStat=='1' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight3':''}
				${t01ComplBuyer.t01CompCert3.certStat=='2' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight1':''}
				${t01ComplBuyer.t01CompCert3.certStat=='3' && t01ComplBuyer.t01CompInfo.apprStat=='2'?'bgLight2':''} ">
                            ${fns:getDictLabel(t01ComplBuyer.t01CompCert3.certStat, 't01_certStat', '')}
                    </span>
                    </c:if>
                </td>
                    <%--医疗机构执业许可状态--%>
                <td>
                     <span class="${t01ComplBuyer.t01CompCert4.certStat=='0' ?'bgLight0':''}
				${t01ComplBuyer.t01CompCert4.certStat=='1' ?'bgLight3':''}
				${t01ComplBuyer.t01CompCert4.certStat=='2' ?'bgLight1':''}
				${t01ComplBuyer.t01CompCert4.certStat=='3'?'bgLight2':''} ">
                             ${fns:getDictLabel(t01ComplBuyer.t01CompCert4.certStat, 't01_certStat', '')}
                     </span>
                </td>
                    <%--经营资质状态--%>
                <td>
                     <span class="${t01ComplBuyer.t01CompCert1.certStat=='0' ?'bgLight0':''}
				${t01ComplBuyer.t01CompCert1.certStat=='1' ?'bgLight3':''}
				${t01ComplBuyer.t01CompCert1.certStat=='2' ?'bgLight1':''}
				${t01ComplBuyer.t01CompCert1.certStat=='3'?'bgLight2':''} ">
                             ${fns:getDictLabel(t01ComplBuyer.t01CompCert1.certStat, 't01_certStat', '')}
                     </span>
                </td>
                    <%--审批状态--%>
                <td>
                        ${fns:getDictLabel(t01ComplBuyer.apprStat, 't01_matr_info_appr_stat', '')}
                </td>
                    <%--最后操作时间--%>
                <td>
                    <fmt:formatDate value="${t01ComplBuyer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                    <%--描述--%>
                <td>
                        ${t01ComplBuyer.t01CompInfo.compDesc}
                </td>
                    <%--备注--%>
                <td>
                        ${t01ComplBuyer.t01CompInfo.remarks}
                </td>
                    <%--境内/境外--%>
                <td>
                        ${fns:getDictLabel(t01ComplBuyer.t01CompInfo.abroad, 'abroad', '')}
                </td>

                <td>
                        ${t01ComplBuyer.t01CompInfo.uniCretNbr}
                </td>
                <td>
                        ${t01ComplBuyer.t01CompInfo.regiNbr}
                </td>
                <td>
                        ${t01ComplBuyer.t01CompInfo.orgCertNbr}
                </td>
                <td>
                        ${t01ComplBuyer.t01CompInfo.taxNbr}
                </td>
                    <%--企业唯一编码--%>
                <td>
                        ${t01ComplBuyer.t01CompInfo.compUniNbr}
                </td>
                <td>
                    <c:if test="${'0'==t01ComplBuyer.t01CompInfo.abroad}">
                        ${t01ComplBuyer.t01CompCert0.certScop}
                    </c:if>
                    <c:if test="${'1'==t01ComplBuyer.t01CompInfo.abroad}">
                        ${t01ComplBuyer.t01CompCert3.certScop}
                    </c:if>
                </td>
                <td>
                    <c:if test="${'0'==t01ComplBuyer.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                    <c:if test="${'1'==t01ComplBuyer.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                </td>
                <td>
                    <c:if test="${'0'==t01ComplBuyer.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                    <c:if test="${'1'==t01ComplBuyer.t01CompInfo.abroad}">
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                </td>
                    <%--<td>--%>
                    <%--${fns:getAttachLabel(t01ComplBuyer.t01CompCert0.attachment)}--%>
                    <%--</td>--%>
                <c:if test="${t01ComplBuyer.certType=='1'}">
                    <td>
                            ${t01ComplBuyer.t01CompCert1.certNbr}
                    </td>
                    <td>
                            ${t01ComplBuyer.t01CompCert1.certName}
                    </td>
                    <td>
                            ${fns:getDictLabel(t01ComplBuyer.t01CompInfo.busiMode, 't01_busiMode', '')}
                    </td>
                    <td>
                            ${t01ComplBuyer.t01CompInfo.busiLoca}
                    </td>
                    <td>
                            ${t01ComplBuyer.t01CompInfo.storLoca}
                    </td>
                    <%--<td>--%>
                    <%--${t01ComplBuyer.t01CompCert1.certScop}--%>
                    <%--</td>--%>
                    <td>
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <%--<td>--%>
                    <%--${fns:getAttachLabel(t01ComplBuyer.t01CompCert1.attachment)}--%>
                    <%--</td>--%>
                </c:if>
                <c:if test="${t01ComplBuyer.certType !='1'}">
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
                <c:if test="${t01ComplBuyer.certType =='0'}">
                    <td>
                            ${t01ComplBuyer.t01CompCert4.certNbr}
                    </td>
                    <td>
                            ${t01ComplBuyer.t01CompCert4.certName}
                    </td>
                    <td>
                            ${t01ComplBuyer.t01CompCert4.certScop}
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert4.effecDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ComplBuyer.t01CompCert4.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <%--<td>--%>
                    <%--${fns:getAttachLabel(t01ComplBuyer.t01CompCert4.attachment)}--%>
                    <%--</td>--%>
                </c:if>
                <c:if test="${t01ComplBuyer.certType !='0'}">
                    <%--<td></td>--%>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </c:if>
                    <%--<td>--%>
                    <%--${fns:getAttachLabel(t01ComplBuyer.attachment)}--%>
                    <%--</td>--%>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination">${page}</div>
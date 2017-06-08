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
            <th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
            <th>注册证/备案凭证编号</th>
            <th>原注册证/备案凭证编号</th>
            <th>风险分类</th>
            <th>技术分类-名称</th>
            <th>生效日期</th>
            <th>有效期至</th>
            <th>资质状态</th>
            <th>资质类型</th>
            <th>物料号</th>
            <th>物料名称（中文）</th>
            <th>物料名称（英文）</th>
            <th>描述</th>
            <th>物料分类</th>
            <th>存储条件_温度</th>
            <th>存储条件_湿度</th>
            <th>运输条件_温度</th>
            <th>运输条件_湿度</th>
            <th>物料单位</th>
            <th>货币单位</th>
            <th>物料单价</th>
            <th>物料规格</th>
            <th>产品有效期（月）</th>
            <th>备注</th>
            <th>首营产品状态</th>
            <th>审批状态</th>
            <th>更新时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="t01ComplProd" varStatus="status">
            <tr>
                <td>
                    <input id="checkbox_a${status.count+1}" class="chk_1" type="checkbox" onchange="checkAll()" data-id="${t01ComplProd.id}"  data-exportId="${t01ComplProd.complProdCertId}" data-deleteId="${t01ComplProd.complProdCertId}"  />
                    <label for="checkbox_a${status.count+1}"></label>
                </td>
                <%--<td>--%>
                    <%--<a class="${t01ComplProd.complProdStat=='0'?'highlight0':''} ${t01ComplProd.complProdStat=='1'?'highlight3':''} ${t01ComplProd.complProdStat=='2'?'highlight1':''} ${t01ComplProd.complProdStat=='3'?'highlight2':''} "--%>
                       <%--href="${ctx}/gsp/t01complprod/t01ComplProd/toDetail?id=${t01ComplProd.id}">--%>
                            <%--${t01ComplProd.regiCertNbr}--%>
                    <%--</a>--%>
                <%--</td>--%>
                <td class="hoverChange">
                    <c:if test="${t01ComplProd.freezeFlag =='0'}">

                        <a class="${t01ComplProd.apprStat=='2' && t01ProdCert.certStat=='0'?'highlight0':''}
				${t01ComplProd.apprStat=='2' && t01ProdCert.certStat=='1'?'highlight3':''}
				${t01ComplProd.apprStat=='2' && t01ProdCert.certStat=='2'?'highlight1':''}
				${t01ComplProd.apprStat=='2' && t01ProdCert.certStat=='3'?'highlight2':''} "
                           href="${ctx}/gsp/t01complprod/t01ComplProd/toDetail?id=${t01ComplProd.id}">
                                ${t01ComplProd.regiCertNbr}
                        </a>
                    </c:if>
                    <c:if test="${t01ComplProd.freezeFlag =='1'}">
                        <a class="${t01ComplProd.apprStat=='2'?'highlight2':''} "
                           href="${ctx}/gsp/t01complprod/t01ComplProd/toDetail?id=${t01ComplProd.id}">
                                ${t01ComplProd.regiCertNbr}
                        </a>
                    </c:if>
                </td>
                <td>
                        ${t01ComplProd.origRegiCertNbr}
                </td>
                <td>
                        ${fns:getDictLabel(t01ComplProd.riskClass, 't01_riskClass', '')}
                </td>
                <td>
                        ${fns:getDictLabel(t01ComplProd.techCateCd, 't01_tech_cate_cd', '')}
                </td>
                <td>
                    <fmt:formatDate value="${t01ComplProd.effeDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <fmt:formatDate value="${t01ComplProd.validPeri}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
					<span class="  ${t01ComplProd.certStat=='0' ?'bgLight0':''}
                                ${t01ComplProd.certStat=='1' ?'bgLight3':''}
                                ${t01ComplProd.certStat=='2' ?'bgLight1':''}
                                ${t01ComplProd.certStat=='3' ?'bgLight2':''} ">
                            ${fns:getDictLabel(t01ComplProd.certStat, 't01_certStat', '')}
                    </span>
                </td>
                <td>
                        ${fns:getDictLabel(t01ComplProd.certType, 't01_certType', '')}
                </td>
                <td>
                        ${t01ComplProd.matrNbr}
                </td>
                <td>
                        ${t01ComplProd.matrNmCn}
                </td>
                <td>
                        ${t01ComplProd.matrNmEn}
                </td>
                <td>
                        ${t01ComplProd.matrDesc}
                </td>
                <td>
                        ${fns:getDictLabel(t01ComplProd.matrType, 't01_matr_info_matr_type', '')}
                </td>
                <td>
                        ${t01ComplProd.storTemp}-${t01ComplProd.storTemp2}
                </td>
                <td>
                        ${t01ComplProd.storWet}- ${t01ComplProd.storWet2}
                </td>
                <td>
                        ${t01ComplProd.tranTemp}-${t01ComplProd.tranTemp2}
                </td>
                <td>
                        ${t01ComplProd.tranWet}-${t01ComplProd.tranWet2}
                </td>
                <td>
                        ${t01ComplProd.martUnit}
                </td>
                <td>
                        ${t01ComplProd.priceUnit}
                </td>
                <td>
                        ${t01ComplProd.matrPrice}
                </td>
                <td>
                        ${t01ComplProd.specType}
                </td>
                <td>
                        ${t01ComplProd.validMonths}
                </td>
                <td>
                        ${t01ComplProd.remarks}
                </td>
                <%--<td class="${t01ComplProd.complProdStat=='0'?'bgLight0':''} ${t01ComplProd.complProdStat=='1'?'bgLight3':''} ${t01ComplProd.complProdStat=='2'?'bgLight1':''} ${t01ComplProd.complProdStat=='3'?'bgLight2':''} " >--%>
                        <%--${fns:getDictLabel(t01ComplProd.complProdStat, 't01ComplProd_complProdStat', '')}--%>
                <%--</td>--%>
                <td>
                <c:if test="${t01ComplProd.freezeFlag =='0'}">

                    <span class="  ${t01ComplProd.apprStat=='2' && t01ComplProd.certStat=='0' ?'bgLight0':''}
                    ${t01ComplProd.apprStat=='2' && t01ComplProd.certStat=='1' ?'bgLight3':''}
                    ${t01ComplProd.apprStat=='2' && t01ComplProd.certStat=='2' ?'bgLight1':''}
                    ${t01ComplProd.apprStat=='2' && t01ComplProd.certStat=='3' ?'bgLight2':''} ">
                    ${fns:getDictLabel(t01ComplProd.certStat, 't01_certStat', '')}
                </c:if>
                <c:if test="${t01ComplProd.freezeFlag =='1'}">
                    <span class=" ${t01ComplProd.apprStat=='2'?'bgLight2':''}">
                            冻结
                    </span>
                </c:if>
                </td>
                <td>
                        ${fns:getDictLabel(t01ComplProd.apprStat, 't01_matr_info_appr_stat', '')}
                </td>
                <td>
                    <fmt:formatDate value="${t01ComplProd.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination">${page}</div>
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

<div id="borderScroll" style="width:99%; overflow: auto;">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label
                    for="checkbox_a1"></label></th>
            <th>销售人员姓名</th>
            <th>所在企业</th>
            <th>销售人员授权状态</th>
            <th>证件类型</th>
            <th>证件号</th>
            <th>销售区域</th>
            <%--<th>授权产品范围</th>--%>
            <th>授权书编号</th>
            <th>生效日期</th>
            <th>有效期至</th>
            <th>附件</th>
            <th>更新时间</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="t01SalesCert" varStatus="status">

            <tr>
                <td><input id="checkbox_a${status.count+1}" class="chk_1" type="checkbox" onchange="checkAll()"
                           data-id="${t01SalesCert.id}"/><label for="checkbox_a${status.count+1}"></label></td>
                <td class="hoverChange">
                    <a class=" ${t01SalesCert.certStat=='0' ?'highlight0':''}
                            ${t01SalesCert.certStat=='1' ?'highlight3':''}
                            ${t01SalesCert.certStat=='2' ?'highlight1':''}
                            ${t01SalesCert.certStat=='3' ?'highlight2':''} "
                            href="${ctx}/gsp/t01salescert/t01SalesCert/toDetail?id=${t01SalesCert.id}">
                            ${t01SalesCert.salesName}
                    </a>
                </td>
                <td>
                        ${t01SalesCert.comp.compNameCn}
                </td>
                <td>
                    <span class="${t01SalesCert.certStat=='0' ?'bgLight0':''}
				${t01SalesCert.certStat=='1' ?'bgLight3':''}
				${t01SalesCert.certStat=='2' ?'bgLight1':''}
				${t01SalesCert.certStat=='3' ?'bgLight2':''} ">
                        ${fns:getDictLabel(t01SalesCert.certStat, 't01_certStat', '')}
                    </span>
                </td>
                <td>
                        ${fns:getDictLabel(t01SalesCert.idType, 't01_SalesIDType', '')}
                </td>
                <td>
                        ${t01SalesCert.idNbr}
                </td>
                <td>
                        ${t01SalesCert.salesArea}
                </td>
                <%--<td>--%>
                        <%--${t01SalesCert.salesScop}--%>
                <%--</td>--%>
                <td>
                        ${t01SalesCert.salesCertNbr}
                </td>
                <td>
                    <fmt:formatDate value="${t01SalesCert.effecDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <fmt:formatDate value="${t01SalesCert.validDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                        ${fns:getAttachCount(t01SalesCert.attachment)}
                </td>
                <td>
                    <fmt:formatDate value="${t01SalesCert.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination">${page}</div>
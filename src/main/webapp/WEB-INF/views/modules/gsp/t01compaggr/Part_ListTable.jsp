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
            <th>协议编号</th>
            <th>协议类别</th>
            <th>购货者</th>
            <th>供货者</th>
            <th>生效日期</th>
            <th>有效期至</th>
            <th>协议状态</th>
            <th>审批状态</th>
            <th>最后操作时间</th>
            <th>销售授权人</th>
            <th>销售区域</th>
            <th>生产企业</th>
            <th>协议金额</th>
            <th>附件</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.list}" var="t01CompAggr" varStatus="varStatus">
            <tr>
                <td><input id="checkbox_a${varStatus.index+2}" class="chk_1" type="checkbox" data-id="${t01CompAggr.id}"
                           onchange="checkAll()"/><label for="checkbox_a${varStatus.index+2}"></label></td>
                <td class="hoverChange">
                    <c:if test="${'0'==t01CompAggr.freeze}">
                    <a class=" ${t01CompAggr.aggrStat=='0' && t01CompAggr.apprStat=='2'?'highlight0':''}
                            ${t01CompAggr.aggrStat=='1' && t01CompAggr.apprStat=='2'?'highlight3':''}
                            ${t01CompAggr.aggrStat=='2' && t01CompAggr.apprStat=='2'?'highlight1':''}
                            ${t01CompAggr.aggrStat=='3' && t01CompAggr.apprStat=='2'?'highlight2':''} "
                       href="${ctx}/gsp/t01compaggr/t01CompAggr/toDetail?id=${t01CompAggr.id}">
                            ${t01CompAggr.agreementNo}
                    </a>
                    </c:if>
                    <c:if test="${'1'==t01CompAggr.freeze}">
                        <a class="highlight2"
                           href="${ctx}/gsp/t01compaggr/t01CompAggr/toDetail?id=${t01CompAggr.id}">
                                ${t01CompAggr.agreementNo}
                        </a>
                    </c:if>
                </td>
                <td>
                        ${fns:getDictLabel(t01CompAggr.aggrType, 't01_comp_aggr_type', '')}
                </td>
                <td>
                        ${t01CompAggr.buyer.t01CompInfo.compNameCn}
                </td>
                <td>
                        ${t01CompAggr.supplier.t01CompInfo.compNameCn}
                </td>
                <td>
                    <fmt:formatDate value="${t01CompAggr.effecDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <fmt:formatDate value="${t01CompAggr.validDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <c:if test="${'0'==t01CompAggr.freeze}">
                <span class="${t01CompAggr.aggrStat=='0' && t01CompAggr.apprStat=='2'?'bgLight0':''}
				${t01CompAggr.aggrStat=='1' && t01CompAggr.apprStat=='2'?'bgLight3':''}
				${t01CompAggr.aggrStat=='2' && t01CompAggr.apprStat=='2'?'bgLight1':''}
				${t01CompAggr.aggrStat=='3' && t01CompAggr.apprStat=='2'?'bgLight2':''} ">
                        ${fns:getDictLabel(t01CompAggr.aggrStat, 't01_certStat', '')}
                </span>
                    </c:if>
                    <c:if test="${'1'==t01CompAggr.freeze}">
                        <span class="bgLight2">
                        ${fns:getDictLabel('3', 't01_certStat', '')}
                        </span>
                    </c:if>
                </td>
                <td>
                        ${fns:getDictLabel(t01CompAggr.apprStat, 't01_apprStat', '')}
                </td>
                <td>
                    <fmt:formatDate value="${t01CompAggr.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                        ${t01CompAggr.authorName}
                </td>
                <td>
                        ${t01CompAggr.location}
                </td>
                <td>
                        ${t01CompAggr.prodComp}
                </td>
                <td>
                        ${t01CompAggr.aggrAmnt}
                </td>
                <td>
                        ${fns:getAttachCount(t01CompAggr.attachment)}
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class=" pagination">
    ${page}</div>
<%@ page contentType="text/html;charset=UTF-8" %>
<table id="contentTable" class="table table-striped table-bordered table-condensed table-nowrap">
    <thead>
    <tr>
        <th><input type="checkbox" id="checkbox_a1" class="chk_1" onchange="chooseAll(this)"/><label for="checkbox_a1"></label></th>
        <th>物料号</th>
        <th>物料名称（中文）</th>
        <th>物料名称（英文）</th>
        <th>描述</th>
        <th>物料分类</th>
        <th>货币单位</th>
        <th>物料单价</th>
        <th>备注</th>
        <th>物料状态</th>
        <th>审批状态</th>
        <th>更新时间</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${matrInfoList}" var="t01MatrInfo" varStatus = "countm">
        <tr>
            <td><input id="checkbox_a${countm.index+1}" class="chk_1"  type="checkbox" onchange="checkAll()" data-id="${t01MatrInfo.id}"/><label for="checkbox_a${countm.index+1}"></label></td>
            <td class="hoverChange ${t01MatrInfo.martStat=='2'?'highlight2':''} ">
                <a class="${t01MatrInfo.martStat=='2'?'highlight2':''} "
                   target="_blank" href="${ctx}/gsp/t01matrinfo/t01MatrInfo/toDetail?id=${t01MatrInfo.id}">
                        ${t01MatrInfo.matrNbr}
                </a></td>
            <td>
                    ${t01MatrInfo.matrNmCn}
            </td>
            <td>
                    ${t01MatrInfo.matrNmEn}
            </td>
            <td>
                    ${t01MatrInfo.matrDesc}
            </td>
            <td>
                    ${fns:getDictLabel(t01MatrInfo.matrType, 't01_matr_info_matr_type', '')}
            </td>
            <td>
                    ${t01MatrInfo.priceUnit}
            </td>
            <td>
                    ${t01MatrInfo.matrPrice}
            </td>
            <td>
                    ${t01MatrInfo.remarks}
            </td>
            <td ${t01MatrInfo.martStat=='2'?'class="bgLight2"':''}>
                    ${fns:getDictLabel(t01MatrInfo.martStat, 't01_matr_info_mart_stat', '')}
            </td>
            <td>
                    ${fns:getDictLabel(t01MatrInfo.apprStat, 't01_matr_info_appr_stat', '')}
            </td>
            <td>
                <fmt:formatDate value="${t01MatrInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
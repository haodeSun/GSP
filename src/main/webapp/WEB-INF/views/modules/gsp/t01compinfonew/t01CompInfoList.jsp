<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>企业信息管理</title>
    <meta name="decorator" content="default"/>
    <script>
        $(document).ready(function(){
            setTableDefault("t01CompInfoNew","${ctx}/sys/user/getSysUserConfig");
            holdTable("t01CompInfoNew","${ctx}/sys/user/setSysUserConfig");
        })
        function exportThis(){

            var exportIds="";

            $('#contentTable tbody input[type="checkbox"]').each(function(){
                if(this.checked == true){
                    exportIds+=$(this).attr("data-id").trim()+",";
                }
            });
            $("#exportIds").val(exportIds);

            var exportUrl="${ctx}/gsp/t01compinfonew/t01CompInfoNew/export";

            var searchUrl= $("#searchForm").attr("action");
            $("#searchForm").attr("action", exportUrl);
            $("#searchForm").submit();
            $("#searchForm").attr("action", searchUrl);
        }

    </script>
</head>
<body>
<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>企业管理<span class="divider">&gt;</span></li>
    <li class="active">企业信息查询</li>
</ul>

<div id="topTitle">企业信息查询</div>
<!--20161113-->

<form:form id="searchForm" modelAttribute="t01CompInfoNew" action="${ctx}/gsp/t01compinfonew/t01CompInfoNew/"
           method="post" class="breadcrumb form-search">
    <input id="exportIds" name="ids" type="hidden">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="conditionOrder" name="conditionOrder" type="hidden" value="${conditionOrder}">
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <div id="foldList" class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
                折叠列表
            </a>
        </div>
        <div id="collapseOne" class="accordion-body collapse in">
            <div class="accordion-inner">
                <div id="selectGroup" class="accordion-group">
                    <span>查询条件</span>
                    <select name='' aria-required=true' class='form-control' id='querySelect'
                            style="width:200px;margin-left:15px;"></select>
                    <a id="addCondition" class="btn btn-primary"  onclick="addCondition()">添加条件</a>
                    <a id="emptyValue" class="btn btn-primary" onclick="emptyThisForm()">清空数值</a>
                    <a id="btnSubmit" class="btn btn-primary"  style="margin-left:40px;" onclick="submitThisForm()">查询</a>
                </div>
                <ul id="conditionOrderUl" class="ul-form">
                    <li style="display:block;"><label>企业名称（中文）：</label>
                        <form:input path="compNameCn" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>企业名称（英文）：</label>
                        <form:input path="compNameEn" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>简称：</label>
                        <form:input path="shortName" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>企业类型：</label>
                        <select name="buyerId" class="input-medium">
                            <option value="">请选择</option>
                            <option value="0">供货者</option>
                            <option value="1">购货者</option>
                            <option value="2">供货者和购货者</option>
                        </select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>成立日期：</label>
                        <input name="t01CompCert3.effecDateBg" type="text" readonly="readonly"
                               class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>有效期至：</label>
                        <input name="t01CompCert3.validDateEd" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>

                    <li style="display:none;"><label>企业状态：</label>
                        <form:select path="t01CompCert0.certStat" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>审批状态：</label>
                        <form:select path="apprStat" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('t01_matr_info_appr_stat')}" itemLabel="label"
                                          itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>最后操作时间：</label>
                        <input name="updateDateEd" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>描述：</label>
                        <form:input path="compDesc" htmlEscape="false" maxlength="1000" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>经营范围：</label>
                        <form:input path="t01CompCert0.certScop" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>境内/境外：</label>
                        <form:select path="abroad" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('abroad')}" itemLabel="label" itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>

                    <li style="display:none;"><label>统一社会信息代码：</label>
                        <form:input path="uniCretNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>注册证号：</label>
                        <form:input path="regiNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>组织机构代码证号：</label>
                        <form:input path="orgCertNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>税务登记证号：</label>
                        <form:input path="taxNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>企业唯一编码：</label>
                        <form:input path="compUniNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>备注：</label>
                        <form:input path="remarks" htmlEscape="false" maxlength="1000" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</form:form>
<sys:message content="${message}"/>
<shiro:hasPermission name="gsp:t01compinfo:t01CompInfo:edit">
    <a href="${ctx}/gsp/t01compinfonew/t01CompInfoNew/form"><span class="modifySpan newBtn btn btn-primary">新增</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01compinfo:t01CompInfo:edit">
    <a href="javascript:void(0)" onclick="toEdit()"><span class="modifySpan newBtn btn btn-primary">修改</span></a>
</shiro:hasPermission>
<shiro:hasPermission name="gsp:t01compinfo:t01CompInfo:edit">
    <a href="javascript:void(0)" onclick="toDelete()"><span class="modifySpan newBtn btn btn-primary">删除</span></a>
</shiro:hasPermission>
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
            <th>企业类型</th>
            <th>成立日期</th>
            <th>有效期至</th>
            <th>企业状态</th>
            <th>审批状态</th>
            <th>最后操作时间</th>
            <th>描述</th>
            <th>经营范围</th>
            <th>境内/境外</th>
            <th>统一社会信息代码</th>
            <th>注册号</th>
            <th>组织机构代码证号</th>
            <th>税务登记证号</th>
            <th>企业唯一编码</th>
            <th>备注</th>
            <th>附件</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="t01CompInfoNew" varStatus="status">

            <tr>
                <td><input id="checkbox_a${status.count+1}" class="chk_1" type="checkbox" onchange="checkAll()"
                           data-id="${t01CompInfoNew.id}"/><label for="checkbox_a${status.count+1}"></label></td>
                <td class="hoverChange">
                    <c:if test="${'0'==t01CompInfoNew.abroad}">
                    <a class=" ${t01CompInfoNew.t01CompCert0.certStat=='0' && t01CompInfoNew.apprStat=='2'?'highlight0':''}
                            ${t01CompInfoNew.t01CompCert0.certStat=='1' && t01CompInfoNew.apprStat=='2'?'highlight3':''}
                            ${t01CompInfoNew.t01CompCert0.certStat=='2' && t01CompInfoNew.apprStat=='2'?'highlight1':''}
                            ${t01CompInfoNew.t01CompCert0.certStat=='3' && t01CompInfoNew.apprStat=='2'?'highlight2':''} "
                       href="${ctx}/gsp/t01compinfonew/t01CompInfoNew/toDetail?id=${t01CompInfoNew.id}">
                            ${t01CompInfoNew.compNameCn}
                    </a>
                    </c:if>
                    <c:if test="${'1'==t01CompInfoNew.abroad}">
                        <a class=" ${t01CompInfoNew.t01CompCert3.certStat=='0' && t01CompInfoNew.apprStat=='2'?'highlight0':''}
                            ${t01CompInfoNew.t01CompCert3.certStat=='1' && t01CompInfoNew.apprStat=='2'?'highlight3':''}
                            ${t01CompInfoNew.t01CompCert3.certStat=='2' && t01CompInfoNew.apprStat=='2'?'highlight1':''}
                            ${t01CompInfoNew.t01CompCert3.certStat=='3' && t01CompInfoNew.apprStat=='2'?'highlight2':''} "
                           href="${ctx}/gsp/t01compinfonew/t01CompInfoNew/toDetail?id=${t01CompInfoNew.id}">
                                ${t01CompInfoNew.compNameCn}
                        </a>
                    </c:if>
                </td>
                <td>
                        ${t01CompInfoNew.compNameEn}
                </td>
                <td>
                        ${t01CompInfoNew.shortName}
                </td>
                <td>
                    <c:if test="${ not empty t01CompInfoNew.buyerId}">
                        购货者
                    </c:if>
                    <c:if test="${ not empty t01CompInfoNew.buyerId && not empty t01CompInfoNew.suplId}">
                        ,
                    </c:if>
                    <c:if test="${ not empty t01CompInfoNew.suplId}">
                        供货者
                    </c:if>
                </td>
                <td>
                    <c:if test="${'0'==t01CompInfoNew.abroad}">
                        <fmt:formatDate value="${t01CompInfoNew.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                    <c:if test="${'1'==t01CompInfoNew.abroad}">
                        <fmt:formatDate value="${t01CompInfoNew.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                </td>
                <td>
                    <c:if test="${'0'==t01CompInfoNew.abroad}">
                        <fmt:formatDate value="${t01CompInfoNew.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                    <c:if test="${'1'==t01CompInfoNew.abroad}">
                        <fmt:formatDate value="${t01CompInfoNew.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>
                    </c:if>
                </td>
                <td>
                    <c:if test="${'0'==t01CompInfoNew.abroad}">
                        <span class="${t01CompInfoNew.t01CompCert0.certStat=='0' && t01CompInfoNew.apprStat=='2'?'bgLight0':''}
				${t01CompInfoNew.t01CompCert0.certStat=='1' && t01CompInfoNew.apprStat=='2'?'bgLight3':''}
				${t01CompInfoNew.t01CompCert0.certStat=='2' && t01CompInfoNew.apprStat=='2'?'bgLight1':''}
				${t01CompInfoNew.t01CompCert0.certStat=='3' && t01CompInfoNew.apprStat=='2'?'bgLight2':''} ">
                        ${fns:getDictLabel(t01CompInfoNew.t01CompCert0.certStat, 't01_certStat', '')}
                        </span>
                    </c:if>
                    <c:if test="${'1'==t01CompInfoNew.abroad}">
                    <span class="${t01CompInfoNew.t01CompCert3.certStat=='0' && t01CompInfoNew.apprStat=='2'?'bgLight0':''}
				${t01CompInfoNew.t01CompCert3.certStat=='1' && t01CompInfoNew.apprStat=='2'?'bgLight3':''}
				${t01CompInfoNew.t01CompCert3.certStat=='2' && t01CompInfoNew.apprStat=='2'?'bgLight1':''}
				${t01CompInfoNew.t01CompCert3.certStat=='3' && t01CompInfoNew.apprStat=='2'?'bgLight2':''} ">
                        ${fns:getDictLabel(t01CompInfoNew.t01CompCert3.certStat, 't01_certStat', '')}
                    </span>
                    </c:if>
                </td>
                <td>
                        ${fns:getDictLabel(t01CompInfoNew.apprStat, 't01_matr_info_appr_stat', '')}
                </td>
                <td>
                    <fmt:formatDate value="${t01CompInfoNew.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                        ${t01CompInfoNew.compDesc}
                </td>
                <td>
                    <c:if test="${'0'==t01CompInfoNew.abroad}">
                        ${t01CompInfoNew.t01CompCert0.certScop}
                    </c:if>
                    <c:if test="${'1'==t01CompInfoNew.abroad}">
                        ${t01CompInfoNew.t01CompCert3.certScop}
                    </c:if>
                </td>
                <td>
                        ${fns:getDictLabel(t01CompInfoNew.abroad, 'abroad', '')}
                </td>
                <td>
                        ${t01CompInfoNew.uniCretNbr}
                </td>
                <td>
                        ${t01CompInfoNew.regiNbr}
                </td>
                <td>
                        ${t01CompInfoNew.orgCertNbr}
                </td>
                <td>
                        ${t01CompInfoNew.taxNbr}
                </td>
                <td>
                        ${t01CompInfoNew.compUniNbr}
                </td>
                <td>
                        ${t01CompInfoNew.remarks}
                </td>
                <td>
                    <c:if test="${'0'==t01CompInfoNew.abroad}">
                        ${fns:getAttachCount(t01CompInfoNew.t01CompCert0.attachment)}
                    </c:if>
                    <c:if test="${'1'==t01CompInfoNew.abroad}">
                        ${fns:getAttachCount(t01CompInfoNew.t01CompCert3.attachment)}
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination">${page}</div>

<script>
    function toEdit() {
        oneDataEdit(function (id) {
            var checkUrl = "${ctx}/gsp/t01compinfonew/t01CompInfoNew/checkStatusBeforeHandle";
            var editUrl = "${ctx}/gsp/t01compinfonew/t01CompInfoNew/form";
            baseEditFunction(checkUrl, id, editUrl);
        })
    }
    function toDelete() {
        oneDataDelete(function (id) {
            var checkUrl = "${ctx}/gsp/t01compinfonew/t01CompInfoNew/checkStatusBeforeHandle";
            var deleteUrl = "${ctx}/gsp/t01compinfonew/t01CompInfoNew/delete";
            baseDeleteFunction(checkUrl, id, deleteUrl);
        })
    }
</script>
</body>
</html>
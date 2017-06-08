<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>企业相关协议信息管理</title>
    <meta name="decorator" content="default"/>
    <style>
        .contentTable tr th {
            -webkit-box-sizing: border-box;
            background-image:none;
            background:#1fb5ac;
            height:40px;
            font-size:12px;
            font-weight:bold;
            color:#ffffff;
            text-align:center;
            vertical-align: middle;
            white-space: nowrap;
        }
        .contentTable tr td {
            -webkit-box-sizing: border-box;
            height:40px;
            font-size:12px;
            color:#3c3c3c;
            text-align:center;
            white-space: nowrap;
        }
        .input-append a.btn {
            margin-left:-80px;
        }
    </style>
    <script>
        $(document).ready(function () {

            onTypeChanged("${t01CompAggr.aggrType}");
        });
        function onTypeChanged(value){
            switch(value){
                case "0":
                    $('#supplier-group').show();
                    $('#supplier').prop('disabled', false);
                    $('#buyer-group').hide();
                    $('#buyerId').prop('disabled', true);
                    break;
                case "1":
                    $('#supplier-group').hide();
                    $('#supplier').prop('disabled', true);
                    $('#buyer-group').show();
                    $('#buyerId').prop('disabled', false);
                    break;
            }
        }
    </script>
</head>

<body>


<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>协议管理<span class="divider">&gt;</span></li>
    <li class="active">协议管理详情</li>
</ul>

<div id="topTitle">协议管理详情</div>

<form:form id="inputForm" modelAttribute="t01CompAggr" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div id="pagingDiv" class="table-scrollable">
        <ul class="nav nav-tabs" role="tablist">
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class=
                    "tab-pane fade in active" id="p0">

                <div class="control-group">
                    <label class="control-label"> 协议类别：</label>
                    <div class="controls">
                        <form:select disabled="true" path="aggrType" class="input-xlarge required" onchange="onTypeChanged(value)">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_comp_aggr_type')}"
                                          itemLabel="label"
                                          itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>

                <div id="supplier-group" class="control-group" style="display: none">
                    <label class="control-label"> 供货者：</label>
                    <div class="controls">
                        <input type="text" disabled="disabled" value="${fns:getEntityById("t01ComplSuplService", t01CompAggr.supplier.id).t01CompInfo.compNameCn}" >
                    </div>
                </div>


                <div id="buyer-group" class="control-group">
                    <label class="control-label"> 购货者：</label>
                    <div class="controls">
                        <input type="text" disabled="disabled" value="${fns:getEntityById("t01ComplSuplService", t01CompAggr.buyer.id).t01CompInfo.compNameCn}" >
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 协议编号：</label>
                    <div class="controls">
                        <form:input disabled="true" path="agreementNo" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                    </div>
                </div>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">--%>
                        <%--&lt;%&ndash;<span class="help-inline"><font color="red">*</font> </span>&ndash;%&gt;--%>
                        <%--上级协议：</label>--%>
                    <%--<div class="controls">--%>
                        <%--&lt;%&ndash;<form:input path="aggrId" htmlEscape="false" maxlength="128"&ndash;%&gt;--%>
                                    <%--&lt;%&ndash;class="input-xlarge required"/>&ndash;%&gt;--%>
                        <%--<sys:treeselect id="parentAgreement" name="parentAgreement.id" value="${t01CompAggr.parentAgreement.id}" labelName="parentAgreement.agreementNo" labelValue="${t01CompAggr.parentAgreement.agreementNo}"--%>
                                        <%--title="上级协议" url="/gsp/t01compaggr/t01CompAggr/get-all-agreements" cssClass="required"/>--%>
                    <%--</div>--%>
                <%--</div>--%>


                <div class="control-group">
                    <label class="control-label"> 授权人：</label>
                    <div class="controls">
                        <form:input disabled="true" path="author" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 地址信息：</label>
                    <div class="controls">
                        <form:input disabled="true" path="location" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                    </div>
                </div>



                <div class="control-group">
                    <label class="control-label"> 经营范围：</label>
                    <div class="controls">
                        <form:input disabled="true" path="aggrScop" htmlEscape="false"
                                    maxlength="1000" class="input-xlarge "/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 生产范围：</label>
                    <div class="controls">
                        <form:input disabled="true" path="prodScop" htmlEscape="false"
                                    maxlength="1000" class="input-xlarge "/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 生产企业：</label>
                    <div class="controls">
                        <form:input disabled="true" path="prodComp" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 协议金额：</label>
                    <div class="controls">
                        <form:input disabled="true" path="aggrAmnt" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"> 协议说明：</label>
                    <div class="controls">
                        <form:input disabled="true" path="explain" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"> 生效日期：</label>
                    <div class="controls">
                        <input disabled="disabled" name="effecDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium Wdate required"
                               value="<fmt:formatDate value="${t01CompAggr.effecDate}" pattern="yyyy-MM-dd"/>"
                               />
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 有效期至：</label>
                    <div class="controls">
                        <input disabled="disabled" name="validDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium Wdate required"
                               value="<fmt:formatDate value="${t01CompAggr.validDate}" pattern="yyyy-MM-dd"/>"
                               />
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 附件：</label>
                    <div class="controls" style="height:auto">
                            ${fns:getAttachLabel(t01CompAggr.attachment)}
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        协议状态：
                    </label>
                    <div class="controls">
                        <form:select path="aggrStat" class="input-xlarge required" disabled="true">
                            <form:option value="" label="" />
                            <form:options
                                    items="${fns:getDictList('t01_certStat')}"
                                    itemLabel="label" itemValue="value" htmlEscape="false" />
                        </form:select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        审批状态：
                    </label>
                    <div class="controls">
                        <form:select path="apprStat" class="input-xlarge required" disabled="true">
                            <form:option value="" label="" />
                            <form:options
                                    items="${fns:getDictList('t01_matr_info_appr_stat')}"
                                    itemLabel="label" itemValue="value" htmlEscape="false" />
                        </form:select>
                    </div>
                </div>

                <%--<div class="control-group">--%>
                    <%--<label class="control-label"> 备注信息：</label>--%>
                    <%--<div class="controls">--%>
                        <%--<form:textarea path="remarks" htmlEscape="false" rows="4"--%>
                                       <%--maxlength="512" class="input-xxlarge "/>--%>
                    <%--</div>--%>
                <%--</div>--%>

            </div>
        </div>
        <div class="control-group">
            <label class="control-label">关联物料：</label>
            <table id="matrInfoTable" class="table table-striped table-bordered table-condensed contentTable">
                <thead>
                <tr>
                    <th>物料号</th>
                    <th>注册证/备案凭证编号</th>
                    <th>产品名称（中文）</th>
                    <th>规格型号</th>
                    <th>单价</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${t01CompAggr.t01CompAggrRelateMatrInfoList}" var="t01CompAggrRelateMatrInfoList">
                    <tr>
                        <td style="display: none">
                            <input class="matrInfoID" type="hidden"  value="${t01CompAggrRelateMatrInfoList.id}">
                        </td>
                        <td>${t01CompAggrRelateMatrInfoList.matrNbr}</td>
                        <td>${t01CompAggrRelateMatrInfoList.regiCertNbr}</td>
                        <td>${t01CompAggrRelateMatrInfoList.matrNmCn}</td>
                        <td>${t01CompAggrRelateMatrInfoList.specType}</td>
                        <td>
                            <input disabled="disabled"  value="${t01CompAggrRelateMatrInfoList.matrPrice}" type='text'  maxlength='128' class='input-small '/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <%--<div class="controls">--%>
                <%--<table id="contentTable"--%>
                       <%--class="table table-striped table-bordered table-condensed">--%>
                    <%--<thead>--%>
                    <%--<tr>--%>
                        <%--<th class="hide"></th>--%>
                        <%--<th>物料</th>--%>
                        <%--<th>单价</th>--%>
                        <%--<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">--%>
                            <%--<th width="10">&nbsp;</th>--%>
                        <%--</shiro:hasPermission>--%>
                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody id="t01AggrMatrList">--%>
                    <%--</tbody>--%>
                    <%--<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit">--%>
                        <%--<tfoot>--%>
                        <%--<tr>--%>
                            <%--<td colspan="7"><a href="javascript:"--%>
                                               <%--onclick="addRow('#t01AggrMatrList', t01AggrMatrRowIdx, t01AggrMatrTpl);t01AggrMatrRowIdx = t01AggrMatrRowIdx + 1;"--%>
                                               <%--class="btn">新增</a></td>--%>
                        <%--</tr>--%>
                        <%--</tfoot>--%>
                    <%--</shiro:hasPermission>--%>
                <%--</table>--%>
                <%--<script type="text/template" id="t01AggrMatrTpl">//<!----%>
						<%--<tr id="t01AggrMatrList{{idx}}">--%>
							<%--<td class="hide">--%>
								<%--<input id="t01AggrMatrList{{idx}}_id" name="t01AggrMatrList[{{idx}}].id" type="hidden" value="{{row.id}}"/>--%>
								<%--<input id="t01AggrMatrList{{idx}}_delFlag" name="t01AggrMatrList[{{idx}}].delFlag" type="hidden" value="0"/>--%>
							<%--</td>--%>
							<%--<td>--%>
                                <%--<sys:treeselect id="t01AggrMatrList{{idx}}_matr"--%>
                                                <%--name="t01AggrMatrList{{idx}}_matr"--%>
                                                <%--value="{{row.matr.matrNmCn}}"--%>
                                                <%--labelName="row.matr.matrNmCn"--%>
                                                <%--labelValue="{{row.matr.matrNmCn}}"--%>
                                                <%--title="物料信息"--%>
                                                <%--url="/gsp/t01matrinfo/t01MatrInfo/get-all-matr"--%>
                                                <%--cssClass="required"/>--%>
							<%--</td>--%>
							<%--<td>--%>
								<%--<input id="t01AggrMatrList{{idx}}_price" name="t01AggrMatrList[{{idx}}].price" type="text" value="{{row.price}}" maxlength="128" class="input-small "/>--%>
							<%--</td>--%>
							<%--<shiro:hasPermission name="gsp:t01compaggr:t01CompAggr:edit"><td class="text-center" width="10">--%>
								<%--{{#delBtn}}<span class="close" onclick="delRow(this, '#t01AggrMatrList{{idx}}')" title="删除">&times;</span>{{/delBtn}}--%>
							<%--</td></shiro:hasPermission>--%>
						<%--</tr>//-->--%>
                <%--</script>--%>
                <%--<script type="text/javascript">--%>
                    <%--var t01AggrMatrRowIdx = 0, t01AggrMatrTpl = $("#t01AggrMatrTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g, "");--%>
                    <%--$(document).ready(function () {--%>
                        <%--var data = ${fns:toJson(t01CompAggr.t01AggrMatrList)};--%>
                        <%--for (var i = 0; i < data.length; i++) {--%>
                            <%--addRow('#t01AggrMatrList', t01AggrMatrRowIdx, t01AggrMatrTpl, data[i]);--%>
                            <%--t01AggrMatrRowIdx = t01AggrMatrRowIdx + 1;--%>
                        <%--}--%>
                    <%--});--%>
                <%--</script>--%>
            <%--</div>--%>
        </div>
    </div>

    <div id="footBtnDiv" class="form-actions">
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" />
    </div>
</form:form>
</body>
</html>
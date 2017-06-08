<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>产品资质管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        var id = "";
        $(document).ready(function () {
            var totalNum = 0;
            for (var j = 1, listInputLen = $("#contentTable").find("tr").length; j < listInputLen; j++) {
                for (var i = 0, hiddenLen = $(".hideInput").length; i < hiddenLen; i++) {
                    if ($($($("#contentTable").find("tr")[j]).find("td")[0]).text().replace(/(^\s*)|(\s*$)/g, "") == $($(".hideInput")[i]).attr("name")) {
                        for (var k = 0, aLen = $($("#contentTable").find("tr")[j]).find("td:last").find("a").length; k < aLen; k++) {
                            if ($($($("#contentTable").find("tr")[j]).find("td:last").find("a")[k]).text() == "新增预警") {
                                $($($("#contentTable").find("tr")[j]).find("td:last").find("a")[k]).css({"display": "none"});
                            }
                        }
                        totalNum += 1;
                    }
                }
                if (totalNum == 0) {
                    for (var n = 0, aLen = $($("#contentTable").find("tr")[j]).find("td:last").find("a").length; n < aLen; n++) {
                        if ($($($("#contentTable").find("tr")[j]).find("td:last").find("a")[n]).text() == "查看预警") {
                            $($($("#contentTable").find("tr")[j]).find("td:last").find("a")[n]).css({"display": "none"});
                        }
                        else if ($($($("#contentTable").find("tr")[j]).find("td:last").find("a")[n]).text() == "修改预警") {
                            $($($("#contentTable").find("tr")[j]).find("td:last").find("a")[n]).css({"display": "none"});
                        }
                    }
                }
                else {
                    totalNum = 0
                }
            }
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function modalWarning(obj) {
            id = $($(obj).parent().siblings()[0]).text().replace(/(^\s*)|(\s*$)/g, "");
            if ($(obj).text() == "查看预警") {
                var numValue = $($(obj).parent().siblings()[3]).text().replace(/(^\s*)|(\s*$)/g, "");
                var numValueHide = $($(obj).parent().siblings()[0]).text().replace(/(^\s*)|(\s*$)/g, "");
                var dataValue = "";
                for (var i = 0, hiddenLen = $(".hideInput").length; i < hiddenLen; i++) {
                    if ($($(".hideInput")[i]).attr("name") == numValueHide) {
                        dataValue = $($(".hideInput")[i]).val();
                    }
                }
                $("#myModalLabel").text("查看预警");
                $("#modalBody").html('<div><label>资质证号</label><input disabled="disabled" id="checkWarning" name="" type="hidden" maxlength="100" value=' + numValueHide + '><input disabled="disabled"  name="" type="text" maxlength="100" value=' + numValue + '></div><div><label>有效期前</label><input disabled="disabled" id="checkData" name="" type="text" maxlength="100" value=' + dataValue + '><label>月</label></div>');
                $("#saveModal").css({"display": "none"});
                $('#myModal').modal('toggle');
            }
            else if ($(obj).text() == "新增预警") {
                var numAddValue = $($(obj).parent().siblings()[3]).text().replace(/(^\s*)|(\s*$)/g, "");
                var numAddValueHide = $($(obj).parent().siblings()[0]).text().replace(/(^\s*)|(\s*$)/g, "");
                var content = $($(obj).parent().siblings()[3]).text().replace(/(^\s*)|(\s*$)/g, "");
                $("#myModalLabel").text("新增预警");
                $("#modalBody").html('<div><label>资质证号</label><input readonly="readonly" id="addWarning" name="" type="hidden" maxlength="100" value=' + numAddValueHide + '><input readonly="readonly" name="" type="text" maxlength="100" value=' + numAddValue + '></div><div><label>有效期前</label><input id="addData" name="" type="text" maxlength="100"><label>月</label></div>');
                $("#saveModal").css({"display": "inline-block"});
                $('#myModal').modal('toggle');
            }
            else {
                var numChangeValue = $($(obj).parent().siblings()[3]).text().replace(/(^\s*)|(\s*$)/g, "");
                var numChangeValueHide = $($(obj).parent().siblings()[0]).text().replace(/(^\s*)|(\s*$)/g, "");
                $("#myModalLabel").text("修改预警");
                $("#modalBody").html('<div><label>资质证号</label><input readonly="readonly" id="changeWarning" name="" type="hidden" maxlength="100" value=' + numChangeValueHide + '><input readonly="readonly" name="" type="text" maxlength="100" value=' + numChangeValue + '></div><div><label>有效期前</label><input id="changeData" name="" type="text" maxlength="100"><label>月</label></div>');
                $("#saveModal").css({"display": "inline-block"});
                $('#myModal').modal('toggle');
            }
        }
        function saveThisModal() {
            console.log($("#myModalLabel").text());
            if ($("#myModalLabel").text() == "新增预警") {
                var addNameValue = $("#addWarning").val();
                var addValue = $("#addData").val();
                $.ajax({
                    url: "../../sysalarm/sysAlarm/api/save",
                    type: "post",
                    data: {id: id, toTime: addValue},
                    success: function (data) {
                        if (data == "OK") {
                            $(".hideInput").append('<input type="hidden" class="hideInput" name=' + addNameValue + ' value=' + addValue + '>');
                            for (var i = 1, trLen = $("#contentTable").find("tr").length; i < trLen; i++) {
                                if ($($($("#contentTable").find("tr")[i]).find("td")[0]).text().replace(/(^\s*)|(\s*$)/g, "") == addNameValue) {
                                    for (var k = 0, aLen = $($("#contentTable").find("tr")[i]).find("td:last").find("a").length; k < aLen; k++) {
                                        if ($($($("#contentTable").find("tr")[i]).find("td:last").find("a")[k]).text() == "新增预警") {
                                            $($($("#contentTable").find("tr")[i]).find("td:last").find("a")[k]).css({"display": "none"});
                                        }
                                        else {
                                            $($($("#contentTable").find("tr")[i]).find("td:last").find("a")[k]).css({"display": "inline-block"});
                                        }
                                    }
                                }
                            }
                            alert("新增预警成功");
                        }
                    }, error: function () {
                        alert("预警保存失败");
                    }
                });
            }
            else if ($("#myModalLabel").text() == "修改预警") {
                var changeNameValue = $("#changeWarning").val();
                var changeValue = $("#changeData").val();
                $.ajax({
                    url: "../../sysalarm/sysAlarm/api/save",
                    type: "post",
                    data: {id: id, toTime: changeValue},
                    success: function (data) {
                        if (data == "OK") {
                            for (var i = 0, inputLen = $(".hideInput").length; i < inputLen; i++) {
                                if ($($(".hideInput")[i]).attr("name") == changeNameValue) {
                                    $($(".hideInput")[i]).val(changeValue);
                                }
                            }
                            alert("修改预警成功");
                        }
                    }, error: function () {
                        alert("预警保存失败");
                    }
                });
            }
            $('#myModal').modal('toggle');
        }

        /**
         * 需要套模板
         */
        function exportThis(){
            top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
                if(v=="ok"){
                    $("#searchForm").attr("action","${ctx}/gsp/t01prodcert/t01ProdCert/export");
                    $("#searchForm").submit();
                }
                $("#searchForm").attr("action","${ctx}/gsp/t01prodcert/t01ProdCert/list");
            },{buttonsFocus:1});
            top.$('.jbox-body .jbox-icon').css('top','55px');
        }

    </script>
</head>
<body>
<!-- 面包屑导航（文字以及链接应换为变量）  -->
<ul class="breadcrumb">
    <li><a href="#">首页</a> <span class="divider">/</span></li>
    <li><a href="#">首营产品</a> <span class="divider">/</span></li>
    <li class="active">产品资质预警</li>
</ul>
<!-- 每页的title（文字换为变量） -->
<div id="topTitle">产品资质预警</div>
<!-- 查询条件下拉部分（id要加上） -->

<form:form id="searchForm" modelAttribute="t01ProdCert" action="${ctx}/gsp/t01prodcert/t01ProdCert/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <!---折叠列表-->
    <div id="foldList" class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
                折叠列表
            </a>
        </div>
        <div class="accordion-group" id="selectGroup">
		    <span>查询条件</span>
		    <select name='' aria-required=true' class='form-control' id='querySelect'
		            style="width:200px;margin-left:15px;"></select>
		    <a id="addCondition" class="btn btn-primary" style="margin-left:40px;" onclick="addCondition()">添加条件</a>
		    <a id="emptyValue" class="btn btn-primary" onclick="emptyThisForm()">清空数值</a>
		</div>
        <div id="collapseOne" class="accordion-body collapse in">
            <div class="accordion-inner">
                <!---折叠列表-->
                <ul class="ul-form">
                    <li style="display:none;"><label>注册证/备案凭证编号：</label>
                        <form:input path="regiCertNo" htmlEscape="false" maxlength="100" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span></li>
                    <li style="display:none;"><label>风险分类：</label>
                        <form:select path="riskClass" class="input-medium">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_riskClass')}" itemLabel="label"
                                          itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>技术分类-名称：</label>
                        <form:input path="techCateName" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>批准日期：</label>
                        <input name="dateOfAppr" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ProdCert.dateOfAppr}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                               />
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>有效期至：</label>
                        <input name="validPeri" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                               />
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>产品名称（中文)：</label>
                        <form:input path="prodNameCn" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>产品名称（原文)：</label>
                        <form:input path="prodNameOrig" htmlEscape="false" maxlength="100" class="input-medium"/>
                    </li>
                    <li style="display:none;"><label>型号规格：</label>
                        <form:input path="modelSpec" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>结构及组成：</label>
                        <form:input path="struAndComp" htmlEscape="false" maxlength="100" class="input-medium"/>
                    </li>
                    <li style="display:none;"><label>有效期：</label>
                        <form:input path="effiDate" htmlEscape="false" maxlength="100" class="input-medium"/>
                    </li>
                    <li style="display:none;"><label>储存条件：</label>
                        <form:input path="storCond" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>运输条件：</label>
                        <form:input path="tranCond" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>注册人/备案人名称：</label>
                        <form:input path="regPersName" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>注册人/备案人住所：</label>
                        <form:input path="regPersAddr" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>注册人/备案人联系方式：</label>
                        <form:input path="regPersCont" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>生产地址：</label>
                        <form:input path="prodAddr" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>代理人名称：</label>
                        <form:input path="agentName" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>代理人住所：</label>
                        <form:input path="agentAddr" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>代理人联系方式：</label>
                        <form:input path="agentCont" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>售后服务单位：</label>
                        <form:input path="saledServUnit" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>资质类型：</label>
                        <form:select path="qualType" class="input-medium">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_qualType')}" itemLabel="label" itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>审批状态：</label>
                        <form:input path="apprStatus" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>资质效力：</label>
                        <form:input path="qualEffe" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>原注册证/备案凭证编号：</label>
                        <form:input path="origRegCertNo" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>生效日期：</label>
                        <input name="effeDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                               />
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>审批意见：</label>
                        <form:input path="apprOpin" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>更新人：</label>
                        <form:input path="updateBy.id" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>更新时间：</label>
                        <input name="updateDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ProdCert.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                               />
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                    <li style="display:none;"><label>备注信息：</label>
                        <form:input path="remarks" htmlEscape="false" maxlength="100" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">删除</span>
                    </li>
                </ul>
            </div>
        </div>
    	<div class="submit-group clearfix">
    		<a id="btnSubmit" class="btn btn-primary pull-right" style="margin-left:40px;" onclick="submitThisForm()">查询</a>
    	</div>
    </div>
</form:form>
<sys:message content="${message}"/>
    <!-- 表单上部的按钮组，左侧的按键如修改、删除、审批的href的id值可以留空，前台会传入数据 (新的class：newBtn)-->
    <c:if test="${!requestScope.oaNotify.self}">
        <shiro:hasPermission name="oa:oaNotify:edit">
            <a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)"><span class="newBtn btn btn-primary">删除</span></a>
            <span class="newBtn btn btn-primary" onclick="printThis(this)">打印</span>
        </shiro:hasPermission>
    </c:if>
    <!-- 表单的列名称下拉项以及导出按钮 -->
    <span class="checkOut newBtn btn btn-primary" onclick="exportThis()">导出</span>
    <div id="columnNameDiv" class="btn-group">
        <a class="newBtn btn dropdown-toggle" data-toggle="dropdown" href="#">
            列名称<span class="caret"></span>
        </a>
        <ul id="columnName" class="dropdown-menu">
        </ul>
    </div>

    <!-- table中的th和td均在第一位加入了多选框 ,table外部多加了个div-->
    <div id="borderScroll" style="width:99%; overflow: auto;">
        <table id="contentTable" class="table table-striped table-bordered table-condensed">
            <thead>
            <tr>
                <th><input type="checkbox" onchange="chooseAll(this)"/></th>
                <th>注册证/备案凭证编号</th>
                <th>风险分类</th>
                <th>技术分类-名称</th>
                <th>批准日期</th>
                <th>有效期至</th>
                <th>产品名称（中文)</th>
                <th>产品名称（原文)</th>
                <th>型号规格</th>
                <th>结构及组成</th>
                <th>有效期</th>
                <th>储存条件</th>
                <th>运输条件</th>
                <th>注册人/备案人名称</th>
                <th>注册人/备案人住所</th>
                <th>注册人/备案人联系方式</th>
                <th>生产地址</th>
                <th>代理人名称</th>
                <th>代理人住所</th>
                <th>代理人联系方式</th>
                <th>售后服务单位</th>
                <th>资质类型</th>
                <th>审批状态</th>
                <th>资质效力</th>
                <th>原注册证/备案凭证编号</th>
                <th>生效日期</th>
                <th>审批意见</th>
                <th>更新人</th>
                <th>更新时间</th>
                <th>备注信息</th>
                <shiro:hasPermission name="gsp:t01prodcert:t01ProdCert:edit">
                    <th>操作</th>
                </shiro:hasPermission>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.list}" var="t01ProdCert">
                <tr>
                    <td><input type="checkbox" onchange="checkAll()"/></td>
                    <td><a href="${ctx}/gsp/t01prodcert/t01ProdCert/form?id=${t01ProdCert.id}">
                            ${t01ProdCert.regiCertNo}
                    </a>
                    </td>
                    <td>
                            ${t01ProdCert.riskClass}
                    </td>
                    <td>
                            ${t01ProdCert.techCateName}
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ProdCert.dateOfAppr}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                            ${t01ProdCert.prodNameCn}
                    </td>
                    <td>
                            ${t01ProdCert.prodNameOrig}
                    </td>
                    <td>
                            ${t01ProdCert.modelSpec}
                    </td>
                    <td>
                            ${t01ProdCert.struAndComp}
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
                            ${t01ProdCert.regPersName}
                    </td>
                    <td>
                            ${t01ProdCert.regPersAddr}
                    </td>
                    <td>
                            ${t01ProdCert.regPersCont}
                    </td>
                    <td>
                            ${t01ProdCert.prodAddr}
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
                            ${t01ProdCert.saledServUnit}
                    </td>
                    <td>
                            ${fns:getDictLabel(t01ProdCert.qualType, 't01_qualType', '')}
                    </td>
                    <td>
                            ${t01ProdCert.apprStatus}
                    </td>
                    <td>
                            ${t01ProdCert.qualEffe}
                    </td>
                    <td>
                            ${t01ProdCert.origRegCertNo}
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                            ${t01ProdCert.apprOpin}
                    </td>
                    <td>
                            ${t01ProdCert.updateBy.id}
                    </td>
                    <td>
                        <fmt:formatDate value="${t01ProdCert.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                            ${t01ProdCert.remarks}
                    </td>
                    <td>
                        <a onclick="modalWarning(this)" href="javascript:" role="button">查看预警</a>
                        <a onclick="modalWarning(this)" href="javascript:" role="button">新增预警</a>
                        <a onclick="modalWarning(this)" href="javascript:" role="button">修改预警</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
<input type="hidden" class="hideInput" name="3ebc101f0dab4583883057196bf98bab" value="test1"/>

<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">Modal header</h3>
    </div>
    <div class="modal-body" id="modalBody">
        <p>One fine body…</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
        <button class="btn btn-primary" id="saveModal" onclick="saveThisModal()" aria-hidden="true">保存</button>
    </div>
</div>
<div class="pagination">${page}</div>
</body>
</html>
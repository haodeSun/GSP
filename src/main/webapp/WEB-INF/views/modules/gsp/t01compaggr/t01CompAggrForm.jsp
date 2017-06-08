<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/treeview.jsp" %>
    <title>企业相关协议信息管理</title>
    <meta name="decorator" content="default"/>
    <style>
        .contentTable tr th {
            -webkit-box-sizing: border-box;
            background-image: none;
            background: #1fb5ac;
            height: 40px;
            font-size: 12px;
            font-weight: bold;
            color: #ffffff;
            text-align: center;
            vertical-align: middle;
            white-space: nowrap;
        }

        .contentTable tr td {
            -webkit-box-sizing: border-box;
            height: 40px;
            font-size: 12px;
            color: #3c3c3c;
            text-align: center;
            white-space: nowrap;
        }

        .input-append a.btn {
            margin-left: -80px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

            switch ("${t01CompAggr.aggrType}") {
                case "0":
                    $('#supplier-group').show();
                    $('#supplierId').prop('disabled', false);
                    $('#supplierName').prop('disabled', false);
                    $('#buyer-group').hide();
                    $('#buyerId').prop('disabled', true);
                    $('#buyerName').prop('disabled', true);
                    break;
                case "1":
                    $('#supplier-group').hide();
                    $('#supplierId').prop('disabled', true);
                    $('#supplierName').prop('disabled', true);
                    $('#buyer-group').show();
                    $('#buyerId').prop('disabled', false);
                    $('#buyerName').prop('disabled', false);
                    break;
            }
            jQuery.validator.addMethod("dateCheck", function (value, element) {
                var result = true;
                var eftDt = $("#effecDate").val() + "";
                var nvldDt = $("#validDate").val() + "";

                if (eftDt.length > 0 && nvldDt.length > 0) {
                    var d1 = new Date(eftDt.replace(/\-/g, "\/"));
                    var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
                    if (d1 > d2) {
                        result = false;
                    }
                }
                return this.optional(element) || result;
            }, "有效期至日期需晚于生效日期");
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                ignore: ".ignore",
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element.siblings("span:last"));
                    }
                }
            });
            $("#btnSubmit").click(function () {
                setCertScopIds()
                repalceIndex();
                ignoreSome()
                if (acceptAggrScop()) {
                    $("#inputForm").submit();
                } else {
                    alertx("请勾选协议范围承诺")
                }
            });
            $("#btnSubmitAndAppr").click(function () {
                setCertScopIds()
                repalceIndex();
                ignoreSome()
                $("#startAudit").val("startAudit");
                if (acceptAggrScop()) {
                    $("#inputForm").submit();
                } else {
                    alertx("请勾选协议范围承诺")
                }
            });
        });
        function setCertScopIds() {
            var tree = $.fn.zTree.getZTreeObj("certScopTree");
            var ids = [], nodes = tree.getCheckedNodes(true);
            for (var i = 0; i < nodes.length; i++) {
                ids.push(nodes[i].id);
            }
            $("#aggrScop").val(ids);
        }
        function ignoreSome() {
            $("div[style='display: none;'] .required").addClass("ignore");
            $(".control-group[style='display: none;'] .required").addClass("ignore");
        }
        function acceptAggrScop() {
            if ($("#checkScope").css("display") != "none") {
                return $("#acceptAggrScop").is(':checked');
            } else {
                return true;
            }
        }
        function repalceIndex() {
            var indexNum = 0;
            $("#matrInfoTable>tbody>tr").each(function () {
                $(this).find("input").each(function () {
                    $(this).attr("data-value", $(this).val())
                })
                $(this).html($(this).html().replace(/\{index\}/g, indexNum))
                indexNum++;
                $(this).find("input").each(function () {
                    $(this).val($(this).attr("data-value"))
                })
            });
            if (indexNum != 0) {
                $("#matrInfoCount").val(indexNum);
            }
        }

        function addRow(list, idx, tpl, row) {
            $(list).append(Mustache.render(tpl, {
                idx: idx, delBtn: true, row: row
            }));
            $(list + idx).find("select").each(function () {
                $(this).val($(this).attr("data-value"));
            });
            $(list + idx).find("input[type='checkbox'], input[type='radio']").each(function () {
                var ss = $(this).attr("data-value").split(',');
                for (var i = 0; i < ss.length; i++) {
                    if ($(this).val() == ss[i]) {
                        $(this).attr("checked", "checked");
                    }
                }
            });
        }
        function delRow(obj, prefix) {
            var id = $(prefix + "_id");
            var delFlag = $(prefix + "_delFlag");
            if (id.val() == "") {
                $(obj).parent().parent().remove();
            } else if (delFlag.val() == "0") {
                delFlag.val("1");
                $(obj).html("&divide;").attr("title", "撤销删除");
                $(obj).parent().parent().addClass("error");
            } else if (delFlag.val() == "1") {
                delFlag.val("0");
                $(obj).html("&times;").attr("title", "删除");
                $(obj).parent().parent().removeClass("error");
            }
        }
        function onTypeChanged(value) {
            $("#supplierId").val("")
            $("#supplierName").val("")
            $("#buyerId").val("")
            $("#buyerName").val("")
            resetScopes();
            switch (value) {
                case "0":
                    $('#supplier-group').show();
                    $('#supplierId').prop('disabled', false);
                    $('#supplierName').prop('disabled', false);
                    $('#buyer-group').hide();
                    $('#buyerId').prop('disabled', true);
                    $('#buyerName').prop('disabled', true);
                    break;
                case "1":
                    $('#supplier-group').hide();
                    $('#supplierId').prop('disabled', true);
                    $('#supplierName').prop('disabled', true);
                    $('#buyer-group').show();
                    $('#buyerId').prop('disabled', false);
                    $('#buyerName').prop('disabled', false);
                    break;
            }
        }
    </script>
</head>
<body>


<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>协议管理<span class="divider">&gt;</span></li>
    <li class="active">协议管理${not empty t01CompAggr.id?'修改':'新增'}</li>
</ul>

<div id="topTitle">协议管理${not empty t01CompAggr.id?'修改':'新增'}</div>

<form:form id="inputForm" modelAttribute="t01CompAggr"
           action="${ctx}/gsp/t01compaggr/t01CompAggr/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <input id="startAudit" name="startAudit" type="hidden" value="0">
    <sys:message content="${message}"/>
    <div id="pagingDiv" class="table-scrollable" style="background:#fff;">
        <ul class="nav nav-tabs" role="tablist">
        </ul>
        <div class="tab-content" style="background:transparent;">
            <div role="tabpanel" style="border-bottom:0px;" class=
                    "tab-pane fade in active" id="p0">

                <div class="control-group">
                    <label class="control-label"><span class="help-inline"><font color="red">*</font></span>
                        协议类别：</label>
                    <div class="controls">
                        <form:select path="aggrType" class="input-xlarge required" onchange="onTypeChanged(value)">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_comp_aggr_type')}"
                                          itemLabel="label"
                                          itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div id="supplier-group" class="control-group" style="display: none">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        供货者：</label>
                    <div class="controls">
                        <sys:treeselect id="supplier" name="supplier.id" value="${t01CompAggr.supplier.id}"
                                        labelName="supplier.t01CompInfo.name"
                                        labelValue="${t01CompAggr.supplier.t01CompInfo.compNameCn}"
                                        title="供货者" url="/gsp/t01complsupl/t01ComplSupl/get-all-suppliers"
                                        cssClass="required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div id="buyer-group" class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        购货者：</label>
                    <div class="controls">
                        <sys:treeselect id="buyer" name="buyer.id" value="${t01CompAggr.buyer.id}"
                                        labelName="buyer.t01CompInfo.name"
                                        labelValue="${t01CompAggr.buyer.t01CompInfo.compNameCn}"
                                        title="购货者" url="/gsp/t01complbuyer/t01ComplBuyer/get-all-buyers"
                                        cssClass="required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        协议编号：</label>
                    <div class="controls">
                        <form:input path="agreementNo" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
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
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        销售授权人：</label>
                    <div class="controls">
                        <select id="author" name="author" class="input-xlarge required">
                        </select>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        销售区域：</label>
                    <div class="controls">
                        <form:input path="location" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 协议范围：</label>
                    <div class="controls">
                        <div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>
                        <form:hidden path="aggrScop" maxlength="1000"/>
                    </div>
                </div>
                <div id="checkScope" class="control-group" style="display: none;">
                    <label class="control-label"> 协议范围承诺：</label>
                    <div class="controls">
                        <form:textarea path="prodScop" htmlEscape="false"
                                       maxlength="1000" class="input-xlarge "/>
                        <div>
                            <input id="acceptAggrScop" type="checkbox" style="width: 15px;"> 承诺此协议范围没超出供货及购货企业的资质范围
                        </div>
                            <%--<span class="promptPic"></span>--%>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"> 生产企业：</label>
                    <div class="controls">
                        <sys:treeselect id="prodComp" name="prodComp" value="${t01CompAggr.prodComp}" labelName=""
                                        labelValue="${t01CompAggr.prodComp}"
                                        title="生产企业" url="/gsp/t01compaggr/t01CompAggr/get-all-prodComps" cssClass=""/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 协议金额：</label>
                    <div class="controls">
                        <form:input path="aggrAmnt" htmlEscape="false" maxlength="250"
                                    class="input-xlarge number"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                    <%--<div class="control-group">--%>
                    <%--<label class="control-label"> 协议说明：</label>--%>
                    <%--<div class="controls">--%>
                    <%--<form:input path="explain" htmlEscape="false" maxlength="1000"--%>
                    <%--class="input-xlarge"/>--%>
                    <%--<span class="promptPic"></span>--%>
                    <%--</div>--%>
                    <%--</div>--%>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        生效日期：</label>
                    <div class="controls">
                        <input id="effecDate" name="effecDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required dateCheck"
                               value="<fmt:formatDate value="${t01CompAggr.effecDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        有效期至：</label>
                    <div class="controls">
                        <input id="validDate" name="validDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required dateCheck"
                               value="<fmt:formatDate value="${t01CompAggr.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 附件：</label>
                    <div class="controls" style="height:auto">
                        <c:if test="${not empty detail}">
                            ${fns:getAttachLabel(t01CompAggr.attachment)}
                        </c:if>
                        <c:if test="${empty detail}">
                            <form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
                                         class="input-xlarge required "/>
                            <sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01CompAggr/"
                                          selectMultiple="true"/>
                        </c:if>
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
        <div class="control-group" style=" border: 1px solid #e4e9ed; border-top:0px;">

            <div style="margin-bottom:10px;">
                <label class="control-label">
                    <span class="help-inline"><font color="red">*</font></span>
                    关联物料：
                </label>
                <input id="matrInfoCount" type="hidden" class="required">
                <input id="addMatrInfo" style="margin-left: 20px;" class="btn btn-primary btnSubmit" value="添加">
                <span class="promptPic"></span>
            </div>
            <table id="matrInfoTable" class="table table-striped table-bordered table-condensed contentTable">
                <thead>
                <tr>
                    <th>物料号</th>
                    <th>注册证/备案凭证编号</th>
                    <th>产品名称（中文）</th>
                    <th>规格型号</th>
                    <th>单价</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${t01CompAggr.t01CompAggrRelateMatrInfoList}" var="t01CompAggrRelateMatrInfoList">
                    <tr>
                        <td style="display: none">
                            <input class="matrInfoID" type="hidden" name="t01AggrMatrList[{index}].matr.id"
                                   value="${t01CompAggrRelateMatrInfoList.id}">
                        </td>
                        <td>${t01CompAggrRelateMatrInfoList.matrNbr}</td>
                        <td>${t01CompAggrRelateMatrInfoList.regiCertNbr}</td>
                        <td>${t01CompAggrRelateMatrInfoList.matrNmCn}</td>
                        <td>${t01CompAggrRelateMatrInfoList.specType}</td>
                        <td>
                            <input name='t01AggrMatrList[{index}].price'
                                   value="${t01CompAggrRelateMatrInfoList.matrPrice}" type='text' maxlength='128'
                                   class='input-small '/>
                        </td>
                        <td>
                            <span style="cursor: pointer;" onclick='deleteTr(this)'>删除</span>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${not empty detail}">
            <sys:operateHistory module="t01CompAggr" dataId="${t01CompAggr.id}"/>
        </c:if>
    </div>

    <div id="footBtnDiv" class="form-actions">
        <shiro:hasPermission name="gsp:t01matrinfo:t01MatrInfo:edit">
            <input id="btnSubmitAndAppr" class="btn btn-primary btnSubmit" value="提 交"/>&nbsp;</shiro:hasPermission>
        <shiro:hasPermission name="gsp:t01matrinfo:t01MatrInfo:edit">
            <input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button"
                   value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回"
               onclick="window.location='${ctx}/gsp/t01compaggr/t01CompAggr'"/>
    </div>
</form:form>
<c:if test="${not empty detail}">
    <sys:operateSave/>
</c:if>
<%@include file="Part_FormCommon.jsp" %>

<script>
    $(document).ready(function () {
        //经营范围数据展示 begin
        var setting = {
            check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
            data: {
                simpleData: {enable: true}
            },
            callback: {
                beforeClick: function (id, node) {
                    tree.checkNode(node, !node.checked, true, true);
                    return false;
                },
                <c:if test="${not empty detail}">
                beforeCheck: function () {
                    return false;
                }
                </c:if>
            }
        };

        // 用户-菜单
        var zNodes = [
                <c:forEach items="${certScopList}" var="menu">{
                id: "${menu.id}",
                pId: "${not empty menu.parent.id?menu.parent.id:0}",
                name: "${not empty menu.parent.id?menu.name:'权限列表'}"
            },
            </c:forEach>];
        // 初始化树结构
        var tree = $.fn.zTree.init($("#certScopTree"), setting, zNodes);
        // 不选择父节点
        tree.setting.check.chkboxType = {"Y": "ps", "N": "ps"};
        // 默认选择节点

        var ids = "${t01CompAggr.aggrScop}".split(",");
        for (var i = 0; i < ids.length; i++) {
            var node = tree.getNodeByParam("id", ids[i]);
            try {
                tree.checkNode(node, true, false);
            } catch (e) {
            }
        }
        // 默认展开全部节点
        tree.expandAll(true);
        //经营范围数据展示 end

        $("#agreementNo").change(function () {
            $.ajax({
                type: "post",
                dataType: "json",
                url: '${ctx}/gsp/t01compaggr/t01CompAggr/checkOnly',
                data: {agreementNo: $(this).val()},
                success: function (result) {
                    if (result.code == "100") {
                        alertx(result.message);
                    } else if (result.code == "101") {
                        alertx(result.message);
                    } else {
                        alertx(result.message);
                    }
                },
                error: function () {
                    alertx("请求服务器数据失败");
                }
            });
        });
        $("#author").change(function () {
            getScopes()
        });


        if ('1' == '${t01CompAggr.aggrType}') {
            buyerTreeselectCallBack();
        }
        if ('0' == '${t01CompAggr.aggrType}') {
            supplierTreeselectCallBack();
        }
        getScopes()

        <c:if test="${not empty detail}">
        $("input").attr("disabled", "disabled");
        $("select").attr("disabled", "disabled");
        $("textarea").attr("disabled", "disabled");
        $("#buyerButton").addClass("disabled")
        $("#supplierButton").addClass("disabled")
        $("#prodCompButton").addClass("disabled")
        $(".help-inline").hide();
        $("#btnSubmit").hide();
        $("#btnSubmitAndAppr").hide();
        $("#btnCancel").removeAttr("disabled")
        $("#operateSaveDiv *").removeAttr("disabled")
        $("#operateHistoryDiv *").removeAttr("disabled")
        </c:if>
    });
    function getScopes() {
        var aggrType = $("#aggrType").val();

        var salesCertId = $("#author").val();
        if ("" != aggrType && "" != salesCertId) {

            var sendData = {};
            sendData.salesCertId = salesCertId;
            if ("0" == aggrType) {
                sendData.supplierId = $("#supplierId").val()
            }
            if ("1" == aggrType) {
                sendData.buyerId = $("#buyerId").val()
            }


            $.ajax({
                async: false,
                type: "post",
                dataType: "json",
                url: '${ctx}/gsp/t01compaggr/t01CompAggr/getScopes',
                data: sendData,
                success: function (result) {
                    if (result.code == "100") {

                        $("#location").val(result.data.location);

                        if ("1" == result.data.showPromise) {
                            $("#checkScope").show();
                        }
                        if ("0" == result.data.showPromise) {
                            $("#checkScope").hide();


                            function filter(node) {
                                var certScopStr = "";

                                certScopStr += result.data.scope;

                                var limitCertScop = certScopStr.split(",");
                                for (var i = 0; i < limitCertScop.length; i++) {
                                    if (limitCertScop[i] == node.id) {
                                        return false;
                                    }
                                }
                                return true;
                            }

                            var treeObj = $.fn.zTree.getZTreeObj("certScopTree");
                            var nodes = treeObj.getNodesByFilter(filter); // 查找节点集合
                            for (var i = 0, l = nodes.length; i < l; i++) {
                                treeObj.setChkDisabled(nodes[i], true);
                            }
                        }
                    } else {
                        alertx(result.message);
                    }
                },
                error: function () {
                    alertx("请求服务器数据失败");
                    return null;
                }
            })
        }
    }


    function supplierTreeselectCallBack() {
        $.ajax({
            async: false,
            type: "post",
            dataType: "json",
            url: '${ctx}/gsp/t01compaggr/t01CompAggr/getSalesCertList',
            data: {
                supplierId: $("#supplierId").val()
            },
            success: function (result) {
                if (result.code == "100") {

                    setSalesCert(result.data.salesCertList);

                } else {
                    alertx(result.message);
                }
            },
            error: function () {
                alertx("请求服务器数据失败");
                return null;
            }
        })
    }
    function buyerTreeselectCallBack() {
        $.ajax({
            async: false,
            type: "post",
            dataType: "json",
            url: '${ctx}/gsp/t01compaggr/t01CompAggr/getSalesCertList',
            data: {
                buyerId: $("#buyerId").val()
            },
            success: function (result) {
                if (result.code == "100") {

                    setSalesCert(result.data.salesCertList);

                } else {
                    alertx(result.message);
                }
            },
            error: function () {
                alertx("请求服务器数据失败");
                return null;
            }
        })
    }
    function resetScopes() {

    }
    function setSalesCert(salesCertList) {
        var selectedId = '${t01CompAggr.author}'

        $("#author").html("")
        var first = '<option value=""></option>'
        $("#author").append(first);

        if (salesCertList != null && salesCertList.length > 0) {
            for (var i = 0; i < salesCertList.length; i++) {
                var template = '<option value="{value}"  {selected}  >{text}</option>'
                template = template.replace("{value}", salesCertList[i].id)
                template = template.replace("{text}", salesCertList[i].salesName)
                if ('' == selectedId) {
                    template = template.replace("{selected}", '')
                } else {
                    template = template.replace("{selected}", 'selected="selected"')
                }

                $("#author").append(template);
            }
            $("#author").select2()
        }
    }
</script>
</body>
</html>
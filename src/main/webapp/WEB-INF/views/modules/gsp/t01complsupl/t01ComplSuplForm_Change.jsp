<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>首营供货者管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
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
            top.$.jBox.tip.mess = 0;

            for (var j = 0, inputLen = $("#inputForm").find(".controls").length; j < inputLen; j++) {
                var inputId = '';
                if ($($("#inputForm").find(".controls")[j]).children("select").length != 0) {
                    inputId = $($("#inputForm").find(".controls")[j]).children("select").attr("name");
                }
                else {
                    inputId = $($("#inputForm").find(".controls")[j]).children().attr("name");
                }

                if ((inputId + "").indexOf("attachment") == -1
                        && inputId != "toggleCertNbr"
                        && inputId != "compNameCn"
                        && inputId != "compNameCn"
                        && inputId != "t01SalesCertIDs") {
                    $($("#inputForm").find(".controls")[j]).append('<span class="newBtnNoFloat btn btn-primary" onclick="changeAs(this)">变更为</span>');
                }

            }
            $(".changeDiv").find(".controls").find("span:last-child").remove();

            $("#btnSubmit").click(function () {
                setCertScopIds();
                changeValueHandler();
                if (checkChangeValue()) {
                    $("#saveChangeForm").submit();
                }
            });
            $("#btnSubmitAndAppr").click(function () {
                setCertScopIds();
                changeValueHandler();
                if (checkChangeValue()) {
                    $("#startAudit").val("startAudit");
                    $("#saveChangeForm").submit();
                }
            });

            //初始化
            initChange();
            function initChange() {
                $(".changeDiv").append($("#templateRemarkDiv").html());
            }

            //在保存前处理变更的值
            function changeValueHandler() {
                var arrCol = ["chanCol", "chanValue", "chanReason","remarks"];
                var namePrefix = $("#hideName").val();
                var inputTemplate = '<input type="hidden" name={0} value={1} >';
                $("#saveChangeForm div").html("");

                $(".changeDiv[style='display: block;']").each(function (index) {

                    var chanColName = namePrefix + "[" + index + "]." + arrCol[0];
                    var chanValueName = namePrefix + "[" + index + "]." + arrCol[1];
                    var chanReasonName = namePrefix + "[" + index + "]." + arrCol[2];
                    var remarksName = namePrefix + "[" + index + "]." + arrCol[3];

                    var chanColValue = $(this).find(".controls:first input:first").attr("name");

                    var inputItemChanCol = inputTemplate.replace("{0}", chanColName).replace("{1}", chanColValue);
                    var inputItemChanValue = inputTemplate.replace("{0}", chanValueName).replace("{1}", $(this).find(".controls:first input:first").val());
                    var inputItemChanReason = inputTemplate.replace("{0}", chanReasonName).replace("{1}", $(this).find(".remarkDiv:first input:first").val());
                    var inputItemRemarks = inputTemplate.replace("{0}", remarksName).replace("{1}", $(this).prev().find(".control-label:first").html().replace("：","").replace(":",""));

                    $("#saveChangeForm div").append(inputItemChanCol)
                    $("#saveChangeForm div").append(inputItemChanValue)
                    $("#saveChangeForm div").append(inputItemChanReason)
                    $("#saveChangeForm div").append(inputItemRemarks)

                })
            }

            function checkChangeValue() {
                var result = false;
                var changeInputs = $("#saveChangeForm div input");
                if (changeInputs == null || changeInputs.length <= 0) {
                    alertx("变更项不能为空")
                } else {
                    var allChangeValueIsNotEmpty = true;
                    $("#saveChangeForm div input[name$='chanValue']").each(function () {
                        if ($(this).val() == null || $(this).val() == "" || $(this).val().trim() == "") {
                            alertx("变更值不能为空")
                            allChangeValueIsNotEmpty = false;
                            return false;
                        }
                    })

                    if (allChangeValueIsNotEmpty) {
                        var chanClos = $("#saveChangeForm div input[name$='chanCol']");
                        chanClos.each(function () {
                            var prefix = $(this).attr("name").split(".")[0];
                            if ("t01CompInfo.abroad" == $(this).val()) {

                                var abroadChangeValue = $("#saveChangeForm div input[name='" + prefix + ".chanValue']").val();
                                //当变更为国内企业
                                if ("0" == abroadChangeValue) {
                                    if (checkMustChange("abroad0Div")) {
                                        result = true;
                                    } else {
                                        alertx("必须变更的值没有变更")
                                        return false;
                                    }
                                }
                                //当变更为国外企业
                                if ("1" == abroadChangeValue) {
                                    if (checkMustChange("abroad1Div")) {
                                        result = true;
                                    } else {
                                        alertx("必须变更的值没有变更")
                                        return false;
                                    }
                                }
                            } else {
                                result = true;
                            }
                        })
                    }
                }
                return result;
            }

            //检查必须变更的相
            function checkMustChange(divId) {
                var result = true;

                $("#" + divId + " .control-group:not(.changeDiv)").each(function () {
                    if ($(this).css("display") != "none") {
                        if ($(this).find(".control-label:first>.help-inline") != null) {
                            var nextDiv = $(this).next(".changeDiv");
                            if (nextDiv.css("display") == "none") {
                                result = false;
                                return false;
                            }
                        }
                    }
                })
                return result;
            }

            function setCertScopIds() {
                var ids = [], nodes = tree2.getCheckedNodes(true);
                for (var i = 0; i < nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#t01CompCert1\\.certScop:eq(1)").val(ids);

                var ids4 = [], nodes4 = tree4.getCheckedNodes(true);
                for (var i = 0; i < nodes4.length; i++) {
                    ids4.push(nodes4[i].id);
                }
                $("#t01CompCert2\\.certScop:eq(1)").val(ids4);
            }

            //经营范围数据展示 begin
            var setting = {
                check: {enable: true, nocheckInherit: true},
                view: {selectedMulti: false},
                data: {simpleData: {enable: true}},
                callback: {
                    beforeClick: function (id, node) {
                        tree.checkNode(node, !node.checked, true, true);
                        return false;
                    },
                    beforeCheck: function () {
                        return false;
                    }
                }
            };

            // 用户-菜单
            var zNodes = [
                    <c:forEach items="${t01ComplSupl.certScopList}" var="menu">{
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

            var ids = "${t01ComplSupl.t01CompCert1.certScop}".split(",");
            for (var i = 0; i < ids.length; i++) {
                var node = tree.getNodeByParam("id", ids[i]);
                try {
                    tree.checkNode(node, true, false);
                } catch (e) {
                }
            }
            // 默认展开全部节点
            tree.expandAll(true);

            var setting2 = {
                check: {enable: true, nocheckInherit: true},
                view: {selectedMulti: false},
                data: {simpleData: {enable: true}},
                callback: {
                    beforeClick: function (id, node) {
                        tree.checkNode(node, !node.checked, true, true);
                        return false;
                    }
                }
            };

            var tree2 = $.fn.zTree.init($("#certScopTree2"), setting2, zNodes);
            // 不选择父节点
            tree2.setting.check.chkboxType = {"Y": "ps", "N": "ps"};

            // 默认展开全部节点
            tree2.expandAll(true);
            //经营范围数据展示 end


            // 初始化树结构
            var tree3 = $.fn.zTree.init($("#certScop2Tree"), setting, zNodes);
            // 不选择父节点
            tree3.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
            // 默认选择节点

            var ids = "${t01ComplSupl.t01CompCert2.certScop}".split(",");
            for(var i=0; i<ids.length; i++) {
                var node = tree3.getNodeByParam("id", ids[i]);
                try{tree3.checkNode(node, true, false);}catch(e){}
            }
            // 默认展开全部节点
            tree3.expandAll(true);


            var tree4 = $.fn.zTree.init($("#certScop2Tree2"), setting2, zNodes);
            // 不选择父节点
            tree4.setting.check.chkboxType = {"Y": "ps", "N": "ps"};

            // 默认展开全部节点
            tree4.expandAll(true);
            //生产范围数据展示 end

            <c:if test="${not empty relate}">
            alertx("该企业信息已关联购货者，变更修改审批通过时会影响到购货者中的相关信息")
            </c:if>

        });

        function changeAs(obj) {
            var nextDiv = $(obj).parent().parent().next(".changeDiv");
            if ($(nextDiv).find(".controls:eq(0)").children("input").size() != 0) {
                $(nextDiv).find(".controls:eq(0)").css({"width": ($(nextDiv).prev().find(".controls").children(":eq(0)").width() + 12)});
            } else {
                $(nextDiv).find(".controls:eq(0)").css({"width": $(nextDiv).prev().find(".controls").children(":eq(0)").width()});
            }

            //当切换境内/境外时触发
            if ("1" == nextDiv.attr("data-abroad")) {
                if (nextDiv.css("display") == "none") {
                    nextDiv.css({"display": "block"});
                    if ("0" == nextDiv.find(".controls:first input:first").val()) {
                        abroad0Click();
                    }
                    if ("1" == nextDiv.find(".controls:first input:first").val()) {
                        abroad1Click();
                    }
                } else {
                    nextDiv.css({"display": "none"});
                    if ("0" == nextDiv.find(".controls:first input:first").val()) {
                        abroad1Click();
                    }
                    if ("1" == nextDiv.find(".controls:first input:first").val()) {
                        abroad0Click();
                    }
                }
            } else if ("1" == nextDiv.attr("data-certType")) {
                //当切换资质类型时触发
                if (nextDiv.css("display") == "none") {
                    nextDiv.css({"display": "block"});
                    disableCertType0();
                    disableCertType1();

                } else {
                    nextDiv.css({"display": "none"});
                    var oldCertType=$("#oldCertType").val();
                    if ("0" == oldCertType) {
                        enableCertType0()
                        disableCertType1();
                    }
                    if ("1" == oldCertType) {
                        enableCertType1()
                        disableCertType0();
                    }
                    if ("2" == oldCertType) {
                        enableCertType0()
                        enableCertType1()
                    }
                }
            } else {
                if (nextDiv.css("display") == "none") {
                    nextDiv.css({"display": "block"});
                    //清除修改变更时候的回显数据
                    nextDiv.find("input[type!='hidden']").val("");
                    nextDiv.find("select").val("");
                }
                else {
                    nextDiv.css({"display": "none"});
                }
            }
        }

    </script>
</head>
<body>
<div id="templateRemarkDiv" style="display: none;">
    <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
        <label class="control-label">备注：</label>
        <input type="text" class="input-xlarge" maxlength="250">
    </div>
</div>

<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>首营供货者<span class="divider">&gt;</span></li>
    <li class="active">首营供货者变更</li>
</ul>

<div id="topTitle">首营供货者变更</div>
<form id="saveChangeForm"
        <c:if test="${empty changeEdit }">
            action="${ctx}/gsp/t01complsupl/t01ComplSupl/saveChange"
        </c:if>
        <c:if test="${not empty changeEdit }">
            action="${ctx}/gsp/t01complsupl/t01ComplSupl/saveChangeEdit"
        </c:if>
      style="display: none;">
    <input name="id" value="${t01ComplSupl.id}">
    <input id="startAudit" name="startAudit" type="hidden" value="0">
    <div>

    </div>
</form>

<form:form id="inputForm" modelAttribute="t01ComplSupl" action="${ctx}/gsp/t01complsupl/t01ComplSupl/saveChange"
           method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="t01CompInfo.id"/>
    <form:hidden path="t01CompCert0.id"/>
    <form:hidden path="t01CompCert1.id"/>
    <form:hidden path="t01CompCert2.id"/>
    <input id="startAudit" name="startAudit" type="hidden" value="0">
    <sys:message content="${message}"/>
    <div id="pagingDiv" class="table-scrollable">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active">
                <a href="#p0" role="tab" data-toggle="tab"> 基本信息 </a>
            </li>
            <li role="presentation">
                <a href="#p1" role="tab" data-toggle="tab"> 营业执照 </a>
            </li>
            <li role="presentation">
                <a href="#p2" role="tab" data-toggle="tab"> 生产资质 </a>
            </li>
            <li role="presentation">
                <a href="#p3" role="tab" data-toggle="tab"> 经营资质 </a>
            </li>
            <li role="presentation">
                <a href="#p4" role="tab" data-toggle="tab"> 销售人员授权书 </a>
            </li>
            <li role="presentation">
                <a href="#p5" role="tab" data-toggle="tab"> 质量能力 </a>
            </li>
            <li role="presentation">
                <a href="#p6" role="tab" data-toggle="tab"> 其他证明文件 </a>
            </li>
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane fade in active" id="p0">

                <div class="control-group">
                    <label class="control-label">
											<span class="help-inline"><font
                                                    color="red">*</font> </span>
                        企业名称（中文）：</label>
                    <div class="controls">
                        <input id="compNameCn" name="compNameCn" type="text" class="input-xlarge "
                               value="${t01ComplSupl.t01CompInfo.compNameCn}">
                        <span class="promptPic"></span>
                        <button id="relateT01ComplBuyer" name="relateT01ComplBuyer" type="button"
                                class="newBtnNoFloat btn btn-primary">关联供货者
                        </button>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        企业名称（英文）：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.compNameEn" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.compNameEn" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        简称：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.shortName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.shortName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        描述：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.compDesc" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.compDesc" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        备注：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.remarks" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.remarks" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        境内/境外：
                    </label>
                    <div class="controls">
                        <input disabled="disabled"
                               <c:if test="${t01ComplSupl.t01CompInfo.abroad=='0'}">checked </c:if>
                               style="width: 30px;"
                               type="radio"
                               value="0"> 境内企业
                        <input disabled="disabled"
                               <c:if test="${t01ComplSupl.t01CompInfo.abroad=='1'}">checked </c:if>
                               style="width: 30px;"
                               type="radio"
                               value="1"> 境外企业
                    </div>
                </div>

                <div class="control-group changeDiv" data-abroad="1" style="display:none">
                    <input class="hideValue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv" style="display:inline-block; float:left; margin-left:20px;">
                        <c:if test="${t01ComplSupl.t01CompInfo.abroad=='1'}">
                            <input id="abroad0" checked
                                   style="width: 30px;"
                                   type="radio"
                                   name="t01CompInfo.abroad" value="0"> 境内企业
                        </c:if>
                        <c:if test="${t01ComplSupl.t01CompInfo.abroad=='0'}">
                            <input id="abroad1" checked
                                   style="width: 30px;"
                                   type="radio"
                                   name="t01CompInfo.abroad" value="1"> 境外企业
                        </c:if>
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <input id="oldCertType" type="hidden" class="required" value="${t01ComplSupl.certType}">
                        <input style="width: 30px;" disabled="disabled"
                        <c:if test="${'0'==t01ComplSupl.certType ||'2'==t01ComplSupl.certType}">
                               checked
                        </c:if>
                               type="checkbox"> 生产资质
                        <input style="width: 30px;" disabled="disabled"
                        <c:if test="${'1'==t01ComplSupl.certType ||'2'==t01ComplSupl.certType}">
                               checked
                        </c:if>
                               type="checkbox"> 经营资质
                    </div>
                </div>

                <div class="control-group changeDiv" data-certType="1" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv" style="display:inline-block; float:left; margin-left:20px;">
                        <input id="certType" type="hidden" name="certType" class="required"
                               value="${t01ComplSupl.certType}">
                        <input id="certType0" style="width: 30px;" type="checkbox"> 生产资质
                        <input id="certType1" style="width: 30px;" type="checkbox"> 经营资质
                    </div>
                </div>

            </div>

            <div role="tabpanel" class="tab-pane fade" id="p1">
                <div id="abroad0Div">
                <c:if test="${empty t01ComplSupl.t01CompInfo.uniCretNbr}">
                    <div class="control-group">
                        <div class="controls">
                            <input id="toggleCertNbr" name="toggleCertNbr" type="checkbox" style="width: 30px;">
                            是否选择三证合一
                        </div>
                    </div>
                </c:if>
                <div class="control-group" <c:if
                        test="${empty t01ComplSupl.t01CompInfo.uniCretNbr}"> style="display: none;" </c:if>>
                    <label class="control-label">
                        统一社会信用代码：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.uniCretNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.uniCretNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <c:if test="${empty t01ComplSupl.t01CompInfo.uniCretNbr}">

                    <div class="control-group">
                        <label class="control-label">
                            注册号：
                        </label>
                        <div class="controls">
                            <form:input disabled="true" path="t01CompInfo.regiNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideVlue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <form:input path="t01CompInfo.regiNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge "/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            组织机构代码证号：
                        </label>
                        <div class="controls">
                            <form:input disabled="true" path="t01CompInfo.orgCertNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>
                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideVlue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <form:input path="t01CompInfo.orgCertNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge "/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            税务登记证号：
                        </label>
                        <div class="controls">
                            <form:input disabled="true" path="t01CompInfo.taxNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideVlue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <form:input path="t01CompInfo.taxNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge "/>
                        </div>
                    </div>

                </c:if>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        名称：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompCert0.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompCert0.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        经营范围：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompCert0.certScop" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompCert0.certScop" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        成立日期：
                    </label>
                    <div class="controls">
                        <input disabled="disabled" name="t01CompCert0.effecDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <input name="t01CompCert0.effecDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <%--<span class="promptPic"></span>--%>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        营业期限至：
                    </label>
                    <div class="controls">
                        <input disabled="disabled" name="t01CompCert0.validDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <input name="t01CompCert0.validDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <%--<span class="promptPic"></span>--%>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font></span>
                        营业执照上传：
                    </label>
                    <div class="controls">
                            ${fns:getAttachLabel(t01ComplSupl.t01CompCert0.attachment)}
                    </div>
                </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideValue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <form:hidden id="attachmentt01CompCert0" path="t01CompCert0.attachment" htmlEscape="false"
                                         maxlength="2048"
                                         class="input-xlarge required"/>
                            <sys:ckfinder input="attachmentt01CompCert0" type="files"
                                          uploadPath="/gsp/t01CompCert0"
                                          selectMultiple="true"/>
                        </div>
                    </div>

                </div>
                <div id="abroad1Div">

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            企业唯一编码：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompInfo.compUniNbr" disabled="true" htmlEscape="false" maxlength="250"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideValue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <form:input path="t01CompInfo.compUniNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge required"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            经营范围：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompCert3.certScop" disabled="true" htmlEscape="false" maxlength="1000"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideValue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <form:input path="t01CompCert3.certScop" htmlEscape="false" maxlength="1000"
                                        class="input-xlarge required"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            成立日期：
                        </label>
                        <div class="controls">
                            <input id="t01CompCert3.effecDate" disabled="disabled" name="t01CompCert3.effecDate"
                                   type="text"
                                   readonly="readonly" maxlength="20" class="input-medium datepicker required"
                                   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideValue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <input id="t01CompCert3.effecDate" name="t01CompCert3.effecDate"
                                   type="text"
                                   readonly="readonly" maxlength="20" class="input-medium datepicker required"
                                   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            营业期限至：
                        </label>
                        <div class="controls">
                            <input disabled="disabled" name="t01CompCert3.validDate"
                                   type="text"
                                   readonly="readonly" maxlength="20"
                                   class="input-medium datepicker required dateCheck0"
                                   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideValue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <input id="t01CompCert3.validDate" name="t01CompCert3.validDate"
                                   type="text"
                                   readonly="readonly" maxlength="20"
                                   class="input-medium datepicker required dateCheck0"
                                   value="<fmt:formatDate value="${t01ComplSupl.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font></span>
                            营业执照上传：
                        </label>
                        <div class="controls" id="t01CompCert3.attachment">
                                ${fns:getAttachLabel(t01ComplSupl.t01CompCert3.attachment)}
                        </div>
                    </div>

                    <div class="control-group changeDiv" style="display:none">
                        <input class="hideValue" type="hidden" value="">
                        <label class="control-label">变更为：</label>
                        <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                            <form:hidden id="attachmentt01CompCert3" path="t01CompCert3.attachment" htmlEscape="false"
                                         maxlength="2048"
                                         class="input-xlarge required"/>
                            <sys:ckfinder input="attachmentt01CompCert3" type="files"
                                          uploadPath="/gsp/t01CompCert3"
                                          selectMultiple="true"/>
                        </div>

                    </div>

                </div>

            </div>

            <div role="tabpanel" class="tab-pane fade" id="p2">

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        编号：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompCert2.certNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompCert2.certNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        企业名称：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompCert2.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompCert2.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        生产范围：
                    </label>
                    <div class="controls">
                        <form:hidden path="t01CompCert2.certScop" maxlength="1000" class="required"/>
                        <div id="certScop2Tree" class="ztree" style="margin-top:3px;float:left;"></div>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">

                        <form:hidden path="t01CompCert2.certScop" maxlength="1000" class="required"/>
                        <div id="certScop2Tree2" class="ztree" style="margin-top:3px;float:left;"></div>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        发证日期：
                    </label>
                    <div class="controls">
                        <input disabled="disabled" name="t01CompCert2.effecDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.effecDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <input name="t01CompCert2.effecDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.effecDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        有效期至：
                    </label>
                    <div class="controls">
                        <input disabled="disabled" name="t01CompCert2.validDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <input name="t01CompCert2.validDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert2.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font></span>
                        生产资质上传：
                    </label>
                    <div class="controls">
                            ${fns:getAttachLabel(t01ComplSupl.t01CompCert2.attachment)}
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideValue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:hidden id="attachmentt01CompCert2" path="t01CompCert2.attachment" htmlEscape="false"
                                     maxlength="2048"
                                     class="input-xlarge required"/>
                        <sys:ckfinder input="attachmentt01CompCert2" type="files" uploadPath="/gsp/t01CompCert2"
                                      selectMultiple="true"/>
                    </div>
                </div>


            </div>

            <div role="tabpanel" class="tab-pane fade" id="p3">

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        经营许可证号/备案凭证号：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        企业名称：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        经营方式：
                    </label>
                    <div class="controls">
                        <form:select disabled="true" path="t01CompInfo.busiMode" class="input-xlarge">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_busiMode')}"
                                          itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:select path="t01CompInfo.busiMode" class="input-xlarge">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_busiMode')}"
                                          itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        经营场所：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        库房地址：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.storLoca" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.storLoca" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        经营范围：
                    </label>
                    <div class="controls">
                        <form:hidden path="t01CompCert1.certScop" maxlength="1000" class="required"/>
                        <div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>

                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">

                        <form:hidden path="t01CompCert1.certScop" maxlength="1000" class="required"/>
                        <div id="certScopTree2" class="ztree" style="margin-top:3px;float:left;"></div>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        发证时间：
                    </label>
                    <div class="controls">
                        <input disabled="disabled" name="t01CompCert1.effecDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <input name="t01CompCert1.effecDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        有效期至：
                    </label>
                    <div class="controls">
                        <input disabled="disabled" name="t01CompCert1.validDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <input name="t01CompCert1.validDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01ComplSupl.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font></span>
                        经营资质上传：
                    </label>
                    <div class="controls">
                            ${fns:getAttachLabel(t01ComplSupl.t01CompCert1.attachment)}
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideValue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:hidden id="attachmentt01CompCert1" path="t01CompCert1.attachment" htmlEscape="false"
                                     maxlength="2048"
                                     class="input-xlarge required"/>
                        <sys:ckfinder input="attachmentt01CompCert1" type="files" uploadPath="/gsp/t01CompCert1"
                                      selectMultiple="true"/>
                    </div>
                </div>

            </div>

            <div role="tabpanel" class="tab-pane fade" id="p4">

                <div id="borderScroll" style="width:100%; overflow: auto;">
                    <div class="controls" style="display: none;">
                        <input type="hidden" name="t01SalesCertIDs">
                    </div>
                    <table class="table table-striped table-bordered table-condensed contentTable">
                        <thead>
                        <tr>
                            <th>销售人员姓名</th>
                            <th>证件号</th>
                            <th>授权产品范围</th>
                            <th>销售区域</th>
                            <th>生效日期</th>
                            <th>有效期至</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${t01ComplSupl.t01SalesCertList}" var="t01SalesCert">
                            <td>${t01SalesCert.salesName}</td>
                            <td>${t01SalesCert.idNbr}</td>
                            <td>${t01SalesCert.salesScop}</td>
                            <td>${t01SalesCert.salesArea}</td>
                            <td><fmt:formatDate value="${t01SalesCert.effecDate}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${t01SalesCert.validDate}" pattern="yyyy-MM-dd"/></td>
                        </c:forEach>
                        </tbody>
                    </table>
                    <%--<div>--%>
                        <%--<span class="newBtnNoFloat btn btn-primary" onclick="changeAs(this)">变更为</span>--%>
                    <%--</div>--%>
                </div>

                <%--<div class="control-group changeDiv" style="display:none">--%>
                    <%--<input class="hideVlue" type="hidden" value="">--%>

                    <%--<div>--%>
                        <%--<button id="addSalesCert" type="button" style="margin-top: 10px; margin-left: 20px;"--%>
                                <%--class="btn btn-primary btnSubmit">添加--%>
                        <%--</button>--%>
                    <%--</div>--%>
                    <%--<div id="borderScroll" style="width:100%; overflow: auto;">--%>
                        <%--<table id="salesCertTable"--%>
                               <%--class="table table-striped table-bordered table-condensed contentTable">--%>
                            <%--<thead>--%>
                            <%--<tr>--%>
                                <%--<th>销售人员姓名</th>--%>
                                <%--<th>证件号</th>--%>
                                <%--<th>授权产品范围</th>--%>
                                <%--<th>销售区域</th>--%>
                                <%--<th>生效日期</th>--%>
                                <%--<th>有效期至</th>--%>
                                <%--<th>操作</th>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                    <%--<div class="controls" style="display:none; float:left; margin-left:20px;">--%>
                        <%--<form:input path="t01SalesCertIDs" htmlEscape="false" maxlength="250"--%>
                                    <%--class="input-xlarge "/>--%>
                    <%--</div>--%>
                    <%--<div class="remarkDiv controls" style=" float:left; margin-left:24px;">--%>
                        <%--<label class="control-label">备注：</label>--%>
                        <%--<form:input path="t01SalesCertIDs" htmlEscape="false" maxlength="250"--%>
                                    <%--class="input-xlarge "/>--%>
                    <%--</div>--%>
                <%--</div>--%>
            </div>

            <div role="tabpanel" class="tab-pane fade" id="p5">
                <div class="control-group">
                    <label class="control-label">
                        生产能力评价：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.prodAbliEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.prodAbliEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        质量管理评价：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.qualMgrEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.qualMgrEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        仓储能力评价：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.storAbliEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.storAbliEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        交付能力评价：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.deliAbliEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.deliAbliEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        售后服务能力评价：
                    </label>
                    <div class="controls">
                        <form:input disabled="true" path="t01CompInfo.afteSaleAbliEval" htmlEscape="false"
                                    maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideVlue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:input path="t01CompInfo.afteSaleAbliEval" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                    </div>
                </div>

            </div>


            <div role="tabpanel" class="tab-pane fade" id="p6">

                <div class="control-group">
                    <label class="control-label">
                        其他附件：
                    </label>
                    <div class="controls">
                            ${fns:getAttachLabel(t01ComplSupl.attachment)}
                    </div>
                </div>

                <div class="control-group changeDiv" style="display:none">
                    <input class="hideValue" type="hidden" value="">
                    <label class="control-label">变更为：</label>
                    <div class="controls controlDiv1" style="display:inline-block; float:left; margin-left:20px;">
                        <form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
                                     class="input-xlarge required"/>
                        <sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01complsupl"
                                      selectMultiple="true"/>
                    </div>
                </div>

            </div>

        </div>
    </div>

    <div id="footBtnDiv" class="form-actions">

        <input id="btnSubmitAndAppr" class="btn btn-primary btnSubmit" value="提 交"/>&nbsp;

        <input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;"
               value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回"
               onclick="window.location='${ctx}/gsp/t01complsupl/t01ComplSupl'"/>
    </div>
</form:form>
<input id="hideName" type="hidden" value="sysChanInfoList">

<form id="relateT01ComplBuyerForm" style="display: none" action="${ctx}/gsp/t01complsupl/t01ComplSupl/formChange"
      method="post">
    <input id="relateT01ComplBuyerID" name="t01CompInfo.compNameCn" class="input-xlarge" type="hide" maxlength="250">
</form>
<%@include file="Part_FormCommon.jsp" %>
<script>
    $(document).ready(function () {

        $("#toggleCertNbr").click(function () {
            $("#p1>.control-group:lt(9):not(:first):not([class*='changeDiv'])").toggle("fade");
        });

        $("#relateT01ComplBuyer").click(function () {
            if ($("#compNameCn").val().trim().length > 0) {
                $("#relateT01ComplBuyerID").val($("#compNameCn").val());

                $("#relateT01ComplBuyerForm").submit();
            } else {
                alertx("请选择企业")
            }
        });

        <c:if test="${'0'== t01ComplSupl.t01CompInfo.abroad}">
        $("#abroad0Div").show();
        $("#abroad1Div").hide();
        </c:if>
        <c:if test="${'1'== t01ComplSupl.t01CompInfo.abroad}">
        $("#abroad1Div").show();
        $("#abroad0Div").hide();
        </c:if>

        <c:if test="${empty t01ComplSupl.id}">
        disableCertType0();
        disableCertType1();
        </c:if>
        <c:if test="${'0'== t01ComplSupl.certType}">
        disableCertType1();
        enableCertType0()
        </c:if>
        <c:if test="${'1'== t01ComplSupl.certType}">
        disableCertType0();
        enableCertType1()
        </c:if>
        <c:if test="${'2'== t01ComplSupl.certType}">
        enableCertType0()
        enableCertType1()
        </c:if>

        $("#certType0").click(function () {
            setCertTypeValue();
            if($(this).attr("checked")){
                enableCertType0()
            }else {
                disableCertType0();
            }
        })

        $("#certType1").click(function () {
            setCertTypeValue();
            if($(this).attr("checked")) {
                enableCertType1()
            }else {
                disableCertType1();
            }
        })

        <c:if test="${not empty changeEdit }">
        <!--***************************处理变更记录回显 Begin**********************************-->
        //拿到变更记录，并显示到页面
        var sysChanInfoList = ${fns:toJson(t01ComplSupl.sysChanInfoList)};
        var certType="";
        var abroad="";

        //遍历变更记录list，将变更过的记录显示到页面
        $.each(sysChanInfoList, function (index, value) {
            var col = value['chanCol'];
            var changeValue=value['chanValue'];
            //获取到当前字段下面的隐藏div
            var $hideNode = $("#" + col).parents('.control-group').next(".changeDiv:first");
            if ($hideNode.length === 0) {
                $hideNode = $("input[name='" + col + "']").parents('.changeDiv:first');
            }
            //显示
            $hideNode.css("display", "block");

            if ("certType" == col) {
                certType=changeValue;
            }
            if ("t01CompCert1.certScop" == col) {
                var ids = value['chanValue'].split(",");
                var tree2 = $.fn.zTree.getZTreeObj("certScop2Tree");
                for (var i = 0; i < ids.length; i++) {
                    var node = tree2.getNodeByParam("id", ids[i]);
                    try {
                        tree2.checkNode(node, true, false);
                    } catch (e) {
                    }
                }
                $("#" + col + ":eq(1)").parents('.changeDiv:first').css("display", "block");
            }
            if ("t01CompCert2.certScop" == col) {
                var ids = value['chanValue'].split(",");
                var tree4 = $.fn.zTree.getZTreeObj("certScop2Tree2");
                for (var i = 0; i < ids.length; i++) {
                    var node = tree4.getNodeByParam("id", ids[i]);
                    try {
                        tree4.checkNode(node, true, false);
                    } catch (e) {
                    }
                }
                $("#" + col + ":eq(1)").parents('.changeDiv:first').css("display", "block");
            }
            if("t01CompInfo.abroad"==col){
                abroad=changeValue;
            }

            //赋值
            $hideNode.find(".controls:first input:first").val(value['chanValue']);
            $hideNode.find(".remarkDiv:first input:first").val(value['chanReason']);

            if("t01CompCert0.attachment"==col){
                attachmentt01CompCert0Preview();
            }
            if("t01CompCert1.attachment"==col){
                attachmentt01CompCert1Preview();
            }
            if("t01CompCert3.attachment"==col){
                attachmentt01CompCert3Preview();
            }
            if("attachment"==col){
                attachmentPreview();
            }
        });
        if("0"==abroad){
            abroad0Click();
        }
        if("1"==abroad){
            abroad1Click()
        }
        if("0"==certType){
            $("#certType0").attr('checked', 'checked');
            setCertTypeValue();
            enableCertType0()
            disableCertType1();
        }
        if("1"==certType){
            $("#certType1").attr('checked', 'checked');
            setCertTypeValue();
            disableCertType0();
            enableCertType1()
        }
        if("2"==certType){
            $("#certType0").attr('checked', 'checked');
            $("#certType1").attr('checked', 'checked');
            setCertTypeValue();
            enableCertType0()
            enableCertType1()
        }

        <!--***************************处理变更记录回显 END**********************************-->
        </c:if>
    });
    function setCertTypeValue() {

        if($("#certType0").attr("checked")&&$("#certType1").attr("checked")){
            $("#certType").val("2")
        }else if($("#certType0").attr("checked")){
            $("#certType").val("0")
        }else if($("#certType1").attr("checked")){
            $("#certType").val("1")
        }else{
            $("#certType").val("")
        }
    }

    function disableCertType0() {
        $("a[href='#p2']").attr("data-toggle","tab disabled");
        $("a[href='#p2']").attr("style","background: #adacac;");
        $("a[href='#p2']").parent().attr("style","border-color: #adacac");
    }
    function enableCertType0() {
        $("a[href='#p2']").attr("data-toggle","tab");
        $("a[href='#p2']").removeAttr("style");
        $("a[href='#p2']").parent().removeAttr("style");
    }
    function disableCertType1() {
        $("a[href='#p3']").attr("data-toggle","tab disabled");
        $("a[href='#p3']").attr("style","background: #adacac;");
        $("a[href='#p3']").parent().attr("style","border-color: #adacac");
    }
    function enableCertType1() {
        $("a[href='#p3']").attr("data-toggle", "tab");
        $("a[href='#p3']").removeAttr("style");
        $("a[href='#p3']").parent().removeAttr("style");
    }
    function abroad0Click() {
        $("#abroad0Div").show();
        $("#abroad1Div").hide();
        $("#p2 .control-group:not(.changeDiv)").show();
        $("#p3 .control-group:not(.changeDiv)").show();
    }
    function abroad1Click() {
        $("#abroad0Div").hide();
        $("#abroad1Div").show();
        $("#p2 .changeDiv:not(:last)").css("display", "none");
        $("#p3 .changeDiv:not(:last)").css("display", "none");
        $("#p2 .control-group:not(.changeDiv):not(:last)").hide();
        $("#p3 .control-group:not(.changeDiv):not(:last)").hide();
    }
</script>
</body>
</html>
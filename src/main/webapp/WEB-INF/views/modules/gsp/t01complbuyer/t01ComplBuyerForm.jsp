<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>首营购货者管理</title>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/include/treeview.jsp" %>
    <style>
        .input-append a.btn {
            margin-left: -80px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            top.$.jBox.tip.mess = 0;
            $(".controls input").blur(function () {
                setTimeout('$("#messageBox").fadeOut("500")', 4000);
            });
            jQuery.validator.addMethod("dateCheck0", function (value, element) {
                var result = true;
                var eftDt = $("#t01CompCert0\\.effecDate").val() + "";
                var nvldDt = $("#t01CompCert0\\.validDate").val() + "";

                if (eftDt.length > 0 && nvldDt.length > 0) {
                    var d1 = new Date(eftDt.replace(/\-/g, "\/"));
                    var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
                    if (d1 > d2) {
                        result = false;
                    }
                }
                return this.optional(element) || result;
            }, "营业期限至日期需晚于成立日期");
            jQuery.validator.addMethod("dateCheck1", function (value, element) {
                var result = true;
                var eftDt = $("#t01CompCert1\\.effecDate").val() + "";
                var nvldDt = $("#t01CompCert1\\.validDate").val() + "";

                if (eftDt.length > 0 && nvldDt.length > 0) {
                    var d1 = new Date(eftDt.replace(/\-/g, "\/"));
                    var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
                    if (d1 > d2) {
                        result = false;
                    }
                }
                return this.optional(element) || result;
            }, "有效期至日期需晚于发证日期");
            jQuery.validator.addMethod("dateCheck4", function (value, element) {
                var result = true;
                var eftDt = $("#t01CompCert4\\.effecDate").val() + "";
                var nvldDt = $("#t01CompCert4\\.validDate").val() + "";

                if (eftDt.length > 0 && nvldDt.length > 0) {
                    var d1 = new Date(eftDt.replace(/\-/g, "\/"));
                    var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
                    if (d1 > d2) {
                        result = false;
                    }
                }
                return this.optional(element) || result;
            }, "有效期至日期需晚于发证日期");


            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                ignore: ".ignore",
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    setTimeout('$("#messageBox").fadeOut("500")', 4000);
                    $("#errorInfo").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element.siblings("span:last"));
                    }
                }
            });

            $("#btnSubmit").click(function () {
                setCertScopIds();
                ignoreSome();
                $("#inputForm").submit();
            });
            $("#btnSubmitAndAppr").click(function () {
                setCertScopIds();
                ignoreSome();
                $("#startAudit").val("startAudit");
                $("#inputForm").submit();
            });
            function ignoreSome() {

                if ($("#certType0").attr("checked")) {
                    $("#p3 .required").addClass("ignore");
                    $("#p2 .required").removeClass("ignore");
                }
                if ($("#certType1").attr("checked")) {
                    $("#p2 .required").addClass("ignore");
                    $("#p3 .required").removeClass("ignore");
                }
                $("div[style='display: none;'] .required").addClass("ignore");
                $(".control-group[style='display: none;'] .required").addClass("ignore");
            }

            function setCertScopIds() {
                var ids = [], nodes = tree.getCheckedNodes(true);
                for (var i = 0; i < nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#t01CompCert1\\.certScop").val(ids);
            }

            //经营范围数据展示 begin
            var setting = {
                check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
                data: {simpleData: {enable: true}}, callback: {
                    beforeClick: function (id, node) {
                        tree.checkNode(node, !node.checked, true, true);
                        return false;
                    }
                }
            };

            // 用户-菜单
            var zNodes = [
                    <c:forEach items="${t01ComplBuyer.certScopList}" var="menu">{
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

            var ids = "${t01ComplBuyer.t01CompCert1.certScop}".split(",");
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

            <c:if test="${'0'== t01ComplBuyer.t01CompInfo.abroad}">
            $("#abroad0").attr('checked', 'checked');
            $("#abroad1Div").hide();
            </c:if>
            <c:if test="${'1'== t01ComplBuyer.t01CompInfo.abroad}">
            $("#abroad1").attr('checked', 'checked');
            $("#abroad0Div").hide();
            </c:if>


        });
    </script>
</head>
<body>

<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>首营购货者<span class="divider">&gt;</span></li>
    <c:if test="${empty detail}">
    <li class="active">首营购货者${not empty t01ComplBuyer.id?'修改':'新增'}</li>
    </c:if>
    <c:if test="${not empty detail}">
    <li class="active">首营购货者详情</li>
    </c:if>
</ul>
<c:if test="${empty detail}">
<div id="topTitle">首营购货者${not empty t01ComplBuyer.id?'修改':'新增'}</div>
</c:if>
<c:if test="${not empty detail}">
<div id="topTitle">首营购货者详情</div>
</c:if>

<form:form id="inputForm" modelAttribute="t01ComplBuyer" action="${ctx}/gsp/t01complbuyer/t01ComplBuyer/save"
           method="post" class="form-horizontal">
    <input id="sysChanInfoList"
           value="<c:forEach items="${t01ComplBuyer.sysChanInfoList}" var="item">${item.chanCol},</c:forEach>"
           type="hidden">
    <form:hidden path="id"/>
    <%--<form:hidden path="t01CompInfo.id"/>--%>
    <form:hidden path="t01CompCert0.id"/>
    <form:hidden path="t01CompCert3.id"/>
    <form:hidden path="t01CompCert1.id"/>
    <form:hidden path="t01CompCert4.id"/>
    <input id="startAudit" name="startAudit" type="hidden" value="0">
    <sys:message content="${message}"/>
    <div id="messageBox" class="alert alert-error hide"
         style="position: absolute;top: 0px;right: 0px;width: 300px;background: rgba(44,52,60,0.80) !important;border: 0px;">
        <label id="errorInfo"></label>
        <button data-dismiss="alert" class="close" style="color:#fff;">×</button>
    </div>
    <div id="pagingDiv" class="table-scrollable">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active">
                <a href="#p0" role="tab" data-toggle="tab"> 基本信息 </a>
            </li>
            <li role="presentation">
                <a href="#p1" role="tab" data-toggle="tab"> 营业执照 </a>
            </li>
            <li role="presentation">
                <a href="#p2" role="tab" data-toggle="tab<c:if test="${t01ComplBuyer.certType=='1'}"> disabled</c:if>"

                        <c:if test="${t01ComplBuyer.certType=='1'}">
                            style="background: #adacac;"
                        </c:if>
                > 医疗机构执业许可 </a>
            </li>
            <li role="presentation">
                <a href="#p3" role="tab" data-toggle="tab<c:if test="${t01ComplBuyer.certType=='0'}"> disabled</c:if>"
                        <c:if test="${t01ComplBuyer.certType=='0'}">
                            style="background: #adacac;"
                        </c:if>
                > 经营资质 </a>
            </li>
            <li role="presentation">
                <a href="#p4" role="tab" data-toggle="tab"> 其他证明文件 </a>
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
                        <sys:treeselect id="comp" name="t01CompInfo.id"
                                        value="${t01ComplBuyer.t01CompInfo.id}"
                                        labelName="t01CompInfo.compNameCn"
                                        labelValue="${t01ComplBuyer.t01CompInfo.compNameCn}"
                                        title="企业"
                                        url="/gsp/t01compinfonew/t01CompInfoNew/getCompsForBuyer"
                                        cssClass="required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        企业名称（英文）：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompInfo.compNameEn" disabled="true" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        简称：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompInfo.shortName" disabled="true" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        描述：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompInfo.compDesc" disabled="true" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        备注：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompInfo.remarks" htmlEscape="false" disabled="true" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        境内/境外：
                    </label>
                    <div class="controls">
                        <input id="abroad0" disabled="disabled"
                               <c:if test="${t01ComplBuyer.t01CompInfo.abroad=='0'}">checked </c:if>
                               style="width: 30px;"
                               type="radio"
                               name="t01CompInfo.abroad" value="0"> 境内企业
                        <input id="abroad1" disabled="disabled"
                               <c:if test="${t01ComplBuyer.t01CompInfo.abroad=='1'}">checked </c:if>
                               style="width: 30px;"
                               type="radio"
                               name="t01CompInfo.abroad" value="1"> 境外企业
                    </div>
                </div>

                <div class="control-group">
                    <div class="controls">
                        <input id="certType0"
                               <c:if test="${t01ComplBuyer.certType=='0'}">checked </c:if> style="width: 30px;"
                               type="radio" name="certType" value="0"> 医疗机构执业许可
                        <input id="certType1"
                               <c:if test="${t01ComplBuyer.certType=='1'}">checked </c:if> style="width: 30px;"
                               type="radio" name="certType" value="1"> 经营资质
                    </div>
                </div>
                <c:if test="${not empty detail}">
                    <div class="control-group">
                        <label class="control-label">
                            购货者状态：
                        </label>
                        <div class="controls">
                            <form:select path="buyerStat" class="input-xlarge required" disabled="true">
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
                </c:if>

            </div>

            <div role="tabpanel" class="tab-pane fade" id="p1">
                <div id="abroad0Div">

                    <div class="control-group" style="display: none;">
                        <div class="controls">
                            <input id="toggleCertNbr" disabled="disabled" type="checkbox" style="width: 30px;"> 是否选择三证合一
                        </div>
                    </div>


                    <div class="control-group"
                         <c:if test="${empty t01ComplBuyer.t01CompInfo.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            统一社会信用代码：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompInfo.uniCretNbr" disabled="true" htmlEscape="false" maxlength="250"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>
                    <div class="control-group"
                         <c:if test="${!empty t01ComplBuyer.t01CompInfo.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            注册号：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompInfo.regiNbr" disabled="true" htmlEscape="false" maxlength="250"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>

                                <%--<button id="relateData1" type="button" class="btn btn-primary" style="margin-left:40px;">关联数据</button>--%>
                        </div>
                    </div>
                    <div class="control-group"
                         <c:if test="${!empty t01ComplBuyer.t01CompInfo.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            组织机构代码证号：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompInfo.orgCertNbr" disabled="true" htmlEscape="false" maxlength="250"
                                        class="input-xlarge"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>
                    <div class="control-group"
                         <c:if test="${!empty t01ComplBuyer.t01CompInfo.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            税务登记证号：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompInfo.taxNbr" disabled="true" htmlEscape="false" maxlength="250"
                                        class="input-xlarge"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            名称：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompCert0.certName" disabled="true" htmlEscape="false" maxlength="250"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            经营范围：
                        </label>
                        <div class="controls">
                            <form:input path="t01CompCert0.certScop" disabled="true" htmlEscape="false" maxlength="1000"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            成立日期：
                        </label>
                        <div class="controls">
                            <input id="t01CompCert0.effecDate" disabled="disabled" name="t01CompCert0.effecDate"
                                   type="text"
                                   readonly="readonly" maxlength="20" class="input-medium datepicker required"
                                   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            营业期限至：
                        </label>
                        <div class="controls">
                            <input id="t01CompCert0.validDate" disabled="disabled" name="t01CompCert0.validDate"
                                   type="text"
                                   readonly="readonly" maxlength="20"
                                   class="input-medium datepicker required dateCheck0"
                                   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font></span>
                            营业执照上传：
                        </label>
                        <div class="controls" id="t01CompCert0.attachment">
                                ${fns:getAttachLabel(t01ComplBuyer.t01CompCert0.attachment)}
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

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            成立日期：
                        </label>
                        <div class="controls">
                            <input id="t01CompCert3.effecDate" disabled="disabled" name="t01CompCert3.effecDate"
                                   type="text"
                                   readonly="readonly" maxlength="20" class="input-medium datepicker required"
                                   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            营业期限至：
                        </label>
                        <div class="controls">
                            <input id="t01CompCert3.validDate" disabled="disabled" name="t01CompCert3.validDate"
                                   type="text"
                                   readonly="readonly" maxlength="20"
                                   class="input-medium datepicker required dateCheck0"
                                   value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>"
                            />
                            <span class="datePic"></span>
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font></span>
                            营业执照上传：
                        </label>
                        <div class="controls" id="t01CompCert3.attachment">
                                ${fns:getAttachLabel(t01ComplBuyer.t01CompCert3.attachment)}
                        </div>
                    </div>
                </div>

            </div>

            <div role="tabpanel" class="tab-pane fade" id="p2">

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        登记号：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompCert4.certNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        机构名称：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompCert4.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        诊疗科目：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompCert4.certScop" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        发证日期：
                    </label>
                    <div class="controls">
                        <input id="t01CompCert4.effecDate" name="t01CompCert4.effecDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert4.effecDate}" pattern="yyyy-MM-dd"/>"
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
                        <input id="t01CompCert4.validDate" name="t01CompCert4.validDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required dateCheck4"
                               value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert4.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font></span>
                        医疗机构执业许可上传：
                    </label>
                    <div class="controls">
                        <c:if test="${not empty detail}">
                            ${fns:getAttachLabel(t01ComplBuyer.t01CompCert4.attachment)}
                        </c:if>
                        <c:if test="${empty detail}">
                        <form:hidden id="attachmentt01CompCert4" path="t01CompCert4.attachment" htmlEscape="false"
                                     maxlength="2048"
                                     class="input-xlarge required"/>
                        <sys:ckfinder input="attachmentt01CompCert4" type="files"
                                      uploadPath="/gsp/t01CompCert4"
                                      selectMultiple="true"/>
                        </c:if>
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
                        <form:input path="t01CompCert1.certNbr" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        企业名称：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompCert1.certName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        经营方式：
                    </label>
                    <div class="controls">
                        <form:select path="t01CompInfo.busiMode" class="input-xlarge">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_busiMode')}"
                                          itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        经营场所：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompInfo.busiLoca" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                        <span class="promptPic"></span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        库房地址：
                    </label>
                    <div class="controls">
                        <form:input path="t01CompInfo.storLoca" htmlEscape="false" maxlength="250"
                                    class="input-xlarge "/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        经营范围：
                    </label>
                    <div class="controls">
                        <div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>
                        <form:hidden path="t01CompCert1.certScop" maxlength="1000" class="required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        发证时间：
                    </label>
                    <div class="controls">
                        <input id="t01CompCert1.effecDate" name="t01CompCert1.effecDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required"
                               value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert1.effecDate}" pattern="yyyy-MM-dd"/>"
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
                        <input id="t01CompCert1.validDate" name="t01CompCert1.validDate" type="text" readonly="readonly"
                               maxlength="20" class="input-medium datepicker required dateCheck1"
                               value="<fmt:formatDate value="${t01ComplBuyer.t01CompCert1.validDate}" pattern="yyyy-MM-dd"/>"
                        />
                        <span class="datePic"></span>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font></span>
                        经营资质上传：
                    </label>
                    <div class="controls">
                        <c:if test="${not empty detail}">
                            ${fns:getAttachLabel(t01ComplBuyer.t01CompCert1.attachment)}
                        </c:if>
                        <c:if test="${empty detail}">
                        <form:hidden id="attachmentt01CompCert1" path="t01CompCert1.attachment" htmlEscape="false"
                                     maxlength="2048"
                                     class="input-xlarge required"/>
                        <sys:ckfinder input="attachmentt01CompCert1" type="files"
                                      uploadPath="/gsp/t01CompCert1"
                                      selectMultiple="true"/>
                        </c:if>
                    </div>
                </div>

            </div>

            <div role="tabpanel" class="tab-pane fade" id="p4">

                <div class="control-group">
                    <label class="control-label">
                        其他附件：
                    </label>
                    <div class="controls">
                        <c:if test="${not empty detail}">
                            ${fns:getAttachLabel(t01ComplBuyer.attachment)}
                        </c:if>
                        <c:if test="${empty detail}">
                        <form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
                                     class="input-xlarge"/>
                        <sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01complbuyer"
                                      selectMultiple="true"/>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>
        <c:if test="${not empty detail}">
            <sys:operateHistory module="t01ComplBuyer" dataId="${t01ComplBuyer.id}"/>
        </c:if>
    </div>

    <div id="footBtnDiv" class="form-actions">
        <input id="btnSubmitAndAppr" class="btn btn-primary btnSubmit" value="提 交"/>&nbsp;

        <input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button"
               value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回"
               onclick="window.location='${ctx}/gsp/t01complbuyer/t01ComplBuyer'"/>
    </div>
</form:form>
<c:if test="${not empty detail}">
    <sys:operateSave/>
</c:if>

<script>
    $(document).ready(function () {

        var sysChanInfos = $("#sysChanInfoList").val().split(",");
        for (var i = 0; i < sysChanInfos.length; i++) {
            if (sysChanInfos[i].length > 0) {
                $(document.getElementById(sysChanInfos[i])).parent("div").siblings("label").css("color", "red");
            }
        }

        $("#certType0").click(function () {
            $("a[href='#p2']").attr("data-toggle", "tab");
            $("a[href='#p2']").removeAttr("style");
            $("a[href='#p2']").parent().removeAttr("style");
            $("a[href='#p3']").attr("data-toggle", "tab disabled");
            $("a[href='#p3']").attr("style", "background: #adacac;");
            $("a[href='#p3']").parent().attr("style", "border-color: #adacac");
        })

        $("#certType1").click(function () {
            $("a[href='#p2']").attr("data-toggle", "tab disabled");
            $("a[href='#p2']").attr("style", "background: #adacac;");
            $("a[href='#p2']").parent().attr("style", "border-color: #adacac");
            $("a[href='#p3']").attr("data-toggle", "tab");
            $("a[href='#p3']").removeAttr("style");
            $("a[href='#p3']").parent().removeAttr("style");
        })
        <c:if test="${empty t01ComplBuyer.id}">
        $("#certType0").click();
        beforeCallBack();
        </c:if>
        <c:if test="${'0'== t01ComplBuyer.certType}">
        $("#certType0").click();
        </c:if>
        <c:if test="${'1'== t01ComplBuyer.certType}">
        $("#certType1").click();
        </c:if>

        if ($("#compId").val() != "") {
            compTreeselectCallBack();
        }
        <c:if test="${not empty detail}">
        $("input").attr("disabled","disabled");
        $(".help-inline").hide();
        $("#btnSubmit").hide();
        $("#btnSubmitAndAppr").hide();
        $("#btnCancel").removeAttr("disabled")
        $("#operateSaveDiv *").removeAttr("disabled")
        $("#operateHistoryDiv *").removeAttr("disabled")
        </c:if>


    });

    function beforeCallBack() {
        $("a[href='#p1']").attr("data-toggle", "tab disabled");
        $("a[href='#p1']").attr("style", "background: #adacac;");
        $("a[href='#p1']").parent().attr("style", "border-color: #adacac");
        $("a[href='#p4']").attr("data-toggle", "tab disabled");
        $("a[href='#p4']").attr("style", "background: #adacac;");
        $("a[href='#p4']").parent().attr("style", "border-color: #adacac");
        $("a[href='#p2']").attr("data-toggle", "tab disabled");
        $("a[href='#p2']").attr("style", "background: #adacac;");
        $("a[href='#p2']").parent().attr("style", "border-color: #adacac");
    }
    function afterCallBack() {
        $("a[href='#p1']").attr("data-toggle", "tab");
        $("a[href='#p1']").removeAttr("style");
        $("a[href='#p1']").parent().removeAttr("style");
        $("a[href='#p4']").attr("data-toggle", "tab");
        $("a[href='#p4']").removeAttr("style");
        $("a[href='#p4']").parent().removeAttr("style");
        $("a[href='#p2']").attr("data-toggle", "tab");
        $("a[href='#p2']").removeAttr("style");
        $("a[href='#p2']").parent().removeAttr("style");
    }

    function compTreeselectCallBack() {
        $.ajax({
            async: false,
            type: "post",
            dataType: "json",
            url: '${ctx}/gsp/t01compinfonew/t01CompInfoNew/getCompInfo',
            data: {
                id: $("#compId").val()
            },
            success: function (result) {
                if (result != null) {
                    <c:if test="${empty t01ComplBuyer.id}">
                    afterCallBack()
                    </c:if>

                    $("#t01CompInfo\\.id").val(result.id)
                    $("#t01CompCert0\\.id").val(result.t01CompCert0.id)
                    $("#t01CompCert3\\.id").val(result.t01CompCert3.id)
                    $("#t01CompCert1\\.id").val(result.t01CompCert1.id)


                    $("#t01CompInfo\\.compNameEn").val(result.compNameEn)
                    $("#t01CompInfo\\.shortName").val(result.shortName)
                    $("#t01CompInfo\\.compDesc").val(result.compDesc)
                    $("#t01CompInfo\\.remarks").val(result.remarks)

                    //国内企业
                    if ("0" == result.abroad) {
                        $("#p2 .control-group").show();
                        $("#p3 .control-group").show();

                        $("#abroad0").attr('checked', 'checked');
                        $("#abroad0Div").show();
                        $("#abroad1Div").hide();


                        $("#t01CompInfo\\.uniCretNbr").val(result.uniCretNbr)


                        $("#t01CompInfo\\.regiNbr").val(result.regiNbr)
                        $("#t01CompInfo\\.orgCertNbr").val(result.orgCertNbr)
                        $("#t01CompInfo\\.taxNbr").val(result.taxNbr)

                        $("#t01CompCert0\\.certName").val(result.t01CompCert0.certName)
                        $("#t01CompCert0\\.certScop").val(result.t01CompCert0.certScop)
                        $("#t01CompCert0\\.effecDate").val(result.t01CompCert0.effecDate)
                        $("#t01CompCert0\\.validDate").val(result.t01CompCert0.validDate)

                        if (result.uniCretNbr != null && result.uniCretNbr != "") {
                            $("#t01CompInfo\\.uniCretNbr").parents(".control-group:first").show();
                            $("#t01CompInfo\\.regiNbr").parents(".control-group:first").hide();
                            $("#t01CompInfo\\.orgCertNbr").parents(".control-group:first").hide();
                            $("#t01CompInfo\\.taxNbr").parents(".control-group:first").hide();
                        } else {
                            $("#t01CompInfo\\.uniCretNbr").parents(".control-group:first").hide();
                            $("#t01CompInfo\\.regiNbr").parents(".control-group:first").show();
                            $("#t01CompInfo\\.orgCertNbr").parents(".control-group:first").show();
                            $("#t01CompInfo\\.taxNbr").parents(".control-group:first").show();
                        }
                        $("#t01CompCert0\\.attachment").html("");
                        $("#t01CompCert0\\.attachment").append(getAttachLabel(result.t01CompCert0.attachment))

                        if(result.t01CompCert1.id!=null&&result.t01CompCert1.id!="") {
                            $("#t01CompCert1\\.certNbr").val(result.t01CompCert1.certNbr)
                            $("#t01CompCert1\\.certName").val(result.t01CompCert1.certName)
                            $("#t01CompCert1\\.certScop").val(result.t01CompCert1.certScop)

                            setTree();

                            $("#t01CompCert1\\.effecDate").val(result.t01CompCert1.effecDate)
                            $("#t01CompCert1\\.validDate").val(result.t01CompCert1.validDate)

                            $("#t01CompInfo\\.busiMode").select2().select2("val",result.busiMode)
                            $("#t01CompInfo\\.busiLoca").val(result.busiLoca)
                            $("#t01CompInfo\\.storLoca").val(result.storLoca)

                            $("#attachmentt01CompCert1").val(result.t01CompCert1.attachment);
                            <c:if test="${empty detail}">
                            attachmentt01CompCert1Preview();
                            </c:if>
                        }
                    }
                    //国外企业
                    if ("1" == result.abroad) {
                        $("#p2 .control-group:not(:last)").hide();
                        $("#p3 .control-group:not(:last)").hide();

                        $("#abroad1").attr('checked', 'checked');
                        $("#abroad0Div").hide();
                        $("#abroad1Div").show();

                        $("#t01CompInfo\\.compUniNbr").val(result.compUniNbr)
                        $("#t01CompCert3\\.certScop").val(result.t01CompCert3.certScop)
                        $("#t01CompCert3\\.effecDate").val(result.t01CompCert3.effecDate)
                        $("#t01CompCert3\\.validDate").val(result.t01CompCert3.validDate)

                        $("#t01CompCert3\\.attachment").html("");
                        $("#t01CompCert3\\.attachment").append(getAttachLabel(result.t01CompCert3.attachment))

                        if(result.t01CompCert1.id!=null&&result.t01CompCert1.id!="") {
                            $("#attachmentt01CompCert1").val(result.t01CompCert1.attachment);
                            attachmentt01CompCert1Preview();
                        }
                    }
                } else {
                    alertx("未查询到相关数据");
                }
            },
            error: function () {
                alertx("请求服务器数据失败");
                return null;
            }
        })
    }
    function setTree() {
        var tree = $.fn.zTree.getZTreeObj("certScopTree");

        var ids = $("#t01CompCert1\\.certScop").val().split(",");
        for (var i = 0; i < ids.length; i++) {
            var node = tree.getNodeByParam("id", ids[i]);
            try {
                tree.checkNode(node, true, false);
            } catch (e) {
            }
        }
    }
</script>
</body>
</html>
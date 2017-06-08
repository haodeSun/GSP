<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>企业信息管理</title>
    <meta name="decorator" content="default"/>
    <style>
        .displayNone {
            display: none;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
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
            jQuery.validator.addMethod("dateCheck3", function (value, element) {
                var result = true;
                var eftDt = $("#t01CompCert3\\.effecDate").val() + "";
                var nvldDt = $("#t01CompCert3\\.validDate").val() + "";

                if (eftDt.length > 0 && nvldDt.length > 0) {
                    var d1 = new Date(eftDt.replace(/\-/g, "\/"));
                    var d2 = new Date(nvldDt.replace(/\-/g, "\/"));
                    if (d1 > d2) {
                        result = false;
                    }
                }
                return this.optional(element) || result;
            }, "营业期限至日期需晚于成立日期");
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
                ignoreSome();
                $("#inputForm").submit();
            });
            $("#abroad0").click(function () {
                $("#abroad0Div").removeClass("displayNone");
                $("#abroad1Div").addClass("displayNone");
                $("#abroad1Div input").val("");
                $("#abroad0Div .required").removeClass("ignore");
                <c:if test="${empty detail}">
                attachmentt01CompCert3Preview();
                </c:if>
            });
            $("#abroad1").click(function () {
                $("#abroad0Div").addClass("displayNone");
                $("#abroad1Div").removeClass("displayNone");
                $("#abroad0Div input").val("");
                $("#abroad1Div .required").removeClass("ignore");
                <c:if test="${empty detail}">
                attachmentt01CompCert0Preview();
                </c:if>
            });
            <c:if test="${empty t01CompInfoNew.id}">
            $("#abroad0").click();
            </c:if>
            <c:if test="${'0'== t01CompInfoNew.abroad}">
            $("#abroad0").click();
            </c:if>
            <c:if test="${'1'== t01CompInfoNew.abroad}">
            $("#abroad1").click();
            </c:if>
            $("#toggleCertNbr").click(function () {
                $("#p1>#abroad0Div>.control-group:lt(5):not(:first) input").val("");
                $("#p1>#abroad0Div>.control-group:lt(5):not(:first) input").attr("value","");

                $("#p1>#abroad0Div>.control-group:lt(5) .required").removeClass("ignore");

                $("#p1>#abroad0Div>.control-group:lt(5):not(:first)").toggle();
            });
            function ignoreSome() {
                $("div[class='displayNone'] .required").addClass("ignore");
                $(".control-group[style='display: none;'] .required").addClass("ignore");
            }
        });
    </script>
</head>
<body>
<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>企业管理<span class="divider">&gt;</span></li>
    <c:if test="${empty detail}">
    <li class="active">企业信息${not empty t01CompInfoNew.id?'修改':'新增'}</li>
    </c:if>
    <c:if test="${not empty detail}">
        <li class="active">企业信息详情</li>
    </c:if>
</ul>
<c:if test="${empty detail}">
<div id="topTitle">企业信息${not empty t01CompInfoNew.id?'修改':'新增'}</div>
</c:if>
<c:if test="${not empty detail}">
    <div id="topTitle">企业信息详情</div>
</c:if>
<form:form id="inputForm" modelAttribute="t01CompInfoNew" action="${ctx}/gsp/t01compinfonew/t01CompInfoNew/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="t01CompCert0.id"/>
    <form:hidden path="t01CompCert3.id"/>
    <sys:message content="${message}"/>
    <div  id="messageBox" class="alert alert-error hide" style="position: absolute;top: 0px;right: 0px;width: 300px;background: rgba(44,52,60,0.80) !important;border: 0px;">
        <label id="errorInfo"></label>
        <button data-dismiss="alert"  class="close" style="color:#fff;">×</button>
    </div>
    <div id="pagingDiv" class="table-scrollable">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active">
                <a href="#p0" role="tab" data-toggle="tab"> 基本信息 </a>
            </li>
            <li role="presentation">
                <a href="#p1" role="tab" data-toggle="tab"> 企业资质 </a>
            </li>
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane fade in active" id="p0">

                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        企业名称（中文）：
                    </label>
                    <div class="controls">
                        <form:input path="compNameCn" htmlEscape="false" maxlength="250"
                                    class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        企业名称（英文）：
                    </label>
                    <div class="controls">
                        <form:input path="compNameEn" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        简称：
                    </label>
                    <div class="controls">
                        <form:input path="shortName" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        描述：
                    </label>
                    <div class="controls">
                        <form:input path="compDesc" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        备注：
                    </label>
                    <div class="controls">
                        <form:input path="remarks" htmlEscape="false" maxlength="1000"
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
                        <input id="abroad0"
                               <c:if test="${t01CompInfoNew.abroad=='0'}">checked </c:if> style="width: 30px;" type="radio"
                               name="abroad" value="0"> 境内企业
                        <input id="abroad1"
                               <c:if test="${t01CompInfoNew.abroad=='1'}">checked </c:if> style="width: 30px;" type="radio"
                               name="abroad" value="1"> 境外企业
                    </div>
                </div>

                <c:if test="${not empty detail}">

                    <div class="control-group">
                        <label class="control-label">
                            企业类型：
                        </label>
                        <div class="controls">
                            <input id="compType" type="text" class="input-xlarge"
                                   value="<c:if test="${ not empty t01CompInfoNew.buyerId}">购货者</c:if>
<c:if test="${ not empty t01CompInfoNew.buyerId && not empty t01CompInfoNew.suplId}">,</c:if>
<c:if test="${ not empty t01CompInfoNew.suplId}">供货者</c:if>">
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            企业状态：
                        </label>
                        <div class="controls">
                            <input id="compState" type="text" class="input-xlarge" value="
<c:if test="${'0'==t01CompInfoNew.abroad}">${fns:getDictLabel(t01CompInfoNew.t01CompCert0.certStat, 't01_certStat', '')}</c:if>
<c:if test="${'1'==t01CompInfoNew.abroad}">${fns:getDictLabel(t01CompInfoNew.t01CompCert3.certStat, 't01_certStat', '')}</c:if>
                        ">
                            <span class="promptPic"></span>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            审批状态：
                        </label>
                        <div class="controls">
                            <input id="apprState" type="text" class="input-xlarge"
                                   value="${fns:getDictLabel(t01CompInfoNew.apprStat, 't01_matr_info_appr_stat', '')}">
                            <span class="promptPic"></span>
                        </div>
                    </div>
                </c:if>
            </div>

            <div role="tabpanel" class="tab-pane fade" id="p1">
                <div id="abroad0Div">
                    <div class="control-group">
                        <div class="controls">
                            <input id="toggleCertNbr" type="checkbox" style="width: 30px;"> 是否选择三证合一
                        </div>
                    </div>


                    <div class="control-group"
                         <c:if test="${empty t01CompInfoNew.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            统一社会信用代码：
                        </label>
                        <div class="controls">
                            <form:input path="uniCretNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>
                    <div class="control-group"
                         <c:if test="${!empty t01CompInfoNew.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            <span class="help-inline"><font color="red">*</font> </span>
                            注册号：
                        </label>
                        <div class="controls">
                            <form:input path="regiNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge required"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>
                    <div class="control-group"
                         <c:if test="${!empty t01CompInfoNew.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            组织机构代码证号：
                        </label>
                        <div class="controls">
                            <form:input path="orgCertNbr" htmlEscape="false" maxlength="250"
                                        class="input-xlarge"/>
                            <span class="promptPic"></span>
                        </div>
                    </div>
                    <div class="control-group"
                         <c:if test="${!empty t01CompInfoNew.uniCretNbr}">style="display: none;" </c:if>>
                        <label class="control-label">
                            税务登记证号：
                        </label>
                        <div class="controls">
                            <form:input path="taxNbr" htmlEscape="false" maxlength="250"
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
                            <form:input path="t01CompCert0.certName" htmlEscape="false" maxlength="250"
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
                            <form:input path="t01CompCert0.certScop" htmlEscape="false" maxlength="250"
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
                            <input id="t01CompCert0.effecDate" name="t01CompCert0.effecDate" type="text"
                                   readonly="readonly" maxlength="20" class="input-medium datepicker required dateCheck0"
                                   value="<fmt:formatDate value="${t01CompInfoNew.t01CompCert0.effecDate}" pattern="yyyy-MM-dd"/>"
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
                            <input id="t01CompCert0.validDate" name="t01CompCert0.validDate" type="text"
                                   readonly="readonly" maxlength="20"
                                   class="input-medium datepicker required  dateCheck0"
                                   value="<fmt:formatDate value="${t01CompInfoNew.t01CompCert0.validDate}" pattern="yyyy-MM-dd"/>"
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
                        <div class="controls">
                            <c:if test="${not empty detail}">
                                ${fns:getAttachLabel(t01CompInfoNew.t01CompCert0.attachment)}
                            </c:if>
                            <c:if test="${empty detail}">
                            <form:hidden id="attachmentt01CompCert0" path="t01CompCert0.attachment" htmlEscape="false"
                                         maxlength="2048"
                                         class="input-xlarge required"/>
                            <sys:ckfinder input="attachmentt01CompCert0" type="files" uploadPath="/gsp/t01CompCert0"
                                          selectMultiple="true"/>
                            </c:if>
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
                            <form:input path="compUniNbr" htmlEscape="false" maxlength="250"
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
                            <form:input path="t01CompCert3.certScop" htmlEscape="false" maxlength="250"
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
                            <input id="t01CompCert3.effecDate" name="t01CompCert3.effecDate" type="text"
                                   readonly="readonly" maxlength="20" class="input-medium datepicker required dateCheck3"
                                   value="<fmt:formatDate value="${t01CompInfoNew.t01CompCert3.effecDate}" pattern="yyyy-MM-dd"/>"
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
                            <input id="t01CompCert3.validDate" name="t01CompCert3.validDate" type="text"
                                   readonly="readonly" maxlength="20"
                                   class="input-medium datepicker required dateCheck3"
                                   value="<fmt:formatDate value="${t01CompInfoNew.t01CompCert3.validDate}" pattern="yyyy-MM-dd"/>"
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
                        <div class="controls">
                            <c:if test="${not empty detail}">
                                ${fns:getAttachLabel(t01CompInfoNew.t01CompCert3.attachment)}
                            </c:if>
                            <c:if test="${empty detail}">
                            <form:hidden id="attachmentt01CompCert3" path="t01CompCert3.attachment" htmlEscape="false"
                                         maxlength="2048"
                                         class="input-xlarge required"/>
                            <sys:ckfinder input="attachmentt01CompCert3" type="files" uploadPath="/gsp/t01CompCert3"
                                          selectMultiple="true"/>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="footBtnDiv" class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button"
               value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回"
               onclick="window.location='${ctx}/gsp/t01compinfonew/t01CompInfoNew'"/>
    </div>
</form:form>
<script>
    $(document).ready(function(){
        var id=$("#id").val();
        $("#compNameCn").blur(function () {
            if($(this).val()!=null&&""!=$(this).val().trim()){
                $.ajax({
                    type: "post",
                    dataType: "json",
                    url: '${ctx}/gsp/t01compinfonew/t01CompInfoNew/checkStatusBeforeHandle',
                    data: {
                        handle: 'checkOnlyByCompNameCn',
                        id: id,
                        compNameCn:$(this).val()
                    },
                    success: function (data) {
                        if ("100" == data.code) {
                        } else if ("101" == data.code) {
                            alertx(data.message);
                        } else {
                        }
                    },
                    error: function () {
                        alertx("请求服务器数据失败");
                    }
                });
            }
        });

        $("#uniCretNbr").blur(function () {
            if($(this).val()!=null&&""!=$(this).val().trim()){
                $.ajax({
                    type: "post",
                    dataType: "json",
                    url: '${ctx}/gsp/t01compinfonew/t01CompInfoNew/checkStatusBeforeHandle',
                    data: {
                        handle: 'checkOnlyByUniCretNbr',
                        id: id,
                        uniCretNbr:$(this).val()
                    },
                    success: function (data) {
                        if ("100" == data.code) {
                        } else if ("101" == data.code) {
                            alertx(data.message);
                        } else {
                        }
                    },
                    error: function () {
                        alertx("请求服务器数据失败");
                    }
                });
            }
        });

        $("#regiNbr").blur(function () {
            if($(this).val()!=null&&""!=$(this).val().trim()){
                $.ajax({
                    type: "post",
                    dataType: "json",
                    url: '${ctx}/gsp/t01compinfonew/t01CompInfoNew/checkStatusBeforeHandle',
                    data: {
                        handle: 'checkOnlyByRegiNbr',
                        id: id,
                        regiNbr:$(this).val()
                    },
                    success: function (data) {
                        if ("100" == data.code) {
                        } else if ("101" == data.code) {
                            alertx(data.message);
                        } else {
                        }
                    },
                    error: function () {
                        alertx("请求服务器数据失败");
                    }
                });
            }
        });
        <c:if test="${not empty detail}">
        $("input").attr("disabled","disabled");
        $(".help-inline").hide();
        $("#btnSubmit").hide();
        $("#btnCancel").removeAttr("disabled")
        </c:if>

    });
</script>
</body>
</html>
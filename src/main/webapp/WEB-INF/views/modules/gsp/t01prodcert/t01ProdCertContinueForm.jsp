<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>产品资质管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/modules/gsp/t01ProdCert.js?version=1.0.0" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            top.$.jBox.tip.mess = 0;
            $(".controls input").blur(function(){
                setTimeout('$("#messageBox").fadeOut("500")',4000);
            });
            //$("#name").focus();
            $("#btnSubmit").click(function () {
                //$( ".required" ).addClass("ignore");
                $("#inputForm").submit();
            });
            $("#btnAudit").click(function () {
                //$(".required").removeClass("ignore");
                $("#inputForm").submit();
            });
            $("#inputForm").validate({
                submitHandler: function (form) {
                    preSaveHandle();
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                ignore: ".ignore",
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    setTimeout('$("#messageBox").fadeOut("500")',4000);
                    $("#errorInfo").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element.siblings("span:last"));
                    }
                }
            });
            var testArray = ${fns:toJson(fields)};
            for (var j = 0, inputLen = $("#inputForm").find(".controls").length; j < inputLen; j++) {
                var inputId = '';
                if($($("#inputForm").find(".controls")[j]).children("select").length != 0){
                    inputId = $($("#inputForm").find(".controls")[j]).children("select").attr("name");
                }
                else{
                    inputId = $($("#inputForm").find(".controls")[j]).children().attr("name");
                }
                if ($.inArray(inputId, testArray) == -1) {
                    if(inputId != "attachment"){
                        $($("#inputForm").find(".controls")[j]).append('<span class="newBtnNoFloat btn btn-primary" onclick="changeAs(this)">变更为</span>');
                    }
                }
                else if (inputId == "origRegiCertNbr") {
                    $($("#inputForm").find(".controls")[j]).siblings("label").prepend('<span class="help-inline"><font color="red">*</font> </span> ');
                    $($("#inputForm").find(".controls")[j]).append(' <span class="newBtnNoFloat btn btn-primary" onclick="queryThisForm()">关联资质</span>');
                    $("input[name='origRegiCertNbr']").css('width','30.6%');
                }
                else {
                    if(inputId == "regiCertNbr" || inputId == "attachment") {
                        $($("#inputForm").find(".controls")[j]).siblings("label").prepend('<span class="help-inline"><font color="red">*</font> </span>');
                    }
                }
            }
            $(".changeDiv").find(".controls").find("span:last-child").remove();

            <!--***************************处理变更记录回显 BEGIN**********************************-->
            //拿到变更记录，并显示到页面
            var sysChanInfoList = ${fns:toJson(t01ProdCert.sysChanInfoList)};
            //遍历变更记录list，将变更过的记录显示到页面
            $.each(sysChanInfoList,function(index,value){
                var col = value['chanCol'];
                //获取到当前字段下面的隐藏div
                var $hideNode = $("#"+col).parents('.control-group').next(".changeDiv:first");
                //console.log($hideNode);
                if($hideNode.length === 0){
                    $hideNode = $("input[name="+col+"]").parents('.control-group').next(".changeDiv:first");
                }
                //显示
                if("attachment" != col){
                    $hideNode.css("display","block");
                }
                //赋值
                $hideNode.find(".controls:first input[name='sysChanInfoList{{idx}}.chanValue']").val(value['chanValue']);
                $hideNode.find(".remarkDiv input[name='sysChanInfoList{{idx}}.chanReason']").val(value['chanReason']);

                //单独处理select2
                $("select").each(function(index,obj){
                    var name = $(obj).attr("name");
                    if(col == name){
                        $(obj).parents('.control-group').next(".changeDiv:first").find(".controls:first").find("select,#"+col).val(value['chanValue']).change();
                    }
                });
            });
            <!--***************************处理变更记录回显 END**********************************-->
        });
        function changeAs(obj) {
            var nextDiv = $(obj).parent().parent().next(".changeDiv");
            if($(nextDiv).find(".controls:eq(0)").children("input").size() != 0){
                $(nextDiv).find(".controls:eq(0)").css({"width":($(nextDiv).prev().find(".controls").children(":eq(0)").width()+12)});
            }else{
                $(nextDiv).find(".controls:eq(0)").css({"width":$(nextDiv).prev().find(".controls").children(":eq(0)").width()});
            }
            if (nextDiv.css("display") == "none") {
                nextDiv.css({"display": "block"});
                //清除修改变更时候的回显数据
                nextDiv.find("input,select").not(":hidden").val("");
            }
            else {
                nextDiv.css({"display": "none"});
            }
        }

        /**
         * 变更延续查询记录
         */
        function queryThisForm() {
            var value = $("#origRegiCertNbr").val();
            value = value.trim();
            if (!value || value.length == 0) {
                alertx("请填写资质证号！");
                return;
            }
            //window.location.href="${ctx}/gsp/t01prodcert/t01ProdCert/getRecord?method=chan&regiCertNo="+value;
            $.ajax({
                url: "${ctx}/gsp/t01prodcert/t01ProdCert/getRecord",
                type: "get",
                data: {regiCertNbr: $("#origRegiCertNbr").val()},
                success: function (result) {
                    if(result.code == '1'){
                        var data = result.data;
                        for (var key in data) {
                            if("origRegiCertNbr" != key && key != "attachment"){
                                if($("input[name=" + key + "]")){
                                    $("input[name=" + key + "]").val(data[key]);
                                }
                            }
                        }
                        $("select").each(function(){
                            var name = $(this).attr('name');
                            $(this).val(data[name]).change();
                        })
                        //清楚注册证号的值
                        $("#regiCertNbr").val("");
                        //显示文件
                        //attachmentPreview();
                        $("#btnAudit").removeAttr("disabled");
                        $("#btnSubmit").removeAttr("disabled");
                    }else if(result.code == '0'){
                        alertx(result.message);
                    }
                }, error: function () {
                    alertx("系统错误！");
                }
            });
        }

    </script>
</head>
<body>
<!-- 面包屑导航（文字以及链接应换为变量）  -->
<ul class="breadcrumb">
    <li>首页<span class="divider">></span></li>
    <li>首营产品<span class="divider">></span></li>
    <li class="active">产品资质延续</li>
</ul>
<!-- 每页的title（文字换为变量） -->
<div id="topTitle">产品资质延续</div>

<form:form id="inputForm" modelAttribute="t01ProdCert" action="${ctx}/gsp/t01prodcert/t01ProdCert/extendSave" method="post"
           class="form-horizontal">
<form:hidden path="id"/>
<input type="hidden" name="currId" value="${currId}"/>
<form:hidden path="act.taskId"/>
<form:hidden path="act.taskName"/>
<form:hidden path="act.taskDefKey"/>
<form:hidden path="act.procInsId"/>
<form:hidden path="act.procDefId"/>
<form:hidden id="flag" path="act.flag"/>
<sys:message content="${message}"/>
<div  id="messageBox" class="alert alert-error hide" style="position: absolute;top: 0px;right: 0px;width: 300px;background: rgba(44,52,60,0.80) !important;border: 0px;">
    <label id="errorInfo"></label>
    <button data-dismiss="alert"  class="close" style="color:#fff;">×</button>
</div>
<div id="pagingDiv" class="table-scrollable">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active">
            <a href="#p0" role="tab" data-toggle="tab">
                基本信息
            </a>
        </li>
        <li role="presentation">
            <a href="#p1" role="tab" data-toggle="tab">
                产品信息
            </a>
        </li>
        <li role="presentation">
            <a href="#p2" role="tab" data-toggle="tab">
                企业信息
            </a>
        </li>
        <li role="presentation">
            <a href="#p3" role="tab" data-toggle="tab">
                资质上传
            </a>
        </li>
    </ul>
    <div class="tab-content">
        <div role="tabpanel" class=
                "tab-pane fade in active"

             id="p0">

            <div class="control-group">
                <label class="control-label">原注册证/备案凭证编号：</label>
                <div class="controls">
                    <form:input path="origRegiCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="origRegiCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="origRegiCertNbr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册证/备案凭证编号：</label>
                <div class="controls">
                    <form:input path="regiCertNbr" onchange="checkProdCertNo()" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="regiCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="regiCertNbr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group">
                <label class="control-label">风险分类：</label>
                <div class="controls">
                    <form:select path="riskClass" class="input-xlarge " disabled="true">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_riskClass')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:select path="riskClass" class="input-xlarge ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_riskClass')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="riskClass" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">技术分类-名称：</label>
                <div class="controls">
                    <form:select path="techCateCd" disabled="true" class="input-xlarge">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_tech_cate_cd')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:select path="techCateCd" class="input-xlarge">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_tech_cate_cd')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="techCateCd" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">批准日期：</label>
                <div class="controls">
                    <input name="apprDate" type="text" disabled="true"  maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.apprDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <input name="apprDate" type="text"  maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.apprDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="apprDate" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生效日期：</label>
                <div class="controls">
                        <%--<form:input path="effeDate" type="text"   disabled="true" maxlength="20" class="input-medium datepicker "/>--%>
                    <input name="effeDate" type="text" disabled="true" maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <input name="effeDate" type="text"  maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="effeDate" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">有效期至：</label>
                <div class="controls">
                        <%--<form:input path="validPeri" type="text"  disabled="true" class="input-medium datepicker"/>--%>
                    <input name="validPeri" type="text" disabled="true"  maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                </div>
            </div>

            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <input name="validPeri" type="text" maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="validPeri" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">资质类型：</label>
                <div class="controls">
                    <form:select path="certType" disabled="true" class="input-xlarge ">
                        <form:option value="2" label="延续"/>
                        <%--<form:options items="${fns:getDictList('t01_certType')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>--%>
                    </form:select>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:select path="certType" class="input-xlarge ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_certType')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="certType" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p1">

            <div class="control-group">
                <label class="control-label">产品名称（中文）：</label>
                <div class="controls">
                    <form:input  disabled="true" path="prodNameCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="prodNameCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="prodNameCn" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">产品名称（英文）：</label>
                <div class="controls">
                    <form:input  disabled="true" path="prodNameEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="prodNameEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="prodNameEn" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">型号规格：</label>
                <div class="controls">
                    <form:input  disabled="true" path="modelSpec" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="modelSpec" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="modelSpec" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">结构及组成：</label>
                <div class="controls">
                    <form:input  disabled="true" path="struComp" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="struComp" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="struComp" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">主要组成成分：</label>
                <div class="controls">
                    <form:input  disabled="true" path="mainMnt" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="mainMnt" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="mainMnt" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">预期用途：</label>
                <div class="controls">
                    <form:input  disabled="true" path="expeUsage" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="expeUsage" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="expeUsage" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">适用范围：</label>
                <div class="controls">
                    <form:input  disabled="true" path="useScope" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="useScope" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="useScope" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">产品有效期（月）：</label>
                <div class="controls">
                    <form:input path="effiDate" disabled="true" htmlEscape="false" type="number" min="1" max="9999" step="1" class="input-xlarge required"/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="effiDate" htmlEscape="false" type="number" maxlength="11" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="effiDate" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">储存条件：</label>
                <div class="controls">
                    <form:input  disabled="true" path="storCond" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="storCond" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="storCond" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">运输条件：</label>
                <div class="controls">
                    <form:input  disabled="true" path="tranCond" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="tranCond" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="tranCond" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">备注：</label>
                <div class="controls">
                    <form:input path="remarks" disabled="true" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="remarks" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="remarks" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">说明：</label>
                <div class="controls">
                    <form:input path="explanation" disabled="true" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="explanation" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="explanation" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p2">

            <div class="control-group">
                <label class="control-label">注册人/备案人名称(原文)：</label>
                <div class="controls">
                    <form:input path="regiPersName" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="regiPersName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="regiPersName" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册人/备案人名称(翻译)：</label>
                <div class="controls">
                    <form:input path="regiPersNameTran" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="regiPersNameTran" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="regiPersNameTran" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册人/备案人住所：</label>
                <div class="controls">
                    <form:input path="regiPersAddr" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="regiPersAddr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="regiPersAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册人/备案人联系方式：</label>
                <div class="controls">
                    <form:input path="regiPersCont" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="regiPersCont" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="regiPersCont" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产地址：</label>
                <div class="controls">
                    <form:input path="produAddr" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="produAddr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="produAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产国或地区（中文）：</label>
                <div class="controls">
                    <form:input path="produAreaCn" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="produAreaCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="produAreaCn" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产国或地区（英文）：</label>
                <div class="controls">
                    <form:input path="produAreaEn" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="produAreaEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="produAreaEn" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产厂商名称（中文）：</label>
                <div class="controls">
                    <form:input path="produFactCn" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="produFactCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="produFactCn" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">代理人名称：</label>
                <div class="controls">
                    <form:input path="agentName" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="agentName" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="agentName" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">代理人住所：</label>
                <div class="controls">
                    <form:input path="agentAddr" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="agentAddr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="agentAddr" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">代理人联系方式：</label>
                <div class="controls">
                    <form:input path="agentCont" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="agentCont" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="agentCont" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">售后服务单位：</label>
                <div class="controls">
                    <form:input path="saledServOrg" disabled="true" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:input path="saledServOrg" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="saledServOrg" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p3">

            <div class="control-group">
                <label class="control-label">附件：</label>
                <div class="controls">
                    <form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
                                 class="input-xlarge required"/>
                    <sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01prodcert/t01ProdCert"
                                  selectMultiple="true"/>
                    <span/>
                </div>
            </div>


            <div class="control-group changeDiv" style="display:none">
                <input class="hideVlue" type="hidden" value="">
                <label class="control-label">变更为：</label>
                <div class="controls" style="display:inline-block; float:left; margin-left:20px;">
                    <form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01prodcert/t01ProdCert"
                                  selectMultiple="true"/>
                </div>
                <div class="remarkDiv controls" style="display:inline-block; float:left; margin-left:24px;">
                    <label class="control-label">变更原因：</label>
                    <form:input path="attachment" htmlEscape="false" maxlength="100" class="input-xlarge "/>
                </div>
            </div>
        </div>

        <input id="hideName" type="hidden" value="sysChanInfoList">

        <div id="footBtnDiv" class="form-actions">
            <input id="isappr" name="isappr" type="hidden" value="0"/>
            <shiro:hasPermission name="gsp:t01prodcert:t01ProdCert:edit">
                <input id="btnAudit" ${t01ProdCert.id == null?'disabled="disabled"':''} class="btn btn-primary" type="button" value="提交" onclick="$('#isappr').val('1');"/>
                <input id="btnSubmit" style="width: 82px;height: 34px;"  ${t01ProdCert.id == null?'disabled="disabled"':''} class="btn btn-primary" type="button" value="保 存" onclick="$('#isappr').val('0');"/>&nbsp;
            </shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回"
                   onclick="window.location='${ctx}/gsp/t01prodcert/t01ProdCert'" />
        </div>
        </form:form>
        <script>
            var hideInput = $("#hideName").val();
            var arrCol = ["chanCol", "chanValue", "chanReason"];
            for (var p = 0, changeInputLen = $(".changeDiv").length; p < changeInputLen; p++) {
                var nameStr = hideInput + "{{idx}}." + arrCol[0];
                var valStr = $($(".changeDiv")[p]).prev().find(".controls").children().attr("name");
                $($(".changeDiv")[p]).find(".hideVlue").attr("name", nameStr);
                $($(".changeDiv")[p]).find(".hideVlue").val(valStr);
            }
            for (var m = 0, changeInputSubLen = $(".changeDiv").find(".controls").length; m < changeInputSubLen; m++) {
                if (m % 2 == 0) {
                    var valueStr = hideInput + "{{idx}}." + arrCol[1];
                    for (var z = 0, childLen = $($(".changeDiv").find(".controls")[m]).children().length; z < childLen; z++) {
                        $($($(".changeDiv").find(".controls")[m]).children()[0]).attr("name", valueStr);
                    }
                }
                else {
                    var nameStr = hideInput + "{{idx}}." + arrCol[2];
                    for (var x = 0, childLen = $($(".changeDiv").find(".controls")[m]).children().length; x < childLen; x++) {
                        $($($(".changeDiv").find(".controls")[m]).children()[1]).attr("name", nameStr);
                    }
                }
            }
        </script>
</body>
</html>

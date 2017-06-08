<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>产品资质管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/modules/gsp/t01ProdCert.js?version=0" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            top.$.jBox.tip.mess = 0;
            //$("#name").focus();
            $("#btnSubmit").click(function(){
                //$( ".required" ).addClass("ignore");
                $("#inputForm").submit();
                setTimeout('$("#messageBox").fadeOut("500")',4000);
            });
            $("#btnAudit").click(function(){
                $( ".required" ).removeClass("ignore");
                $("#inputForm").submit();
                setTimeout('$("#messageBox").fadeOut("500")',4000);
            });
            $(".controls input").blur(function(){
            	setTimeout('$("#messageBox").fadeOut("500")',4000);
            });
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                ignore: ".ignore",
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#errorInfo").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element.siblings("span:last"));
                    }
                }
            });
        });
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
        /**
         * 新增页面的注册证号校验
         */
        function checkProdCertNo4Insert() {
            var prodCertNo = $("#regiCertNbr").val();
            var id = $("#id").val();
            //console.log(currId);
            if (!prodCertNo || id.length > 0) {
                return;
            }
            $.ajax({
                url: ctx + "/gsp/t01prodcert/t01ProdCert/uniqueForAll?prodCertNo=" + prodCertNo,
                type: "get",
                success: function (val) {
                    if (val.code == '0') {
                        alertx(val.message);
                        $("#btnAudit").attr("disabled", "disabled");
                        $("#btnSubmit").attr("disabled", "disabled");
                    } else {
                        $("#btnAudit").removeAttr("disabled");
                        $("#btnSubmit").removeAttr("disabled");
                    }
                },
                error: function () {
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
    <li class="active">产品资质${not empty t01ProdCert.id?'修改':'新增'}</li>
</ul>
<!-- 每页的title（文字换为变量） -->
<div id="topTitle">产品资质${not empty t01ProdCert.id?'修改':'新增'}</div>

<form:form id="inputForm" modelAttribute="t01ProdCert" action="${ctx}/gsp/t01prodcert/t01ProdCert/save" method="post" class="form-horizontal">
<form:hidden path="id"/>
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
        <li role="presentation"  class="active">
            <a href="#p0" role="tab" data-toggle="tab">
                基本信息
            </a>
        </li>
        <li role="presentation" >
            <a href="#p1" role="tab" data-toggle="tab">
                产品信息
            </a>
        </li>
        <li role="presentation" >
            <a href="#p2" role="tab" data-toggle="tab">
                企业信息
            </a>
        </li>
        <li role="presentation" >
            <a href="#p3" role="tab" data-toggle="tab">
                资质上传
            </a>
        </li>
    </ul>
    <div class="tab-content">
        <div role="tabpanel"  class=
                "tab-pane fade in active"

             id="p0">

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 注册证/备案凭证编号：</label>
                <div class="controls">
                    <form:input path="regiCertNbr" htmlEscape="false" maxlength="250" onchange="checkProdCertNo4Insert()" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

       <%--     <div class="control-group">
                <label class="control-label">原注册证/备案凭证编号：</label>
                <div class="controls">
                    <form:input path="origRegiCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>--%>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 风险分类：</label>
                <div class="controls">
                    <form:select path="riskClass" class="input-xlarge required">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_riskClass')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 技术分类-名称：</label>
                <div class="controls">
                    <form:select path="techCateCd" class="input-xlarge required">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_tech_cate_cd')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span>批准日期：</label>
                <div class="controls">
                    <input name="apprDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
                           value="<fmt:formatDate value="${t01ProdCert.apprDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 生效日期：</label>
                <div class="controls">
                    <input name="effeDate" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
                           value="<fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 有效期至：</label>
                <div class="controls">
                    <input name="validPeri" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker required"
                           value="<fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 资质类型：</label>
                <div class="controls">
                    <form:select path="certType" class="input-xlarge required">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_certType')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
                </div>
            </div>
            <%--<div class="control-group">
                <label class="control-label">资质状态：</label>
                <div class="controls">
                    <form:select path="certStat" class="input-xlarge ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
                </div>
            </div>--%>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p1">

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 产品名称（中文）：</label>
                <div class="controls">
                    <form:input path="prodNameCn" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">产品名称（英文）：</label>
                <div class="controls">
                    <form:input path="prodNameEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 型号规格：</label>
                <div class="controls">
                    <form:input path="modelSpec" htmlEscape="false" maxlength="1000" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 结构及组成：</label>
                <div class="controls">
                    <form:input path="struComp" htmlEscape="false" maxlength="1000" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">主要组成成分：</label>
                <div class="controls">
                    <form:input path="mainMnt" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">预期用途：</label>
                <div class="controls">
                    <form:input path="expeUsage" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">适用范围：</label>
                <div class="controls">
                    <form:input path="useScope" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 产品有效期（月）：</label>
                <div class="controls">
                    <form:input path="effiDate" htmlEscape="false" type="number" min="1" max="1000" step="1" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 储存条件：</label>
                <div class="controls">
                    <form:input path="storCond" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 运输条件：</label>
                <div class="controls">
                    <form:input path="tranCond" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">备注：</label>
                <div class="controls">
                    <form:input path="remarks" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">说明：</label>
                <div class="controls">
                    <form:input path="explanation" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p2">

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 注册人/备案人名称(原文)：</label>
                <div class="controls">
                    <form:input path="regiPersName" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 注册人/备案人名称(翻译)：</label>
                <div class="controls">
                    <form:input path="regiPersNameTran" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 注册人/备案人住所：</label>
                <div class="controls">
                    <form:input path="regiPersAddr" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册人/备案人联系方式：</label>
                <div class="controls">
                    <form:input path="regiPersCont" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 生产地址：</label>
                <div class="controls">
                    <form:input path="produAddr" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产国或地区（中文）：</label>
                <div class="controls">
                    <form:input path="produAreaCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产国或地区（英文）：</label>
                <div class="controls">
                    <form:input path="produAreaEn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产厂商名称（中文）：</label>
                <div class="controls">
                    <form:input path="produFactCn" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 代理人名称：</label>
                <div class="controls">
                    <form:input path="agentName" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 代理人住所：</label>
                <div class="controls">
                    <form:input path="agentAddr" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">代理人联系方式：</label>
                <div class="controls">
                    <form:input path="agentCont" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">售后服务单位：</label>
                <div class="controls">
                    <form:input path="saledServOrg" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p3">

            <div class="control-group">
                <label class="control-label"><span class="help-inline"><font color="red">*</font></span> 附件：</label>
                <div class="controls">
                    <form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
                                 class="input-xlarge required"/>
                    <sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01prodcert/t01ProdCert"
                                  selectMultiple="true"/>
                    
                </div>
            </div>
        </div>

        <div id="footBtnDiv" class="form-actions">
            <input id="isappr" name="isappr" type="hidden" value="0"/>
            <shiro:hasPermission name="gsp:t01prodcert:t01ProdCert:edit">
                <input id="btnAudit" class="btn btn-primary" type="button" value="提 交" onclick="$('#isappr').val('1')"/>
                <input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button" value="保 存" onclick="$('#isappr').val('0')"/>&nbsp;
            </shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回"
                   onclick="window.location='${ctx}/gsp/t01prodcert/t01ProdCert'" />
        </div>
        </form:form>
</body>
</html>
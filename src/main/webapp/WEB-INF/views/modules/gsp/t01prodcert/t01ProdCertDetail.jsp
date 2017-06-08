<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>产品资质管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
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
         * 高亮显示变更字段
         */
        $(function(){
            var sysList = ${fns:toJson(t01ProdCert.sysChanInfoList)};
            $.each(sysList,function (i,v){
                var chanCol = v['chanCol'];
                $("input[name="+chanCol+"]").parent().prev().css("color","red");
                $("#"+chanCol).parent().prev().css("color","red");
            });
        });
    </script>
    <style>
        .hoverChange a:visited,.hoverChange a:active {
            color:#969696 !important;
        }
    </style>
</head>
<body>

<!-- 面包屑导航（文字以及链接应换为变量）  -->
<ul class="breadcrumb">
    <li>首页<span class="divider">></span></li>
    <li>首营产品<span class="divider">></span></li>
    <li class="active">产品资质详情</li>
</ul>
<!-- 每页的title（文字换为变量） -->
<div id="topTitle">产品资质详情</div>

<form:form id="inputForm" modelAttribute="t01ProdCert" action="${ctx}/gsp/t01prodcert/t01ProdCert/save"
           method="post" class="form-horizontal">
<form:hidden path="id"/>
<sys:message content="${message}"/>
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
                <label class="control-label">注册证/备案凭证编号：</label>
                <div class="controls">
                    <form:input disabled="true" path="regiCertNbr" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
            <c:if test="${not empty t01ProdCert.origRegiCertNbr}">
                <div class="control-group">
                    <label class="control-label">原注册证/备案凭证编号：</label>
                    <div class="controls">
                        <form:input disabled="true" path="origRegiCertNbr" htmlEscape="false" maxlength="128"
                                    class="input-xlarge "/>
                        <span class="promptPic"></span>
                    </div>
                </div>
            </c:if>

            <div class="control-group">
                <label class="control-label">风险分类：</label>
                <div class="controls">
                    <form:select disabled="true" path="riskClass" class="input-xlarge ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_riskClass')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
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
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">批准日期：</label>
                <div class="controls">
                    <input name="apprDate" disabled="true" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.apprDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生效日期：</label>
                <div class="controls">
                    <input name="effeDate" disabled="true" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.effeDate}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">有效期至：</label>
                <div class="controls">
                    <input name="validPeri" disabled="true" type="text" readonly="readonly" maxlength="20" class="input-medium datepicker "
                           value="<fmt:formatDate value="${t01ProdCert.validPeri}" pattern="yyyy-MM-dd"/>"
                           />
                    <span class="datePic"></span>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">资质类型：</label>
                <div class="controls">
                    <form:select disabled="true" path="certType" class="input-xlarge ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_certType')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">资质状态：</label>
                <div class="controls">
                    <form:select disabled="true" path="certStat" class="input-xlarge ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">审批状态：</label>
                <div class="controls">
                    <form:select disabled="true" path="apprStat" class="input-xlarge ">
                        <form:option value="" label=""/>
                        <form:options items="${fns:getDictList('t01_apprStat')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                    <span class="promptPic"></span>
                </div>
            </div>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p1">

            <div class="control-group">
                <label class="control-label">产品名称（中文）：</label>
                <div class="controls">
                    <form:input disabled="true" path="prodNameCn" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">产品名称（英文）：</label>
                <div class="controls">
                    <form:input disabled="true" path="prodNameEn" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">型号规格：</label>
                <div class="controls">
                    <form:input disabled="true" path="modelSpec" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">结构及组成：</label>
                <div class="controls">
                    <form:input disabled="true" path="struComp" htmlEscape="false" maxlength="512" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">主要组成成分：</label>
                <div class="controls">
                    <form:input disabled="true" path="mainMnt" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">预期用途：</label>
                <div class="controls">
                    <form:input disabled="true" path="expeUsage" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">适用范围：</label>
                <div class="controls">
                    <form:input  disabled="true" path="useScope" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">产品有效期（月）：</label>
                <div class="controls">
                    <form:input disabled="true" path="effiDate" htmlEscape="false" maxlength="11" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">储存条件：</label>
                <div class="controls">
                    <form:input disabled="true" path="storCond" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">运输条件：</label>
                <div class="controls">
                    <form:input disabled="true" path="tranCond" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">备注：</label>
                <div class="controls">
                    <form:input disabled="true" path="remarks" htmlEscape="false" maxlength="256" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">说明：</label>
                <div class="controls">
                    <form:input disabled="true" path="explanation" htmlEscape="false" maxlength="256" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p2">

            <div class="control-group">
                <label class="control-label">注册人/备案人名称(原文)：</label>
                <div class="controls">
                    <form:input disabled="true" path="regiPersName" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册人/备案人名称(翻译)：</label>
                <div class="controls">
                    <form:input disabled="true" path="regiPersNameTran" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册人/备案人住所：</label>
                <div class="controls">
                    <form:input disabled="true" path="regiPersAddr" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">注册人/备案人联系方式：</label>
                <div class="controls">
                    <form:input  disabled="true" path="regiPersCont" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产地址：</label>
                <div class="controls">
                    <form:input disabled="true" path="produAddr" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产国或地区（中文）：</label>
                <div class="controls">
                    <form:input disabled="true" path="produAreaCn" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产国或地区（英文）：</label>
                <div class="controls">
                    <form:input disabled="true" path="produAreaEn" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">生产厂商名称（中文）：</label>
                <div class="controls">
                    <form:input disabled="true" path="produFactCn" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">代理人名称：</label>
                <div class="controls">
                    <form:input disabled="true" path="agentName" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">代理人住所：</label>
                <div class="controls">
                    <form:input disabled="true" path="agentAddr" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">代理人联系方式：</label>
                <div class="controls">
                    <form:input disabled="true" path="agentCont" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">售后服务单位：</label>
                <div class="controls">
                    <form:input disabled="true" path="saledServOrg" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    <span class="promptPic"></span>
                </div>
            </div>
        </div>
        <div role="tabpanel" class=
                "tab-pane fade"

             id="p3">

            <div class="control-group">
                <label class="control-label">附件：</label>
                <div class="controls">
                    <label  style="display: inline-block">${fns:getAttachLabel(t01ProdCert.attachment)}</label>
                    <%--<form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2048"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="attachment" type="files" uploadPath="/gsp/t01prodcert/t01ProdCert"
                                  selectMultiple="true"/>--%>
                    <span class="promptPic"></span>
                </div>
            </div>
        </div>
    </div>
</div>
</form:form>

        <!----------------------------------->
        <form class="relationForm">
            <div id="pagingDiv" class="table-scrollable">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active">
                        <a href="#p4" role="tab" data-toggle="tab">
                            资质信息
                        </a>
                    </li>
                    <li role="presentation">
                        <a href="#p5" role="tab" data-toggle="tab">
                            物料信息
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class=
                            "tab-pane fade in active"

                         id="p4">
                        <div id="borderScroll" style="width:99%; overflow: auto; margin-left:1%;">
                            <%@include file="part_prodCertListTable.jsp"%>
                        </div>
                    </div>
                    <div role="tabpanel" class=
                            "tab-pane fade"

                         id="p5">
                        <div id="borderScroll" style="width:99%; overflow: auto; margin-left:1%;">
                            <%@include file="part_metrInfoListTable.jsp"%>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footBtnDiv" class="form-actions right">
                <input id="btnCancel" class="btn" type="submit" value="返回" onclick="javascript:history.back();return false;"/>
            </div>
        </form>
</body>
</html>
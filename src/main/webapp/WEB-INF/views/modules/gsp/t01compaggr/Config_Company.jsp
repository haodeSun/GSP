<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <%@ include file="/WEB-INF/views/include/treeview.jsp" %>
    <title>企业相关协议信息管理</title>
    <meta name="decorator" content="default"/>
    <style>
        .input-append a.btn {
            margin-left:-80px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

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
            $("#btnSubmit").click(function () {
                $("#inputForm").submit();
            });

//            //经营范围数据展示 begin
//            var setting = {
//                check: {enable: true, nocheckInherit: true},
//                view: {selectedMulti: false},
//                data:{simpleData:{enable:true}},
//                callback:{
//                    beforeClick:function(id, node){
//                    tree.checkNode(node, !node.checked, true, true);
//                    return false;
//                },
//                    beforeCheck: function(){
//                        return false;
//                    }
//                }
//            };

            <%--// 用户-菜单--%>
            <%--var zNodes=[--%>
                    <%--<c:forEach items="${certScopList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},--%>
                <%--</c:forEach>];--%>
            <%--// 初始化树结构--%>
            <%--var tree = $.fn.zTree.init($("#certScopTree"), setting, zNodes);--%>
            <%--// 不选择父节点--%>
            <%--tree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };--%>
            <%--// 默认选择节点--%>

            <%--var ids = "${t01CompInfoSB.certScop}".split(",");--%>
            <%--for(var i=0; i<ids.length; i++) {--%>
                <%--var node = tree.getNodeByParam("id", ids[i]);--%>
                <%--try{tree.checkNode(node, true, false);}catch(e){}--%>
            <%--}--%>
            <%--// 默认展开全部节点--%>
            <%--tree.expandAll(true);--%>
            <%--//经营范围数据展示 end--%>


        });

    </script>
</head>
<body>


<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>企业管理<span class="divider">&gt;</span></li>
    <li class="active">本企业设置</li>
</ul>

<div id="topTitle">本企业设置</div>

<form:form id="inputForm" modelAttribute="t01CompInfoNew"
           action="${ctx}/gsp/t01compaggr/t01CompAggr/saveConfigCompany" method="post"
           class="form-horizontal">
    <sys:message content="${message}"/>
    <div id="pagingDiv" class="table-scrollable">
        <ul class="nav nav-tabs" role="tablist">
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class=
                    "tab-pane fade in active" id="p0">


                <div id="supplier-group" class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        企业名称（中文）：</label>
                    <div class="controls">
                        <sys:treeselect id="compInfoSB" name="compId" value="${t01CompInfoNew.id}" labelName="" labelValue="${t01CompInfoNew.compNameCn}"
                                        title="企业" url="/gsp/t01compinfonew/t01CompInfoNew/getAllComps" cssClass=""/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        企业名称（英文）：
                    </label>
                    <div class="controls">
                        <form:input path="compNameEn" readonly="true" htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        简称：
                    </label>
                    <div class="controls">
                        <form:input path="shortName" readonly="true"  htmlEscape="false" maxlength="250"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        描述：
                    </label>
                    <div class="controls">
                        <form:input path="compDesc" readonly="true" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        备注：
                    </label>
                    <div class="controls">
                        <form:input path="remarks" readonly="true" htmlEscape="false" maxlength="1000"
                                    class="input-xlarge"/>
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        境内/境外：
                    </label>
                    <div class="controls">
                        <input id="abroad0" disabled="disabled"
                               <c:if test="${t01CompInfoNew.abroad=='0'}">checked </c:if> style="width: 30px;" type="radio"
                               name="abroad" value="0"> 境内企业
                        <input id="abroad1" disabled="disabled"
                               <c:if test="${t01CompInfoNew.abroad=='1'}">checked </c:if> style="width: 30px;" type="radio"
                               name="abroad" value="1"> 境外企业
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        企业类型：
                    </label>
                    <div class="controls">
                        <input id="compType" readonly="readonly" type="text" class="input-xlarge" value="<c:if test="${ not empty t01CompInfoNew.buyerId}">购货者</c:if>
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
                        <input id="compState" readonly="readonly" type="text" class="input-xlarge" value="
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
                        <input id="apprState" readonly="readonly" type="text" class="input-xlarge" value="${fns:getDictLabel(t01CompInfoNew.apprStat, 't01_matr_info_appr_stat', '')}" >
                        <span class="promptPic"></span>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div id="footBtnDiv" class="form-actions">
        <shiro:hasPermission name="gsp:t01matrinfo:t01MatrInfo:edit">
            <input id="btnSubmit" class="btn btn-primary btnSubmit" value="保 存"/>&nbsp;
        </shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回"
               onclick="window.location='${ctx}/gsp/t01compinfonew/t01CompInfoNew'"/>
    </div>
</form:form>

<script>
    $(document).ready(function () {

    });
    function compInfoSBTreeselectCallBack() {
        $.ajax({
            async : false,
            type: "post",
            dataType: "json",
            url: '${ctx}/gsp/t01compinfonew/t01CompInfoNew/getCompInfo',
            data: {
                id:$("#compInfoSBId").val()
            },
            success: function (result) {
                if (result!=null) {
                    $("#compNameEn").val(result.compNameEn)
                    $("#shortName").val(result.shortName)
                    $("#compDesc").val(result.compDesc)
                    $("#remarks").val(result.remarks)
                    $("#abroad0").removeAttr("disabled")
                    $("#abroad1").removeAttr("disabled")
                    if("0"==result.abroad){
                        $("#abroad0").click();
                    }
                    if("1"==result.abroad){
                        $("#abroad1").click();
                    }
                    $("#abroad0").attr("disabled","disabled")
                    $("#abroad1").attr("disabled","disabled")
                    $("#compType").val(result.buyerId)
                    $("#compState").val(result.t01CompCert0.certStat)
                    $("#apprState").val(result.apprStat)


//                    // 默认选择节点
//                    var tree = $.fn.zTree.getZTreeObj("certScopTree");
//                    var ids = result.data.certScop.split(",");
//                    for(var i=0; i<ids.length; i++) {
//                        var node = tree.getNodeByParam("id", ids[i]);
//                        try{tree.checkNode(node, true, false);}catch(e){}
//                    }
                }else {
                    alertx("未查询到相关数据");
                }
            },
            error:function () {
                alertx("请求服务器数据失败");
                return null;
            }
        })
    }
</script>
</body>
</html>
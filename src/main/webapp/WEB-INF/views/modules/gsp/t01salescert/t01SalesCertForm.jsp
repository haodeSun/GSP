<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>销售人员管理</title>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/include/treeview.jsp" %>
    <style>
        .input-append a.btn {
            margin-left: -80px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
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
                setCertScopIds();
                ignoreSome();
                $("#inputForm").submit();
            });


            function setCertScopIds() {
                var ids = [], nodes = tree.getCheckedNodes(true);
                for (var i = 0; i < nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#salesScop").val(ids);
            }
            function ignoreSome() {
                $(".control-group[style='display: none;'] .required").addClass("ignore");
            }


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

            var ids = "${t01SalesCert.salesScop}".split(",");
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


        });
    </script>
</head>
<body>
<!-- 面包屑导航（文字以及链接应换为变量）  -->
<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>销售人员授权<span class="divider">&gt;</span></li>
    <c:if test="${empty detail}">
    <li class="active">销售人员授权${not empty t01SalesCert.id?'修改':'新增'}</li>
    </c:if>
    <c:if test="${not empty detail}">
        <li class="active">销售人员授权详情</li>
    </c:if>
</ul>
<c:if test="${empty detail}">
<div id="topTitle">销售人员授权${not empty t01SalesCert.id?'修改':'新增'}</div>
</c:if>
<c:if test="${not empty detail}">
    <div id="topTitle">销售人员授权详情</div>
</c:if>
<form:form id="inputForm" modelAttribute="t01SalesCert" action="${ctx}/gsp/t01salescert/t01SalesCert/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div id="pagingDiv" class="table-scrollable">
        <ul class="nav nav-tabs" role="tablist">
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class=
                    "tab-pane fade in active"

                 id="p0">


                <div class="control-group">
                    <label class="control-label">
											<span class="help-inline"><font
                                                    color="red">*</font> </span>
                        企业名称：</label>
                    <div class="controls">
                        <sys:treeselect id="comp" name="comp.id"
                                        value="${t01SalesCert.comp.id}"
                                        labelName="t01SalesCert.comp.compNameCn"
                                        labelValue="${t01SalesCert.comp.compNameCn}"
                                        title="企业"
                                        url="/gsp/t01compinfo/t01CompInfo/get-all-comp"
                                        cssClass="required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        销售人员姓名：</label>
                    <div class="controls">
                        <form:input path="salesName" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        证件类型：</label>
                    <div class="controls">
                        <form:select path="idType" class="input-xlarge required">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_SalesIDType')}" itemLabel="label"
                                          itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        证件号：</label>
                    <div class="controls">
                        <form:input path="idNbr" htmlEscape="false" maxlength="250" class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        销售区域：</label>
                    <div class="controls">
                        <form:input path="salesArea" htmlEscape="false" maxlength="1000" class="input-xlarge required"/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group" id="certScopDiv" style='display: none;'>
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        授权产品范围：
                    </label>
                    <div class="controls">
                        <div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>
                        <form:hidden path="salesScop"  class="required" maxlength="1000" />
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"> 授权书编号：</label>
                    <div class="controls">
                        <form:input path="salesCertNbr" htmlEscape="false" maxlength="250" class="input-xlarge "/>
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        生效日期：</label>
                    <div class="controls">
                        <input id="effecDate" name="effecDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker required dateCheck"
                               value="<fmt:formatDate value="${t01SalesCert.effecDate}" pattern="yyyy-MM-dd"/>"
                               />
                        <span class="promptPic"></span>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">
                        <span class="help-inline"><font color="red">*</font> </span>
                        有效期至：</label>
                    <div class="controls">
                        <input id="validDate" name="validDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker required dateCheck"
                               value="<fmt:formatDate value="${t01SalesCert.validDate}" pattern="yyyy-MM-dd"/>"
                               />
                        <span class="promptPic"></span>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"><span
                            class="help-inline"><font color="red">*</font></span>
                        附件：</label>
                    <div class="controls">
                        <c:if test="${not empty detail}">
                            ${fns:getAttachLabel(t01SalesCert.attachment)}
                        </c:if>
                        <c:if test="${empty detail}">
                            <form:hidden id="attachment"
                                         path="attachment"
                                         htmlEscape="false"
                                         maxlength="2048"
                                         class="input-xlarge required"/>
                            <sys:ckfinder input="attachment"
                                          type="files"
                                          uploadPath="/gsp/t01salescert/t01SalesCert"
                                          selectMultiple="true"/>
                        </c:if>
                    </div>
                </div>
                <c:if test="${not empty detail}">
                    <div class="control-group">
                        <label class="control-label">
                            销售人员授权状态：
                        </label>
                        <div class="controls">
                            <input id="compState" type="text" class="input-xlarge" value="
${fns:getDictLabel(t01SalesCert.certStat, 't01_certStat', '')}
                        ">
                            <span class="promptPic"></span>
                        </div>
                    </div>
                </c:if>

            </div>
        </div>
    </div>
    <div id="footBtnDiv" class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" style="width:82px; height:34px;" type="button"
               value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回"
               onclick="history.go(-1)"/>
    </div>
</form:form>
<input id="limitCertScop" type="hidden">
<script>
    $(document).ready(function () {
        <c:if test="${not empty detail}">
        $("input").attr("disabled", "disabled");
        $("select").attr("disabled", "disabled");
        $(".help-inline").hide();
        $("#btnSubmit").hide();
        $("#btnCancel").removeAttr("disabled")
        </c:if>

        if(null!=$("#compId").val()&&""!=$("#compId").val()&&""!=$("#compId").val().trim()){
            compTreeselectCallBack();
        }

    });
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
                    if ((result.suplId != null  && "" != result.suplId)
                            && (result.apprStat != null && "审批通过" == result.apprStat)
                            && (result.abroad != null && "0" == result.abroad)) {
                        $("#certScopDiv").css("display", "block")


                        function filter(node) {
                            var certScopStr="";
                            if(result.t01CompCert1.certScop!=null&&""!=result.t01CompCert1.certScop){
                                certScopStr+=result.t01CompCert1.certScop;
                            }
                            if(result.t01CompCert2.certScop!=null&&""!=result.t01CompCert2.certScop){
                                certScopStr+=result.t01CompCert2.certScop;
                            }
                            var limitCertScop=certScopStr.split(",");
                            for (var i=0;i<limitCertScop.length;i++){
                                if(limitCertScop[i]==node.id){
                                    return false;
                                }
                            }
                            return true;
                        }
                        var treeObj = $.fn.zTree.getZTreeObj("certScopTree");
                        var nodes = treeObj.getNodesByFilter(filter); // 查找节点集合
                        for (var i=0, l=nodes.length; i < l; i++) {
                            treeObj.setChkDisabled(nodes[i], true);
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
</script>
</body>
</html>
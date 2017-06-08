<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<div id="operateSaveDiv" class="form-actions" style="display: none;">
    <form id="operateSave" action="${ctx}/gsp/t01operatehist/T01OperateHist/save" method="post">
        <input id="module" type="hidden" name="module">
        <input id="dataId" type="hidden" name="dataId">
        <input id="operateType" type="hidden" name="operateType">

        <div class="control-group">
            <label id="operateLabel" class="control-label"></label>
            <div class="controls">
                <textarea name="description" maxlength="250" class="input-xlarge"></textarea>
            </div>
        </div>

        <input class="btn" type="button" value="返 回" onclick="history.go(-1)"/>

        <input id="operate" class="btn" type="button"/>
    </form>
</div>

<script type="text/javascript">
    $(document).ready(function () {

        var module=GetQueryString("module");
        if (module != null) {
            $("#footBtnDiv").hide();
            initOperateConfig();
        }
    });
    function initOperateConfig() {
        $("#operateSaveDiv").show();
        var module = GetQueryString("module");
        var id = GetQueryString("id");
        var operateType = GetQueryString("operateType");

        $("#module").val(module);
        $("#dataId").val(id);
        $("#operateType").val(operateType);
        var operateVal;
        var operateLabel;
        if ("0" == operateType) {
            operateVal = "确认解冻";
            operateLabel = "解冻原因：";
        }
        if ("1" == operateType) {
            operateVal = "确认冻结";
            operateLabel = "冻结原因：";
        }
        $("#operate").val(operateVal);
        $("#operateLabel").html(operateLabel);

        $("#operate").click(function () {
            operateSave($(this).val());
        });
    }

    function operateSave(operateTypeText) {
        confirmx("是否" + operateTypeText + "？", function () {
            $("#operateSave").submit();
        })
    }

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return decodeURI((r[2]));
        } else {
            return null;
        }
    }
</script>



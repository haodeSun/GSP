<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="module" type="java.lang.String" required="true" description="所在模块" %>
<%@ attribute name="dataId" type="java.lang.String" required="true" description="数据id" %>
<style>
    #template {
        display: none;
    }

    #exportFrame {
        display: none;
    }

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
</style>
<div id="operateHistoryDiv">
    <div>
        <select id="operateClassify">
            <option value="">全部</option>
            <option value="0">审批</option>
            <option value="1">冻结</option>
        </select>
        <span class="checkOut newBtn btn btn-primary" onclick="printOperateHist()">打印</span>
        <span class="checkOut newBtn btn btn-primary" onclick="exportExcel()">导出</span>
    </div>
    <table id="operateHistTable" class="table table-striped table-bordered table-condensed contentTable">
        <thead>
        <tr>
            <td>序号</td>
            <td>操作内容</td>
            <td>操作说明</td>
            <td>操作人</td>
            <td>操作时间</td>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

    <div id="template">
        <table>
            <tbody>
            <tr>
                <td>{orderNum}</td>
                <td>{operateType}</td>
                <td>{description}</td>
                <td>{updateBy.loginName}</td>
                <td>{updateDate}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <iframe id="exportFrame"></iframe>
</div>
<script type="text/javascript">
    $(document).ready(function () {


        getOperateHist();

        $("#operateClassify").change(function () {
            getOperateHist();
        });

    });
    function getOperateHist() {

        $.ajax({
            type: "post",
            dataType: "json",
            url: '${ctx}/gsp/t01operatehist/T01OperateHist',
            data: {
                module: '${module}',
                dataId: '${dataId}',
                classify:$("#operateClassify").val()
            },
            success: function (data) {
                $("#operateHistTable tbody").html("")
                if (data.code == "100") {
                    replaceTemplate(data.data);
                } else {

                }
            },
            error: function () {
                alertx("请求服务器数据失败");
            }
        });
    }

    function replaceTemplate(data) {

        $.each(data, function (idx, obj) {
            var template = $("#template tbody").html();
            template = template.replace("{orderNum}", idx + 1);
            template = template.replace("{operateType}", convertNull(obj.operateType));
            template = template.replace("{description}", convertNull(obj.description));
            template = template.replace("{updateBy.loginName}", convertNull(obj.updateBy.loginName));
            template = template.replace("{updateDate}", convertNull(obj.updateDate));

            $("#operateHistTable tbody").append(template);
        });
    }
    function exportExcel() {
        var url = encodeURI("${ctx}/gsp/t01operatehist/T01OperateHist/export?module=${module}&dataId=${dataId}&classify="+$("#operateClassify").val() + "&timestamp=" + new Date().getTime());
        $("#exportFrame").attr("src", url);
    }
    function convertNull(obj) {
        if (obj == null) {
            return "";
        } else {
            return obj;
        }
    }
    function printOperateHist() {
        $("body").find(":hidden").not("script").attr("data-forPrintOperateHistory", "1")
        $("body").children("[data-forPrintOperateHistory!='1']").hide();
        $("#operateHistTable").show();
        $("body").printArea();
        $("body").children("[data-forPrintOperateHistory!='1']").show();
        $("body").children("[data-forPrintOperateHistory='1']").removeAttr("data-forPrintOperateHistory")
    }
</script>



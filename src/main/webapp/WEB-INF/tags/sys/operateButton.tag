<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="module" type="java.lang.String" required="true" description="所在模块" %>
<%@ attribute name="forward" type="java.lang.String" required="true" description="前往的路径" %>


<a id="operate0" href="javascript:void(0)"><span class="modifySpan newBtn btn btn-primary">解冻</span></a>
<a id="operate1" href="javascript:void(0)"><span class="modifySpan newBtn btn btn-primary">冻结</span></a>


<script type="text/javascript">
    $(document).ready(function () {
        $("#operate0").click(function () {
            operateButton("解冻", "0");
        });
        $("#operate1").click(function () {
            operateButton("冻结", "1");
        });
    });
    function operateButton(operateTypeText, operateType) {
        var handle;
        if("0"==operateType){
            handle="unfreeze";
        }
        if("1"==operateType){
            handle="freeze";
        }

        var selectedIds = "";
        var selectedNum = 0;
        $('#contentTable tbody input[type="checkbox"]').each(function () {
            if (this.checked == true) {
                selectedIds = $(this).attr("data-id").trim();
                selectedNum++;
            }
        });
        if (selectedNum > 1) {
            alertx("只能选择一条数据" + operateTypeText + "！");
            return false;
        } else if (selectedNum == 0) {
            alertx("请选择一条数据" + operateTypeText + "！");
            return false;
        } else {
            $.ajax({
                type: "post",
                dataType: "json",
                url: '${ctx}/gsp/t01operatehist/T01OperateHist/checkBeforeHandleStatus',
                data: {
                    handle: handle,
                    module: '${module}',
                    dataId: selectedIds
                },
                success: function (data) {
                    if ("100" == data.code) {
                        window.location.href = encodeURI("${forward}?id=" + selectedIds + "&module=${module}&operateType=" + operateType + "&timestamp=" + new Date().getTime());
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
    }
</script>



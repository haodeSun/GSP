<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="topSalesCertListDiv" style="position: fixed;z-index: 1000; top:10px; width: 300px;height: 6px;">--%>

<%--</div>--%>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">销售人员授权列表</h3>
    </div>
    <div class="modal-body">
        <div id="topSalesCertListDiv" >

        </div>
    </div>
    <%--<div class="modal-footer">--%>
    <%--<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>--%>
    <%--</div>--%>
</div>

<div id="template1" style="display: none">
    <div id="borderScroll" style="width:99%; overflow: auto;">
        <table id="contentTable" class="table table-striped table-bordered table-condensed">
            <thead>
            <tr>
                <th>销售人员姓名</th>
                <th>证件号</th>
                <th>授权产品范围</th>
                <th>销售区域</th>
                <th>生效日期</th>
                <th>有效期至</th>
                <th style="display: none">操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<div id="template2" style="display: none">
    <table>
        <tbody>
        <tr>
            <td style="display: none"><input class="salesCertID" type="hidden" value="{id}"></td>
            <td>{salesName}</td>
            <td>{idNbr}</td>
            <td>{salesScop}</td>
            <td>{salesArea}</td>
            <td>{effecDate}</td>
            <td>{validDate}</td>
            <td class="noneTd" style="display: none">{operate}</td>
        </tr>
        </tbody>
    </table>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        //$("#p4").append($("#template1").html());
        //$("#topSalesCertListDiv").attr("display", "none")
        $("#addSalesCert").click(function () {
            //$("#topSalesCertListDiv").attr("display", "block")

            $("#myModal").modal('toggle')

            getSalesCertList();
        });
    });
    function getSalesCertList(needIds) {
        $("#topSalesCertListDiv").html("")
        $.ajax({
            url: "${ctx}/gsp/t01complsupl/t01ComplSupl/salesCertList",
            type: "post",
            data: {ids:getSalesCertIDList(),needIds:needIds},
            success: function (result) {
                if (result.code == '100') {
                    addTr(result);
                    $("#topSalesCertListDiv").append($("#template1").html());
                    $("#topSalesCertListDiv tbody>tr").click(function () {
                        toSelectTr(this);
                        $(this).remove();
                    })
                } else {
                    alertx(result.message);
                }
            }, error: function () {
                alertx("请求服务器信息失败");
            }
        });
    }
    function addTr(result) {
        $("#template1 #contentTable>tbody").html("");
        for (var i = 0; i < result.data.length; i++) {
            var tr = $("#template2>table>tbody").html();
            tr = tr.replace("{id}", result.data[i].id);
            tr = tr.replace("{salesName}", result.data[i].salesName);
            tr = tr.replace("{idNbr}", result.data[i].idNbr);
            tr = tr.replace("{salesScop}", result.data[i].salesScop);
            tr = tr.replace("{salesArea}", result.data[i].salesArea);
            tr = tr.replace("{effecDate}", result.data[i].effecDate);
            tr = tr.replace("{validDate}", result.data[i].validDate);
            tr = tr.replace("{operate}", "<span style=\"cursor: pointer;\" onclick='deleteTr(this)'>删除</span>");
            $("#template1 #contentTable>tbody").append(tr);
        }
    }
    function toSelectTr(obj) {
        $(obj).find(".salesCertID").attr("name","t01SalesCertIDList")
        $("#salesCertTable tbody").append("<tr>" + $(obj).html() + "</tr>");
        $("#salesCertTable tbody").find(".noneTd").each(function () {
            $(this).css("display","")
        })
    }
    function deleteTr(obj) {
        $(obj).parents("tr:first").remove();
    }
    function getSalesCertIDList() {
        var ids="";
        $("#salesCertTable .salesCertID").each(function () {
            ids=ids+$(this).val()+",";
        })
        return ids;
    }
</script>
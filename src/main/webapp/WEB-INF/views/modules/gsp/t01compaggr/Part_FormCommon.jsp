<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="topSalesCertListDiv" style="position: fixed;z-index: 1000; top:10px; width: 300px;height: 6px;">--%>

<%--</div>--%>

<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">物料列表</h3>
    </div>
    <div class="modal-body">
        <div id="searchDiv">
            <input id="searchInput" type='text'  maxlength='128' class='input ' placeholder="物料查找"/>
        </div>
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
                <th>物料号</th>
                <th>注册证/备案凭证编号</th>
                <th>产品名称（中文）</th>
                <th>规格型号</th>
                <th style="display: none" >单价</th>
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
            <td style="display: none">
                <input class="matrInfoID" name="t01AggrMatrList[{index}].matr.id" type="hidden" value="{id}">
            </td>
            <td>{matrNbr}</td>
            <td>{regiCertNbr}</td>
            <td>{matrNmCn}</td>
            <td>{specType}</td>
            <td class="noneTd" style="display: none">
                <input  name='t01AggrMatrList[{index}].price' type='text'  maxlength='128' class='input-small '/>
            </td>
            <td class="noneTd" style="display: none">{operate}</td>
        </tr>
        </tbody>
    </table>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        //$("#p4").append($("#template1").html());
        //$("#topSalesCertListDiv").attr("display", "none")
        $("#addMatrInfo").click(function () {
            //$("#topSalesCertListDiv").attr("display", "block")
            $("#myModal").modal('toggle')
            getMatrInfoList();
        });

        $("#searchInput").keyup(function () {
            searchTr($(this).val())
        })
    });
    function getMatrInfoList(needIds) {

        $("#topSalesCertListDiv").html("")
        $.ajax({
            url: "${ctx}/gsp/t01compaggr/t01CompAggr/matrInfoList",
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
            tr = tr.replace("{matrNbr}", result.data[i].matrNbr);
            tr = tr.replace("{regiCertNbr}", replaceBlank(result.data[i].regiCertNbr));
            tr = tr.replace("{matrNmCn}", result.data[i].matrNmCn);
            tr = tr.replace("{specType}", replaceBlank(result.data[i].specType));
            tr = tr.replace("{operate}", "<span style=\"cursor: pointer;\"  onclick='deleteTr(this)'>删除</span>");
            $("#template1 #contentTable>tbody").append(tr);
        }
    }
    function replaceBlank(obj) {
        if (obj == null || obj.length <= 0) {
            return "";
        } else {
            return obj;
        }
    }

    function toSelectTr(obj) {
        $("#matrInfoTable tbody").append("<tr>" + $(obj).html() + "</tr>");
        $("#matrInfoTable tbody").find(".noneTd").each(function () {
            $(this).css("display","")
        })
    }
    function deleteTr(obj) {
        $(obj).parents("tr:first").remove();
        if($("#matrInfoCount")!=null){
            var indexNum = 0;
            $("#matrInfoTable>tbody>tr").each(function () {
                indexNum++;
            });
            if(indexNum==0){
                $("#matrInfoCount").val("");
            }
        }
    }
    function getSalesCertIDList() {
        var ids="";
        $("#matrInfoTable .matrInfoID").each(function () {
            ids=ids+$(this).val()+",";
        })
        return ids;
    }

    function searchTr(inputValue) {
        $("#topSalesCertListDiv tbody>tr").each(function () {
            $(this).css("display","")
            if(inputValue.trim()!=""&&$(this).children('td').eq(1).html().toLowerCase().indexOf(inputValue.toLowerCase())<0){
                if(inputValue.trim()!=""&&$(this).children('td').eq(3).html().toLowerCase().indexOf(inputValue.toLowerCase())<0){
                    $(this).css("display","none")
                }
            }
        })
    }
</script>
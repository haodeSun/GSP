/**
 * Created by guodonglin on 2017/4/5.
 */

$(document).ready(function () {
    if($("#columnName")!=null){
        var saveButton='<li><button id="holdTable" class="btn btn-success" style="margin:2px 0px 10px 2px;background:#DCEBEA;color:#1FB5AC;border:1px solid #1FB5AC">保存设置</button></li>';

        $("#columnName").prepend(saveButton);

    }
    // function attachmentFinderOpen(){
    //     alert(123);
    //     if($(".controls ol li")!=null){
    //
    //         $(".controls ol li>a:last-child").html("-");
    //     }
    //
    // }
});
//表格初始加载
function setTableDefault(param,url1){
        $.ajax({
            type: "post",
            dataType: "json",
            url: url1,
            data: {
                configType:0,
                configParam:param
            },
            success: function (data) {
                if ("100" == data.code) {
                    if(data.data.configValue!=null&&data.data.configValue.length>0){
                        var showCol=data.data.configValue.split(",");
                        $("#contentTable thead th:gt(0)").each(function (index) {
                            var col1= $(this).html();
                            $(this).css("display","none")
                            $("#contentTable tbody tr").each(function () {
                                $(this).find("td:gt(0):eq("+index+")").css("display","none")
                            })

                            for(var i=0;i<showCol.length;i++){
                                if(col1==showCol[i]){
                                    $(this).css("display","table-cell")
                                    $("#contentTable tbody tr").each(function () {
                                        $(this).find("td:gt(0):eq("+index+")").css("display","table-cell")
                                    })
                                    break;
                                }
                            }
                        })
                        $('#columnName li input[type="checkbox"]').each(function () {
                            var col2= $(this).parent().text();
                            $(this).attr("checked",false);
                            for(var i=0;i<showCol.length;i++){
                                if(col2==showCol[i]){
                                    $(this).attr("checked",true);
                                    break;
                                }
                            }

                        })

                    }
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

//表格保存设置
  function holdTable(param,url) {
      $("#holdTable").click(function () {
          var holdList = "";
          $('#columnName li input[type="checkbox"]').each(function () {
              if (this.checked == true) {
                  holdList += $(this).parent().text() + ",";
              }
          });
          $.ajax({
              type: "post",
              dataType: "json",
              url: url,
              data: {
                  configType: 0,
                  configParam: param,
                  configValue: holdList
              },
              success: function (data) {
                  if ("100" == data.code) {
                      alertx("保存成功");
                  }
                  else if ("101" == data.code) {
                      alertx("保存失败");
                  } else {
                      alertx("保存失败");
                  }
              },
              error: function () {
                  alertx("请求服务器数据失败");
              }
          })
      })

  }


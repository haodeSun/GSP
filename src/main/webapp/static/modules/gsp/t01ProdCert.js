/*$(function(){
    $("#contentTable tr:not(:first)").hover(function(){
        $(this).css("cursor","pointer");
    },function(){
        $(this).css("cursor","default");
    });
    $("#contentTable tr:not(:first)").dblclick(function(){
        detail(this);
    });
});*/

// /**
//  * 删除条件
//  * @param obj
//  */
// function deleteSelf(obj){
//     $(obj).parent("li").css({"display":"none"});
// }
// /**
//  * 表单提交
//  */
// function submitThisForm(){
//     $("#searchForm").submit();
// }

// /**
//  * 添加查询条件
//  */
// function addCondition(){
//     var optionsText = $(".ul-form").find("label").text();
//     var newOptionsText = optionsText.split("：");
//     var chooseValue = $("#querySelect").val();
//     var copyHtml = "";
//     for(var k=0,newOptionsTextLen=newOptionsText.length;k<newOptionsTextLen;k++){
//         var liDisplay = $($(".ul-form").find("li")[k]).css("display");
//         if(chooseValue == newOptionsText[k]){
//             if(liDisplay == "block"){
//                 alert("选项已存在");
//             }
//             else{
//                 $($(".ul-form").find("label")[k]).parent().css({"display":"block"});
//                 copyHtml = $($(".ul-form").find("label")[k]).parent().prop("outerHTML");
//                 $($(".ul-form").find("label")[k]).parent().remove();
//                 $(".ul-form li:last").after(copyHtml);
//             }
//         }
//     }
// }
/**
 * 检查变更或者延续是否变更字段
 * @returns {boolean}
 */
function preventSubmit(){
    //判断是否变更过任何字段，如果没有变化过，就不能提交或者保存
    var inputNode = $("input[name='sysChanInfoList[0].chanValue']").val();
    var selectNode = $("select[name='sysChanInfoList[0].chanValue']").val();
    //本来准备做成前段控制，按钮置灰功能，但是这样对前段之前的逻辑影响较大
    /*if(!inputNode && !selectNode){
        alertx("没有任何值不能保存或者提交！");
        $("#btnAudit").attr("disabled","disabled");
        $("#btnSubmit").attr("disabled","disabled");
        return false;
    }else {
        $("#inputForm").submit();
    }*/
    $("#inputForm").submit();
}
/**
 * 删除资质
 */
function deleteProdCert(){
    var checks = $("#contentTable input:checkbox").not(":first").filter(":checked");
    if(checks.size()<1){
        alertx("你必须选择一条记录修改！");
        return ;
    }else if(checks.size()>1){
        alertx("你只能选择一条记录修改！");
        return ;
    }
    var dataId = checks.attr("data-id");
    window.location.href=ctx+"/gsp/t01prodcert/t01ProdCert/delete?id="+dataId;
};
/**
 * 需要套模板
 * 修改按钮调用方法
 */
function update(){
    var checks = $("#contentTable input:checkbox").not(":first").filter(":checked");
    if(checks.size()<1){
        alertx("你必须选择一条记录修改！");
        return ;
    }else if(checks.size()>1){
        alertx("你只能选择一条记录修改！");
        return ;
    }
    var dataId = checks.attr("data-id");
    window.location.href=ctx+"/gsp/t01prodcert/t01ProdCert/form?id="+dataId;
    /*$.ajax({
        url:ctx+"/gsp/t01prodcert/t01ProdCert/beforeUpdate?id="+dataId,
        type:"get",
        async:false,
        success:function(val) {
            if('1' == val.code){
                window.location.href=ctx+"/gsp/t01prodcert/t01ProdCert/form?id="+dataId;
            }else if(val.code){
                alertx(val.message);
            }
        },error:function(){
            alertx("系统出错！");
        }
    });*/
}


/**
 * 需要套模板
 * 导出数据
 */
function exportThis(){
    // top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
        // if(v=="ok"){
            var ids = [];
            var checks = $("#contentTable input:checkbox").not(":first").filter(":checked");
            if(checks.size()>0){
                checks.map(function(){
                    ids.push($(this).attr("data-id"));
                });
                $("#searchForm").append("<input id='ids' name='ids' type='hidden' value='"+ids+"'/>");
            }
            $("#searchForm").attr("action",ctx+"/gsp/t01prodcert/t01ProdCert/export");
            $("#searchForm").submit();
        // }
        $("#ids").remove();
        $("#searchForm").attr("action",ctx+"/gsp/t01prodcert/t01ProdCert/list");
    // },{buttonsFocus:1});
    top.$('.jbox-body .jbox-icon').css('top','55px');
}
/**
 * 变更和延续保存按钮执行方法
 */
function preSaveHandle() {
    var removeArr = [];
    for (var i = 0, changeDivLen = $(".changeDiv").length; i < changeDivLen; i++) {
        if ($($(".changeDiv")[i]).css("display") == "none") {
            removeArr.push($($(".changeDiv")[i]));
        }
    }
    for (var n = 0, arrLen = removeArr.length; n < arrLen; n++) {
        removeArr[n].remove();
    }
    for (var j = 0, changeNameLen = $(".changeDiv").find(".controls").length / 2; j < changeNameLen; j++) {
        for (var k = 0, trueInpurLen = 1; k < trueInpurLen; k++) {
            var childNode = '';
            if($($($(".changeDiv")[j]).find(".controls")[k]).children("select").length != "0"){
                childNode = "select";
            }
            else{
                childNode = "input";
            }
            if ($($($(".changeDiv")[j]).find(".controls")[k]).children(childNode).attr("name").indexOf("{{idx}}") != "-1") {
                var replaceName = $($($(".changeDiv")[j]).find(".controls")[k]).children(childNode).attr("name").replace("{{idx}}", "[" + j + "]");
                var replaceHideName = $($(".changeDiv")[j]).find(".hideVlue").attr("name").replace("{{idx}}", "[" + j + "]");
                var changeName = $($(".changeDiv")[j]).find(".remarkDiv").children("input").attr("name").replace("{{idx}}", "[" + j + "]");
                $($($(".changeDiv")[j]).find(".controls")[k]).children(childNode).attr("name", replaceName);
                $($(".changeDiv")[j]).find(".hideVlue").attr("name", replaceHideName);
                $($(".changeDiv")[j]).find(".remarkDiv").children("input").attr("name", changeName);
            }
        }
    }
}

//注册证号排重
function checkProdCertNo(){
    var prodCertNo = $("#regiCertNbr").val().trim();
    var currId = $("input:hidden[name='currId']").val();
    //console.log(currId);
    if(!prodCertNo || currId || prodCertNo.length == 0) {
        return ;
    }
    $.ajax({
        url:ctx+"/gsp/t01prodcert/t01ProdCert/uniqueForAll?prodCertNo="+prodCertNo,
        type:"get",
        success:function(val){
            if(val.code == '0'){
                alertx(val.message);
                $("#btnAudit").attr("disabled","disabled");
                $("#btnSubmit").attr("disabled","disabled");
            }else{
                $("#btnAudit").removeAttr("disabled");
                $("#btnSubmit").removeAttr("disabled");
            }
        },
        error:function(){
        }
    });
}

/**
 * 查看资质详情
 * @param obj
 */
/*
function detail(obj){
    var id = $(obj).find("td:first input").attr("data-id");
    console.log(id);
    if(!id){
        alertx("查看详情出错！");
    }
    window.location.href="ctx/gsp/t01prodcert/t01ProdCert/details?id="+id;
}
*/


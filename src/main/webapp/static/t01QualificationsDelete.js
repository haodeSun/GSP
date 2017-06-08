/**
 * 此文件里面包含所有通用方法；
 * 初始加载项包含内容：
 *     处理弹出框兼容
 *     处理查询条件的传递方式
 *     处理查询条件内容格式
 */
$(document).ready(function() {
    top.$.jBox.tip.mess = 0;
    if (parent.document.getElementById("mainFrame") != null) {
        menuHighLight(parent.document.getElementById("mainFrame").contentWindow.location.href);
    }
    var optionsCN = $(".ul-form").find("label").text();
    $("#contentTable").find("thead tr th").text();
    var newOptionsCN = optionsCN.split("：");
    for(var i=0,newOptionsCNLen=newOptionsCN.length;i<newOptionsCNLen-1;i++){
        $("#querySelect").append("<option value ='"+newOptionsCN[i]+"'>"+newOptionsCN[i]+"</option>");
    }
    for(var k=1,thValLen=$("#contentTable").find("thead tr th").length;k<thValLen;k++){
        $("#columnName").append("<li data-stopPropagation='true'><input type='checkbox' checked='checked' onchange='columnChoose()'/>"+$($("#contentTable").find("thead tr th")[k]).text()+"</li>");
    }
    if ($("#conditionOrderUl").length != 0 && $("#conditionOrder").length != 0 && $("#conditionOrder").val() != "") {

        $.base64.utf8encode = true;
        $("#conditionOrderUl").html($.base64.atob($("#conditionOrder").val(), true));
        $(".ul-form").find("select").each(function () {
            $(this).select2();
            $(this).val($(this).attr("data-value"));
            var selectChosenVal = $(this).parent("li").find("div:first").find(".select2-chosen").text();
            $(this).parent("li").find("div:first").remove();
            $(this).parent("li").find("div:first").find(".select2-chosen").text(selectChosenVal);

        });
        $("#conditionOrderUl").find("li>input[type='text']").each(function (key, value) {
            if ($(value).parent("li").css("display") == "block") {
                $(value).val($(value).attr("data-value"));
            }
        });
        //单独处理number类型
        $("#conditionOrderUl").find("li>input[type='number']").each(function (key, value) {
            if ($(value).parent("li").css("display") == "block") {
                $(value).val($(value).attr("data-value"));
            }
        });
    }
    $(document).click(function(){
		$(window.parent.document).find(".fadeInLeft").css({"display":"none","right":"45px"});
	});
    dropdownOpen();
    $("select").on("select2-close", function(e) {
        //添加自动验证
        if ($("#inputForm") != null && $("#inputForm").validate() != null) {
            var validator = $("#inputForm").validate();
            validator.element(this);
        }
    })

    initDatePicker();

    //change the default matcher
    function matchStart(term, text) {
        if (text.toUpperCase().indexOf(term.trim().toUpperCase()) >= 0) {
            return true;
        }
        return false;
    }
    $("select").select2({
        matcher: matchStart
    });
    toggleListTitle();
    
    $(window).resize(function(){
    	$(".changeDiv").each(function(){
    		if($(this).find(".controls:eq(0)").children("input").size() != 0){
    			$(this).find(".controls:eq(0)").css({"width":($(this).prev().find(".controls").children(":eq(0)").width()+12)});
    		}else{
    			$(this).find(".controls:eq(0)").css({"width":$(this).prev().find(".controls").children(":eq(0)").width()});
    		}
    	});
	});

});

function toggleListTitle(){
    if($("#foldList .accordion-heading a")!=null){
        $("#foldList .accordion-heading a").click(function () {
            if($(this).hasClass("collapsed")){
                $(this).html("折叠列表");
            }else {
                $(this).html("展开列表");
            }
        })
    }
}

function initDatePicker() {
    $(".datepicker").datepicker({
        language: 'zh-CN',
        format:'yyyy-mm-dd',
        autoclose: true,
        clearBtn:true,
        todayBtn:'linked',
        todayHighlight:true
    });
    $(".datepicker").datepicker()
        .on('hide', function(e) {
            if ($("#inputForm") != null && $("#inputForm").validate() != null) {
                var validator = $("#inputForm").validate();
                validator.element(this);
            }
        });
}

/**
 * table分页插件初始化
 * @param n
 * @param s
 * @returns {boolean}
 */
function page(n,s){
    $("#pageNo").val(n);
    $("#pageSize").val(s);
    $("#searchForm").submit();
    return false;
}
/**
 * 双页日期插件初始化
 * @param obj
 */
function dataQuery(obj){
    $(obj).daterangepicker({
        autoUpdateInput: false,
        locale: {
            cancelLabel: 'Clear'
        }
    });

    $(obj).on('apply.daterangepicker', function(ev, picker) {
        $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
    });

    $(obj).on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });
}
/**
 * 单页日期控件初始化
 * @param obj
 */
function dataEnter(obj){
    $(obj).daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        timePicker: true,
        locale: {
            cancelLabel: 'Clear'
        }
    });
    $(obj).on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });
}
/**
 * “列名称”选项菜单不缩回功能
 */
function dropdownOpen() {
    var $dropdownLi = $("#columnName li");
    $dropdownLi.click(function(e) {
        e.stopPropagation();
    });
}
function menuHighLight(hrefName){
    $('.accordion-group', window.parent.document).each(function(){
        $(this).find(".accordion-body .accordion-inner ul li ul li").each(function(key,value){
            if(hrefName.indexOf($(value).children("a").attr("href")) > 0){
                $(value).siblings("li").removeClass("active");
                $(value).addClass("active");
            }
        });
    });
}
/**
 * 删除查询条件功能
 * @param obj
 */
function deleteSelf(obj){
    if($(obj).parent("li").find("select").length > 0){
        $(obj).parent("li").find(".select2-chosen").text("");
        $(obj).parent("li").find("select").val("").attr("data-value","");
    }
    else{
        $(obj).parent("li").find("input").val("");
    }
    $(obj).parent("li").css({"display":"none"});
}
/**
 * 查询条件的查询功能
 */
function submitThisForm() {
    if ($("#conditionOrderUl").length != 0 && $("#conditionOrder").length != 0) {
        $("#conditionOrderUl").find("li>input[type='text']").each(function (key, value) {
            if ($(value).parent("li").css("display") == "block") {
                $(value).attr("data-value", $(value).val());
            }
        });
        $("#conditionOrderUl").find("select").each(function (key, value) {

            if ($(value).parent("li").css("display") == "block") {
                $(value).attr("data-value", $(value).val());
            }
        });
        //单独处理number类型
        $("#conditionOrderUl").find("input[type='number']").each(function(key,value){
            if ($(value).parent("li").css("display") == "block") {
                $(value).attr("data-value", $(value).val());
            }
        });
        $.base64.utf8encode = true;

        $("#conditionOrder").val($.base64.btoa($("#conditionOrderUl").html()));

        $("#searchForm").submit();
    }else {

        $("#searchForm").submit();}
}
/**
 * 清空查询数值功能
 */
function emptyThisForm(){
    $("#conditionOrderUl").find("li").each(function(){
        if($(this).css("display") == "block"){
            if($(this).find("select").length > 0){
                $(this).find(".select2-chosen").text("");
                $(this).find("select").val("").attr("data-value","");
            }
            else{
                $(this).find("input").val("");
            }
        }
    });
}
/**
 * 添加查询条件功能
 */
function addCondition(){
    var optionsText = $(".ul-form").find("label").text();
    var newOptionsText = optionsText.split("：");
    var chooseValue = $("#querySelect").val();
    var copyHtml = "";


    if($("#querySelect").siblings("div").find(".select2-chosen").html() == "&nbsp;"){
        alertx("请选择添加项");
    }
    else{
        for(var k=0,newOptionsTextLen=newOptionsText.length;k<newOptionsTextLen;k++){
            var liDisplay = $($(".ul-form").find("li")[k]).css("display");
            if(chooseValue == newOptionsText[k]){
                if(liDisplay == "block"){
                    alertx("选项已存在");
                }
                else{
                    if($($(".ul-form").find("label")[k]).siblings("select").length != 0){
                        $($(".ul-form").find("label")[k]).siblings("div").remove();
                    }
                    $($(".ul-form").find("label")[k]).parent().css({"display":"block"});
                    copyHtml = $($(".ul-form").find("label")[k]).parent().prop("outerHTML");
                    $($(".ul-form").find("label")[k]).parent().remove();
                    $(".ul-form li:last").after(copyHtml);
                    $(".ul-form li:last").find("select").select2();
                    initDatePicker();
                }
            }
        }
        if($("#foldList .accordion-heading .accordion-toggle").hasClass("collapsed")){
            $("#foldList .accordion-heading .accordion-toggle").click();
        }
    }
}
/**
 * 列表多选框全选功能(thead一对多)
 * @param obj
 */
function chooseAll(obj){
    if($(obj).attr("checked") == "checked"){
        $(obj).parents("thead").siblings("tbody").find("input:checkbox").attr("checked","checked");
    }
    else{
        $(obj).parents("thead").siblings("tbody").find("input:checkbox").attr("checked",false);
    }
}
/**
 * 判定列表多选框是否全选(tbody多对一)
 */
function checkAll(){
    var allNum = 0;
    $("tbody").find("input:checkbox").each(function(){
        if($(this).attr("checked") == "checked"){
            allNum++;
        }
    });
    if(allNum == $("tbody").find("input:checkbox").length){
        $("thead").find("input:checkbox").attr("checked","checked");
    }
    else{
        $("thead").find("input:checkbox").attr("checked",false);
    }
}
/**
 * “列名称”菜单功能
 */
function columnChoose(){
    var noneName = [],noneIndex = [];
    $("#columnName").find("input:checkbox").each(function(){
        if($(this).attr("checked") != "checked"){
            noneName.push($(this).parent().text());
        }
    });

    $("#contentTable").find("thead tr th").each(function(index){
        if(index != 0){
            if($.inArray($(this).text(),noneName) != -1){
                $(this).css({'display':'none'});
                noneIndex.push(index);
            }
            else{
                $(this).css({'display':''});
            }
        }
    });

    $("#contentTable").find("tbody tr").each(function(){
        $(this).find("td").each(function(index){
            if(index != 0){
                if($.inArray(index,noneIndex) != -1){
                    $(this).css({'display':'none'});
                }
                else{
                    $(this).css({'display':''});
                }
            }
            else{
                $(this).css({'display':''});
            }
        });
    });

}

function oneDataHandler(handlerName, handlerFunction) {
    var selectedId = "";
    var selectedNum = 0;
    $('#contentTable tbody input[type="checkbox"]').each(function () {
        if (this.checked == true) {
            selectedId = $(this).attr("data-id").trim();
            selectedNum++;
        }
    });

    if (selectedNum > 1) {
        alertx("只能选择一条数据进行" + handlerName + "！");
        return false;
    } else if (selectedNum == 0) {
        alertx("请选择一条数据进行" + handlerName + "！");
        return false;
    } else {
        handlerFunction(selectedId);
    }
}

function oneDataEdit(handlerFunction) {
    oneDataHandler("修改", handlerFunction);
}
function oneDataDelete(handlerFunction) {
    oneDataHandler("删除", handlerFunction);
}
function oneDataAppr(handlerFunction) {
    oneDataHandler("审批", handlerFunction);
}
function oneDataChange(handlerFunction) {
    oneDataHandler("变更", handlerFunction);
}
function oneDataContinue(handlerFunction) {
    oneDataHandler("延续", handlerFunction);
}

function checkStatusBeforeHandleById(url,handle,id,okFunction) {
    $.ajax({
        type: "post",
        dataType: "json",
        url: url,
        data: {
            handle: handle,
            id: id
        },
        success: function (data) {
            if ("100" == data.code) {
                okFunction(id);
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
function baseEditFunction(url, id, editUrl) {
    checkStatusBeforeHandleById(url, "edit", id, function (id) {
        window.location.href = editUrl + "?id=" + id;
    })
}
function baseDeleteFunction(url, id, deleteUrl) {
    checkStatusBeforeHandleById(url, "delete", id, function (id) {
        confirmx('一旦删除数据将无法恢复，请确认是否删除？', function () {
            window.location.href = deleteUrl + "?id=" + id;
        });
    })
}
function baseApprFunction(url, id, apprUrl) {
    checkStatusBeforeHandleById(url, "appr", id, function (id) {
        window.location.href = apprUrl + "?id=" + id;
    })
}
function baseChangeFunction(url, id, changeUrl) {
    checkStatusBeforeHandleById(url, "change", id, function (id) {
        window.location.href = changeUrl + "?id=" + id;
    })
}


function getAttachLabel(attach) {
    var label = "";
    var labelStr = "";
    if (attach != null && attach != "") {
        var strs = attach.substring(1).split("[|]");
        for (var i = 0; i < strs.length; i++) {
            var showName = strs[i].substring(strs[i].lastIndexOf("/") == -1 ? 0 : strs[i].lastIndexOf("/") + 1);
            showName = decodeURI(showName);
            label += "，<a href=\"";
            label += strs[i];
            label += "\"";
            label += " target=\"_blank\"";
            label += ">";
            label += showName;
            label += "</a>";
        }
    }
    //截取掉第一个逗号
    if (label.length > 2) {
        labelStr = label.substring(1);
    }

    return labelStr;
}
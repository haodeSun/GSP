<style>
    .contentTable tr th {
        -webkit-box-sizing: border-box;
        background-image:none;
        background:#1fb5ac;
        height:40px;
        font-size:12px;
        font-weight:bold;
        color:#ffffff;
        text-align:center;
        vertical-align: middle;
        white-space: nowrap;
    }
    .contentTable tr td {
        -webkit-box-sizing: border-box;
        height:40px;
        font-size:12px;
        color:#3c3c3c;
        text-align:center;
        white-space: nowrap;
    }
    .input-append a.btn {
        margin-left:-80px;
    }
</style>
<script>
    $(document).ready(function() {
//经营范围数据展示 begin
        var setting = {
            check: {enable: true, nocheckInherit: true},
            view: {selectedMulti: false},
            data: {simpleData: {enable: true}},
            callback: {
                beforeClick: function (id, node) {
                    tree.checkNode(node, !node.checked, true, true);
                    return false;
                },
                beforeCheck: function () {
                    return false;
                }
            }
        };

        // 用户-菜单
        var zNodes=[<#list t01CompAggr.certScopList as menu>
        {id:"${menu.id!''}", pId:"${menu.parent.id!''}", name:"${menu.name!''}"},
        </#list>];
        // 初始化树结构
        var tree = $.fn.zTree.init($("#certScopTree"), setting, zNodes);
        // 不选择父节点
        tree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps" };
        // 默认选择节点
        function beforeCheck(treeId, treeNode) {
            return (treeNode.doCheck !== false);
        }
        var ids = "${t01CompAggr.aggrScop!''}".split(",");
        for(var i=0; i<ids.length; i++) {
            var node = tree.getNodeByParam("id", ids[i]);
            try{tree.checkNode(node, true, false);}catch(e){}
        }
        // 默认展开全部节点
        tree.expandAll(true);
        //经营范围数据展示 end

    });

</script>
<ul class="breadcrumb">
    <li>首页<span class="divider">&gt;</span></li>
    <li>协议管理<span class="divider">&gt;</span></li>
    <li class="active">协议管理审批</li>
</ul>

<div id="topTitle">协议管理审批</div>

<form id="inputForm" class="form-horizontal">

        <div id="pagingDiv" class="table-scrollable">
            <div id="changeThePic" class="
                <#if t01CompAggr.apprStat=='1'>
                    noApproval
                <#elseif t01CompAggr.apprStat=='2'>
                    passApproval
                <#elseif t01CompAggr.apprStat=='3'>
                    rejectApproval
                </#if>">
            </div>
            <ul class="nav nav-tabs" role="tablist">
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class=
                        "tab-pane fade in active" id="p0">

                    <div class="control-group">
                        <label class="control-label"> 协议类别：</label>
                        <div class="controls">
                            <select id="aggrType" name="aggrType" class="input-xlarge required" disabled="disabled">
                                <option value="" selected="selected">${getDictLabel(t01CompAggr.aggrType,'t01_comp_aggr_type','')}</option>
                            </select>
                        </div>
                    </div>

                    <#if t01CompAggr.aggrType=='0'>
                    <div id="supplier-group" class="control-group" style="display: none">
                        <label class="control-label"> 供货者：</label>
                        <div class="controls">
                            <input type="text" disabled="disabled" <#if t01CompAggr.supplier??> value="${t01CompAggr.supplier.t01CompInfo.compNameCn!''}"  </#if>>
                        </div>
                    </div>
                    <#elseif t01CompAggr.aggrType=='1'>

                    <div id="buyer-group" class="control-group">
                        <label class="control-label"> 购货者：</label>
                        <div class="controls">
                            <input type="text" disabled="disabled" <#if t01CompAggr.buyer??> value="${t01CompAggr.buyer.t01CompInfo.compNameCn!''}" </#if>  >
                        </div>
                    </div>
                    </#if>

                    <div class="control-group">
                        <label class="control-label"> 协议编号：</label>
                        <div class="controls">
                            <input id="agreementNo" name="agreementNo" class="input-xlarge required" disabled="disabled"
                                   type="text" value="${t01CompAggr.agreementNo!''}" maxlength="250"/>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label"> 销售授权人：</label>
                        <div class="controls">
                            <input id="author" name="author" class="input-xlarge required" disabled="disabled"
                                   type="text" value="${t01CompAggr.authorName!''}" maxlength="250"/>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label"> 销售区域：</label>
                        <div class="controls">
                            <input id="location" name="location" class="input-xlarge required" disabled="disabled"
                                   type="text" value="${t01CompAggr.location!''}" maxlength="250"/>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label"> 协议范围：</label>
                        <div class="controls">
                            <div id="certScopTree" class="ztree" style="margin-top:3px;float:left;"></div>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label"> 生产企业：</label>
                        <div class="controls">
                            <input id="prodComp" name="prodComp" class="input-xlarge " disabled="disabled" type="text"
                                   value="${t01CompAggr.prodComp!''}" maxlength="250"/>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label"> 协议金额：</label>
                        <div class="controls">
                            <input id="aggrAmnt" name="aggrAmnt" class="input-xlarge " disabled="disabled" type="text"
                                   value="${t01CompAggr.aggrAmnt!''}" maxlength="250"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label"> 生效日期：</label>
                        <div class="controls">
                            <input disabled="disabled" name="effecDate" type="text" readonly="readonly"
                                   maxlength="20" class="input-medium Wdate required"
                                   value="${(t01CompAggr.effecDate?string("yyyy-MM-dd"))!''}"
                                   />
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label"> 有效期至：</label>
                        <div class="controls">
                            <input disabled="disabled" name="validDate" type="text" readonly="readonly"
                                   maxlength="20" class="input-medium Wdate required"
                                   value="${(t01CompAggr.validDate?string("yyyy-MM-dd"))!''}"
                                   />
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label"> 附件：</label>
                        <div class="controls" style="height:auto">
                            <div>${getAttachLabel(t01CompAggr.attachment)}</div>
                        </div>
                    </div>


                </div>
            </div>
            <div class="control-group">
                <label class="control-label">关联物料：</label>
                <table id="matrInfoTable" class="table table-striped table-bordered table-condensed contentTable">
                    <thead>
                    <tr>
                        <th>物料号</th>
                        <th>注册证/备案凭证编号</th>
                        <th>产品名称（中文）</th>
                        <th>规格型号</th>
                        <th>单价</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list t01CompAggr.t01CompAggrRelateMatrInfoList as t01CompAggrRelateMatrInfo>
                        <tr>
                            <td>${t01CompAggrRelateMatrInfo.matrNbr!''}</td>
                            <td>${t01CompAggrRelateMatrInfo.regiCertNbr!''}</td>
                            <td>${t01CompAggrRelateMatrInfo.matrNmCn!''}</td>
                            <td>${t01CompAggrRelateMatrInfo.specType!''}</td>
                            <td>
                                <input  disabled="disabled" value="${t01CompAggrRelateMatrInfo.matrPrice!''}" type='text' maxlength='128'
                                       class='input-small '/>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>


            </div>
        </div>
</form>

<%@page pageEncoding="UTF-8" %>

<input id="exportIds" name="ids" type="hidden">
<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
<input id="conditionOrder" name="conditionOrder" type="hidden" value="${conditionOrder}">
<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
<div id="foldList" class="accordion-group">
    <div class="accordion-heading">
        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
            折叠列表
        </a>
    </div>
    <div id="collapseOne" class="accordion-body collapse in">
        <div class="accordion-inner">
        	<div id="selectGroup" class="accordion-group">
				<span>查询条件</span>
				<select name='' aria-required=true' class='form-control' id='querySelect' style="width:200px;margin-left:15px;"></select>
				<a id="addCondition" class="btn btn-primary"  onclick="addCondition()">添加条件</a>
                <a id="emptyValue" class="btn btn-primary" onclick="emptyThisForm()">清空数值</a>
			</div>
            <ul  id="conditionOrderUl" class="ul-form">
                <li style="display:block;"><label>销售人员姓名：</label>
                    <form:input path="salesName" htmlEscape="false" maxlength="16" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>所在企业：</label>
                    <form:input path="comp.compNameCn" htmlEscape="false" maxlength="200" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>销售人员授权状态：</label>
                    <form:select path="certStat" class="input-medium">
                        <form:option value="" label="请选择"/>
                        <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>证件类型：</label>
                    <form:select path="idType" class="input-medium">
                        <form:option value="" label="请选择"/>
                        <form:options items="${fns:getDictList('t01_SalesIDType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                    </form:select>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>证件号：</label>
                    <form:input path="idNbr" htmlEscape="false" maxlength="64" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>销售区域：</label>
                    <form:input path="salesArea" htmlEscape="false" maxlength="128" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <%--<li style="display:none;"><label>授权产品范围：</label>--%>
                    <%--<form:input path="salesScop" htmlEscape="false" maxlength="128" class="input-medium"/>--%>
                    <%--<span class="btn btn-primary" onclick="deleteSelf(this)">一</span>--%>
                <%--</li>--%>
                <li style="display:none;"><label>授权书编号：</label>
                    <form:input path="salesCertNbr" htmlEscape="false" maxlength="64" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>生效日期：</label>
                    <input name="effecDateBg" type="text" readonly="readonly"class="input-medium datepicker"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>有效期至：</label>
                    <input name="validDateEd" type="text" readonly="readonly"class="input-medium datepicker"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>更新时间：</label>
                    <input name="updateDateBg" type="text" readonly="readonly"class="input-medium datepicker"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
            </ul>
            <a id="btnSubmit" class="btn btn-primary"  onclick="submitThisForm()">查询</a>
        </div>
    </div>
</div>

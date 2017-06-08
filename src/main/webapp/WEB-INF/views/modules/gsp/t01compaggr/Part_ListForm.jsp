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
                <li style="display:block;"><label>协议编号：</label>
                    <form:input path="agreementNo" htmlEscape="false" maxlength="128" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>协议类别：</label>
                    <form:select path="aggrType" class="input-medium">
                        <form:option value="" label="请选择"/>
                        <form:options items="${fns:getDictList('t01_comp_aggr_type')}" itemLabel="label"
                                      itemValue="value" htmlEscape="false"/>
                    </form:select>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>供货者：</label>
                    <form:input path="supplier.t01CompInfo.compNameCn" htmlEscape="false" maxlength="128" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>购货者：</label>
                    <form:input path="buyer.t01CompInfo.compNameCn" htmlEscape="false" maxlength="128" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>生效日期：</label>
                    <input name="effecDateBg" type="text" readonly="readonly"class="input-small datepicker"/>
                    -
                    <input name="effecDateEd" type="text" readonly="readonly"class="input-small datepicker"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>有效期至：</label>
                    <input name="validDateBg" type="text" readonly="readonly"class="input-small datepicker"/>
                    -
                    <input name="validDateEd" type="text" readonly="readonly"class="input-small datepicker"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>协议状态：</label>
                    <form:select path="aggrStat" class="input-medium">
                        <form:option value="" label="请选择"/>
                        <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label"
                                      itemValue="value" htmlEscape="false"/>
                    </form:select>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>审核状态：</label>
                    <form:select path="apprStat" class="input-medium">
                        <form:option value="" label="请选择"/>
                        <form:options items="${fns:getDictList('t01_apprStat')}" itemLabel="label"
                                      itemValue="value" htmlEscape="false"/>
                    </form:select>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>最后操作时间：</label>
                    <input name="updateDateBg" type="text" readonly="readonly"class="input-small datepicker"/>
                    -
                    <input name="updateDateEd" type="text" readonly="readonly"class="input-small datepicker"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>销售授权人：</label>
                    <form:input path="authorName" htmlEscape="false" maxlength="250" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>销售区域：</label>
                    <form:input path="location" htmlEscape="false" maxlength="250" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>生产企业：</label>
                    <form:input path="prodComp" htmlEscape="false" maxlength="250" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
                <li style="display:none;"><label>协议金额：</label>
                    <form:input path="aggrAmnt" htmlEscape="false" maxlength="250" class="input-medium"/>
                    <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                </li>
            </ul>
            <a id="btnSubmit" class="btn btn-primary"  onclick="submitThisForm()">查询</a>
        </div>
    </div>
</div>

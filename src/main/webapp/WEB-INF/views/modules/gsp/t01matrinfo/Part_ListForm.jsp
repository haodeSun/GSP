<%@page pageEncoding="UTF-8" %>


    <input id="exportIds" name="ids" type="hidden">
    <input id="conditionOrder" name="conditionOrder" type="hidden" value="${conditionOrder}">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="orderBy" name="orderBy" type="hidden">
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
					<select name='' aria-required="true" class='form-control' id='querySelect'
							style="width:200px;margin-left:15px;"></select>
					<a id="addCondition" class="btn btn-primary"  onclick="addCondition()">添加条件</a>
					<a id="emptyValue" class="btn btn-primary" onclick="emptyThisForm()">清空数值</a>
				</div>
                <ul id="conditionOrderUl" class="ul-form">
                    <li style="display:block;"><label>物料号：</label>
                        <form:input path="matrNbr" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>物料名称（中文）：</label>
                        <form:input path="matrNmCn" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>物料名称（英文）：</label>
                        <form:input path="matrNmEn" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>描述：</label>
                        <form:input path="matrDesc" htmlEscape="false" maxlength="1000" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>物料分类：</label>
                        <form:select path="matrType" class="input-medium">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_matr_info_matr_type')}" itemLabel="label"
                                          itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>货币单位：</label>
                        <form:input path="priceUnit" htmlEscape="false" maxlength="64" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>物料单价：</label>
                        <form:input path="matrPrice" htmlEscape="false" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>备注：</label>
                        <form:input path="remarks" htmlEscape="false" maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>物料状态：</label>
                        <form:select path="martStat" class="input-medium">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_matr_info_mart_stat')}" itemLabel="label"
                                          itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>审批状态：</label>
                        <form:select path="apprStat" class="input-medium">
                            <form:option value="" label=""/>
                            <form:options items="${fns:getDictList('t01_matr_info_appr_stat')}" itemLabel="label"
                                          itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>更新时间：</label>
                        <input name="updateDate" type="text" readonly="readonly" maxlength="20"
                               class="input-medium datepicker"
                               value="<fmt:formatDate value="${t01MatrInfo.updateDate}" pattern="yyyy-MM-dd"/>"
                               />
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                </ul>
                <a id="btnSubmit" class="btn btn-primary" onclick="submitThisForm()">查询</a>
            </div>
        </div>
    </div>

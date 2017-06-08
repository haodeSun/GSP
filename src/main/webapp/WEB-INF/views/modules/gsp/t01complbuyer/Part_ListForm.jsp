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
                    <li style="display:block;"><label>企业名称（中文）：</label>
                        <form:input path="t01CompInfo.compNameCn"
                                    htmlEscape="false" maxlength="250"
                                    class="input-medium"/> <span
                                class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>企业名称（英文）：</label>
                        <form:input path="t01CompInfo.compNameEn"
                                    htmlEscape="false" maxlength="250"
                                    class="input-medium"/> <span
                                class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>简称：</label>
                        <form:input path="t01CompInfo.shortName" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>购货者状态：</label>
                        <form:select path="buyerStat" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>企业状态：</label>
                        <form:select path="t01CompCert0.certStat" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>医疗机构执业许可状态：</label>
                        <form:select path="t01CompCert4.certStat" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>经营资质状态：</label>
                        <form:select path="t01CompCert1.certStat" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('t01_certStat')}" itemLabel="label" itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>审批状态：</label>
                        <form:select path="apprStat" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('t01_matr_info_appr_stat')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>最后操作时间：</label>
                        <input name="updateDateEd" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>描述：</label>
                        <form:input path="t01CompInfo.compDesc" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>备注：</label>
                        <form:input path="t01CompInfo.remarks" htmlEscape="false" maxlength="1000" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>境内/境外：</label>
                        <form:select path="t01CompInfo.abroad" class="input-medium">
                            <form:option value="" label="请选择"/>
                            <form:options items="${fns:getDictList('abroad')}" itemLabel="label" itemValue="value"
                                          htmlEscape="false"/>
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>


                    <li style="display:none;"><label>统一社会信用代码：</label>
                        <form:input path="t01CompInfo.uniCretNbr" htmlEscape="false"
                                    maxlength="250"
                                    class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>注册号：</label>
                        <form:input path="t01CompInfo.regiNbr" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>组织机构代码证号：</label>
                        <form:input path="t01CompInfo.orgCertNbr" htmlEscape="false"
                                    maxlength="250"
                                    class="input-medium"/> <span
                                class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>税务登记证号：</label>
                        <form:input path="t01CompInfo.taxNbr" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>企业唯一编码：</label>
                        <form:input path="t01CompInfo.compUniNbr" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>名称：</label>
                        <form:input path="t01CompCert0.certName" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>经营范围：</label>
                        <form:input path="t01CompCert0.certScop" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>成立日期：</label>
                        <input name="t01CompCert3.effecDateBg" type="text" readonly="readonly"
                               class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>营业期限至：</label>
                        <input name="t01CompCert3.validDateEd" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>

                    <li style="display:none;"><label>经营许可证号/备案凭证号：</label>
                        <form:input path="t01CompCert1.certNbr"
                                    htmlEscape="false"
                                    maxlength="250"
                                    class="input-medium"/> <span
                                class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>企业名称：</label>
                        <form:input path="t01CompCert1.certName" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>经营方式：</label>
                        <form:select path="t01CompInfo.busiMode" class="input-medium">
                            <form:option value="" label="请选择" />
                            <form:options items="${fns:getDictList('t01_busiMode')}"
                                          itemLabel="label" itemValue="value" htmlEscape="false" />
                        </form:select>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>经营场所：</label>
                        <form:input path="t01CompInfo.busiLoca" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>库房地址：</label>
                        <form:input path="t01CompInfo.storLoca" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <%--<li style="display:none;"><label>经营范围：</label>--%>
                        <%--<form:input path="t01CompCert1.certScop" htmlEscape="false"--%>
                                    <%--maxlength="250" class="input-medium"/>--%>
                        <%--<span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>--%>
                    <li style="display:none;"><label>经营资质发证时间：</label>
                        <input name="t01CompCert1.effecDateBg" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>经营资质有效期至：</label>
                        <input name="t01CompCert1.validDateEd" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>登记号：</label>
                        <form:input path="t01CompCert4.certNbr" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>机构名称：</label>
                        <form:input path="t01CompCert4.certName" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>诊疗科目：</label>
                        <form:input path="t01CompCert4.certScop" htmlEscape="false"
                                    maxlength="250" class="input-medium"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span></li>
                    <li style="display:none;"><label>医疗机构执业许可发证日期：</label>
                        <input name="t01CompCert4.effecDateBg" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>
                    <li style="display:none;"><label>医疗机构执业许可有效期至：</label>
                        <input name="t01CompCert4.validDateEd" type="text" readonly="readonly"class="input-medium datepicker"/>
                        <span class="btn btn-primary" onclick="deleteSelf(this)">一</span>
                    </li>

                </ul>
                <a id="btnSubmit" class="btn btn-primary"  onclick="submitThisForm()">查询</a>
            </div>
        </div>
    </div>

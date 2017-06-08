<form class="form-horizontal">
		<div class="table-scrollable">
			<ul class="nav nav-tabs" role="tablist">
						</ul>
			<div class="tab-content">
				<div role="tabpanel"  class=
					"tab-pane fade in active"
				
				 id="p0">
				
								<div class="control-group">
									<label class="control-label">备注信息：</label>
									<div class="controls">
										<textarea  htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge ">
										</textarea>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">流程实例ID：</label>
									<div class="controls">
										<input type="text" value="${t02Stockin.procInsId!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">入库单号：</label>
									<div class="controls">
										<input type="text" value="${t02Stockin.stocNo!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">验收单号：</label>
									<div class="controls">
										<input type="text" value="${t02Stockin.checkNo!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">入库时间：</label>
									<div class="controls">
										<input name="stocDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
											value="${t02Stockin.stocDate!?string('yyyy-MM-dd HH:mm:ss')}" />
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">审核人：</label>
									<div class="controls">
										<input type="text" value="${t02Stockin.auditPers!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">仓库id：</label>
									<div class="controls">
										<input type="text" value="${t02Stockin.wareHouseId!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">仓库管理员签字：</label>
									<div class="controls">
										<input type="text" value="${t02Stockin.wareSign!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
					
					<!--子表-->
					<div class="control-group">
						<label class="control-label">入库-物料信息：</label>
						<div class="controls">
							<table id="contentTable" class="table table-striped table-bordered table-condensed">
								<thead>
									<tr>
										<th class="hide"></th>
										<th>物料id</th>
										<th>备注信息</th>
										<th>流程实例ID</th>
										<th>序号</th>
										<th>描述</th>
										<th>入库数量</th>
										<th>质量状态/区域</th>
										<th>备注</th>
									</tr>
								</thead>
								<tbody>
								 <#list t02Stockin.t02StockinMateList as row>
											<td>
												<input type="text" value="${row.mateId!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<textarea value="remarks" htmlEscape="false" rows="4" maxlength="100" class="input-xxlarge ">
												</textarea>
											</td>
											<td>
												<input type="text" value="${row.procInsId!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.sequence!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.description!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.storQuan!}" htmlEscape="false" maxlength="11" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.qualStat!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.comments!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
								 </#list>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
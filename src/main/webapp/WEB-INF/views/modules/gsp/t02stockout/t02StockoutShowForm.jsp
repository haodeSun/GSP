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
										<input type="text" value="${t02Stockout.procInsId!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">出库单号：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.stocNumb!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">验收单号：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.checkNo!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">出库时间：</label>
									<div class="controls">
										<input name="stocDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
											value="${t02Stockout.stocDate!?string('yyyy-MM-dd HH:mm:ss')}" />
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">库房管理员姓名：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.wareName!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">库房管理员签字：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.wareSign!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">审核人：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.auditPers!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">仓库id：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.wareHouseId!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">组织编码：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.orgaCode!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">备注：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.comments!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">不含税金额：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.noTaxAmou!}" htmlEscape="false" maxlength="11" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">箱数：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.boxCount!}" htmlEscape="false" maxlength="11" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">单品数量：</label>
									<div class="controls">
										<input type="text" value="${t02Stockout.singProdCount!}" htmlEscape="false" maxlength="11" class="input-xlarge "/>
									</div>
								</div>
							
								<div class="control-group">
									<label class="control-label">出库时间：</label>
									<div class="controls">
									</div>
								</div>
							
					
					<!--子表-->
					<div class="control-group">
						<label class="control-label">t02_stockout_mate：</label>
						<div class="controls">
							<table id="contentTable" class="table table-striped table-bordered table-condensed">
								<thead>
									<tr>
										<th class="hide"></th>
										<th>id</th>
										<th>备注信息</th>
										<th>流程实例ID</th>
										<th>序号</th>
										<th>描述</th>
										<th>出库数量</th>
										<th>单位</th>
										<th>单位含量</th>
										<th>数量</th>
										<th>批次号</th>
										<th>备注</th>
									</tr>
								</thead>
								<tbody>
								 <#list t02Stockout.t02StockoutMateList as row>
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
												<input type="text" value="${row.seriNo!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.describe!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.outQuan!}" htmlEscape="false" maxlength="11" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.unit!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.unitCont!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.count!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.batchNumb!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
											</td>
											<td>
												<input type="text" value="${row.comm!}" htmlEscape="false" maxlength="100" class="input-xlarge "/>
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
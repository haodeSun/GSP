/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02acceptmate;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 验收-物料信息Entity
 * @author gyq
 * @version 2016-10-26
 */
public class T02AcceptMate extends DataEntity<T02AcceptMate> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String mateNo;		// 物料编号
	private String prodNameCn;		// 产品名称（中文）
	private String regiCertNo;		// 注册证号
	private String batchNumb;		// 生产批号
	private String manuDate;		// 生产日期
	private String disaDate;		// 失效日期
	private String valiPeri;		// 有效期
	private String manuEnte;		// 生产企业
	private String supplier;		// 供货者
	private String receQuan;		// 收货数量
	private String acceNumb;		// 验收合格数
	private String checkResu;		// 验收结果
	private String unquNumb;		// 不合格数
	private String unquHandMeas;		// 不合格事项及处理措施
	
	public T02AcceptMate() {
		super();
	}

	public T02AcceptMate(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="物料编号长度必须介于 0 和 100 之间")
	public String getMateNo() {
		return mateNo;
	}

	public void setMateNo(String mateNo) {
		this.mateNo = mateNo;
	}
	
	@Length(min=0, max=100, message="产品名称（中文）长度必须介于 0 和 100 之间")
	public String getProdNameCn() {
		return prodNameCn;
	}

	public void setProdNameCn(String prodNameCn) {
		this.prodNameCn = prodNameCn;
	}
	
	@Length(min=0, max=100, message="注册证号长度必须介于 0 和 100 之间")
	public String getRegiCertNo() {
		return regiCertNo;
	}

	public void setRegiCertNo(String regiCertNo) {
		this.regiCertNo = regiCertNo;
	}
	
	@Length(min=0, max=100, message="生产批号长度必须介于 0 和 100 之间")
	public String getBatchNumb() {
		return batchNumb;
	}

	public void setBatchNumb(String batchNumb) {
		this.batchNumb = batchNumb;
	}
	
	@Length(min=0, max=100, message="生产日期长度必须介于 0 和 100 之间")
	public String getManuDate() {
		return manuDate;
	}

	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}
	
	@Length(min=0, max=100, message="失效日期长度必须介于 0 和 100 之间")
	public String getDisaDate() {
		return disaDate;
	}

	public void setDisaDate(String disaDate) {
		this.disaDate = disaDate;
	}
	
	@Length(min=0, max=100, message="有效期长度必须介于 0 和 100 之间")
	public String getValiPeri() {
		return valiPeri;
	}

	public void setValiPeri(String valiPeri) {
		this.valiPeri = valiPeri;
	}
	
	@Length(min=0, max=100, message="生产企业长度必须介于 0 和 100 之间")
	public String getManuEnte() {
		return manuEnte;
	}

	public void setManuEnte(String manuEnte) {
		this.manuEnte = manuEnte;
	}
	
	@Length(min=0, max=100, message="供货者长度必须介于 0 和 100 之间")
	public String getSupplier() {
		return supplier;
	}

	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	
	@Length(min=0, max=100, message="收货数量长度必须介于 0 和 100 之间")
	public String getReceQuan() {
		return receQuan;
	}

	public void setReceQuan(String receQuan) {
		this.receQuan = receQuan;
	}
	
	@Length(min=0, max=100, message="验收合格数长度必须介于 0 和 100 之间")
	public String getAcceNumb() {
		return acceNumb;
	}

	public void setAcceNumb(String acceNumb) {
		this.acceNumb = acceNumb;
	}
	
	@Length(min=0, max=100, message="验收结果长度必须介于 0 和 100 之间")
	public String getCheckResu() {
		return checkResu;
	}

	public void setCheckResu(String checkResu) {
		this.checkResu = checkResu;
	}
	
	@Length(min=0, max=100, message="不合格数长度必须介于 0 和 100 之间")
	public String getUnquNumb() {
		return unquNumb;
	}

	public void setUnquNumb(String unquNumb) {
		this.unquNumb = unquNumb;
	}
	
	@Length(min=0, max=100, message="不合格事项及处理措施长度必须介于 0 和 100 之间")
	public String getUnquHandMeas() {
		return unquHandMeas;
	}

	public void setUnquHandMeas(String unquHandMeas) {
		this.unquHandMeas = unquHandMeas;
	}
	
}
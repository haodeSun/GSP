/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr;

import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.validation.constraints.NotNull;

/**
 * 协议与物料的关联信息Entity
 * @author XXS
 * @version 2016-12-05
 */
public class T01AggrMatr extends DataEntity<T01AggrMatr> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String aggrId;		    // 协议id
    @Getter @Setter @NotNull
	private T01MatrInfo matr;		// 物料id

	@Length(max=128, message="单价长度必须介于 0 和 128 之间")
	@Getter @Setter @NotNull
	private String price;		    // 单价
	@Length(max=128, message="单价长度必须介于 0 和 128 之间")
	@Getter @Setter
	private String count;		    // 数量
	
	public T01AggrMatr() {
		super();
	}

	public T01AggrMatr(String id){
		super(id);
	}

	@Length(max=128, message="流程实例ID长度必须介于 0 和 128 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=1, max=128, message="协议id长度必须介于 1 和 128 之间")
	public String getAggrId() {
		return aggrId;
	}

	public void setAggrId(String aggrId) {
		this.aggrId = aggrId;
	}
}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.t02reviewhistory;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 审核记录Entity
 * @author yohu
 * @version 2016-11-17
 */
public class T02ReviewHistory extends DataEntity<T02ReviewHistory> {
	
	private static final long serialVersionUID = 1L;
	private String reivewType;		// 审核分类
	private String reviewResult;		// 审核结果
	private String reviewInst;		// 审核对象
	
	public T02ReviewHistory() {
		super();
	}

	public T02ReviewHistory(String id){
		super(id);
	}

	@Length(min=1, max=100, message="审核分类长度必须介于 1 和 100 之间")
	public String getReivewType() {
		return reivewType;
	}

	public void setReivewType(String reivewType) {
		this.reivewType = reivewType;
	}
	
	@Length(min=1, max=100, message="审核结果长度必须介于 1 和 100 之间")
	public String getReviewResult() {
		return reviewResult;
	}

	public void setReviewResult(String reviewResult) {
		this.reviewResult = reviewResult;
	}
	
	@Length(min=1, max=100, message="审核对象长度必须介于 1 和 100 之间")
	public String getReviewInst() {
		return reviewInst;
	}

	public void setReviewInst(String reviewInst) {
		this.reviewInst = reviewInst;
	}
	
}
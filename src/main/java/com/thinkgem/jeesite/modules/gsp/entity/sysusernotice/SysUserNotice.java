/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.entity.sysusernotice;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户notice表Entity
 * @author gyq
 * @version 2016-10-29
 */
public class SysUserNotice extends DataEntity<SysUserNotice> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String noticeTitle;		// 消息标题
	private String noticeType;		// 消息类型
	private String content;		// 消息内容
	private String noticeStatus;		// 消息状态
	private String pushUser;		// 推送对象
	private String attach;		// 附件
	
	public SysUserNotice() {
		super();
	}

	public SysUserNotice(String id){
		super(id);
	}

	@Length(min=0, max=100, message="流程实例ID长度必须介于 0 和 100 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=100, message="消息标题长度必须介于 0 和 100 之间")
	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	
	@Length(min=0, max=100, message="消息类型长度必须介于 0 和 100 之间")
	public String getNoticeType() {
		return noticeType;
	}

	public void setNoticeType(String noticeType) {
		this.noticeType = noticeType;
	}
	
	@Length(min=0, max=100, message="消息内容长度必须介于 0 和 100 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=0, max=100, message="消息状态长度必须介于 0 和 100 之间")
	public String getNoticeStatus() {
		return noticeStatus;
	}

	public void setNoticeStatus(String noticeStatus) {
		this.noticeStatus = noticeStatus;
	}
	
	@Length(min=0, max=100, message="推送对象长度必须介于 0 和 100 之间")
	public String getPushUser() {
		return pushUser;
	}

	public void setPushUser(String pushUser) {
		this.pushUser = pushUser;
	}
	
	@Length(min=0, max=100, message="附件长度必须介于 0 和 100 之间")
	public String getAttach() {
		return attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}
	
}
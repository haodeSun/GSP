package com.thinkgem.jeesite.modules.act;

import org.springframework.transaction.annotation.Transactional;

/**
 * @author XXS
 * @date 2016/12/23.
 */
@Transactional
public interface ActActionInvoke {
    /**
     * 在审批通过时调用
     *
     * @param businessId 业务表ID
     */
    void actPassInvoke(String businessId) throws Exception;

    /**
     * 在审批未通过时调用
     *
     * @param businessId 业务表ID
     */
    void actNoPassInvoke(String businessId) throws Exception;
}

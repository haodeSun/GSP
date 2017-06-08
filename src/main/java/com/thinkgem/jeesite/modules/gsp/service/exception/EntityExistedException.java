package com.thinkgem.jeesite.modules.gsp.service.exception;

/**
 * @author Greg Song
 * @since 26/11/2016
 */
public class EntityExistedException extends BusinessException{
    public EntityExistedException(String message, String code) {
        super(message, code);
    }
}

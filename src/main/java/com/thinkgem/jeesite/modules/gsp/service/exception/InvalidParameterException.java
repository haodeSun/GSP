package com.thinkgem.jeesite.modules.gsp.service.exception;

/**
 * @author Greg Song
 * @since 25/12/2016
 */
@SuppressWarnings("unused")
public class InvalidParameterException extends BusinessException {
    public InvalidParameterException(String message, String code) {
        super(message, code);
    }
}

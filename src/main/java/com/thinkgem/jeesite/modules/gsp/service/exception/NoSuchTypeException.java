package com.thinkgem.jeesite.modules.gsp.service.exception;

/**
 * @author Greg Song
 * @since 03/11/2016
 */
public class NoSuchTypeException extends BusinessException {
    public NoSuchTypeException(String message, String code) {
        super(message, code);
    }
}

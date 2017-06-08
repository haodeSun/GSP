package com.thinkgem.jeesite.modules.gsp.service.exception;

/**
 * @author Greg Song
 * @since 03/11/2016
 */
abstract public class BusinessException extends Exception{
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    private String code = "";

    public BusinessException(String message, String code) {
        super(message);
        this.code = code;
    }
}

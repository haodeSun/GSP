package com.thinkgem.jeesite.modules.gsp.service.exception;

/**
 * Created by XXS on 2017/03/23.
 */
public class DataNotExistException extends BusinessException{
    public DataNotExistException(String message, String code) {
        super(message, code);
    }
}

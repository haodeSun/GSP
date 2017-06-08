package com.thinkgem.jeesite.modules.gsp.web.t01matrinfo;

/**
 * @author Greg Song
 * @since 26/11/2016
 */
public enum ImportStatus {
    EXISTED("101"), NOT_EXISTED("100"), ERROR("102");

    private String value;
    ImportStatus(String value) {
        this.value = value;
    }
    public String toString(){
        String result;
        switch (this) {
            case EXISTED:
                result = "物料号已存在";
                break;
            case NOT_EXISTED:
                result = "物料号可以录入";
                break;
            case ERROR:
                result = "请稍后再试";
                break;
            default:
                result = "异常";
                break;
        }
        return result;
    }

    public String getValue() {
        return value;
    }
}

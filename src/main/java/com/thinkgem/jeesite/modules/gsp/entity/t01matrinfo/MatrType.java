package com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo;

/**
 * 物料分类
 */
public enum MatrType {

    /**
     * 0：医疗器械
     * 1：非医疗器械
     */
    MEDICAL("0"), NOT_MEDICAL("1");

    private String value;

    MatrType(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }


}

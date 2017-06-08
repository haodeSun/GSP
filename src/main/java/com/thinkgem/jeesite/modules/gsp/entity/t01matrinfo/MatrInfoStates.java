package com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo;

/**
 * 物料状态
 */
public enum MatrInfoStates {

    /**
     * 0：关联
     * 1：未关联
     * 2：冻结
     */
    RELATED("0"), NOT_RELATED("1"), FREEZE("2");

    private String value;

    MatrInfoStates(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }


}

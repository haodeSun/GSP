package com.thinkgem.jeesite.modules.gsp.entity.t01complprod;

/**
 * 产品状态
 */
public enum ComplProdStates {

    /**
     * 0：生效
     * 1：失效
     * 2: 近效期
     * 3：冻结
     */
    EFFECTIVE("0"), NOT_EFFECTIVE("1"), NEAR_EFFECTIVE("2"), FREEZE("3");

    private String value;

    ComplProdStates(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }


}

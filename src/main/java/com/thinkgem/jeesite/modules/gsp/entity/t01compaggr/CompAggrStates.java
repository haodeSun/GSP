package com.thinkgem.jeesite.modules.gsp.entity.t01compaggr;

/**
 * 协议状态
 */
public enum CompAggrStates {

    /**
     * 0：生效
     * 1：近效期预警
     * 2: 过期
     * 3：冻结
     */
    EFFECTIVE("0"), NEAR_EFFECTIVE("1"), NOT_EFFECTIVE("2"), FREEZE("3");

    private String value;

    CompAggrStates(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }


}

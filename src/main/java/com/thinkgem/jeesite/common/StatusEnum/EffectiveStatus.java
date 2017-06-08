package com.thinkgem.jeesite.common.StatusEnum;

/**
 * @author Greg Song
 * @since 25/12/2016
 */
@SuppressWarnings("unused")
public enum EffectiveStatus {
    EFFECTIVE("0"),
    EXPIRING("1"),
    INVALID("2"),
    FROZEN("3"),
    UNKNOWN("-1");

    private String value;

    EffectiveStatus(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }
}

package com.thinkgem.jeesite.common.StatusEnum;

/**
 * 审批状态
 * Created by XXS on 2016/11/30.
 */
public enum ApprStatus {
    /**
     * 0：未提交
     * 1：未审批
     * 2：审批通过
     * 3：审批未通过
     * 4: 未知
     */
    NOSUBMIT("0"), NOAPPR("1"), PASS("2"), NOPASS("3"), UNKNOWN("4");

    private String value;

    ApprStatus(String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }

    @SuppressWarnings("unused")
    public static ApprStatus fromString(String str){
        if (null == str) return UNKNOWN;
        switch (str){
            case "0":
                return NOSUBMIT;
            case "1":
                return NOAPPR;
            case "2":
                return PASS;
            case "3":
                return NOPASS;
            default:
                return UNKNOWN;
        }
    }

    public static boolean equals(ApprStatus status, String str){
        return null != status && status.toString().equals(str);
    }
}

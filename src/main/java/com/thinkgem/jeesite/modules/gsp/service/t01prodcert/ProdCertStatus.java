package com.thinkgem.jeesite.modules.gsp.service.t01prodcert;

import java.util.Arrays;
import java.util.Optional;

/**
 * 产品资质相关状态接口
 *
 * @author JOKING
 * @since 2016/11/25
 */
@SuppressWarnings("unused")
public interface ProdCertStatus {
    String _N1 = "-1";
    String _0 = "0";
    String _1 = "1";
    String _2 = "2";
    String _3 = "3";
    String _4 = "4";
    //风险分类
    enum RiskClass {
        /**
         * 1：I
         * 2：II
         * 3：III
         */
        ONE(_1), TWO(_2), THREE(_3), UNKNOWN(_N1);

        private String value;

        RiskClass(String value) {
            this.value = value;
        }

        public String toString() {
            return value;
        }

        public static RiskClass fromString(String str){
            if (null == str) return UNKNOWN;
            Optional<RiskClass> opt= Arrays.stream(RiskClass.values())
                    .filter(s -> s.toString().equals(str))
                    .findAny();
            return opt.orElse(UNKNOWN);
        }
    }
    //审批状态
    enum ApprStatus {
        /**
         * 0：未提交
         * 1：未审批
         * 2：审批通过
         * 3：审批未通过
         */
        NOSUBMIT(_0), NOAPPR(_1), PASS(_2), NOPASS(_3), UNKNOWN(_N1);

        private String value;

        ApprStatus(String value) {
            this.value = value;
        }

        public String toString() {
            return value;
        }

        public static ApprStatus fromString(String str){
            if (null == str) return UNKNOWN;
            Optional<ApprStatus> opt= Arrays.stream(ApprStatus.values())
                    .filter(s -> s.toString().equals(str))
                    .findAny();
            return opt.orElse(UNKNOWN);
        }

        public static boolean equals(ApprStatus status, String statusStr) {
            return status.toString().equals(statusStr);
        }

        public static boolean in(ApprStatus[] statuses, String statusStr) {
            return Arrays.stream(statuses).anyMatch(s->s.toString().equals(statusStr));
        }
    }
    //资质类型
    enum CertType {
        /**
         * 0：首次
         * 1：变更
         * 2：延续
         */
        FIRST(_0), CHANGE(_1), EXTEND(_2), UNKNOWN(_N1);

        private String value;

        CertType(String value) {
            this.value = value;
        }

        public String toString() {
            return value;
        }

        public static CertType fromString(String str){
            if (null == str) return UNKNOWN;
            Optional<CertType> opt= Arrays.stream(CertType.values())
                    .filter(s -> s.toString().equals(str))
                    .findAny();
            return opt.orElse(UNKNOWN);
        }

        public static boolean equals(CertType type,String str) {
            return null != type && type.toString().equals(str);
        }
    }
    //资质状态
    enum CertStatus {
        /**
         * 0：有效
         1：预警
         2：过期（自动计算）
         3：冻结（人工选择）
         */
        EFFECTIVE(_0), INVALID(_2), FREEZE(_3), WILLINVALID(_1), UNKNOWN(_N1);

        private String value;

        CertStatus(String value) {
            this.value = value;
        }

        public String toString() {
            return value;
        }

        public static CertStatus fromString(String str){
            if (null == str) return UNKNOWN;
            Optional<CertStatus> opt= Arrays.stream(CertStatus.values())
                    .filter(s -> s.toString().equals(str))
                    .findAny();
            return opt.orElse(UNKNOWN);
        }
    }
    //是否是进口
    enum IsImport {
        /**
         * 0：国内
         * 1：进口
         */
        YES(_1),NO(_0), UNKNOWN(_N1);

        private String value;

        IsImport(String value) {
            this.value = value;
        }

        public String toString() {
            return value;
        }

        public static IsImport fromString(String str){
            if (null == str) return UNKNOWN;
            Optional<IsImport> opt= Arrays.stream(IsImport.values())
                    .filter(s -> s.toString().equals(str))
                    .findAny();
            return opt.orElse(UNKNOWN);
        }
    }
    //是否是提交,即将取消
    enum IsAppr{
        /**
         * 0. 保存
         * 1. 提交
         */
        YES(_1),NO(_0);

        private String value;

        IsAppr(String value){
            this.value = value;
        }
        
        public String toString(){
            return value;
        }

        public static boolean yes(String option) {
            return YES.toString().equals(option);
        }
    }
}



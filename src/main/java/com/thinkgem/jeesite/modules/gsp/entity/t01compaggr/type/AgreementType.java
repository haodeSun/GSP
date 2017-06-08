package com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.type;

import lombok.Getter;

import java.util.Arrays;
import java.util.Optional;

/**
 * @author Greg Song
 * @since 25/12/2016
 */
@SuppressWarnings("unused")
public enum AgreementType {
    SALE("1"), SUPPLY("0"), UNKNOWN("-1");

    @Getter
    private String value;

    AgreementType(String value) {
        this.value = value;
    }

    public static AgreementType fromString(String str){
        if (null == str) return UNKNOWN;
        Optional<AgreementType> opt= Arrays.stream(AgreementType.values())
                .filter(s -> s.toString().equals(str))
                .findAny();
        return opt.orElse(UNKNOWN);
    }

    public String toString() {
        return value;
    }

    public boolean equals(String value){
        return value != null && this.value.equals(value);
    }

    public static boolean in(
            AgreementType[] statuses,
            String statusStr) {
        return Arrays.stream(statuses)
                .anyMatch(s->s.toString().equals(statusStr));
    }
}

package cn.com.dataocean.validator.constraints;

import cn.com.dataocean.validator.DictTypeValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * 通过字典类型判断数据
 *
 * @author XXS
 */
@Documented
@Constraint(validatedBy = {DictTypeValidator.class})
@Target({METHOD, FIELD})
@Retention(RUNTIME)
public @interface DictType {
    String message() default "输入值必须属于对应字典类型的值";

    /**
     * 字典类型
     */
    String dictType() default "";

    /**
     * 是否可以为空或null
     */
    boolean canBlank() default true;

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    @Target({METHOD, FIELD})
    @Retention(RUNTIME)
    @Documented
    public @interface List {
        DictType[] value();
    }
}

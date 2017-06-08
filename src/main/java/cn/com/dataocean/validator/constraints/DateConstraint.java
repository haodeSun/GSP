package cn.com.dataocean.validator.constraints;

import cn.com.dataocean.validator.DateValidatorHandler;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * @author Greg Song
 * eg.
 * @ DateConstraint(field1 = "effeDate", field2 = "apprDate", comparator = NotBeforeThan.class)
 * public class T01ProdCert extends ActEntity<T01ProdCert> {
 * @author greg.song <kuroro2121@gmail.com>
 * @since 01/12/2016
 */
@Target({ TYPE })
@Retention(RUNTIME)
@Constraint(validatedBy = { DateValidatorHandler.class })
@Documented
public @interface DateConstraint {
    String message() default "cn.com.dataocean.validator.constraints";

    Class<?>[] groups() default { };
    Class<? extends Payload>[] payload() default { };
    String field1();
    String field2();
    Class<?> comparator();

    @Target({ TYPE })
    @Retention(RUNTIME)
    @Documented
    @interface List {
        DateConstraint[] value();
    }
}

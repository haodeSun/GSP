package cn.com.dataocean.validator;

import cn.com.dataocean.validator.comparator.Comparator;
import cn.com.dataocean.validator.constraints.DateConstraint;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.lang.reflect.Field;
import java.util.Date;

/**
 * @author Greg Song
 * @since 01/12/2016
 */
public class DateValidatorHandler implements ConstraintValidator<DateConstraint, Object> {
    private Class<?> comparatorClazz;
    private String property1;
    private String property2;

    @Override
    public void initialize(DateConstraint constraintAnnotation) {
        comparatorClazz = constraintAnnotation.comparator();
        property1 = constraintAnnotation.field1();
        property2 = constraintAnnotation.field2();
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        Class<?> clazz = value.getClass();
        try {
            Field field1 = clazz.getDeclaredField(property1);
            Field field2 = clazz.getDeclaredField(property2);
            field1.setAccessible(true);
            field2.setAccessible(true);
            Object value1 = field1.get(value);
            Object value2 = field2.get(value);
            Object comparator =  comparatorClazz.newInstance();
            if ( comparator instanceof Comparator<?> &&
                    (value1 == null ||value1 instanceof Date) &&
                    (value2 == null || value2 instanceof Date)) {
                return ((Comparator<Date>)comparator).compare((Date) value1, (Date) value2);
            }
        } catch (NoSuchFieldException | IllegalAccessException | InstantiationException e) {
            return false;
        }
        return false;
    }
}

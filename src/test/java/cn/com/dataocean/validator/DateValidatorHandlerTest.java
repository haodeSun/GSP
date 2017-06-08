package cn.com.dataocean.validator;

import cn.com.dataocean.test.data.Lesson;
import cn.com.dataocean.test.data.Task;
import org.junit.Before;
import org.junit.Test;

import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.Date;
import java.util.Set;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * @author Greg Song
 * @since 02/12/2016
 */
@SuppressWarnings("deprecation")
public class DateValidatorHandlerTest {
    private Validator validator;
    @Before
    public void setUp() throws Exception {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator =  factory.getValidator();
    }

    @Test
    public void testValidateSingleAnnotation() throws Exception {
        Task task = new Task(
                new Date(116, 1, 1),
                new Date(116, 2, 1),
                new Date(),
                new Date()
        );
        Set constraintViolations = validator.validate(task);
        assertTrue(constraintViolations.isEmpty());
    }

    @Test
    public void testViolateSingleAnnotation() throws Exception {
        Task task = new Task(
                new Date(116, 3, 1),
                new Date(116, 2, 1),
                new Date(),
                new Date()
        );
        Set constraintViolations = validator.validate(task);
        assertFalse(constraintViolations.isEmpty());
    }
    @Test
    public void testValidateMultipleAnnotation() throws Exception {
        Lesson lesson = new Lesson(
                new Date(116, 1, 1),
                new Date(116, 2, 1),
                new Date(116, 1, 1),
                new Date(116, 2, 1)
        );
        lesson.setBeforeDate1(new Date(116, 3,1));
        lesson.setBeforeDate2(new Date(116, 3,2));
        Set constraintViolations = validator.validate(lesson);
        assertTrue(constraintViolations.isEmpty());
    }
    @Test
    public void testViolateMultipleAnnotation() throws Exception {
        Lesson lesson = new Lesson(
                new Date(116, 3, 1),
                new Date(116, 2, 1),
                new Date(116, 3, 1),
                new Date(116, 2, 1)
        );
        lesson.setBeforeDate1(new Date(116, 4,1));
        lesson.setBeforeDate2(new Date(116, 3,2));
        Set constraintViolations = validator.validate(lesson);
        assertFalse(constraintViolations.isEmpty());
        assertEquals(2, constraintViolations.size());
    }

    @Test
    public void testBeforeThen() throws Exception {
        Lesson lesson = new Lesson(
                new Date(116, 1, 1),
                new Date(116, 2, 1),
                new Date(116, 3, 1),
                new Date(116, 2, 1)
        );
        lesson.setBeforeDate1(new Date(116, 3,1));
        lesson.setBeforeDate2(new Date(116, 3,2));
        Set constraintViolations = validator.validate(lesson);
        assertTrue(constraintViolations.isEmpty());
    }

    @Test
    public void testBeforeNullThen() throws Exception {
        Lesson lesson = new Lesson(
                new Date(116, 1, 1),
                new Date(116, 2, 1),
                new Date(116, 3, 1),
                new Date(116, 2, 1)
        );
        lesson.setBeforeDate1(new Date(116, 3,1));
        lesson.setBeforeDate2(null);
        Set constraintViolations = validator.validate(lesson);
        assertTrue(constraintViolations.isEmpty());
    }
    @Test
    public void testNullBeforeNullThen() throws Exception {
        Lesson lesson = new Lesson(
                new Date(116, 1, 1),
                new Date(116, 2, 1),
                new Date(116, 3, 1),
                new Date(116, 2, 1)
        );
        lesson.setBeforeDate1(null);
        lesson.setBeforeDate2(null);
        Set constraintViolations = validator.validate(lesson);
        assertEquals(1, constraintViolations.size());
    }
}
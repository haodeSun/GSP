/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.common.utils.excel.annotation;

import java.lang.annotation.*;

import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * Excel注解定义
 * @author ThinkGem
 * @version 2013-03-10
 */
@Target({ElementType.METHOD, ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ExcelField {

	/**
	 * 导出字段名（默认调用当前字段的“get”方法，如指定导出字段为对象，请填写“对象名.对象属性”，例：“area.name”、“office.name”）
	 */
	String value() default "";

	/**
	 * 导出字段标题（需要添加批注请用“**”分隔，标题**批注，仅对导出模板有效）
	 */
	String title();

	/**
	 * field 名，如果在方法和属性上面，则自动取值
	 */
	String field() default "";

	/**
	 * 字段类型（0：导出导入；1：仅导出；2：仅导入）
	 */
	int type() default 0;

	/**
	 * 导出字段对齐方式（0：自动；1：靠左；2：居中；3：靠右）
	 */
	int align() default 0;

	/**
	 * 导出字段字段排序（升序）
	 */
	int sort() default 0;

	/**
	 * 如果是字典类型，请设置字典的type值
	 */
	String dictType() default "";

	/**
	 * 反射类型
	 */
	Class<?> fieldType() default Class.class;

	/**
	 * Datatype-specific additional piece of configuration that may be used
	 * to further refine formatting aspects. This may, for example, determine
	 * low-level format String used for {@link java.util.Date} serialization;
	 */
	String pattern() default "";

	/**
	 * 字段归属组（根据分组导出导入）
	 */
	int[] groups() default {};

	/**
	 * Defines several {@code @Length} annotations on the same element.
	 */
	@Target({ElementType.TYPE,ElementType.CONSTRUCTOR})
	@Retention(RUNTIME)
	@Documented
	@interface List {
		ExcelField[] value();
	}
}

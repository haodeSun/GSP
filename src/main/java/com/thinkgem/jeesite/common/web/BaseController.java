/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.common.web;

import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.i18n.I18nHelperInterface;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.utils.DateUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.ValidationException;
import javax.validation.Validator;
import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 控制器支持类
 * @author ThinkGem
 * @version 2013-3-23
 */
public abstract class BaseController {

    @Autowired
	protected I18nHelperInterface i18nHelper;
	/**
	 * 日志对象
	 */
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	private Map<String,String> errorMap = new HashMap<>();

	/**
	 * 管理基础路径
	 */
	@Value("${adminPath}")
	protected String adminPath;
	
	/**
	 * 前端基础路径
	 */
	@Value("${frontPath}")
	protected String frontPath;
	
	/**
	 * 前端URL后缀
	 */
	@Value("${urlSuffix}")
	protected String urlSuffix;
	
	/**
	 * 验证Bean实例对象
	 */
	@Autowired
	protected Validator validator;

    /**
     * 获取到验证异常并拼成字符串返回
     *
     * @param ex ConstraintViolationException
     * @return 异常消息
     */
    protected String getValidatorExceptionMessage(ConstraintViolationException ex, String separator) {
        String message = "";
        for (ConstraintViolation violation : ex.getConstraintViolations()) {
            message += violation.getMessage() + separator;
        }
        return message;
    }

	/**
	 * 服务端参数有效性验证
	 * @param object 验证的实体对象
	 * @param groups 验证组
	 * @return 验证成功：返回true；严重失败：将错误信息添加到 message 中
	 */
	protected boolean beanValidator(Model model, Object object, Class<?>... groups) {
		try{
			BeanValidators.validateWithException(validator, object, groups);
		}catch(ConstraintViolationException ex){
//			List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
//			list.add(0, "数据验证失败：");
//			addMessage(model, list.toArray(new String[]{}));
			//修改验证错误的提示内容 去掉字段的显示
            addMessage(model, getText("数据校验失败:" + getValidatorExceptionMessage(ex, "</br>")));
            return false;
		}
		return true;
	}

    /**
	 * 服务端参数有效性验证
	 * @param object 验证的实体对象
	 * @param groups 验证组
	 * @return 验证成功：返回true；严重失败：将错误信息添加到 flash message 中
	 */
	protected boolean beanValidator(RedirectAttributes redirectAttributes, Object object, Class<?>... groups) {
		try{
			BeanValidators.validateWithException(validator, object, groups);
		}catch(ConstraintViolationException ex){
//			List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
//			list.add(0, "数据验证失败：");
//			addMessage(redirectAttributes, list.toArray(new String[]{}));
			//修改验证错误的提示内容 去掉字段的显示
            addMessage(redirectAttributes, getText("数据校验失败:" + getValidatorExceptionMessage(ex, "</br>")));
            return false;
		}
		return true;
	}
	
	/**
	 * 服务端参数有效性验证
	 * 验证成功：继续执行；验证失败：抛出异常跳转400页面。
	 * @param object 验证的实体对象
	 * @param groups 验证组，不传入此参数时，同@Valid注解验证
	 */
	protected void beanValidator(Object object, Class<?>... groups) {
		BeanValidators.validateWithException(validator, object, groups);
	}
	
	/**
	 * 添加Model消息
	 * @param messages messages
	 */
	protected void addMessage(Model model, String... messages) {
		StringBuilder sb = new StringBuilder();
		for (String message : messages){
			sb.append(message).append(messages.length>1?"<br/>":"");
		}
		model.addAttribute("message", sb.toString());
	}
	
	/**
	 * 添加Flash消息
	 */
	protected void addMessage(RedirectAttributes redirectAttributes, String... messages) {
		StringBuilder sb = new StringBuilder();
		for (String message : messages){
			getText(message);
			sb.append(message).append(messages.length>1?"<br/>":"");
		}
		redirectAttributes.addFlashAttribute("message", sb.toString());
	}
	
	/**
	 * 客户端返回JSON字符串
	 * @param response response
	 * @param object object to send as json
	 * @return json string
	 */
	protected String renderString(HttpServletResponse response, Object object) {
		return renderString(response, JsonMapper.toJsonString(object), "application/json");
	}
	
	/**
	 * 客户端返回字符串
	 * @param response response object
	 * @param string string to send
	 * @return response string
	 */
	protected String renderString(HttpServletResponse response, String string, String type) {
		try {
			response.reset();
	        response.setContentType(type);
	        response.setCharacterEncoding("utf-8");
			response.getWriter().print(string);
			return null;
		} catch (IOException e) {
			return null;
		}
	}

	/**
	 * 参数绑定异常
	 */
	@ExceptionHandler({BindException.class, ConstraintViolationException.class, ValidationException.class})
    public String bindException() {  
        return "error/400";
    }
	
	/**
	 * 授权登录异常
	 */
	@ExceptionHandler({AuthenticationException.class})
    public String authenticationException() {  
        return "error/403";
    }
	
	/**
	 * 初始化数据绑定
	 * 1. 将所有传递进来的String进行HTML编码，防止XSS攻击
	 * 2. 将字段中Date类型转换为String类型
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		// String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
		binder.registerCustomEditor(String.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				setValue(text == null ? null : StringEscapeUtils.escapeHtml4(text.trim()));
			}
			@Override
			public String getAsText() {
				Object value = getValue();
				return value != null ? value.toString() : "";
			}
		});
		// Date 类型转换
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				setValue(DateUtils.parseDate(text));
			}
//			@Override
//			public String getAsText() {
//				Object value = getValue();
//				return value != null ? DateUtils.formatDateTime((Date)value) : "";
//			}
		});
	}

	public Map<String, String> getErrorMap() {
		return errorMap;
	}

	public void setErrorMap(String viewName,String viewRoute) {
		this.errorMap.put(viewName, viewRoute);
	}

	protected void handleErrorMessage(RedirectAttributes redirectAttributes, String message) {
		SplitStringHelper helper = new SplitStringHelper() {
			@Override
			public void handle(String message) {
				addMessage(redirectAttributes, message);
			}
		};
		helper.split(message);
	}

	protected void handleErrorMessage(Model model, String message) {
		SplitStringHelper helper = new SplitStringHelper() {
			@Override
			public void handle(String message) {
				addMessage(model, message);
			}
		};
		helper.split(message);
	}

	public String getText(String text) {
		if (getI18nHelper() != null) {
			return getI18nHelper().getText(text);
		}
		return text;
	}

    protected void extractMessage(RedirectAttributes redirectAttributes, String message) {
	    handleErrorMessage(redirectAttributes, message);
    }

	public I18nHelperInterface getI18nHelper() {
		return i18nHelper;
	}

	@SuppressWarnings("unused")
	public void setI18nHelper(I18nHelperInterface i18nHelper) {
		this.i18nHelper = i18nHelper;
	}

	abstract class SplitStringHelper{
		void split(String message) {
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(",");
				if (mess.length >= 2) {
					message = mess[0];
				}
				handle(message);
			}
		}
		public abstract void handle(String message);
	}
}

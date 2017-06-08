/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.web.t01prodcert;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.beanvalidator.Submit;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.T01ProdCertService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import static com.thinkgem.jeesite.common.StatusEnum.ApprStatus.NOAPPR;
import static com.thinkgem.jeesite.common.StatusEnum.ApprStatus.PASS;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.CertType;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.CertType.*;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.IsAppr;

/**
 * 产品资质Controller
 * @author gyq
 * @version 2016-11-28
 */
public class T01ProdCertController extends BaseController {

	@SuppressWarnings("WeakerAccess")
	T01ProdCertService t01ProdCertService;
	protected final T01ProdCertExtService t01ProdCertExtService;

	@Autowired
	public T01ProdCertController(
	        T01ProdCertService t01ProdCertService,
            T01ProdCertExtService t01ProdCertExtService
	) {
	    Assert.notNull(t01ProdCertService);
	    this.t01ProdCertService = t01ProdCertService;
        this.t01ProdCertExtService = t01ProdCertExtService;
	}

    @ModelAttribute
	public T01ProdCert get(@RequestParam(required=false) String id) {
		T01ProdCert entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = t01ProdCertService.get(id);
		}
		if (entity == null){
			entity = new T01ProdCert();
		}
		return entity;
	}
	
	@RequiresPermissions("gsp:t01prodcert:t01ProdCert:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			@RequestParam(required = false) String conditionOrder,
			T01ProdCert t01ProdCert,
			HttpServletRequest request,
			HttpServletResponse response,
			Model model) {
		try {
			Page<T01ProdCert> page = t01ProdCertService.findPage(new Page<>(request, response), t01ProdCert);
			model.addAttribute("page", page);
			model.addAttribute("conditionOrder", conditionOrder);
//			if (page.getList().isEmpty()) {
//				addMessage(model, "没有查到你要找的记录！");
//			}
		}catch (Exception e){
			logger.error("查询列表出错："+e.getMessage());
			addMessage(model, "查询列表出错！");
			return "modules/gsp/t01prodcert/t01ProdCertList";
		}
		return "modules/gsp/t01prodcert/t01ProdCertList";
	}

	@RequiresPermissions("gsp:t01prodcert:t01ProdCert:view")
	@RequestMapping(value = "form")
	public String form(T01ProdCert t01ProdCert,
					   RedirectAttributes redirectAttributes,
					   Model model,
					   String view) {
		t01ProdCertExtService.handleAct(t01ProdCert);
		model.addAttribute("t01ProdCert", t01ProdCert);
		if (view != null && StringUtils.isNotBlank(view)) {
			return view;
		}
		String id = t01ProdCert.getId();
		String apprStat = t01ProdCert.getApprStat();
		String certType = t01ProdCert.getCertType();
		//id 为空时直接返回页面，主要是控制异常情况
		if(StringUtils.isBlank(id)){
			return "modules/gsp/t01prodcert/t01ProdCertForm";
		}

		String returnView="modules/gsp/t01prodcert/t01ProdCertForm";
		if (ApprStatus.equals(NOAPPR,apprStat) || ApprStatus.equals(PASS,apprStat)) {
			addMessage(redirectAttributes,i18nHelper.getText("只有未提交、审批未通过状态可进行修改，未审批及审批通过状态无法修改！"));
			returnView = "redirect:" + Global.getAdminPath() + "/gsp/t01prodcert/t01ProdCert/details?id="+id;
		} else if (CertType.equals(FIRST,certType)) {
			returnView="modules/gsp/t01prodcert/t01ProdCertForm";
		} else if (CertType.equals(EXTEND,certType)
				&& isChanOrExtend(t01ProdCert)) {
		    //如果是延续，别且路由大于等于2的时候，就说明是延续修改
			returnView = "redirect:" + Global.getAdminPath() + "/gsp/t01prodcert/t01ProdCert/toExtend?repage&id=" + id+"&method=update";
		} else if (CertType.equals(CHANGE,certType)
				&& isChanOrExtend(t01ProdCert)) {
			//如果是变更，别且路由大于等于2的时候，就说明是变更修改
			returnView = "redirect:" + Global.getAdminPath() + "/gsp/t01prodcert/t01ProdCert/toChan?repage&method=update&id=" + id;
		}
		return returnView;
	}

	/**
	 * 判断是否是真是意义上的变更或者延续
	 * @param t01ProdCert 资质信息
	 * @return 结果
	 */
	private boolean isChanOrExtend(T01ProdCert t01ProdCert){
		String regiCertNbrs = t01ProdCert.getRegiCertNbrs();
		int length = getArrays(regiCertNbrs).length;
		return length >= 2;
	}

	private String[] getArrays(String regiCertNbrs) {
		String[] arrs = {};
		if(StringUtils.isNotBlank(regiCertNbrs)){
			arrs = regiCertNbrs.split(",");
		}
		return arrs;
	}

	@RequiresPermissions("gsp:t01prodcert:t01ProdCert:edit")
	@RequestMapping(value = "save")
	public String save(
            T01ProdCert t01ProdCert,
            Model model,
            RedirectAttributes redirectAttributes) {
		String view = "redirect:"+Global.getAdminPath()+"/gsp/t01prodcert/t01ProdCert/?repage";
		try{
			//1.新增或者修改资质证号检查
			if(StringUtils.isNotBlank(t01ProdCert.getRegiCertNbr())){
				if(!t01ProdCertExtService.uniqueCheckAll(t01ProdCert.getRegiCertNbr(),t01ProdCert.getId())){
					addMessage(model,getText("注册证号重复，不能保存或者提交！"));
					return form(t01ProdCert,null,model,null);
				}
			}
			//设置审批状态
			t01ProdCertExtService.apprStatHandle(t01ProdCert);
			//2.数据验证
            BeanValidators.validateWithException(validator, t01ProdCert,Submit.class);
		    t01ProdCertService.save(t01ProdCert);
		} catch(BusinessException be){
		    addMessage(model,be.getMessage());
		    return form(t01ProdCert,null,model,null);
        }catch (ConstraintViolationException cvExc) {//捕获验证异常
            String message = "";
            for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                message +=violation.getMessage()+"</br>";
            }
            addMessage(model,getText("数据校验失败:"+message));
            return form(t01ProdCert,null, model, null);
        } catch (Exception  e) {
			String message = e.getMessage();
			if (message != null && !message.isEmpty()) {
				String[] mess = message.split(", ");
				if (mess.length >= 2) {
					message = mess[0];
				}
				addMessage(redirectAttributes, message);
			}
            t01ProdCert.setId(StringUtils.EMPTY);
			return form(t01ProdCert,null, model, null);
		}

        if(IsAppr.NO.toString().equals(t01ProdCert.getIsappr())){
            model.addAttribute("t01ProdCert",t01ProdCert);
            addMessage(model,getText("保存成功！"));
            view = "modules/gsp/t01prodcert/t01ProdCertForm";
        }

        //如果是提交，则开启流程
        if(IsAppr.YES.toString().equals(t01ProdCert.getIsappr())){
            try{
                t01ProdCertExtService.startProcess(t01ProdCert.getId(), t01ProdCert.getAct().getTaskId());
            }catch (ConstraintViolationException cvExc) {//捕获验证异常
                String message = "";
                for (ConstraintViolation violation : cvExc.getConstraintViolations()) {
                    message +=violation.getMessage();
                }
                addMessage(model,getText("流程开启失败，保存成功:"+message));
                return form(t01ProdCert,null, model, null);
            }catch (BusinessException | NullPointerException e){
                logger.error(getText("流程启动失败："),e.getMessage());
                addMessage(model,getText("流程开启失败，保存成功！"+e.getMessage()));
                return form(t01ProdCert,null, model, null);
            } catch (Exception e) {
				addMessage(model,getText("流程开启失败，保存成功！"+e.getMessage()));
				return form(t01ProdCert,null, model, null);
			}
		}
		addMessage(redirectAttributes, getText("保存产品资质成功,已提交审批！"));
		return view;
	}
	
	@RequiresPermissions("gsp:t01prodcert:t01ProdCert:edit")
	@RequestMapping(value = "delete")
	public String delete(
            T01ProdCert t01ProdCert,
            RedirectAttributes redirectAttributes) {
		try {
			t01ProdCertService.delete(t01ProdCert);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		addMessage(redirectAttributes, "删除产品资质成功");
		return "redirect:"+Global.getAdminPath()+"/gsp/t01prodcert/t01ProdCert/toDelete?repage";
	}

}
/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01compinfonew;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01compinfonew.T01CompInfoNewDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01compcert.T01CompCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew.T01CompInfoNew;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.ComplSuplStat;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01compcert.T01CompCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01salescert.T01SalesCertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 企业信息Service
 * @author XXS
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class T01CompInfoNewService extends ExtCrudService<T01CompInfoNewDao, T01CompInfoNew> {

	/**
	 * 企业资质service
	 */
    @Autowired
	private T01CompCertService t01CompCertService;
    @Autowired
    private T01CompInfoNewHelperService t01CompInfoNewHelperService;
	@Autowired
	protected T01SalesCertService t01SalesCertService;
    @Autowired
    public T01CompInfoNewService(
            T01CompInfoNewDao dao) {
        super(dao);
    }

	public T01CompInfoNew get(String id) {

		T01CompInfoNew t01CompInfo = super.get(id);

		//设置销售人员授权信息
		T01SalesCert t01SalesCert = new T01SalesCert();
		T01CompInfo search=new T01CompInfo();
		search.setId(id);
		t01SalesCert.setComp(search);

		t01CompInfo.setT01SalesCertList(t01SalesCertService.findList(t01SalesCert));

		return t01CompInfo;
	}
	
	public List<T01CompInfoNew> findList(T01CompInfoNew t01CompInfo) {
		return super.findList(t01CompInfo);
	}
	
	public Page<T01CompInfoNew> findPage(Page<T01CompInfoNew> page, T01CompInfoNew t01CompInfo) {

		Page<T01CompInfoNew> paginator = super.findPage(page, t01CompInfo);

		return paginator;
	}

	@Transactional
	public void save(T01CompInfoNew t01CompInfo) throws BusinessException {
		boolean isNewRecord = t01CompInfo.getIsNewRecord();

		t01CompInfoNewHelperService.checkStatusBeforeHandle("save",t01CompInfo);
		if(!isNewRecord) {
			t01CompInfoNewHelperService.checkStatusBeforeHandle("edit", t01CompInfo);
		}

		//执行保存操作
		super.save(t01CompInfo);

		if (t01CompInfo.getT01CompCert0() != null) {
			T01CompCert t01CompCert;
			t01CompCert = t01CompInfo.getT01CompCert0();
			if("0".equals(t01CompInfo.getAbroad())) {
				t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
			}else {
				t01CompCert=new T01CompCert();
				t01CompCert.setId(t01CompInfo.getT01CompCert0().getId());
			}

			t01CompCert.setCompId(t01CompInfo.getId());
			//企业信息的统一社会信用代码或注册号为企业营业执照资质的编号
			if (StringUtils.isNotBlank(t01CompInfo.getUniCretNbr())) {
				t01CompCert.setCertNbr(t01CompInfo.getUniCretNbr());
			} else {
				t01CompCert.setCertNbr(t01CompInfo.getRegiNbr());
			}
			t01CompCert.setCertType("0");//企业资质（国内）

			t01CompCertService.save(t01CompCert);
		}

		if (t01CompInfo.getT01CompCert3() != null) {
			T01CompCert t01CompCert;
			t01CompCert = t01CompInfo.getT01CompCert3();
			if("1".equals(t01CompInfo.getAbroad())) {
				t01CompCert.setCertStat(checkCertStat(t01CompCert.getEffecDate(), t01CompCert.getValidDate()));
			}else {
				t01CompCert=new T01CompCert();
				t01CompCert.setId(t01CompInfo.getT01CompCert3().getId());
			}
			t01CompCert.setCompId(t01CompInfo.getId());
			t01CompCert.setCertNbr(t01CompInfo.getCompUniNbr());
			t01CompCert.setCertType("3");//企业资质（国外）

			t01CompCertService.save(t01CompCert);
		}
	}

	@Transactional
	public void delete(T01CompInfoNew t01CompInfo) throws BusinessException{
        t01CompInfoNewHelperService.checkStatusBeforeHandle("delete",t01CompInfo);
		//删除
		super.delete(t01CompInfo);
	}

	public List<T01CompInfoNew> findSelectedList(List<String> ids) {
		return dao.findSelectedList(ids);
	}
	
}
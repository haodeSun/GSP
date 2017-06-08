/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02stockin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02Stockin;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockin.T02StockinMate;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockin.T02StockinMateDao;

/**
 * 入库Service
 * @author yohu
 * @version 2016-11-24
 */
@Transactional(readOnly = true)
public class T02StockinService extends ExtCrudService<T02StockinDao, T02Stockin> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required = false)
	private List<BusinessService<T02Stockin>> businessServices = new ArrayList<>();

	private T02StockinMateDao t02StockinMateDao;

    @Autowired
    public T02StockinService(
            T02StockinDao dao ,
            T02StockinMateDao T02StockinMateDao
            ) {
        super(dao);
            this.t02StockinMateDao = T02StockinMateDao;
    }

	public T02Stockin get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			businessService.preFetch(id);
		}
		T02Stockin t02Stockin = super.get(id);
		t02Stockin.setT02StockinMateList(t02StockinMateDao.findList(new T02StockinMate(t02Stockin)));
		//执行保存后的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			 businessService.postFetch(t02Stockin);
		}
		return t02Stockin;
	}
	
	public List<T02Stockin> findList(T02Stockin t02Stockin) {
		return super.findList(t02Stockin);
	}
	
	public Page<T02Stockin> findPage(Page<T02Stockin> page, T02Stockin t02Stockin) {
		//执行保存前的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			 businessService.prePaging(page,t02Stockin);
		}
		Page<T02Stockin> paginator = super.findPage(page, t02Stockin);
		//执行保存后的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}
	
	@Transactional
	public void save(T02Stockin t02Stockin) throws BusinessException {
		boolean isNewRecord = t02Stockin.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t02Stockin);
			}else{
				businessService.preInsert(t02Stockin);
			}
		}
		super.save(t02Stockin);
		t02Stockin.getT02StockinMateList()
		            .stream()
		            .filter( t02StockinMate -> t02StockinMate.getId() != null )
		            .forEach( t02StockinMate -> {
			            if (T02StockinMate.DEL_FLAG_NORMAL.equals(t02StockinMate.getDelFlag())){
				            if (StringUtils.isBlank(t02StockinMate.getId())){
				                t02StockinMate.setStockinId(t02Stockin);
	                            t02StockinMate.preInsert();
					            t02StockinMateDao.insert(t02StockinMate);
				            }else{
					            t02StockinMate.preUpdate();
					            t02StockinMateDao.update(t02StockinMate);
				            }
			            } else {
				                t02StockinMateDao.delete(t02StockinMate);
			            }
		            });
		//执行保存后的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t02Stockin);
			}else{
				businessService.postInsert(t02Stockin);
			}
		}
	}
	
	@Transactional
	public void delete(T02Stockin t02Stockin) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			businessService.preDelete(t02Stockin);
		}
		//删除
		super.delete(t02Stockin);
		t02StockinMateDao.delete(new T02StockinMate(t02Stockin));
		//执行保存前的业务代码
		for(BusinessService<T02Stockin> businessService : businessServices){
			businessService.postDelete(t02Stockin);
		}
	}
	
}
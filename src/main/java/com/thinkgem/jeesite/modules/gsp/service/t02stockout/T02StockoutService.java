/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02stockout;

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
import com.thinkgem.jeesite.modules.gsp.entity.t02stockout.T02Stockout;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockout.T02StockoutDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02stockout.T02StockoutMate;
import com.thinkgem.jeesite.modules.gsp.dao.t02stockout.T02StockoutMateDao;

/**
 * 出库信息Service
 * @author yohu
 * @version 2016-11-25
 */
@Service(value="t02StockoutService")
//@Transactional(readOnly = false)
@Transactional(readOnly = true)
public class T02StockoutService extends ExtCrudService<T02StockoutDao, T02Stockout> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required = false)
	private List<BusinessService<T02Stockout>> businessServices = new ArrayList<>();

	private T02StockoutMateDao t02StockoutMateDao;

    @Autowired
    public T02StockoutService(
            T02StockoutDao dao ,
            T02StockoutMateDao T02StockoutMateDao
            ) {
        super(dao);
            this.t02StockoutMateDao = T02StockoutMateDao;
    }

	public T02Stockout get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			businessService.preFetch(id);
		}
		T02Stockout t02Stockout = super.get(id);
		t02Stockout.setT02StockoutMateList(t02StockoutMateDao.findList(new T02StockoutMate(t02Stockout)));
		//执行保存后的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			 businessService.postFetch(t02Stockout);
		}
		return t02Stockout;
	}
	
	public List<T02Stockout> findList(T02Stockout t02Stockout) {
		return super.findList(t02Stockout);
	}
	
	public Page<T02Stockout> findPage(Page<T02Stockout> page, T02Stockout t02Stockout) {
		//执行保存前的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			 businessService.prePaging(page,t02Stockout);
		}
		Page<T02Stockout> paginator = super.findPage(page, t02Stockout);
		//执行保存后的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}
	
	@Transactional
	public void save(T02Stockout t02Stockout) throws BusinessException {
		boolean isNewRecord = t02Stockout.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t02Stockout);
			}else{
				businessService.preInsert(t02Stockout);
			}
		}
		super.save(t02Stockout);
		t02Stockout.getT02StockoutMateList()
		            .stream()
		            .filter( t02StockoutMate -> t02StockoutMate.getId() != null )
		            .forEach( t02StockoutMate -> {
			            if (T02StockoutMate.DEL_FLAG_NORMAL.equals(t02StockoutMate.getDelFlag())){
				            if (StringUtils.isBlank(t02StockoutMate.getId())){
				                t02StockoutMate.setStockoutId(t02Stockout);
	                            t02StockoutMate.preInsert();
					            t02StockoutMateDao.insert(t02StockoutMate);
				            }else{
					            t02StockoutMate.preUpdate();
					            t02StockoutMateDao.update(t02StockoutMate);
				            }
			            } else {
				                t02StockoutMateDao.delete(t02StockoutMate);
			            }
		            });
		//执行保存后的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t02Stockout);
			}else{
				businessService.postInsert(t02Stockout);
			}
		}
	}
	
	@Transactional
	public void delete(T02Stockout t02Stockout) {
		//执行保存前的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			businessService.preDelete(t02Stockout);
		}
		//删除
		try {
			super.delete(t02Stockout);
		} catch (BusinessException e) {
			e.printStackTrace();
		}
		t02StockoutMateDao.delete(new T02StockoutMate(t02Stockout));
		//执行保存前的业务代码
		for(BusinessService<T02Stockout> businessService : businessServices){
			businessService.postDelete(t02Stockout);
		}
	}
	
}
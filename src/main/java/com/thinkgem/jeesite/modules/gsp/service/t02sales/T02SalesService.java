/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02sales;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t02sales.T02SalesDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02sales.T02SalesMateDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02sales.T02Sales;
import com.thinkgem.jeesite.modules.gsp.entity.t02sales.T02SalesMate;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;

/**
 * 售出信息Service
 * @author yohu
 * @version 2016-11-17
 */
@Service
@Transactional(readOnly = true)
public class T02SalesService extends ExtCrudService<T02SalesDao, T02Sales> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required = false)
	private List<BusinessService<T02Sales>> businessServices = new ArrayList<>();

	private T02SalesMateDao t02SalesMateDao;

    @Autowired
    public T02SalesService(
            T02SalesDao dao ,
            T02SalesMateDao T02SalesMateDao
            ) {
        super(dao);
            this.t02SalesMateDao = T02SalesMateDao;
    }

	public T02Sales get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			businessService.preFetch(id);
		}
		T02Sales t02Sales = super.get(id);
		t02Sales.setT02SalesMateList(t02SalesMateDao.findList(new T02SalesMate(t02Sales)));
		//执行保存后的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			 businessService.postFetch(t02Sales);
		}
		return t02Sales;
	}
	
	public List<T02Sales> findList(T02Sales t02Sales) {
		return super.findList(t02Sales);
	}
	
	public Page<T02Sales> findPage(Page<T02Sales> page, T02Sales t02Sales) {
		//执行保存前的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			 businessService.prePaging(page,t02Sales);
		}
		Page<T02Sales> paginator = super.findPage(page, t02Sales);
		//执行保存后的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}
	
	@Transactional
	public void save(T02Sales t02Sales) throws BusinessException {
		boolean isNewRecord = t02Sales.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t02Sales);
			}else{
				businessService.preInsert(t02Sales);
			}
		}
		super.save(t02Sales);
		t02Sales.getT02SalesMateList()
		            .stream()
		            .filter( t02SalesMate -> t02SalesMate.getId() != null )
		            .forEach( t02SalesMate -> {
			            if (T02SalesMate.DEL_FLAG_NORMAL.equals(t02SalesMate.getDelFlag())){
				            if (StringUtils.isBlank(t02SalesMate.getId())){
				                t02SalesMate.setSalesId(t02Sales);
	                            t02SalesMate.preInsert();
					            t02SalesMateDao.insert(t02SalesMate);
				            }else{
					            t02SalesMate.preUpdate();
					            t02SalesMateDao.update(t02SalesMate);
				            }
			            } else {
				                t02SalesMateDao.delete(t02SalesMate);
			            }
		            });
		//执行保存后的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t02Sales);
			}else{
				businessService.postInsert(t02Sales);
			}
		}
	}
	
	@Transactional
	public void delete(T02Sales t02Sales) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			businessService.preDelete(t02Sales);
		}
		//删除
		super.delete(t02Sales);
		t02SalesMateDao.delete(new T02SalesMate(t02Sales));
		//执行保存前的业务代码
		for(BusinessService<T02Sales> businessService : businessServices){
			businessService.postDelete(t02Sales);
		}
	}
	
}
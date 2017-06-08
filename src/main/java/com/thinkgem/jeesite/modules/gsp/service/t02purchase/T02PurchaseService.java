/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t02purchase;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t02purchase.T02PurcMateDao;
import com.thinkgem.jeesite.modules.gsp.dao.t02purchase.T02PurchaseDao;
import com.thinkgem.jeesite.modules.gsp.entity.t02purchase.T02PurcMate;
import com.thinkgem.jeesite.modules.gsp.entity.t02purchase.T02Purchase;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.service.SysAlarmService;

/**
 * 采购Service
 * @author yohu
 * @version 2016-11-16
 */
@Transactional(readOnly = true)
public class T02PurchaseService extends ExtCrudService<T02PurchaseDao, T02Purchase> {

	@SuppressWarnings({"MismatchedQueryAndUpdateOfCollection", "SpringAutowiredFieldsWarningInspection"})
	@Autowired(required = false)
	private List<BusinessService<T02Purchase>> businessServices = new ArrayList<>();

	private T02PurcMateDao t02PurcMateDao;

    @Autowired
    public T02PurchaseService(
            T02PurchaseDao dao ,
            T02PurcMateDao T02PurcMateDao
            ) {
    	super(dao);
        this.t02PurcMateDao = T02PurcMateDao;
    }

	public T02Purchase get(String id) {
		//执行保存前的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			businessService.preFetch(id);
		}
		T02Purchase t02Purchase = super.get(id);
		t02Purchase.setT02PurcMateList(t02PurcMateDao.findList(new T02PurcMate(t02Purchase)));
		//执行保存后的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			 businessService.postFetch(t02Purchase);
		}
		return t02Purchase;
	}
	
	public List<T02Purchase> findList(T02Purchase t02Purchase) {
		return super.findList(t02Purchase);
	}
	
	public Page<T02Purchase> findPage(Page<T02Purchase> page, T02Purchase t02Purchase) {
		//执行保存前的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			 businessService.prePaging(page,t02Purchase);
		}
		Page<T02Purchase> paginator = super.findPage(page, t02Purchase);
		//执行保存后的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			businessService.postPaging(paginator);
		}
		return paginator;
	}
	@Override
	@Transactional
	public void save(T02Purchase t02Purchase) throws BusinessException  {
		boolean isNewRecord = t02Purchase.getIsNewRecord();
		//执行保存前的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			if(!isNewRecord){
				businessService.preUpdate(t02Purchase);
			}else{
				businessService.preInsert(t02Purchase);
			}
		}
		super.save(t02Purchase);
		t02Purchase.getT02PurcMateList()
		            .stream()
		            .filter( t02PurcMate -> t02PurcMate.getId() != null )
		            .forEach( t02PurcMate -> {
			            if (T02PurcMate.DEL_FLAG_NORMAL.equals(t02PurcMate.getDelFlag())){
				            if (StringUtils.isBlank(t02PurcMate.getId())){
				                t02PurcMate.setPurcId(t02Purchase);
	                            t02PurcMate.preInsert();
					            t02PurcMateDao.insert(t02PurcMate);
				            }else{
					            t02PurcMate.preUpdate();
					            t02PurcMateDao.update(t02PurcMate);
				            }
			            } else {
				                t02PurcMateDao.delete(t02PurcMate);
			            }
		            });
		//执行保存后的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			if(!isNewRecord){
				businessService.postUpdate(t02Purchase);
			}else{
				businessService.postInsert(t02Purchase);
			}
		}
	}
	
	@Transactional
	public void delete(T02Purchase t02Purchase) throws BusinessException{
		//执行保存前的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			businessService.preDelete(t02Purchase);
		}
		//删除
		super.delete(t02Purchase);
		t02PurcMateDao.delete(new T02PurcMate(t02Purchase));
		//执行保存前的业务代码
		for(BusinessService<T02Purchase> businessService : businessServices){
			businessService.postDelete(t02Purchase);
		}
	}


	
}
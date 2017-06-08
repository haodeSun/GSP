package com.thinkgem.jeesite.modules.gsp.service.t01salescert;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplExtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 销售人员授权BusinessService
 *
 * @author xuxiaoshuo
 * @version 2017-02-28
 */
@Service
@Transactional
public class T01SalesCertBusinessService extends GenericBusinessService<T01SalesCert> {

    @Autowired
    private T01ComplSuplExtService t01ComplSuplExtService;

    @Override
    public ServiceFlag postInsert(T01SalesCert entity) throws BusinessException {
        return super.postInsert(entity);
    }

    @Override
    public ServiceFlag postUpdate(T01SalesCert entity) throws BusinessException {
        setSuplStat(entity);
        return super.postUpdate(entity);
    }

    /**
     * 当销售人员授权修改时，触发供货者状态更新
     * @param entity
     * @throws BusinessException
     */
    private void setSuplStat(T01SalesCert entity) throws BusinessException {
        if(entity!=null
                &&entity.getComp()!=null
                && StringUtils.isNotBlank(entity.getComp().getId())){
            T01ComplSupl t01ComplSuplSearch=new T01ComplSupl();
            t01ComplSuplSearch.setCompId(entity.getComp().getId());
            List<T01ComplSupl> t01ComplSuplList= t01ComplSuplExtService.findList(t01ComplSuplSearch);

            if(!t01ComplSuplList.isEmpty()){
                t01ComplSuplList=t01ComplSuplList.stream()
                        .filter(item->entity.getComp().getId().equals(item.getCompId()))
                        .collect(Collectors.toList());
            }
            if(!t01ComplSuplList.isEmpty()){
                T01ComplSupl t01ComplSupl=t01ComplSuplExtService.get(t01ComplSuplList.get(0).getId());
                t01ComplSuplExtService.setSuplStatFromSalesCert(t01ComplSupl);
            }
        }

    }





}

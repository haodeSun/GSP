/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01operatehist;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01operatehist.T01OperateHistDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01operatehist.T01OperateHist;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 操作历史Service
 *
 * @author xxs
 * @version 2017-03-22
 */
@Service
@Transactional(readOnly = true)
public class T01OperateHistService extends ExtCrudService<T01OperateHistDao, T01OperateHist> {
    @Autowired
    private T01OperateHistHelperService t01OperateHistHelperService;

    @Autowired
    public T01OperateHistService(
            T01OperateHistDao dao) {
        super(dao);
    }

    public T01OperateHist get(String id) {

        T01OperateHist t01OperateHist = super.get(id);
        return t01OperateHist;
    }

    public List<T01OperateHist> findList(T01OperateHist t01OperateHist) {
        List<T01OperateHist> t01OperateHistList=super.findList(t01OperateHist);

        if("0".equals(t01OperateHist.getClassify())){
            List<String> apprClassify=new ArrayList<>();
            apprClassify.add("2");
            apprClassify.add("3");
            apprClassify.add("4");
            t01OperateHistList=t01OperateHistList.stream().filter(item->apprClassify.contains(item.getOperateType()))
                    .collect(Collectors.toList());
        }
        if("1".equals(t01OperateHist.getClassify())){
            List<String> freezeClassify=new ArrayList<>();
            freezeClassify.add("0");
            freezeClassify.add("1");
            t01OperateHistList=t01OperateHistList.stream().filter(item->freezeClassify.contains(item.getOperateType()))
                    .collect(Collectors.toList());
        }

        for (T01OperateHist item:t01OperateHistList){
            item.setOperateType(DictUtils.getDictLabel(item.getOperateType(),"operateType",""));
        }
        return t01OperateHistList;
    }

    public Page<T01OperateHist> findPage(Page<T01OperateHist> page, T01OperateHist t01OperateHist) {
        Page<T01OperateHist> paginator = super.findPage(page, t01OperateHist);
        return paginator;
    }

    @Transactional
    public void save(T01OperateHist t01OperateHist) throws BusinessException {
        if ("0".equals(t01OperateHist.getOperateType())) {
            t01OperateHistHelperService.checkBeforeHandleStatus("unfreeze", t01OperateHist);
        }
        if ("1".equals(t01OperateHist.getOperateType())) {
            t01OperateHistHelperService.checkBeforeHandleStatus("freeze", t01OperateHist);
        }

        t01OperateHist.preInsert();
        dao.insert(t01OperateHist);
        dao.updateFreezeStatusById(getTableFromModule(t01OperateHist.getModule()), t01OperateHist);
    }

    @Transactional
    public void delete(T01OperateHist t01OperateHist) throws BusinessException{
        //删除
        super.delete(t01OperateHist);
    }
}
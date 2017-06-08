package com.thinkgem.jeesite.modules.gsp.service.t01matrinfo;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01matrinfo.T01MatrInfoDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.EntityExistedException;
import com.thinkgem.jeesite.modules.gsp.service.t01complprod.T01ComplProdExtService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;

/**
 * 物料信息BusinessService
 *
 * @author xuxiaoshuo
 * @version 2016-11-22
 */
@Service
@Transactional
public class T01MatrInfoBusinessService extends GenericBusinessService<T01MatrInfo> {

    /**
     * 物料状态为未关联
     */
    private final String NOT_RELATED = "1";
    /**
     * 物料审批状态为未提交
     */
    private final String UNCOMMITTED = "0";

    private final T01MatrInfoDao t01MatrInfoDao;

    /**
     * 首营产品service
     */
    private final T01ComplProdExtService t01ComplProdExtService;

    @Autowired
    public T01MatrInfoBusinessService(
            T01MatrInfoDao t01MatrInfoDao,
            T01ComplProdExtService t01ComplProdExtService) {
        Assert.notNull(t01ComplProdExtService);
        this.t01MatrInfoDao = t01MatrInfoDao;
        this.t01ComplProdExtService = t01ComplProdExtService;
    }

    /**
     * 在插入新的物料信息前判断物料号是否重复，如果重复则抛出exception
     */
    @Override
    public ServiceFlag preInsert(T01MatrInfo entity) throws BusinessException {

        if (StringUtils.isNotBlank(entity.getMatrNbr())) {
            List<T01MatrInfo> list = t01MatrInfoDao.findByMatrNbr(entity.getMatrNbr());

            if (!list.isEmpty()) {
                throw new EntityExistedException("保存失败，该物料号已存在", "");
            }
        }
        //设置新添加的数据审核状态为未提交
        entity.setApprStat(UNCOMMITTED);
        entity.setMartStat(NOT_RELATED);
        if(StringUtils.isBlank(entity.getMatrPrice())){
            //entity.setMatrPrice("0");
        }

        return ServiceFlag.SUCCESS;
    }

    /**
     * 在删除前需要判断物料是否关联资质，关联资质不能删除抛出exception
     */
    @Override
    public ServiceFlag preDelete(T01MatrInfo entity) {
        //在删除前需要判断物料是否关联资质，关联资质不能删除

//	   List<T01MatrInfo> list = t01MatrInfoDao.findByMatrNbr(entity.getMatrNbr());
//
//	   if (!list.isEmpty()) {
//	     throw new EntityExistedException("该物料号已存在", "");
//	   }


        return ServiceFlag.SUCCESS;
    }

    /**
     *  获取与物料信息关联的产品资质列表
     * @param entity entity
     * @return ServiceFlag
     */
    @Override
    public ServiceFlag postFetch(T01MatrInfo entity) {
        if (entity != null && StringUtils.isNotBlank(entity.getId())) {

            T01ComplProd t01ComplProd = new T01ComplProd();
            t01ComplProd.setMatrId(entity.getId());

            List<T01ComplProd> t01ComplProdResultList = t01ComplProdExtService.findList(t01ComplProd);

            if (t01ComplProdResultList != null && !t01ComplProdResultList.isEmpty()) {
                T01ComplProd t01ComplProdResult = t01ComplProdExtService.get(t01ComplProdResultList.get(0).getId());
                if (t01ComplProdResult != null) {
                    entity.setProdCertIdList(t01ComplProdResult.getProdCertIdList());
                }
            }
        }
        return ServiceFlag.SUCCESS;
    }
}

package com.thinkgem.jeesite.modules.gsp.service.t01complprod;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01complprod.T01ComplProdDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01complprodcert.T01ComplProdCertDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01matrinfo.T01MatrInfoDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.ComplProdStates;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprodcert.T01ComplProdCert;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.MatrInfoStates;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.MatrType;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.EntityExistedException;
import com.thinkgem.jeesite.modules.gsp.service.exception.NoSuchTypeException;
import com.thinkgem.jeesite.modules.gsp.service.t01complprodcert.T01ComplProdCertService;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 首营产品Service
 * @author XXS
 * @version 2016-12-06
 */
@Service
@Transactional
public class T01ComplProdBusinessService extends GenericBusinessService<T01ComplProd> {

    /** 首营产品资质关联Service */
    private T01ComplProdCertService t01ComplProdCertService;
    /** 首营产品资质关联Dao */
    private T01ComplProdCertDao t01ComplProdCertDao;
    /** 物料信息Dao */
    private T01MatrInfoDao t01MatrInfoDao;
    /** 产品资质Dao */
    private T01ProdCertDao t01ProdCertDao;
    /** 首营产品Dao */
    private T01ComplProdDao t01ComplProdDao;

    @Autowired
    public T01ComplProdBusinessService(
            T01ComplProdCertService t01ComplProdCertService,
            T01ComplProdCertDao t01ComplProdCertDao,
            T01MatrInfoDao t01MatrInfoDao,
            T01ProdCertDao t01ProdCertDao,
            T01ComplProdDao t01ComplProdDao) {
        Assert.notNull(t01ComplProdCertService);
        Assert.notNull(t01ComplProdCertDao);
        Assert.notNull(t01MatrInfoDao);
        Assert.notNull(t01ProdCertDao);
        Assert.notNull(t01ComplProdDao);

        this.t01ComplProdCertService = t01ComplProdCertService;
        this.t01ComplProdCertDao=t01ComplProdCertDao;
        this.t01MatrInfoDao=t01MatrInfoDao;
        this.t01ProdCertDao=t01ProdCertDao;
        this.t01ComplProdDao=t01ComplProdDao;
    }

    /**
     * 插入entity前进行唯一和状态检查，进行默认值赋值
     * @param entity entity
     * @return ServiceFlag
     * @throws BusinessException exception
     */
    @Override
    public ServiceFlag preInsert(T01ComplProd entity) throws BusinessException {
        checkOnly(entity);
        checkApprStatu(entity);
        //设置新添加的数据审核状态为未提交
        entity.setApprStat(ApprStatus.NOSUBMIT.toString());

        entity.setComplProdStat(ComplProdStates.EFFECTIVE.toString());

        return ServiceFlag.SUCCESS;
    }

    /**
     * 更新entity前进行唯一和状态检查
     * @param entity entity
     * @return ServiceFlag
     * @throws BusinessException exception
     */
    @Override
    public ServiceFlag preUpdate(T01ComplProd entity) throws BusinessException {
        checkOnly(entity);
        checkApprStatu(entity);

        return ServiceFlag.SUCCESS;
    }

    /**
     * 关联物料与资质前，检查两者审批状态。要求为审批通过
     * 同时要求物料和资质不能为空
     * @param t01ComplProd entity
     */
    private void checkApprStatu(T01ComplProd t01ComplProd) throws BusinessException {

        if (t01ComplProd != null) {
            if (StringUtils.isNotBlank(t01ComplProd.getMatrId())) {
                T01MatrInfo t01MatrInfo = new T01MatrInfo();
                t01MatrInfo.setId(t01ComplProd.getMatrId());
                T01MatrInfo t01MatrInfoResult = t01MatrInfoDao.get(t01MatrInfo);
                if (t01MatrInfoResult != null) {
                    if (!ApprStatus.PASS.toString().equals(t01MatrInfoResult.getApprStat())) {
                        throw new ApprStatusException("保存失败，相关信息通过审批后才能进行关联保存", "");
                    }
                    if (MatrInfoStates.FREEZE.toString().equals(t01MatrInfoResult.getMartStat())) {
                        throw new ApprStatusException("保存失败，相关信息在冻结状态无法进行关联保存", "");
                    }
                    if (MatrType.NOT_MEDICAL.toString().equals(t01MatrInfoResult.getMatrType())) {
                        throw new ApprStatusException("保存失败，非医疗器械物料信息无法进行关联保存", "");
                    }
                }
            }else {
                throw new NoSuchTypeException("保存失败，必须关联物料信息","");
            }
            if (t01ComplProd.getProdCertIdList()!=null) {
                for (String prodCertId : t01ComplProd.getProdCertIdList()) {
                    T01ProdCert t01ProdCert = new T01ProdCert();
                    t01ProdCert.setId(prodCertId);
                    T01ProdCert t01ProdCertResult = t01ProdCertDao.get(t01ProdCert);
                    if (t01ProdCertResult != null) {
                        if (!ApprStatus.PASS.toString().equals(t01ProdCertResult.getApprStat())) {
                            throw new ApprStatusException("保存失败，相关信息通过审批后才能进行关联保存", "");
                        }
                        if (ProdCertStatus.CertStatus.FREEZE.toString().equals(t01ProdCertResult.getCertStat())) {
                            throw new ApprStatusException("保存失败，相关信息在冻结状态无法进行关联保存", "");
                        }
                    }
                }
            }else {
                throw new NoSuchTypeException("保存失败，必须关联产品资质信息","");
            }
        }
    }

    /**
     * 相同物料号+规格型号只能保存一次
     * @param t01ComplProd entity
     * @throws BusinessException exception
     */
    private void checkOnly(T01ComplProd t01ComplProd) throws BusinessException {

        if (t01ComplProd != null) {

            T01ComplProd t01ComplProdSearch = new T01ComplProd();
            t01ComplProdSearch.setMatrId(t01ComplProd.getMatrId());
            t01ComplProdSearch.setSpecType(t01ComplProd.getSpecType());

            List<T01ComplProd> t01ComplProdList = t01ComplProdDao.findList(t01ComplProdSearch);
            if (StringUtils.isNotBlank(t01ComplProd.getId())) {
                t01ComplProdList = t01ComplProdList.stream().filter(item -> !t01ComplProd.getId().equals(item.getId())).collect(Collectors.toList());
            }
            if (t01ComplProdList != null && !t01ComplProdList.isEmpty()) {
                throw new EntityExistedException("保存失败，相同首营产品信息已存在", "");
            }
        }
    }

    /**
     * 在插入首营产品信息后，插入新的资质关联
     * @param entity entity
     * @return ServiceFlag
     * @throws BusinessException exception
     */
    @Override
    public ServiceFlag postInsert(T01ComplProd entity) throws BusinessException {
        saveProdCertIdList(entity);
        return ServiceFlag.SUCCESS;
    }

    /**
     * 在更新首营产品信息后，删除原来资质关联信息，插入新的资质关联
     * @param entity entity
     * @return ServiceFlag
     * @throws BusinessException exception
     */
    @Override
    public ServiceFlag postUpdate(T01ComplProd entity) throws BusinessException {

        t01ComplProdCertDao.deleteByComplProdId(entity.getId());

        saveProdCertIdList(entity);

        return ServiceFlag.SUCCESS;
    }

    /**
     * 保持资质关联
     * @param entity 首营产品entity
     * @throws BusinessException exception
     */
    private void saveProdCertIdList(T01ComplProd entity) throws BusinessException {
        if (entity.getProdCertIdList() != null) {
            for (String prodCertId : entity.getProdCertIdList()) {
                T01ComplProdCert t01ComplProdCert = new T01ComplProdCert();
                t01ComplProdCert.setComplProdId(entity.getId());
                t01ComplProdCert.setProdCertId(prodCertId);
                t01ComplProdCertService.save(t01ComplProdCert);
            }
        }
    }

    /**
     * 获取entity后给ProdCertIdList赋值
     * @param entity entity
     * @return ServiceFlag
     */
    @Override
    public ServiceFlag postFetch(T01ComplProd entity) {
        if (entity != null && StringUtils.isNotBlank(entity.getId())) {
            T01ComplProdCert t01ComplProdCert = new T01ComplProdCert();

            t01ComplProdCert.setComplProdId(entity.getId());

            List<T01ComplProdCert> t01ComplProdCertList = t01ComplProdCertService.findList(t01ComplProdCert);

            if (!t01ComplProdCertList.isEmpty()) {
                List<String> prodCertIdList = new ArrayList<>();
                for (T01ComplProdCert item : t01ComplProdCertList) {
                    prodCertIdList.add(item.getProdCertId());
                }
                entity.setProdCertIdList(prodCertIdList);
            }
        }
        return ServiceFlag.SUCCESS;
    }
}

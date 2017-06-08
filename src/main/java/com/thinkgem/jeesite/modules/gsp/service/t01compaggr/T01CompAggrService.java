/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gsp.service.t01compaggr;

import com.thinkgem.jeesite.common.StatusEnum.ApprStatus;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BusinessService;
import com.thinkgem.jeesite.common.service.ExtCrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01aggrmatr.T01AggrMatrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01compaggr.T01CompAggrDao;
import com.thinkgem.jeesite.modules.gsp.dao.t01matrinfo.T01MatrInfoDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01aggrmatr.T01AggrMatr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggr;
import com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.T01CompAggrRelateMatrInfo;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfonew.T01CompInfoNew;
import com.thinkgem.jeesite.modules.gsp.entity.t01complbuyer.T01ComplBuyer;
import com.thinkgem.jeesite.modules.gsp.entity.t01complprod.T01ComplProd;
import com.thinkgem.jeesite.modules.gsp.entity.t01complsupl.T01ComplSupl;
import com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo.T01MatrInfo;
import com.thinkgem.jeesite.modules.gsp.service.exception.ApprStatusException;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.exception.EntityExistedException;
import com.thinkgem.jeesite.modules.gsp.service.t01aggrmatr.T01AggrMatrService;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfonew.T01CompInfoNewService;
import com.thinkgem.jeesite.modules.gsp.service.t01complbuyer.T01ComplBuyerExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01complprod.T01ComplProdExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01complsupl.T01ComplSuplExtService;
import com.thinkgem.jeesite.modules.gsp.service.t01matrinfo.T01MatrInfoService;
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
import com.thinkgem.jeesite.modules.sys.service.SysConfigService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.thinkgem.jeesite.modules.gsp.entity.t01compaggr.type.AgreementType.SALE;

/**
 * 企业相关协议信息Service
 * @author XXS
 * @version 2016-12-13
 */
public class T01CompAggrService extends ExtCrudService<T01CompAggrDao, T01CompAggr> {

	/**
	 * 业务表表名
	 */
	protected static final String BUSINESS_TABLE = "t01_comp_aggr";
	protected static final String BUSINESS_MODULE = "t01CompAggr";
	protected static final String CONFIG_COMPANY_KEY="config_company_id";

	@Autowired
	protected T01CompInfoNewService t01CompInfoNewService;
	/**
	 * 物料service
	 */
	@Autowired
	protected T01MatrInfoService t01MatrInfoService;
	/**
	 * 首营产品Service
	 */
	@Autowired
	protected T01ComplProdExtService t01ComplProdExtService;
	/**
	 * 购货者service
	 */
	@Autowired
	protected T01ComplBuyerExtService t01ComplBuyerExtService;
	/**
	 * 供货者service
	 */
	@Autowired
	protected T01ComplSuplExtService t01ComplSuplExtService;
	/**
	 * 协议关联物料Service
	 */
	@Autowired
	protected T01AggrMatrService t01AggrMatrService;

	/**
	 * 协议管理Dao
	 */
	@Autowired
	protected T01CompAggrDao t01CompAggrDao;

	/**
	 * 物料信息Dao
	 */
	@Autowired
	protected T01MatrInfoDao t01MatrInfoDao;

	@Autowired
	protected T01AggrMatrDao t01AggrMatrDao;

	@Autowired
	protected SystemService systemService;

	@Autowired
	protected SysConfigService sysConfigService;
	@Autowired
	protected T01CompAggrHelperService t01CompAggrHelperService;

    @Autowired
    public T01CompAggrService(
            T01CompAggrDao dao) {
        super(dao);
    }

	public T01CompAggr get(String id) {

		T01CompAggr entity = super.get(id);

		//设置经营范围数据列表
		entity.setCertScopList(systemService.findAllCertScop());

		//设置购/供货者 和关联的物料/首营产品信息
		if (StringUtils.isNotBlank(entity.getBuyer().getId())) {
			entity.setBuyer(t01ComplBuyerExtService.get(entity.getBuyer().getId()));
		}
		if (StringUtils.isNotBlank(entity.getSupplier().getId())) {
			entity.setSupplier(t01ComplSuplExtService.get(entity.getSupplier().getId()));
		}


		if (entity != null && StringUtils.isNotBlank(entity.getId())) {
			T01AggrMatr t01AggrMatr = new T01AggrMatr();

			t01AggrMatr.setAggrId(entity.getId());

			List<T01AggrMatr> t01AggrMatrList = t01AggrMatrService.findList(t01AggrMatr);

			if (!t01AggrMatrList.isEmpty()) {
				List<T01CompAggrRelateMatrInfo> t01CompAggrRelateMatrInfoList = new ArrayList<>();
				for (T01AggrMatr itemAggrMatr : t01AggrMatrList) {

					T01CompAggrRelateMatrInfo t01CompAggrRelateMatrInfo = new T01CompAggrRelateMatrInfo();

					//设置物料id和单价
					t01CompAggrRelateMatrInfo.setId(itemAggrMatr.getMatr().getId());
					t01CompAggrRelateMatrInfo.setMatrPrice(itemAggrMatr.getPrice());


					//1：找到首营产品
					T01ComplProd t01ComplProd = new T01ComplProd();
					t01ComplProd.setMatrId(itemAggrMatr.getMatr().getId());

					List<T01ComplProd> t01ComplProdList = t01ComplProdExtService.findList(t01ComplProd);

					if (t01ComplProdList != null && !t01ComplProdList.isEmpty()) {
						for (T01ComplProd item : t01ComplProdList) {
							if (StringUtils.isBlank(t01CompAggrRelateMatrInfo.getRegiCertNbr())) {
								t01CompAggrRelateMatrInfo.setRegiCertNbr(item.getRegiCertNbr());
							} else {
								t01CompAggrRelateMatrInfo.setRegiCertNbr(t01CompAggrRelateMatrInfo.getRegiCertNbr() + "," + item.getRegiCertNbr());
							}
							if (StringUtils.isBlank(t01CompAggrRelateMatrInfo.getSpecType())) {
								t01CompAggrRelateMatrInfo.setSpecType(item.getSpecType());
							} else {
								t01CompAggrRelateMatrInfo.setSpecType(t01CompAggrRelateMatrInfo.getSpecType() + "," + item.getSpecType());
							}
						}
					}
					//2：找到物料信息
					T01MatrInfo t01MatrInfo = t01MatrInfoService.get(itemAggrMatr.getMatr().getId());
					t01CompAggrRelateMatrInfo.setMatrNbr(t01MatrInfo.getMatrNbr());
					t01CompAggrRelateMatrInfo.setMatrNmCn(t01MatrInfo.getMatrNmCn());

					t01CompAggrRelateMatrInfoList.add(t01CompAggrRelateMatrInfo);
				}
				entity.setT01CompAggrRelateMatrInfoList(t01CompAggrRelateMatrInfoList);
			}
		}


		return entity;
	}
	
	public List<T01CompAggr> findList(T01CompAggr t01CompAggr) {
		return super.findList(t01CompAggr);
	}
	
	public Page<T01CompAggr> findPage(Page<T01CompAggr> page, T01CompAggr t01CompAggr) {

		Page<T01CompAggr> paginator = super.findPage(page, t01CompAggr);

		return paginator;
	}

	/**
	 * 相同协议编号只能保存一次
	 *
	 * @param t01CompAggr entity
	 * @throws BusinessException exception
	 */
	private void checkOnly(T01CompAggr t01CompAggr) throws BusinessException {

		if (t01CompAggr != null) {

			T01CompAggr t01CompAggrSearch = new T01CompAggr();
			t01CompAggrSearch.setAgreementNo(t01CompAggr.getAgreementNo());

			List<T01CompAggr> t01CompAggrList = t01CompAggrDao.findList(t01CompAggrSearch);
			if (StringUtils.isNotBlank(t01CompAggr.getId())) {
				t01CompAggrList = t01CompAggrList.stream()
						.filter(item -> t01CompAggr.getAgreementNo().equals(item.getAgreementNo()))
						.filter(item -> !t01CompAggr.getId().equals(item.getId()))
						.collect(Collectors.toList());
			}
			if (t01CompAggrList != null && !t01CompAggrList.isEmpty()) {
				throw new EntityExistedException("保存失败，相同协议信息已存在", "");
			}
		}
	}
	/**
	 * 关联物料前，检查审批状态。要求为审批通过
	 * 同时要求物料不能为空
	 *
	 * @param t01CompAggr entity
	 */
	private void checkApprStatu(T01CompAggr t01CompAggr) throws BusinessException {

		if (t01CompAggr != null) {
			if (t01CompAggr.getT01AggrMatrList() != null && !t01CompAggr.getT01AggrMatrList().isEmpty()) {
				for (T01AggrMatr item : t01CompAggr.getT01AggrMatrList()) {
					T01MatrInfo t01MatrInfo = new T01MatrInfo();
					t01MatrInfo.setId(item.getMatr().getId());
					T01MatrInfo t01MatrInfoResult = t01MatrInfoDao.get(t01MatrInfo);
					if (t01MatrInfoResult != null) {
						if (!ApprStatus.PASS.toString().equals(t01MatrInfoResult.getApprStat())) {
							throw new ApprStatusException("保存失败，相关物料信息通过审批后才能进行关联保存", "");
						}
					}
				}
			} else {
			}
		}
	}
	/**
	 * 保存物料关联
	 *
	 * @param entity 协议entity
	 * @throws BusinessException exception
	 */
	private void saveAggrMatrList(T01CompAggr entity) throws BusinessException {

		if (StringUtils.isNotBlank(entity.getId())) {
			t01AggrMatrDao.deleteByAggrId(entity.getId());
		}
		if (entity.getT01AggrMatrList() != null && !entity.getT01AggrMatrList().isEmpty()) {
			for (T01AggrMatr item : entity.getT01AggrMatrList()) {
				item.setAggrId(entity.getId());
				t01AggrMatrService.save(item);
			}
		}
	}

	private void setTheCompany(T01CompAggr entity) {
		//获取本企业
		SysConfig sysConfig = new SysConfig();
		sysConfig.setConfigName(CONFIG_COMPANY_KEY);
		T01CompInfoNew t01CompInfoNew=new T01CompInfoNew();
		List<SysConfig> sysConfigList = sysConfigService.findList(sysConfig);
		if (sysConfigList != null && !sysConfigList.isEmpty()) {

			t01CompInfoNew= t01CompInfoNewService.get(sysConfigList.get(0).getConfigValue());

		}
		if (SALE.equals(entity.getAggrType())) {
			// 如果是经销协议，
			T01ComplSupl supplier = new T01ComplSupl();
			supplier.setId(t01CompInfoNew.getSuplId());
			entity.setSupplier(supplier);
		} else {
			// 如果是采购协议，
			T01ComplBuyer buyer = new T01ComplBuyer();
			buyer.setId(t01CompInfoNew.getBuyerId());
			entity.setBuyer(buyer);
		}
	}

	@Transactional
	public void save(T01CompAggr entity) throws BusinessException {

		t01CompAggrHelperService.checkStatusBeforeHandle("save", entity);

		boolean isNewRecord = entity.getIsNewRecord();

		checkOnly(entity);

		checkApprStatu(entity);

		entity.setAggrStat(checkCertStat(entity.getEffecDate(), entity.getValidDate()));

		setTheCompany(entity);

		//执行保存操作
		super.save(entity);

		saveAggrMatrList(entity);
	}
	
	@Transactional
	public void delete(T01CompAggr entity) throws BusinessException{

		t01CompAggrHelperService.checkStatusBeforeHandle("delete", entity);
		//删除
		super.delete(entity);

	}
	
}
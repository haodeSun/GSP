package com.thinkgem.jeesite.modules.gsp.service.t01prodcert;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.ApprStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class T01ProdCertValidateService extends GenericBusinessService<T01ProdCert> {

	private final T01ProdCertDao t01ProdCertDao;

	@Autowired
	public T01ProdCertValidateService(
			T01ProdCertDao t01ProdCertDao) {
		this.t01ProdCertDao = t01ProdCertDao;
	}

	/**
	 * 更新之后检查是提交还是保存，提交的话就开启流程
	 *
	 * @param entity 产品资质
	 * @return 返回SUCCESS继续其他处理
	 */
	/*@Override
	public ServiceFlag postUpdate(T01ProdCert entity) throws BusinessException {
		String isAppr = entity.getIsappr();
		if(IsAppr.YES.toString().equals(isAppr)){
            String procInsId = t01ProdCertDao.get(entity.getId()).getProcInsId();
            if(validateUpdate(entity)){
				if (StringUtils.isBlank(procInsId)){
					t01ProdCertExtService.startProcess(entity.getId());
					entity.setApprStat(ApprStatus.NOAPPR.toString());
                }else{
					//如果点击的是“提交”按钮，并且流程id 已经存在，则，再次触发流程流转
                    actTaskService.complete(
                    		entity.getAct().getTaskId(),
							procInsId,
							StringUtils.EMPTY,
							entity.getRegiCertNbr(),
							null);
				}
			}else {
				throw new RuntimeException("该记录在审批或者已经通过不能再提交！");
			}
		}
		return ServiceFlag.SUCCESS;
	}
*/
	/**
	 * 修改之前验证
	 * @param t01ProdCert 产品资质实体数据
	 * @return true||false
	 */
	public boolean validateUpdate(T01ProdCert t01ProdCert){
		String apprStatus = t01ProdCert.getApprStat();
		if(StringUtils.isBlank(apprStatus)){
			apprStatus = t01ProdCertDao.get(t01ProdCert.getId()).getApprStat();
		}
		if(ApprStatus.NOAPPR.toString().equals(apprStatus)
				|| ApprStatus.PASS.toString().equals(apprStatus)){
			//加进去一些验证
			return false;
		}

		return true;
	}

}

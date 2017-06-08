package com.thinkgem.jeesite.modules.gsp.service.t01prodcert;

import com.thinkgem.jeesite.common.service.GenericBusinessService;
import com.thinkgem.jeesite.common.service.ServiceFlag;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gsp.dao.t01prodcert.T01ProdCertDao;
import com.thinkgem.jeesite.modules.gsp.entity.t01prodcert.T01ProdCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.ApprStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;

import static com.thinkgem.jeesite.common.service.ServiceFlag.SUCCESS;
import static com.thinkgem.jeesite.modules.gsp.service.t01prodcert.ProdCertStatus.CertStatus;


@Service
@Transactional
public class T01ProdCertBusinessService extends GenericBusinessService<T01ProdCert> {

    // TODO 做成Enum
    private int defaultEffectiveMonths = 6;


    private final T01ProdCertDao t01ProdCertDao;


    @Autowired
    public T01ProdCertBusinessService(T01ProdCertDao t01ProdCertDao) {
        this.t01ProdCertDao = t01ProdCertDao;
    }

    /**
     * 设置保存之前需要自动处理的值
     *
     * @param entity 用户提交的产品资质信息
     * @return 返回状态标识
     */
    @Override
    public ServiceFlag preInsert(T01ProdCert entity) {
        entity.setApprStat(ApprStatus.NOSUBMIT.toString());
        //设置资质状态
        calcAndsetCertStat(entity);
        return SUCCESS;
    }

    /**
     * 自动设置资质状态
     * @param entity 资质数据
     */
    private void calcAndsetCertStat(T01ProdCert entity) {
        //先判断系统配置中是否配置了，有效期（月），如果没有，则去默认值
        int effeArea = defaultEffectiveMonths;
        Calendar calendar = Calendar.getInstance();
        //计算出近效期时间点
        calendar.setTime(entity.getValidPeri());
        calendar.add(Calendar.MONTH, 0 - effeArea);
        Date willInvalDate = calendar.getTime();
        //只处理提交了  生效日期  和  有效期至 的
        if(
                entity != null
                && entity.getEffeDate() != null
                && entity.getValidPeri() != null) {
            //.失效：      now > vaildPeri ||   now < effeDate
            Date currentDate = DateUtils.parseDate(DateUtils.getDate());
            calendar.setTime(currentDate);
            if (DateUtils.toCalendar(entity.getEffeDate())
                    .before(DateUtils.toCalendar(entity.getValidPeri()))) {
                if (DateUtils.toCalendar(entity.getValidPeri()).before(calendar)
                        || DateUtils.toCalendar(entity.getEffeDate()).after(calendar)) {
                    //只要是失效的，就都为失效状态，不管到没到近效期
                    entity.setCertStat(CertStatus.INVALID.toString());
                    //生效：now >= effeDate
                } else if (calendar.after(DateUtils.toCalendar(entity.getEffeDate()))
                        || calendar.equals(DateUtils.toCalendar(entity.getEffeDate()))) {
                    //到近效期  近效期      now＞ vaildPeri - 近效期（月） 　&&　now <= vaildPeri
                    if (calendar.after(DateUtils.toCalendar(willInvalDate))
                            && (calendar.before(DateUtils.toCalendar(entity.getValidPeri()))
                            || calendar.equals(DateUtils.toCalendar(entity.getValidPeri())))) {
                        //资质状态为   近效期
                        entity.setCertStat(CertStatus.WILLINVALID.toString());
                        //未到近效期     now < vaildPeri - 近效期（月） && now>=effeDate
                    } else if (calendar.before(DateUtils.toCalendar(entity.getValidPeri()))
                            && (calendar.after(DateUtils.toCalendar(entity.getEffeDate()))
                            || calendar.equals(DateUtils.toCalendar(entity.getEffeDate())))) {
                        //资质状态为  生效
                        entity.setCertStat(CertStatus.EFFECTIVE.toString());
                    } else {
                        //其他情况默认为空
                        entity.setCertStat(null);
                    }
                } else {
                    entity.setCertStat(null);
                }
            } else {
                entity.setCertStat(null);
            }
        }else{
            entity.setCertStat(null);
        }
    }

    @Override
    public ServiceFlag postInsert(T01ProdCert t01ProdCert) {
        if(t01ProdCert == null){
            return SUCCESS;
        }
        //保存产品资质之后，在路由的后面添加上自己的  id+“,”
        String regiCertNbrs = t01ProdCert.getRegiCertNbrs();
        if(StringUtils.isNotBlank(regiCertNbrs)){
            t01ProdCert.setRegiCertNbrs(regiCertNbrs+t01ProdCert.getId()+",");
        }else{
            t01ProdCert.setRegiCertNbrs(t01ProdCert.getId()+",");
        }
        //同步修改到数据库
        t01ProdCertDao.update(t01ProdCert);
        return SUCCESS;
    }

    @Override
    public ServiceFlag postUpdate(T01ProdCert t01ProdCert){

       /* List<SysChanInfo> sysChanInfoList = t01ProdCert.getSysChanInfoList();
        //update之后更新变更记录的chanId
        sysChanInfoList.forEach(
                chanInfo -> {
                    chanInfo.setChanId(t01ProdCert);
                    sysChanInfoDao.update(chanInfo);
                });*/
        return SUCCESS;
    }


    /**
     * 更新之前检查是否是变更或者延续
     *
     * @param entity 产品资质
     * @return 返回SUCCESS继续其他处理
     */
    @Override
    public ServiceFlag preUpdate(T01ProdCert entity) throws BusinessException {
        //设置资质状态
        calcAndsetCertStat(entity);
        entity.setApprStat(ApprStatus.NOSUBMIT.toString());
        return SUCCESS;
    }

}

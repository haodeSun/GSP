package com.thinkgem.jeesite.modules.gsp.entity.t01compaggr;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * @author XXS
 * @date 2017/1/3
 */
public class T01CompAggrRelateMatrInfo {

    private String id;// 物料id
    private String matrNbr; // 物料号
    private String regiCertNbr;        // 注册证/备案凭证编号
    private String matrNmCn; // 物料名称（中文）
    private String specType;        // 规格型号
    private String matrPrice; // 物料单价

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMatrNbr() {
        return matrNbr;
    }

    public void setMatrNbr(String matrNbr) {
        this.matrNbr = matrNbr;
    }

    public String getRegiCertNbr() {
        return regiCertNbr;
    }

    public void setRegiCertNbr(String regiCertNbr) {
        this.regiCertNbr = regiCertNbr;
    }

    public String getMatrNmCn() {
        return matrNmCn;
    }

    public void setMatrNmCn(String matrNmCn) {
        this.matrNmCn = matrNmCn;
    }

    public String getSpecType() {
        return specType;
    }

    public void setSpecType(String specType) {
        this.specType = specType;
    }

    public String getMatrPrice() {
        return matrPrice;
    }

    public void setMatrPrice(String matrPrice) {
        this.matrPrice = matrPrice;
    }

}

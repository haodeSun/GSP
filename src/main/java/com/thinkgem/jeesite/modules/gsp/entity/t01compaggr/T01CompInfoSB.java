package com.thinkgem.jeesite.modules.gsp.entity.t01compaggr;

/**
 * @author XXS
 * @date 2017/1/3
 */
public class T01CompInfoSB {

    private String id;//配置表id
    private String compId;// 企业id
    private String compName; // 企业名称
    private String buyerId;        // 购货者id
    private String supplierId;        // 供货者id
    private String certScop;        // 供货者id

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompId() {
        return compId;
    }

    public void setCompId(String compId) {
        this.compId = compId;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

    public String getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(String buyerId) {
        this.buyerId = buyerId;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public String getCertScop() {
        return certScop;
    }

    public void setCertScop(String certScop) {
        this.certScop = certScop;
    }
}

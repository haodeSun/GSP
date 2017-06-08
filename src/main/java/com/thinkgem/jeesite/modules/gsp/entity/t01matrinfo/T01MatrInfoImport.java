package com.thinkgem.jeesite.modules.gsp.entity.t01matrinfo;

/**
 * 物料信息导入Entity
 *
 * @author XXS
 */
public class T01MatrInfoImport extends T01MatrInfo {

    private static final long serialVersionUID = 1L;
    /**
     * 同步状态
     */
    private String syncStat;
    /**
     * 同步结果
     */
    private String syncRslt;
    /**
     * 导入批次
     */
    private String batch;

    public T01MatrInfoImport() {
        super();
    }

    public String getSyncStat() {
        return syncStat;
    }

    public void setSyncStat(String syncStat) {
        this.syncStat = syncStat;
    }

    public String getSyncRslt() {
        return syncRslt;
    }

    public void setSyncRslt(String syncRslt) {
        this.syncRslt = syncRslt;
    }

    public String getBatch() {
        return batch;
    }

    public void setBatch(String batch) {
        this.batch = batch;
    }
}

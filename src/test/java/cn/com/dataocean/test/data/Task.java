package cn.com.dataocean.test.data;

import cn.com.dataocean.validator.comparator.NotLaterThan;
import cn.com.dataocean.validator.constraints.DateConstraint;

import java.util.Date;

/**
 * @author Greg Song
 * @since 02/12/2016
 */
@SuppressWarnings("unused")
@DateConstraint(field1 = "startDate", field2 = "endDate", comparator = NotLaterThan.class)
public class Task {
    private Date startDate;
    private Date endDate;
    private Date createDate;
    private Date updateDate;

    public Task(
            Date startDate,
            Date endDate,
            Date createDate,
            Date updateDate) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}

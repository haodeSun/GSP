package cn.com.dataocean.test.data;

import cn.com.dataocean.validator.comparator.Before;
import cn.com.dataocean.validator.comparator.NotLaterThan;
import cn.com.dataocean.validator.constraints.DateConstraint;

import java.util.Date;

/**
 * @author Greg Song
 * @since 02/12/2016
 */
@SuppressWarnings("unused")
@DateConstraint.List({
        @DateConstraint(field1 = "startDate", field2 = "endDate", comparator = NotLaterThan.class, message = "startDate should be no later than endDate"),
        @DateConstraint(field1 = "beforeDate1", field2 = "beforeDate2", comparator = Before.class, message = "beforeDate1 should be before beforeDate2")
})
public class Lesson {
    private Date startDate;
    private Date endDate;
    private Date createDate;
    private Date updateDate;
    private Date beforeDate1;
    private Date beforeDate2;


    public Lesson(Date startDate, Date endDate, Date createDate, Date updateDate) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }

    public Date getBeforeDate1() {
        return beforeDate1;
    }

    public void setBeforeDate1(Date beforeDate1) {
        this.beforeDate1 = beforeDate1;
    }

    public Date getBeforeDate2() {
        return beforeDate2;
    }

    public void setBeforeDate2(Date beforeDate2) {
        this.beforeDate2 = beforeDate2;
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

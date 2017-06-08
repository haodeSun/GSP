package cn.com.dataocean.validator.comparator;

import java.util.Date;

/**
 * @author Greg Song
 * @since 01/12/2016
 */
public abstract class DateComparator implements Comparator<Date> {

    @Override
    public abstract boolean compare(Date a1, Date a2);
}

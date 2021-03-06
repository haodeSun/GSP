package cn.com.dataocean.validator.comparator;

import java.util.Date;

/**
 * 时间比较器，a1早于a2；或者a2为null
 * null代表无限远未来
 * @author Greg Song
 * @since 01/12/2016
 */
public class Before extends DateComparator{
    @Override
    public boolean compare(Date a1, Date a2) {
        return a1 != null && (a2 == null || a1.before(a2));
    }
}

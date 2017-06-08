package cn.com.dataocean.validator.comparator;

import java.util.Date;

/**
 * 时间比较器，a1不可以晚于a2；a1不可以为null或者a2为空
 * null代表无限远未来
 * @author Greg Song
 * @since 01/12/2016
 */
public class NotLaterThan extends DateComparator {
    @Override
    public boolean compare(Date a1, Date a2) {
        return a2 == null || (a1 != null && (a1.before(a2) || a1.equals(a2)));
    }
}

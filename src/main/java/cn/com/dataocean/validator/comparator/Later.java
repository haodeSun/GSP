package cn.com.dataocean.validator.comparator;

import java.util.Date;

/**
 * 时间比较器，a1晚于a2；或者a1为null
 * null代表无限远未来
 * @author Greg Song
 * @since 01/12/2016
 */
@SuppressWarnings("unused")
public class Later extends DateComparator {
    @Override
    public boolean compare(Date a1, Date a2) {
        return a1 == null || ( a2 != null && a1.after(a2));
    }
}

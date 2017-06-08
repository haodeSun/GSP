package cn.com.dataocean.validator.comparator;

/**
 * @author Greg Song
 * @since 01/12/2016
 */
public interface Comparator<T> {
    boolean compare(T a1, T a2);
}

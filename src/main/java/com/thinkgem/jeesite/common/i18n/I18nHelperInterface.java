package com.thinkgem.jeesite.common.i18n;

/**
 * @author Greg Song
 * @since 26/11/2016
 */
public interface I18nHelperInterface {
    /**
     * 获取信息
     * @param text 需要转换的文字
     * @return 转换后的文字
     */
    String getText(String text);

    /**
     * 获取信息
     * @param textId 信息ID
     * @return 转换后的信息
     */
    String getText(Integer textId);
}

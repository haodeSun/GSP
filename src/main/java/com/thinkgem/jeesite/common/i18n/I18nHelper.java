package com.thinkgem.jeesite.common.i18n;

/**
 * @author Greg Song
 * @since 26/11/2016
 */
public class I18nHelper implements I18nHelperInterface{
    @Override
    public String getText(String text) {
        return text;
    }

    @Override
    public String getText(Integer textId) {
        return null;
    }
}

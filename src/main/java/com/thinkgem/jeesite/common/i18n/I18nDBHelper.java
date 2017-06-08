package com.thinkgem.jeesite.common.i18n;

/**
 * @author Greg Song
 * @since 26/11/2016
 */
public class I18nDBHelper implements I18nHelperInterface{
    @Override
    public String getText(String text) {
        // access db or file or constants
        return text;
    }

    /**
     * 根据消息ID来获取消息正文
     * @param textId 信息ID
     * @return 消息正文
     */
    @Override
    public String getText(Integer textId) {
        // 暂时放到一个全局的String Helper里面
        return null;
    }
}

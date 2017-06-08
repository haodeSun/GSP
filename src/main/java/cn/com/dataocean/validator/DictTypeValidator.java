package cn.com.dataocean.validator;

import cn.com.dataocean.validator.constraints.DictType;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.List;

/**
 * 通过字典类型判断数据验证实现
 * 验证规则:
 * 1：当canBlank为true时,被验证值为Blank时,则返回true;
 * 被验证值不为Blank时，通过dictType获取到listDict，listDict为empty则直接返回false，
 * 不为空时，如果value属于listDict的value值，则返回true;否则返回false.
 * 2：当canBlank为false时,被验证值为Blank时,则返回false；
 * 被验证值不为Blank时，通过dictType获取到listDict，listDict为empty则直接返回false，
 * 不为空时，如果value属于listDict的value值，则返回true;否则返回false.
 *
 * @author XXS
 */
public class DictTypeValidator implements ConstraintValidator<DictType, String> {
    private String dictType;
    private boolean canBlank;

    /**
     * 初始化字典验证注解
     */
    @Override
    public void initialize(DictType arg0) {
        this.dictType = arg0.dictType();
        this.canBlank = arg0.canBlank();
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext constraintValidatorContext) {
        if (canBlank && StringUtils.isBlank(value)) {
            return true;
        } else if (StringUtils.isBlank(value)) {
            return false;
        } else {
            List<Dict> listDict = DictUtils.getDictList(dictType);
            if (listDict.isEmpty()) {
                return false;
            }
            for (Dict item : listDict) {
                if (value.equals(item.getValue())) {
                    return true;
                }
            }
            return false;
        }
    }
}

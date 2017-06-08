package com.thinkgem.jeesite.modules.gsp.web.t01salescert;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.JsonResponse;
import com.thinkgem.jeesite.modules.gsp.entity.t01salescert.T01SalesCert;
import com.thinkgem.jeesite.modules.gsp.service.exception.BusinessException;
import com.thinkgem.jeesite.modules.gsp.service.t01salescert.T01SalesCertHelperService;
import com.thinkgem.jeesite.modules.gsp.service.t01salescert.T01SalesCertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author Greg Song
 * @since 22/12/2016
 */
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01salescert/t01SalesCert")
public class T01SalesCertExtController extends T01SalesCertController {
    @Autowired
    private T01SalesCertHelperService t01SalesCertHelperService;
    @Autowired
    public T01SalesCertExtController(
            T01SalesCertService t01SalesCertService) {
        super(t01SalesCertService);
    }
    @RequestMapping(value = {"toDelete"})
    public String toDelete(
            @RequestParam(required = false) String conditionOrder,
            T01SalesCert t01SalesCert,
            HttpServletRequest request,
            HttpServletResponse response,
            Model model) {
        Page<T01SalesCert> page = t01SalesCertService.findPage(new Page<>(request, response), t01SalesCert);
        model.addAttribute("page", page);
        //保存上次查询条件
        model.addAttribute("conditionOrder", conditionOrder);
        return "modules/gsp/t01salescert/t01SalesCertList_Delete";
    }

    /**
     * 获取所有最新的购货者记录
     * @return 购货者列表
     */
    @RequestMapping(
            value="get-all-sales",
            name="t01_sales_get_all_sales",
            method = RequestMethod.GET
    )
    @ResponseBody
//    @RequiresPermissions("gsp:t01complbuyer:t01ComplBuyer:view")
    public List<Map<String, Object>> getAllBuyers() {
        // 获取所有的购货者记录
        return t01SalesCertService
                .findList(new T01SalesCert())
                .stream()
//                .filter( b -> true ) // TODO 过滤已经被变更过的记录
                .map(sales -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", sales.getId());
                    map.put("pId", null);
                    if (sales.getSalesName() != null) {
                        map.put("name", sales.getSalesName());
                    } else {
                        map.put("name", sales.getId());
                    }
                    return map;
                })
                .collect(Collectors.toList());
    }

    @ResponseBody
    @RequestMapping(value = "checkStatusBeforeHandle")
    public Object checkStatusBeforeHandle(
            @RequestParam String handle,
            T01SalesCert t01SalesCert) {

        String code;
        String message;
        int data = 0;
        try {
            t01SalesCertHelperService.checkStatusBeforeHandle(handle, t01SalesCert);
            code = "100";
            message = "可以操作";
        } catch (BusinessException e) {
            code = "101";
            message = e.getMessage();
        } catch (Exception e) {
            logger.error("处理前的状态检查发生错误" + e.getMessage());
            code = "102";
            message = "检查错误";
        }
        return JsonResponse.create(code, message, data).getResult();
    }
}

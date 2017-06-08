package com.thinkgem.jeesite.modules.gsp.web.t01compinfo;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.modules.gsp.entity.t01compinfo.T01CompInfo;
import com.thinkgem.jeesite.modules.gsp.service.t01compinfo.T01CompInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author Greg Song
 * @since 21/12/2016
 */
@SuppressWarnings("MVCPathVariableInspection")
@Controller
@RequestMapping(value = "${adminPath}/gsp/t01compinfo/t01CompInfo")
public class T01CompInfoExtController extends T01CompInfoController {
    @Autowired
    public T01CompInfoExtController(T01CompInfoService t01CompInfoService) {
        super(t01CompInfoService);
    }

    /**
     * 获取所有最新的购货者记录
     * @return 购货者列表
     */
    @RequestMapping(
            value="/get-all-comp",
            name="get_all_companies",
            method = RequestMethod.GET
    )
    @ResponseBody
//    @RequiresPermissions("gsp:t01compinfo:t01CompInfo:view")
    public List<Map<String, Object>> getAllBuyers() {
        // 获取所有的购货者记录
        return t01CompInfoService
                .findList(new T01CompInfo())
                .stream()
                .filter( i -> true ) // TODO 过滤掉旧的记录
                .map(info -> {
                    Map<String, Object> map = Maps.newHashMap();
                    map.put("id", info.getId());
                    map.put("pId", null);
                    if (info.getCompNameCn() != null) {
                        map.put("name", info.getCompNameCn());
                    } else {
                        map.put("name", info.getId());
                    }
                    return map;
                })
                .collect(Collectors.toList());
    }
}

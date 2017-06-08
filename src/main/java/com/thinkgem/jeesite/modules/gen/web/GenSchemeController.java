/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.gen.Exception.InvalidGroupSettingException;
import com.thinkgem.jeesite.modules.gen.entity.GenScheme;
import com.thinkgem.jeesite.modules.gen.entity.GenTable;
import com.thinkgem.jeesite.modules.gen.entity.GenTableColumn;
import com.thinkgem.jeesite.modules.gen.service.GenSchemeService;
import com.thinkgem.jeesite.modules.gen.service.GenTableService;
import com.thinkgem.jeesite.modules.gen.util.GenUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 生成方案Controller
 * @author ThinkGem
 * @version 2013-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/gen/genScheme")
public class GenSchemeController extends BaseController {

	private static final String ERR_MESSAGE_INVALID_GROUP_SETTING = "部分列没有设置分组";
	private final GenSchemeService genSchemeService;

	private final GenTableService genTableService;

	@Autowired
	public GenSchemeController(GenSchemeService genSchemeService,
							   GenTableService genTableService) {
		this.genSchemeService = genSchemeService;
		this.genTableService = genTableService;
	}

	@ModelAttribute
	public GenScheme get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return genSchemeService.get(id);
		}else{
			return new GenScheme();
		}
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = {"list", ""})
	public String list(GenScheme genScheme, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			genScheme.setCreateBy(user);
		}
        Page<GenScheme> page = genSchemeService.find(new Page<>(request, response), genScheme);
        model.addAttribute("page", page);

		return "modules/gen/genSchemeList";
	}

	@RequiresPermissions("gen:genScheme:view")
	@RequestMapping(value = "form")
	public String form(GenScheme genScheme, Model model) {
		if (StringUtils.isBlank(genScheme.getPackageName())){
			genScheme.setPackageName("com.thinkgem.jeesite.modules");
		}
		model.addAttribute("genScheme", genScheme);
		model.addAttribute("config", GenUtils.getConfig());
		model.addAttribute("tableList", genTableService.findAll());
		return "modules/gen/genSchemeForm";
	}

	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "save")
	public String save(GenScheme genScheme, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, genScheme)){
			return form(genScheme, model);
		}
		List<Group> genTableColMaps = group(genScheme);
		genScheme.setColumnGroupList(genTableColMaps);
		String result = genSchemeService.save(genScheme);
		addMessage(redirectAttributes, "操作生成方案'" + genScheme.getName() + "'成功<br/>"+result);
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}

	/**
	 * 对该表所有列进行分组
	 * @param genScheme 表结构
	 * @return 排序后分组
	 * @throws InvalidGroupSettingException 分组设定不正确
	 */
	public List<Group> group(GenScheme genScheme) throws InvalidGroupSettingException {
		GenTable genTable = genTableService.get(genScheme.getGenTable().getId());
		List<String> groupNameList = genTableService.getGroupNames(genTable.getId());
		List<GenTableColumn> genTableColumnList = genTable.getColumnList();

		// 因为只在ViewForm中使用，不影响其他页面
		genTableColumnList = genTableColumnList.stream()
				.filter(c -> Objects.equals(c.getIsEdit(), "1"))
				.collect(Collectors.toList());

		int groupNumber = genTableService.getGroupNumber(genTable.getId());
		List<Group> groupList = new
				ArrayList<>();

		// 如果没有设定分组则统一按照单个分组处理
		if (groupNumber == 0) {
			groupList.add(new Group(0, genTableColumnList, null));
		} else { // 对字段进行分组和优先级排序
			int fieldHandledNumber = 0;
			int setPriority =999;//默认优先级
			// 遍历分组
			for (String name : groupNameList) {
				// 利用Java8的stream api对column列表进行过滤，
				// 只有是当前分组并且不是基本字段的列计入该分组
				List<GenTableColumn> genTableColList = genTableColumnList
						.stream()
						.filter((col) ->
								name.equals(col.getGroupName()) &&
										col.getIsNotBaseField() )
						.collect(Collectors.toList());

				// 如果分组成员不为空，加入分组列表
				if (!genTableColList.isEmpty()) {
					// 强制要求使用该分组下第一个列的设定优先级设置
					Integer priority = genTableColList.get(0).getGroupPriority();
					//优先级为空，设置默认优先级
					if(priority==null){
						priority =setPriority;
						setPriority++;
					}
					groupList.add(new Group(priority, genTableColList, name));

					// 累计符合条件的列数量
					fieldHandledNumber += genTableColList.size();
				}
			}
			groupList = groupList
					.stream()
					.sorted(Comparator.comparingInt(Group::getPriority))
					.collect(Collectors.toList())
			;

			// 统计所有非基本列的数量
			long totalFieldNumber = genTableColumnList.stream().filter
					(GenTableColumn::getIsNotBaseField).count() ;

			// 检查是否所有列都设置了分组
			if (fieldHandledNumber != totalFieldNumber) {
				throw new InvalidGroupSettingException(ERR_MESSAGE_INVALID_GROUP_SETTING);
			}
		}
		return groupList;
	}

	@RequiresPermissions("gen:genScheme:edit")
	@RequestMapping(value = "delete")
	public String delete(GenScheme genScheme, RedirectAttributes redirectAttributes) {
		genSchemeService.delete(genScheme);
		addMessage(redirectAttributes, "删除生成方案成功");
		return "redirect:" + adminPath + "/gen/genScheme/?repage";
	}

}

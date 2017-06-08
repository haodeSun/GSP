/*
  Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.gen.dao.GenSchemeDao;
import com.thinkgem.jeesite.modules.gen.dao.GenTableColumnDao;
import com.thinkgem.jeesite.modules.gen.dao.GenTableDao;
import com.thinkgem.jeesite.modules.gen.entity.*;
import com.thinkgem.jeesite.modules.gen.util.GenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.thinkgem.jeesite.modules.gen.util.GenUtils.fileToObject;

/**
 * 生成方案Service
 * @author ThinkGem
 * @version 2013-10-15
 */
@Service
@Transactional(readOnly = true)
public class GenSchemeService extends BaseSchemeService {

	private final GenSchemeDao genSchemeDao;
	//	@Autowired
//	private GenTemplateDao genTemplateDao;
	private final GenTableDao genTableDao;
	private final GenTableColumnDao genTableColumnDao;

	@Autowired
	public GenSchemeService(
			GenSchemeDao genSchemeDao,
			GenTableDao genTableDao,
			GenTableColumnDao genTableColumnDao) {
		Assert.notNull(genSchemeDao);
		Assert.notNull(genTableDao);
		Assert.notNull(genTableColumnDao);
		this.genSchemeDao = genSchemeDao;
		this.genTableDao = genTableDao;
		this.genTableColumnDao = genTableColumnDao;
	}

	public GenScheme get(String id) {
		return genSchemeDao.get(id);
	}
	
	public Page<GenScheme> find(Page<GenScheme> page, GenScheme genScheme) {
		GenUtils.getTemplatePath();
		genScheme.setPage(page);
		page.setList(genSchemeDao.findList(genScheme));
		return page;
	}
	
	@Transactional
	public String save(GenScheme genScheme) {
		if (super.save(genScheme) == PersistStatus.NEW){
			genSchemeDao.insert(genScheme);
		}else{
			genSchemeDao.update(genScheme);
		}

		// 生成代码
		if (FLAG_SAVE.equals(genScheme.getFlag())){
			return generateCode(genScheme);
		}
		return "";
	}
	
	@Transactional
	public void delete(GenScheme genScheme) {
		genSchemeDao.delete(genScheme);
	}
	
	private String generateCode(GenScheme genScheme){

		// 结果消息，用于返回给用户
		StringBuilder result = new StringBuilder();

		// 获取主表的配置数据, from gen_table
		GenTable genTable = getTableMetadata(genScheme);

		// 获取主表字段的配置数据，from gen_table_column
		setTableColumnMetadata(genTable);

		// 获取所有代码模板
		GenConfig config = GenUtils.getConfig();

		GenOverrideConfig overrideConfig = fileToObject(
				"override_config.xml",
				GenOverrideConfig.class
		);

		// 获取模板列表
		genScheme.setGenTable(genTable);

        // 获取主表模板
		Map<String, List<GenTemplate>> templateList =
				GenUtils.getTemplateList(
						config,
						overrideConfig,
						genScheme,
						genScheme.getCategory(),
						false
				);

		// 构造查询条件
		GenTable parentTable = new GenTable();
		parentTable.setParentTable(genTable.getName());

		// 获取所有字表数据
		genTable.setChildList(genTableDao.findList(parentTable));

		// 获取子表模板
		Map<String, List<GenTemplate>> childTableTemplateList =
				GenUtils.getTemplateList(
						config,
                        overrideConfig,
						genScheme,
						genScheme.getCategory(),
						true
				);

		// 先生成子表文件
		result.append(
				genCode4SlaveTables(
						genScheme,
						genTable,
						childTableTemplateList)
		);

		// 生成主表文件
		result.append(
				genCode4MasterTable(
						genScheme,
						genTable,
						templateList)
		);
		return  result.toString();
	}

	private void setTableColumnMetadata(GenTable genTable) {
		// 设置表的列配置
		genTable.setColumnList(
				genTableColumnDao.findList(
						new GenTableColumn(new GenTable(genTable.getId()))
				)
		);
	}

	// 查询主表及字段列
	private GenTable getTableMetadata(GenScheme genScheme) {
		return genTableDao.get(
				genScheme.getGenTable().getId()
		);
	}

	// 生成子表模板代码

	/**
	 * FIXME 这个方法开始有点长得过分了
	 * @param genScheme 代码配置数据
	 * @param genTable 表配置
	 * @param templateMapper 字表对应的模板
	 */
	private String genCode4SlaveTables(
			GenScheme genScheme,
			GenTable genTable,
			Map<String, List<GenTemplate>> templateMapper) {
		final StringBuilder result = new StringBuilder();
		// 遍历模板列表
		templateMapper.entrySet()
				.forEach(entry -> {
					String tableName = entry.getKey();
					List<GenTemplate> templateList = entry.getValue();
					// 遍历子表列表，找到和模板对应的字表数据
					genTable.getChildList().stream()
							.filter(table -> tableName.equals(table.getName()))
							.findFirst()
							.ifPresent(table->{
								table.setParent(genTable);
								setTableColumnMetadata(table);
								// 相当于设置当前要生成的表
								genScheme.setGenTable(table);

								// 遍历模板列表生成代码文件
								templateList.forEach(
										t -> {
											// TODO 这个merge操作应该用泛型重新实现
											Map<String, Object> m =  Stream.of(GenUtils
													.getDataModel(genScheme), t.getContext())
													.map((java.util.function.Function<Map<String, ?>, java.util.Set<? extends Map.Entry<String, ?>>>) (stringMap) -> stringMap.entrySet())          // converts each map into an entry set
													.flatMap(Collection::stream) // converts each set into an entry stream, then "concatenates" it in place of the original set
													.collect(
															Collectors.toMap(            // collects into a map
																	Map.Entry::getKey,   // where each entry is based
																	Map.Entry::getValue, // on the entries in the stream
																	(oldValue, value) -> value         // such that
																	// if a value already exist for
																	// a given key, the max of the old
																	// and new value is taken
															)
													);
											m.put("actions", t.getActions());
											result.append(
													GenUtils.generateToFile(
															t,
															m,
															genScheme.getReplaceFile(),genScheme.getCategory()
													)
											);
										});
							});
				});

		return result.toString();
	}

	// 生成主表模板代码
	/**
	 *
	 * @param genScheme 代码配置数据
	 * @param genTable 表信息
	 * @param templateMapper 模板列表
	 * @return 文件生成结果
	 */
	private String genCode4MasterTable(
			GenScheme genScheme,
			GenTable genTable,
			Map<String, List<GenTemplate>> templateMapper) {
		genScheme.setGenTable(genTable);
		StringBuilder result = new StringBuilder();
		Map<String, Object> model = GenUtils.getDataModel(genScheme);
		// 合并context到model里面
		// 通过遍历模板列表生成文件
		templateMapper.entrySet().stream()
				// 查找当前主表的对应模板
				.filter(t->t.getKey().equals(genTable.getName()))
				.findFirst() // 只可能有一个
				.ifPresent( entry -> {
					List<GenTemplate> templateList = entry.getValue();
					// 更新model
					templateList.forEach(t -> {
						Map<String, Object> m =  Stream.of(model, t.getContext())
								.map((java.util.function.Function<Map<String, ?>, java.util.Set<? extends Map.Entry<String, ?>>>) (stringMap) -> stringMap.entrySet())          // converts each map into an entry set
								.flatMap(Collection::stream) // converts each set into an entry stream, then "concatenates" it in place of the original set
								.collect(
										Collectors.toMap(            // collects into a map
												Map.Entry::getKey,   // where each entry is based
												Map.Entry::getValue, // on the entries in the stream
												(oldValue, value) -> value         // such that
													// if a value already exist for
												// a given key, the max of the old
												// and new value is taken
										)
								)
						;
						m.put("actions", t.getActions());
						result.append(
								GenUtils.generateToFile(
										t,
										m,
										genScheme.getReplaceFile(),genScheme.getCategory()
								)
						);

					});
				});
		return result.toString();
	}
}

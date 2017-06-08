/*
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.gen.util;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JaxbMapper;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.FileUtils;
import com.thinkgem.jeesite.common.utils.FreeMarkers;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.gen.entity.*;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;

import java.io.*;
import java.nio.file.Files;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 代码生成工具类
 *
 * @author ThinkGem
 * @version 2013-11-16
 */
public class GenUtils {

    private static Logger logger = LoggerFactory.getLogger(GenUtils.class);
    private static final String EXTEND_DETECT_PATTERN =
            "(.+)(Controller|Service|Dao).java";

    /**
     * 初始化列属性字段
     *
     * @param genTable 表信息
     */
    public static void initColumnField(GenTable genTable) {
        for (GenTableColumn column : genTable.getColumnList()) {

            // 如果是不是新增列，则跳过。
            if (StringUtils.isNotBlank(column.getId())) {
                continue;
            }

            // 设置字段说明
            if (StringUtils.isBlank(column.getComments())) {
                column.setComments(column.getName());
            }

            // 设置java类型
            if (StringUtils.startsWithIgnoreCase(column.getJdbcType(), "CHAR")
                    || StringUtils.startsWithIgnoreCase(column.getJdbcType(), "VARCHAR")
                    || StringUtils.startsWithIgnoreCase(column.getJdbcType(), "NARCHAR")) {
                column.setJavaType("String");
            } else if (StringUtils.startsWithIgnoreCase(column.getJdbcType(), "DATETIME")
                    || StringUtils.startsWithIgnoreCase(column.getJdbcType(), "DATE")
                    || StringUtils.startsWithIgnoreCase(column.getJdbcType(), "TIMESTAMP")) {
                column.setJavaType("java.util.Date");
                column.setShowType("dateselect");
            } else if (StringUtils.startsWithIgnoreCase(column.getJdbcType(), "BIGINT")
                    || StringUtils.startsWithIgnoreCase(column.getJdbcType(), "NUMBER")) {
                // 如果是浮点型
                String[] ss = StringUtils.split(StringUtils.substringBetween(column.getJdbcType(), "(", ")"), ",");
                if (ss != null && ss.length == 2 && Integer.parseInt(ss[1]) > 0) {
                    column.setJavaType("Double");
                }
                // 如果是整形
                else if (ss != null && ss.length == 1 && Integer.parseInt(ss[0]) <= 10) {
                    column.setJavaType("Integer");
                }
                // 长整形
                else {
                    column.setJavaType("Long");
                }
            }

            // 设置java字段名
            column.setJavaField(StringUtils.toCamelCase(column.getName()));

            // 是否是主键
            column.setIsPk(genTable.getPkList().contains(column.getName()) ? "1" : "0");

            // 插入字段
            column.setIsInsert("1");

            // 编辑字段
            if (!StringUtils.equalsIgnoreCase(column.getName(), "id")
                    && !StringUtils.equalsIgnoreCase(column.getName(), "create_by")
                    && !StringUtils.equalsIgnoreCase(column.getName(), "create_date")
                    && !StringUtils.equalsIgnoreCase(column.getName(), "del_flag")) {
                column.setIsEdit("1");
            }

            // 列表字段
            if (StringUtils.equalsIgnoreCase(column.getName(), "name")
                    || StringUtils.equalsIgnoreCase(column.getName(), "title")
                    || StringUtils.equalsIgnoreCase(column.getName(), "remarks")
                    || StringUtils.equalsIgnoreCase(column.getName(), "update_date")) {
                column.setIsList("1");
            }

            // 查询字段
            if (StringUtils.equalsIgnoreCase(column.getName(), "name")
                    || StringUtils.equalsIgnoreCase(column.getName(), "title")) {
                column.setIsQuery("1");
            }

            // 查询字段类型
            if (StringUtils.equalsIgnoreCase(column.getName(), "name")
                    || StringUtils.equalsIgnoreCase(column.getName(), "title")) {
                column.setQueryType("like");
            }

            // 设置特定类型和字段名

            // 用户
            if (StringUtils.startsWithIgnoreCase(column.getName(), "user_id")) {
                column.setJavaType(User.class.getName());
                column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                column.setShowType("userselect");
            }
            // 部门
            else if (StringUtils.startsWithIgnoreCase(column.getName(), "office_id")) {
                column.setJavaType(Office.class.getName());
                column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                column.setShowType("officeselect");
            }
            // 区域
            else if (StringUtils.startsWithIgnoreCase(column.getName(), "area_id")) {
                column.setJavaType(Area.class.getName());
                column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                column.setShowType("areaselect");
            }
            // 创建者、更新者
            else if (StringUtils.startsWithIgnoreCase(column.getName(), "create_by")
                    || StringUtils.startsWithIgnoreCase(column.getName(), "update_by")) {
                column.setJavaType(User.class.getName());
                column.setJavaField(column.getJavaField() + ".id");
            }
            // 创建时间、更新时间
            else if (StringUtils.startsWithIgnoreCase(column.getName(), "create_date")
                    || StringUtils.startsWithIgnoreCase(column.getName(), "update_date")) {
                column.setShowType("dateselect");
            }
            // 备注、内容
            else if (StringUtils.equalsIgnoreCase(column.getName(), "remarks")
                    || StringUtils.equalsIgnoreCase(column.getName(), "content")) {
                column.setShowType("textarea");
            }
            // 父级ID
            else if (StringUtils.equalsIgnoreCase(column.getName(), "parent_id")) {
                column.setJavaType("This");
                column.setJavaField("parent.id|name");
                column.setShowType("treeselect");
            }
            // 所有父级ID
            else if (StringUtils.equalsIgnoreCase(column.getName(), "parent_ids")) {
                column.setQueryType("like");
            }
            // 删除标记
            else if (StringUtils.equalsIgnoreCase(column.getName(), "del_flag")) {
                column.setShowType("radiobox");
                column.setDictType("del_flag");
            }
        }
    }

    /**
     * 获取模板路径
     *
     * @return 模板路径
     */
    public static String getTemplatePath() {
        try {
            File file = new DefaultResourceLoader().getResource("").getFile();
            if (file != null) {
                return file.getAbsolutePath() + File.separator + StringUtils.replaceEach(GenUtils.class.getName(),
                        new String[]{"util." + GenUtils.class.getSimpleName(), "."}, new String[]{"template", File.separator});
            }
        } catch (Exception e) {
            logger.error("{}", e);
        }

        return "";
    }

    /**
     * XML文件转换为对象，默认使用/templates/module/gen路劲下代码
     *
     * @param fileName 待转换文件名
     * @param clazz    要转换成的类
     * @return 生成好的类
     */
    @SuppressWarnings({"unchecked", "WeakerAccess"})
    public static <T> T fileToObject(String fileName, Class<?> clazz) {
        String pathName = "/templates/modules/gen/" + fileName;
        try {
//			logger.debug("File to object: {}", pathName);
            Resource resource = new ClassPathResource(pathName);
            InputStream is = resource.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            StringBuilder sb = new StringBuilder();
            while (true) {
                String line = br.readLine();
                if (line == null) {
                    break;
                }
                sb.append(line).append("\r\n");
            }

            is.close();
            br.close();

            return StringToObject(sb.toString(), clazz);
        } catch (IOException e) {
            logger.warn("Error file convert: {}", e.getMessage());
        }
//		String pathName = StringUtils.replace(getTemplatePath() + "/" + fileName, "/", File.separator);
//		logger.debug("file to object: {}", pathName);
//		String content = "";
//		try {
//			content = FileUtils.readFileToString(new File(pathName), "utf-8");
////			logger.debug("read config content: {}", content);
//			return (T) JaxbMapper.fromXml(content, clazz);
//		} catch (IOException e) {
//			logger.warn("error convert: {}", e.getMessage());
//		}
        return null;
    }

    @SuppressWarnings({"unchecked", "WeakerAccess"})
    public static <T> T StringToObject(String templateStr, Class<?> clazz) {
        return (T) JaxbMapper.fromXml(templateStr, clazz);
    }

    /**
     * 获取代码生成配置对象
     *
     * @return 配置对象
     */
    public static GenConfig getConfig() {
        return fileToObject("config.xml", GenConfig.class);
    }

    /**
     * 根据分类获取模板列表
     *
     * @param config       配置
     * @param scheme       生成方案, 主要是为了在这里获取到表名，这样可以从覆盖配置里面找到对应的配置项
     * @param category     生成类别
     * @param isChildTable 是否是子表
     * @return 模板列表
     */
    public static Map<String, List<GenTemplate>> getTemplateList(
            GenConfig config,
            GenOverrideConfig overrideConfig,
            GenScheme scheme,
            String category,
            boolean isChildTable) {
        Map<String, List<GenTemplate>> templateMap = new HashMap<>();
        // 参数是否提供完整
        if (config != null &&
                config.getCategoryList() != null &&
                category != null) {
            // 遍历分类
            for (GenCategory e : config.getCategoryList()) {
                if (category.equals(e.getValue())) { // 找到对应分类
                    List<String> list = new ArrayList<>();
                    List<GenTable> tables = new ArrayList<>();
                    if (!isChildTable) {
                        // 主表模板列表
                        list = e.getTemplate();
                        tables.add(scheme.getGenTable());
                    } else {
                        // 子表模板列表，这个是规定当一个表是子表时需要生成的代码
                        list = e.getChildTableTemplate() == null ? list : e.getChildTableTemplate();
                        // 这里要得到一个子表名列表
                        scheme.getGenTable()
                                .getChildList()
                                .forEach(tables::add);

                    }


                    for (GenTable table : tables) {
                        String tableName = table.getName();
                        List<GenTemplate> templateList = new ArrayList<>();
                        for (String s : list) {
                            // 这里其实是解析reference的过程，并且递归获取模板的过程
                            if (isReferenceTemplateCategory(s)) {
                                // 保存GenTable用于恢复上下文
                                GenTable originGenTable = scheme.getGenTable();
                                scheme.setGenTable(table);
                                Map<String, List<GenTemplate>> map = getTemplateList(
                                        config,
                                        overrideConfig,
                                        scheme,
                                        getReferencedTemplateCategory(s),
                                        false
                                );
                                // 恢复上下文
                                scheme.setGenTable(originGenTable);

                                // 如果模板已经有内容了，需要进行合并
                                if (templateMap.size() > 0){
                                    templateMap = Stream.of(templateMap, map)
                                            .flatMap(m -> m.entrySet().stream())
                                            .collect(
                                                    Collectors.toMap(
                                                            Map.Entry::getKey,
                                                            Map.Entry::getValue,
                                                            (oldValue, value) ->
                                                            {
                                                                oldValue.addAll(value);
                                                                return oldValue;
                                                            }
                                                    )
                                            );
                                } else {
                                    templateMap.putAll(map);
                                }
                            } else {
                                // 直接通过xml->object的方式获取模板配置（文件名，目录，模板内容）
                                GenTemplate template = fileToObject(s, GenTemplate.class);
                                if (template != null) {
                                    template.setTemplatePath(s);
                                    templateList.add(template);
                                }
                            }
                        }
                        // TODO hack original process and inject template by override configuration
                        // FIXME 这段代码需要重构，太丑了
                        if (overrideConfig != null) {
                            overrideConfig.getTableList()
                                    .stream()
                                    // 查找对应表设置
                                    .filter(t -> Objects.equals(t.getName(), tableName))
                                    .findFirst()
                                    // 如果找到对应表
                                    .ifPresent(
                                            t -> t.getCategoryConfList()
                                                    .stream()
                                                    // 查找对应类别
                                                    .filter(c -> c.getName().equals(category))
                                                    .findFirst()
                                                    // 如果找到
                                                    .ifPresent(c -> {
                                                        c.getTemplateConfList()
                                                                .forEach(template -> {
                                                                    switch (template.getType()) {
                                                                        case "override":
                                                                            templateList
                                                                                    .stream()
                                                                                    .filter(tmp -> tmp.getTemplatePath().equals(template.getPath()))
                                                                                    .findFirst()
                                                                                    .ifPresent(templateList::remove);
                                                                        case "add":
                                                                            if (templateList
                                                                                    .stream()
                                                                                    .filter(tmp -> tmp.getTemplatePath().equals(template.getPath()))
                                                                                    .count() == 0) {
                                                                                GenTemplate genTemplate = fileToObject(template.getPath(), GenTemplate.class);
                                                                                if (genTemplate != null) {
                                                                                    genTemplate.setContext(template.getContext());
                                                                                    genTemplate.setActions(template.getActions());
                                                                                    genTemplate.setTemplatePath(template.getPath());
                                                                                    templateList.add(genTemplate);
                                                                                }
                                                                            }
                                                                            break;
                                                                        case "remove":
                                                                            templateList
                                                                                    .stream()
                                                                                    .filter(tmp -> tmp.getTemplatePath().equals(template.getPath()))
                                                                                    .findFirst()
                                                                                    .ifPresent(templateList::remove);
                                                                            break;
                                                                        default:
                                                                            // 暂时不知道还有没有第三种操作
                                                                            break;
                                                                    }
                                                                });
                                                    }));
                        }
                        if (templateMap.containsKey(tableName)) {
                            templateMap.get(tableName).addAll(templateList);
                        } else {
                            templateMap.put(tableName, templateList);
                        }
                    }
                }
            }
        }
        return templateMap;
    }

    private static String getReferencedTemplateCategory(String s) {
        return StringUtils.replace(
                s,
                GenCategory.CATEGORY_REF,
                "");
    }

    private static boolean isReferenceTemplateCategory(String s) {
        return StringUtils.startsWith(s, GenCategory.CATEGORY_REF);
    }

    /**
     * 获取数据模型
     *
     * @param genScheme 元数据
     * @return 数据模型
     */
    public static Map<String, Object> getDataModel(GenScheme genScheme) {
        Map<String, Object> model = Maps.newHashMap();

        model.put("packageName", StringUtils.lowerCase(genScheme.getPackageName()));
        model.put("lastPackageName", StringUtils.substringAfterLast((String) model.get("packageName"), "."));
        model.put("moduleName", StringUtils.lowerCase(genScheme.getModuleName()));
        model.put("subModuleName", StringUtils.lowerCase(genScheme.getSubModuleName()));
        model.put("className", StringUtils.uncapitalize(genScheme.getGenTable().getClassName()));
        model.put("ClassName", StringUtils.capitalize(genScheme.getGenTable().getClassName()));

        model.put("functionName", genScheme.getFunctionName());
        model.put("functionNameSimple", genScheme.getFunctionNameSimple());
        model.put("functionAuthor", StringUtils.isNotBlank(genScheme.getFunctionAuthor()) ? genScheme.getFunctionAuthor() : UserUtils.getUser().getName());
        model.put("functionVersion", DateUtils.getDate());

        model.put("urlPrefix", model.get("moduleName") + (StringUtils.isNotBlank(genScheme.getSubModuleName())
                ? "/" + StringUtils.lowerCase(genScheme.getSubModuleName()) : "") + "/" + model.get("className"));
        model.put("viewPrefix", //StringUtils.substringAfterLast(model.get("packageName"),".")+"/"+
                model.get("urlPrefix"));
        model.put("permissionPrefix", model.get("moduleName") + (StringUtils.isNotBlank(genScheme.getSubModuleName())
                ? ":" + StringUtils.lowerCase(genScheme.getSubModuleName()) : "") + ":" + model.get("className"));

        model.put("dbType", Global.getConfig("jdbc.type"));

        model.put("table", genScheme.getGenTable());
        model.put("groupList", genScheme.getColumnGroupList());
        return model;
    }

    /**
     * 生成代码文件
     *
     * @param tpl           模板
     * @param model         元数据
     * @param isReplaceFile 是否替换原文件
     * @return 状态消息
     */
    public static String generateToFile(
            GenTemplate tpl,
            Map<String, Object> model,
            boolean isReplaceFile,String category) {
        // 获取生成文件名
        String fileName = genFileName(tpl, model,category.contains("ext"));
        logger.debug(" fileName === " + fileName);

        // TODO 这里要检查需要生成的文件是否已有扩展


        // 获取生成文件内容
        String content = FreeMarkers.renderString(
                tpl.getTemplatePath(),
                StringUtils.trimToEmpty(tpl.getContent()),
                model
        );
        logger.debug(" content === \r\n" + content);

        // 如果选择替换文件，则删除原文件
        if (isReplaceFile) {
            FileUtils.deleteFile(fileName);
        }

        // 创建并写入文件
        if (FileUtils.createFile(fileName)) {
            FileUtils.writeToFile(fileName, content, true);
            logger.debug(" file create === " + fileName);
            return "生成成功：" + fileName + "<br/>";
        } else {
            logger.debug(" file extents === " + fileName);
            return "文件已存在：" + fileName + "<br/>";
        }
    }

    @SuppressWarnings("WeakerAccess")
    protected static String genFileName(GenTemplate tpl, Map<String, Object> model,boolean isGenExt) {
        String fileName = Global.getProjectPath()
                + File.separator
                + StringUtils.replaceEach(
                FreeMarkers.renderString(tpl.getTemplatePath(),
                        tpl.getFilePath() + "/",
                        model),
                new String[]{"//", "/", "."},
                new String[]{File.separator, File.separator, File.separator})
                + FreeMarkers.renderString(tpl.getTemplatePath(), tpl.getFileName(), model);
        // TODO 这里暂时只实现对Controller、Service、Dao的Java文件的扩展检查，其他类型文件暂不处理
        Pattern r = Pattern.compile(EXTEND_DETECT_PATTERN);
        Matcher m = r.matcher(fileName);
        if (m.find( )) {
            String extendedFileName = m.group(1) + "Ext" + m.group(2) + ".java";
            if (Files.exists(new File(extendedFileName).toPath())|| isGenExt) {
                model.put("extended", true);
            } else {
                model.put("extended", false);
            }
        }
        return fileName;
    }

    public static void main(String[] args) {
        try {
            GenConfig config = getConfig();
            System.out.println(config);
            System.out.println(JaxbMapper.toXml(config));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

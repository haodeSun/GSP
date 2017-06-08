package com.thinkgem.jeesite.modules.gen.entity;

import org.junit.Test;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

/**
 * @author Greg Song
 * @since 06/11/2016
 */
public class GenOverrideConfigTest {
    private String output = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
            "<config>\n" +
            "    <tables>\n" +
            "        <table name=\"t01_prod_cert\" workflow=\"false\">\n" +
            "            <categories>\n" +
            "                <category name=\"dao\">\n" +
            "                    <template type=\"add\">\n" +
            "                        <actions/>\n" +
            "                        <context>\n" +
            "                            <entries>\n" +
            "<key>childTable</key>\n" +
            "<value xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xs=\"http://www.w3.org/2001/XMLSchema\" xsi:type=\"xs:string\">lala</value>\n" +
            "                            </entries>\n" +
            "                        </context>\n" +
            "                        <path>over.xml</path>\n" +
            "                    </template>\n" +
            "                </category>\n" +
            "            </categories>\n" +
            "        </table>\n" +
            "    </tables>\n" +
            "</config>\n";

    @Test
    public void testGenOverrideConfig() throws JAXBException, IOException {
        GenOverrideConfig config = new GenOverrideConfig();

        GenOverrideConfig.TemplateConf template = new GenOverrideConfig.TemplateConf();
        template.setType("add");
        template.setPath("over.xml");
        template.addContext("childTable", "lala");
        GenOverrideConfig.CategoryConf category = new GenOverrideConfig.CategoryConf();
        category.setName("dao");
        category.addTemplateConf(template);
        GenOverrideConfig.TableConf table = new GenOverrideConfig.TableConf();
        table.setName("t01_prod_cert");
        table.addCategory(category);
        config.addTable(table);
        File file = new File("file.xml");
        JAXBContext jaxbContext = JAXBContext.newInstance(GenOverrideConfig.class);
        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
        // output pretty printed
        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        jaxbMarshaller.marshal(config, file);
        String content = new String(Files.readAllBytes(Paths.get("file.xml")));
        // 测试符合预期输出
        assertEquals(output, content);
        Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
        config = (GenOverrideConfig) jaxbUnmarshaller.unmarshal(file);
        // 测试反序列化成功
        assertNotNull(config);
        // 测试解析正确
        assertEquals("t01_prod_cert", config.getTableList().get(0).getName());
    }
}
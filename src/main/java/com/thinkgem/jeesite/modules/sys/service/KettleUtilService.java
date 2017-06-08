package com.thinkgem.jeesite.modules.sys.service;

import org.apache.commons.lang.StringUtils;
import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.Result;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.logging.KettleLogStore;
import org.pentaho.di.core.logging.LogLevel;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.modules.gen.util.GenUtils;
import com.thinkgem.jeesite.modules.sys.entity.SysConfig;
/**
 * Kettle 的服务类
 * @author huyong
 *
 */
@Service
public class KettleUtilService {
	private static Logger logger = LoggerFactory.getLogger(KettleUtilService.class);
	
	private static final int maxSize = 5000;
	private static final int maxLogTimeoutMinutes = 1440;
	private SysConfigExtService sysConfigService;

	@Autowired
	public KettleUtilService(SysConfigExtService sysConfigService){
		this.sysConfigService=sysConfigService;
	}
	public void trans() {
		SysConfig sysConfig =sysConfigService.findByName("ktr.purchase.dir");
		if (sysConfig != null && !StringUtils.isBlank(sysConfig.getConfigValue())) {
		try {
//			用于设置kettle的plugin 目录，也可通过设置系统参数：
//			-DKETTLE_PLUGIN_BASE_FOLDERS="D:\Program Files\pdi\data-integration\plugins"进行配置
			
//			StepPluginType.getInstance().getPluginFolders()
//			.add(new PluginFolder(plugDir, false, true));
				KettleEnvironment.init();
				KettleLogStore.init(maxSize, maxLogTimeoutMinutes, true, true);

				TransMeta transMeta = new TransMeta(sysConfig.getConfigValue());

				Trans trans = new Trans(transMeta);
				trans.setLogLevel(LogLevel.DEBUG);
				trans.execute(null);
				trans.waitUntilFinished();

				Result result = trans.getResult();

				if (result.getNrErrors() > 0) {
					String all_msg = KettleLogStore.getAppender().getBuffer()
							.toString();
					KettleLogStore.getAppender().clear();
					logger.debug(all_msg);
				} else {
					logger.debug(result.getLogText());

				}
			}
			 catch (KettleException e) {
				e.printStackTrace();
			}
		}

			
	}
}

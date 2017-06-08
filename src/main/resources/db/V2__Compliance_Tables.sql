CREATE TABLE `t01_compl_prod` (
  `id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '系统主键',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remarks` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '逻辑删除标志',
  `proc_ins_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例id',
  `cert_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '产品资质id',
  `matr_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '物料ID',
  `compl_prod_stat` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '首营产品状态',
  `appr_stat` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '审批状态',
  `mart_unit` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '物料单位',
  `spec_type` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '规格型号',
  `stor_temp` double NOT NULL COMMENT '存储条件_温度',
  `stor_wet` double NOT NULL COMMENT '存储条件_湿度',
  `tran_temp` double NOT NULL COMMENT '运输条件_温度',
  `tran_wet` double NOT NULL COMMENT '运输条件_湿度',
  `valid_months` int(11) NOT NULL COMMENT '产品有效期（月）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用于记录首营审批的物料信息、物料质量信息(用于提取判断)';

CREATE TABLE `t01_compl_prod_cert` (
  `id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '系统主键',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remarks` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '逻辑删除标志',
  `proc_ins_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `prod_cert_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '产品资质ID',
  `compl_prod_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '首营产品ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `t01_compl_prod_cert_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用于记录首营产品与产品资质的关联';
CREATE TABLE `t01_comp_aggr` (
  `id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '系统主键',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remarks` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL COMMENT '逻辑删除标志',
  `proc_ins_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `supl_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '供货者id',
  `buye_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '购货者id',
  `aggr_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '协议编号',
  `orig_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '上级协议Id',
  `author` varchar(250) COLLATE utf8_bin NOT NULL COMMENT '授权人',
  `location` varchar(250) COLLATE utf8_bin NOT NULL COMMENT '地址信息',
  `aggr_type` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '协议类别',
  `aggr_scop` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '经营范围',
  `prod_scop` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '生成范围',
  `prod_comp` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '生成企业',
  `aggr_amnt` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '协议金额',
  `aggr_stat` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '协议状态',
  `appr_stat` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '审核状态',
  `effec_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '生效日期',
  `valid_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '有效期至',
  `attachment` varchar(2048) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='记录企业相关协议信息（采购、经销）';

CREATE TABLE `t01_aggr_matr` (
  `id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '系统主键',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remarks` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '逻辑删除标志',
  `proc_ins_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `aggr_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '协议id',
  `matr_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '物料id',
  `price` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '单价',
  `count` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用于记录协议与物料的关联';

CREATE TABLE `t01_comp_info` (
  `id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '系统主键',
  `create_by` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remarks` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '逻辑删除标志',
  `proc_ins_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `comp_type` varchar(16) CHARACTER SET utf8 DEFAULT NULL COMMENT '企业类型',
  `uni_cret_nbr` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '统一社会信用代码',
  `regi_nbr` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '注册证号',
  `org_cert_nbr` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '组织机构代码证号',
  `tax_nbr` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '税务登记证号',
  `busi_mode` varchar(16) COLLATE utf8_bin DEFAULT NULL COMMENT '经营方式',
  `busi_loca` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '经营场所',
  `stor_loca` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '库房地址',
  `comp_name_cn` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '企业名称（中文）',
  `comp_name_en` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '企业名称（英文）',
  `short_name` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '简称',
  `comp_desc` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `regi_loca` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '注册地址',
  `annu_check_stat` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '年检状态',
  `legal_pers` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '法人姓名',
  `prod_abli_eval` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '生产能力评价',
  `qual_mgr_eval` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '质量管理评价',
  `stor_abli_eval` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '仓储能力评价',
  `deli_abli_eval` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '交付能力评价',
  `afte_sale_abli_eval` varchar(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '售后服务能力评价',
  `phonetic` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '拼音',
  `code` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '邮编',
  `area_code` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '区号',
  `telephone` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `fax` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '传真',
  `telegraph` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '电报',
  `cont_pers` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '联系人',
  `cont_pers_tel` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '联系人电话',
  `email` varchar(250) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用于记录企业信息';

CREATE TABLE `t01_comp_cert` (
  `id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '系统主键	',
  `create_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '更新人',
  `update_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remarks` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '逻辑删除标志',
  `proc_ins_id` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '流程实例ID',
  `comp_id` varchar(128) COLLATE utf8_bin NOT NULL COMMENT '企业id',
  `cert_nbr` varchar(250) COLLATE utf8_bin NOT NULL COMMENT '资质证号',
  `cert_type` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '资质类型',
  `cert_name` varchar(250) COLLATE utf8_bin NOT NULL COMMENT '机构名称/销售人员姓名',
  `cert_scop` varchar(1000) COLLATE utf8_bin NOT NULL COMMENT '生产/经营/销售范围/诊疗科目',
  `effec_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '生效日期/发证日期',
  `valid_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '有效期至',
  `cert_stat` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '资质状态',
  `appr_stat` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '审批状态',
  `attachment` varchar(2048) COLLATE utf8_bin NOT NULL COMMENT '附件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用于记录企业资质（经营资质、生产资质、医疗机构、销售授权）';

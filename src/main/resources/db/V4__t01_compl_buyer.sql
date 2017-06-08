CREATE TABLE `t01_compl_buyer` (
  `id` varchar(128) NOT NULL COMMENT '系统主键',
  `create_by` varchar(64) NOT NULL COMMENT '创建人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新人',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(512) DEFAULT NULL COMMENT '备注信息',
  `del_flag` varchar(1) NOT NULL DEFAULT '0' COMMENT '删除标志',
  `proc_ins_id` varchar(128) DEFAULT NULL COMMENT '流程实例ID',
  `comp_id` varchar(128) NOT NULL COMMENT '企业id',
  `buyer_stat` varchar(16) NOT NULL COMMENT '购货者状态',
  `appr_stat` varchar(16) NOT NULL COMMENT '审批状态',
  `attachment` varchar(2048) DEFAULT NULL COMMENT '附件',
  `isChanged` char(1) NOT NULL DEFAULT '0' COMMENT '是否被变更标志',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='首营购货者表';
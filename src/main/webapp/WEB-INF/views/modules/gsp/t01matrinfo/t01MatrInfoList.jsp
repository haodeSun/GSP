<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>物料信息管理</title>
    <meta name="decorator" content="default"/>
    <%--HeadJS模块--%>
    <%@ include file="Part_ListHeadJS.jsp" %>
	<script>
        $(document).ready(function(){
            setTableDefault("t01MatrInfo","${ctx}/sys/user/getSysUserConfig");
            holdTable("holdTable","t01MatrInfo","${ctx}/sys/user/setSysUserConfig");
        })
	</script>
</head>
<body>

	<ul class="breadcrumb">
	  <li>首页<span class="divider">&gt;</span></li>
	  <li>物料信息<span class="divider">&gt;</span></li>
	  <li class="active">物料信息查询</li>
	</ul>

	<div id="topTitle">物料信息查询</div>

	<%--Form模块--%>
	<form:form id="searchForm" modelAttribute="t01MatrInfo" action="${ctx}/gsp/t01matrinfo/t01MatrInfo/" method="post"
			   class="breadcrumb form-search">
	<%@ include file="Part_ListForm.jsp" %>
	</form:form>
	<sys:message content="${message}"/>

    <%--修改--%>
	<shiro:hasPermission name="gsp:t01matrinfo:t01MatrInfo:edit">
	<a id="toEdit" href="javascript:void(0)" onclick="toEdit()"><span class="modifySpan newBtn btn btn-primary">修改</span></a>
	</shiro:hasPermission>
	<sys:operateButton module="t01MatrInfo" forward="${ctx}/gsp/t01matrinfo/t01MatrInfo/toDetail"/>

	<%--Table模块--%>
	<%@ include file="Part_ListTable.jsp" %>

	<input id="exportUrl" type="hidden"  value="${ctx}/gsp/t01matrinfo/t01MatrInfo/export" >

    <script type="text/javascript">
        function toEdit() {
            var editId = "";
            var selectedNum = 0;
            $('#contentTable tbody input[type="checkbox"]').each(function () {
                if (this.checked == true) {
                    editId = $(this).attr("data-id").trim();
                    selectedNum++;
                }
            });

            if (selectedNum > 1) {
                alertx("只能选择一条数据修改！");
                return false;
            } else if (selectedNum == 0) {
                alertx("请选择一条数据修改！");
                return false;
            } else {
                window.location.href = "${ctx}/gsp/t01matrinfo/t01MatrInfo/form?id=" + editId;
            }
        }
    </script>
</body>
</html>
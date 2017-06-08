<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>仪表盘</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>

<form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/" method="post" class="breadcrumb form-search">
    <%--<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>--%>
    <%--<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>--%>
    <div id="pagingDiv" class="table-scrollable homePage">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation"  class="active">
                <a href="#p0" role="tab" data-toggle="tab">
                    首页
                </a>
            </li>
            <li role="presentation" >
                <a href="#p1" role="tab" data-toggle="tab">
                    日历
                </a>
            </li>
        </ul>
        <div class="tab-content">
            <div role="tabpanel"  class=
                    "tab-pane fade in active"

                 id="p0">
                <table id="contentTable" class="table table-bordered">
                    <thead>
                    <tr>
                        <th><span class="toDoSpan"></span>待办事项<i class="icon-plus-sign toDoI"></i></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    </tbody>
                </table>

                <table id="contentTable" class="table table-bordered">
                    <thead>
                    <tr>
                        <th><span class="earlyWarningSpan"></span>首营产品近效期预警<i class="icon-plus-sign earlyWarningI"></i></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="newsSpan">new</span><span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    </tbody>
                </table>

                <table id="contentTable" class="table table-bordered">
                    <thead>
                    <tr>
                        <th><span class="earlyWarningSpan"></span>首营供货近效期预警<i class="icon-plus-sign earlyWarningI"></i></th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>

                <table id="contentTable" class="table table-bordered">
                    <thead>
                    <tr>
                        <th><span class="earlyWarningSpan"></span>首营购货近效期预警<i class="icon-plus-sign earlyWarningI"></i></th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>

                <table id="contentTable" class="table table-bordered">
                    <thead>
                    <tr>
                        <th><span class="noticeSpan"></span>系统公告<i class="icon-plus-sign noticeI"></i></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    <tr>
                        <td>系统公告系统公告系统公告系统公告系统公告系统公告<span class="dataSpan">2016.11.23</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div role="tabpanel" class=
                    "tab-pane fade"

                 id="p1">
            </div>
        </div>
    </div>
</form:form>

</body>
</html>

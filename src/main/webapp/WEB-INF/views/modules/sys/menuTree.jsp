<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%><%--
<html>
<head>
	<title>菜单导航</title>
	<meta name="decorator" content="blank"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".accordion-heading a").click(function(){
				$('.accordion-toggle i').removeClass('icon-chevron-down');
				$('.accordion-toggle i').addClass('icon-chevron-right');
				if(!$($(this).attr('href')).hasClass('in')){
					$(this).children('i').removeClass('icon-chevron-right');
					$(this).children('i').addClass('icon-chevron-down');
				}
			});
			$(".accordion-body a").click(function(){
				$("#menu-${param.parentId} li").removeClass("active");
				$("#menu-${param.parentId} li i").removeClass("icon-white");
				$(this).parent().addClass("active");
				$(this).children("i").addClass("icon-white");
				//loading('正在执行，请稍等...');
			});
			//$(".accordion-body a:first i").click();
			//$(".accordion-body li:first li:first a:first i").click();
		});
	</script>
</head>
<body> --%>
	<c:set var="index" value="1" scope="request" />
	<div class="accordion" id="menu-${param.parentId}">
	<c:set var="menuList" value="${fns:getMenuList()}"/>
	<c:set var="firstMenu" value="true"/><c:forEach items="${menuList}" var="menu" varStatus="idxStatus"><c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
		<div class="accordion-group">
		    <div class="accordion-heading">
		    	<!-- <div class="backgroundDiv"></div> onmouseenter="moveIn(this,event)" onmouseleave="moveOut(this,event)"-->
		    	<a style="padding-left:2px;" class="accordion-toggle" data-toggle="collapse" data-parent="#menu-${param.parentId}" data-href="#collapse-${menu.id}" href="#collapse-${menu.id}" title="${menu.remarks}"><i class="icon-${not empty menu.icon ? menu.icon : 'circle-arrow-right'}"></i><%-- <i class="icon-chevron-${not empty firstMenu && firstMenu ? 'down' : 'right'}"></i> --%><!-- <i class="penPic"></i> -->&nbsp;${menu.name}</a>
		    </div>
		    <span class="underline"></span>
		    <div id="collapse-${menu.id}" class="accordion-body collapse ${not empty firstMenu && firstMenu ? 'in' : ''}">
				<div class="accordion-inner">
					<ul class="nav nav-list">
					  <c:forEach items="${menuList}" var="menu2">
					  <c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
						<li>
							<!-- <div class="backgroundDiv"></div> onmouseenter="moveIn(this,event)" onmouseleave="moveOut(this,event)"-->
							<a onclick="threeLevelPullDown(this)" data-href=".menu3-${menu2.id}" href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}" target="${not empty menu2.target ? menu2.target : 'mainFrame'}" >
								<!-- <i class="icon-${not empty menu2.icon ? menu2.icon : 'circle-arrow-right'}"></i> -->
							&nbsp;${menu2.name}<i class="pullDown"></i></a>
							<ul class="nav nav-list hide" style="margin:0;padding-right:0;">
							  <c:forEach items="${menuList}" var="menu3">
							  <c:if test="${menu3.parent.id eq menu2.id&&menu3.isShow eq '1'}">
								<li class="menu3-${menu2.id} hide">
									<!-- <div class="backgroundDiv"></div> onmouseenter="moveIn(this,event)" onmouseleave="moveOut(this,event)"-->
									<a data-href=".menu3-${menu3.id}" href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}" target="${not empty menu3.target ? menu3.target : 'mainFrame'}" >
										<!-- <i class="icon-${not empty menu3.icon ? menu3.icon : 'circle-arrow-right'}"></i> -->
										<!-- <i class="circlePic"></i> -->
										<i></i>
									&nbsp;${menu3.name}</a>
									<ul class="nav nav-list hide" style="margin:0;padding-right:0;">
									  <c:forEach items="${menuList}" var="menu4">
									  <c:if test="${menu4.parent.id eq menu3.id&&menu4.isShow eq '1'}">
										<li class="menu3-${menu3.id} hide">
											<!-- <div class="backgroundDiv"></div> onmouseenter="moveIn(this,event)" onmouseleave="moveOut(this,event)"-->
											<a href="${fn:indexOf(menu4.href, '://') eq -1 ? ctx : ''}${not empty menu4.href ? menu4.href : '/404'}" target="${not empty menu4.target ? menu4.target : 'mainFrame'}" >
												<!-- <i class="icon-${not empty menu4.icon ? menu4.icon : 'circle-arrow-right'}"></i> -->
												<!-- <i class="circlePic"></i> -->
												<i></i>
											&nbsp;${menu4.name}</a>
										</li>
									  </c:if>
									  </c:forEach>
									</ul>
								</li>
							  </c:if>
							  </c:forEach>
							</ul>
						</li>
						<c:set var="firstMenu" value="false"/>
					  </c:if>
					  </c:forEach>
					</ul>
				</div>
		    </div>
		</div>
	</c:if></c:forEach></div>
	<%--
</body>
</html> --%>
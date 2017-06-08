<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')}</title>
	<meta name="decorator" content="blank"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}"/>
    <c:if test="${tabmode eq '1'}"><link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
    <script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script></c:if>
	<style type="text/css">
		  
		body{font-family: "Microsoft YaHei" ! important;}
		#main {padding:0;margin:0;} #main .container-fluid{padding:0 4px 0 6px;}
		#header {margin:0 0 8px;position:static;} #header li {font-size:14px;_font-size:12px;}
		#header .brand {font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:26px; margin:0px;}
		#header .brand img {padding-left:10px; padding-right:50px;}
		#footer {margin:8px 0 0 -10px;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
		#footer, #footer a {color:#999;} #left{overflow-x:hidden;overflow-y:auto;} #left .collapse{position:static;}
		#userControl>li>a{/*color:#fff;*/text-shadow:none;} #userControl>li>a:hover, #user #userControl>li.open>a{background:transparent;}
		#slider {
			width:56px;
			height:4px;
			background:#1FB5AB;
			border:0px;
			border-radius:2px;
			position:absolute;
			z-index:999;
			top:37px;
			left:233px;
		}
		.navbar .nav>.active>a{
			background:#fff;
			color:#1FB5AB;
			box-shadow:0px 0px 0px #fff;
		}
		.navbar .nav>.active>a:hover{
			background:#fff;
			color:#1FB5AB;
			box-shadow:0px 0px 0px #fff;
		}
		.navbar .nav>li>a {
			color:#3c3c3c;
			text-shadow: 0px 0px 0 rgba(0,0,0,0); 
			font-family:"Microsoft YaHei";
			font-size:14px;
		}
		.navbar .nav>li>a:hover {
			background:#fff;
			color:#1FB5AB;
		}
		
		.accordion-heading {
			background-image:none;
			background-color:#3d4652;
		}
		.accordion-heading a{
			/*padding-left:20px !important;*/
			color:#889097;
			padding:19px 50px 18px 30px!important;
			padding-bottom: 18px !important;
			font-family:"Microsoft YaHei" !important;
		}
		.accordion-heading a:hover {
			color:#fff;
		}
		.accordion-inner{
			padding: 0px;
			border:0px;
		}
		.accordion-inner a {
			color:#889097;
		}
		.accordion-inner>ul>li>a {
			background:url('${ctxStatic}/images/leftMiddle.svg');
		}
		.accordion-inner>ul>li>a:hover {
			background:url('${ctxStatic}/images/leftMiddle.svg');
			color:#fff;
		}
		.nav-list>.active>a,.nav-list>.active>a:hover {
			background:url('${ctxStatic}/images/leftMiddle.svg');
			color:#fff;
		}
		.accordion-group {
			border:0px;
			margin-bottom:0px;
		}
		.nav.nav-list.hide {
			margin-left: -15px !important;
		}
		.nav.nav-list.hide a {
			padding-left:40px;
			background:url('${ctxStatic}/images/leftSm.svg');
		}
		.nav-list.hide>.active>a,.nav-list.hide>li>a:hover {
			background:url('${ctxStatic}/images/leftSmActive.svg');
			color:#fff;
		}
		.nav-list li a{
			/*margin-top:0px;
			margin-bottom:0px;
			padding-left:30px !important;*/
			font-family:"Microsoft YaHei" !important;
			font-size:12px;
			margin-top:0px;
			margin-bottom:0px;
			padding:15px 15px 15px 30px;
			text-shadow: 0 0 0 rgba(255,255,255,0);
		}
		.nav-list li a i{
			font-size:8px;
		}
		.navbar .nav li.dropdown.open > .dropdown-toggle,
		.navbar .nav li.dropdown.active > .dropdown-toggle,
		.navbar .nav li.dropdown.open.active > .dropdown-toggle  {
			color:#1fb5ac;
			background:#fff;
			border:0px;
			font-family:"Microsoft YaHei";
			font-size:12px;
		}
		.navbar .nav li.dropdown > .dropdown-toggle{
			color:#1fb5ac;
			background:#fff;
			border:0px;
			font-family:"Microsoft YaHei";
			font-size:12px;
		}
		#downPic {
			display:inline-block;
			background-image:url('${ctxStatic}/images/down.svg');
			background-repeat:no-repeat;
			width:10px; 
			height:7px;
		}
		.penPic {
			display:inline-block;
			width:15px;
			height:16px;
			background:url('${ctxStatic}/images/pen.svg') 0 0 no-repeat;
			vertical-align: middle;
		}
		.circlePic {
			display:inline-block;
			width:10px;
			height:15px;
			background:url('${ctxStatic}/images/circular.png') 5px 9px no-repeat;
		}
		.underline {
			display:block;
			width:100%;
		    height:1px;
		    border:0px;
		    background: linear-gradient(to right , rgba(255,255,255,0.4) ,rgba(255,255,255,0.4), transparent);
		    margin-top:-1px;
		}
		#footer {
			color:#969696;
			border:0px;
			padding:0px;
			padding-left:30px;
			background:#fff;
		}
		#mainFrame {
			padding-left:22px;
			padding-top:15px;
		}
		#mainFrame::-webkit-scrollbar{
			width: 8px;
   			background-color: #f1f1f1;
		}
		#mainFrame::-webkit-scrollbar-thumb {
			border-radius: 10px;
		    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
		    background-color: #e7e8ea;
		}
		#header {
			margin:0px;
		}
		#main .container-fluid {
			padding:0px;
		}
		.navbar-fixed-top .navbar-inner {
			box-shadow:0 0px 0px #fff;
		}
		body::-webkit-scrollbar{
			width: 8px;
   			background-color: #f1f1f1;
		}
		body::-webkit-scrollbar-thumb {
			border-radius: 10px;
		    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
		    background-color: #e7e8ea;
		}
		#searchDiv {
			height:26px;
			width:160px;
			border-radius:26px;
			background:#ffffff;
			margin:auto 10px;
			margin-top:10px;
			margin-bottom:10px;
		}
		#searchSpan {
			display:block;
			width:60px;
			height:18px;
			padding-left:14px;
			background:url('${ctxStatic}/images/search.svg') 0px 4px no-repeat;
			position:relative;
			font-family:"Microsoft YaHei";
			font-size:12px;
			color:#b1b1b1;
			top: -33px;
    		left: 14px;
		}
		#searchInput {
			box-sizing:border-box;
			-moz-box-sizing:border-box; /* Firefox */
			-webkit-box-sizing:border-box; /* Safari */
			width:160px;
			height:26px;
			border:0px !important;
			padding:0px 13px;
			line-height:26px;
			background:transparent;
			border-radius:26px;
		}
		#left::-webkit-scrollbar {
			width:0px;
			height:0px;
		}
		.pullDown {
			padding: 10px 10px;
    		background: url('${ctxStatic}/images/pullDownPic.svg') 50% 50% no-repeat;
			float:right;
			transform:rotate(90deg);
			transition:transform 0.3s;
			-moz-transition: -moz-transform 0.3s;
			-webkit-transition: -webkit-transform 0.3s;
			-o-transition: -o-transform 0.3s;
		}
		.touchActive {
			transform:rotate(0deg);
			-moz-transform:rotate(0deg); /* Firefox 4 */
			-webkit-transform:rotate(0deg); /* Safari and Chrome */
			-o-transform:rotate(0deg); /* Opera */
		} 
		.touchNoActive {
			transform:rotate(90deg);
			-moz-transform:rotate(90deg); /* Firefox 4 */
			-webkit-transform:rotate(90deg); /* Safari and Chrome */
			-o-transform:rotate(90deg); /* Opera */
		} 
		
 	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			var bgUrl = "${ctxStatic}/images/leftBg.png";
			// <c:if test="${tabmode eq '1'}"> 初始化页签
			$.fn.initJerichoTab({
                renderTo: '#right', uniqueId: 'jerichotab',
                contentCss: { 'height': $('#right').height() - tabTitleHeight },
                tabs: [], loadOnce: true, tabWidth: 110, titleHeight: tabTitleHeight
            });//</c:if>
			// 绑定菜单单击事件
			$("#menu a.menu").click(function(){
				// 一级菜单焦点
				$("#menu li.menu").removeClass("active");
				$(this).parent().addClass("active");
				// 左侧区域隐藏
				if ($(this).attr("target") == "mainFrame"){
					$("#left,#openClose").hide();
					wSizeWidth();
					// <c:if test="${tabmode eq '1'}"> 隐藏页签
					$(".jericho_tab").hide();
					$("#mainFrame").show();//</c:if>
					return true;
				}
				// 左侧区域显示
				$("#left,#openClose").show();
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
				// 显示二级菜单
				var menuId = "#menu-" + $(this).attr("data-id");
				if ($(menuId).length > 0){
					$("#left .accordion").hide();
					$(menuId).show();
					// 初始化点击第一个二级菜单
					if (!$(menuId + " .accordion-body:first").hasClass('in')){
						$(menuId + " .accordion-heading:first a").click();
					}
					if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")){
						$(menuId + " .accordion-body a:first i").click();
						
					}
					// 初始化点击第一个三级菜单
					$(menuId + " .accordion-body li:first li:first a:first i").click();
					$(menuId + " .accordion-body li:first a:first i").removeClass("touchNoActive");
					$(menuId + " .accordion-body li:first a:first i").addClass("touchActive");
				}else{
					// 获取二级菜单数据
					$.get($(this).attr("data-href"), function(data){
						if (data.indexOf("id=\"loginForm\"") != -1){
							alert('未登录或登录超时。请重新登录，谢谢！');
							top.location = "${ctx}";
							return false;
						}
						$("#left .accordion").hide();
						$("#left").append(data);
						// 链接去掉虚框
						$(menuId + " a").bind("focus",function() {
							if(this.blur) {this.blur()};
						});
						// 二级标题
						$(menuId + " .accordion-heading a").click(function(){
							$(menuId + " .accordion-heading a").css({"background":"none"});
							$(menuId + " .accordion-heading a").css({"color":"#889097"});
							//$(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
							if(!$($(this).attr('data-href')).hasClass('in')){
								//$(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
								//$(this).css("background-image","url("+bgUrl+")");
								$(this).css("color","#fff");
							}
						});
						// 二级内容
						$(menuId + " .accordion-body a").click(function(){
							$(menuId + " li").removeClass("active");
							//$(menuId + " li i").removeClass("icon-white");
							$(this).parent().addClass("active");
							//$(this).children("i").addClass("icon-white");
						});
						// 展现三级
						$(menuId + " .accordion-inner a").click(function(){
							$(this).parent().siblings("li").children("ul").slideUp();
							$(this).parent().siblings("li").children("ul").children("li").slideUp();
							$(this).parent().siblings("li").children("a").children("i").removeClass("touchActive");
							$(this).parent().siblings("li").children("a").children("i").addClass("touchNoActive");
							var href = $(this).attr("data-href");
							if($(href).length > 0){
								if($(href).css("display") == "none"){
									$(href).toggle();
								}
								else{
									$(href).slideToggle();
								}
								$(href).parent().slideToggle();
								return false;
							}
							// <c:if test="${tabmode eq '1'}"> 打开显示页签
							return addTab($(this)); // </c:if>
						});
						// 默认选中第一个菜单
						//$(menuId + " .accordion-heading a:first").css("background-image","url("+bgUrl+")");
						$(menuId + " .accordion-heading a:first").css("color","#fff");
						$(menuId + " .accordion-body a:first i").click();
						$(menuId + " .accordion-body a:first i").removeClass("touchNoActive");
						$(menuId + " .accordion-body a:first i").addClass("touchActive");
						//$(menuId + " .accordion-body a:first").css("color","#fff");
						$(menuId + " .accordion-body li:first li:first a:first i").click();
					});
				}
				// 大小宽度调整
				wSizeWidth();
				return false;
				
			});
			// 初始化点击第一个一级菜单
			$("#menu a.menu:first span").click();
			// <c:if test="${tabmode eq '1'}"> 下拉菜单以选项卡方式打开
			$("#userInfo .dropdown-menu a").mouseup(function(){
				return addTab($(this), true);
			});// </c:if>
			// 鼠标移动到边界自动弹出左侧菜单
			$("#openClose").mouseover(function(){
				if($(this).hasClass("open")){
					$(this).click();
				}
			});
			// 获取通知数目  <c:set var="oaNotifyRemindInterval" value="${fns:getConfig('oa.notify.remind.interval')}"/>
			function getNotifyNum(){
				$.get("${ctx}/oa/oaNotify/self/count?updateSession=0&t="+new Date().getTime(),function(data){
					var num = parseFloat(data);
					if (num > 0){
						$(".notifyNum").show().html(""+num+"");
					}else{
						$(".notifyNum").hide().html("");
					}
				});
			}
			getNotifyNum(); //<c:if test="${oaNotifyRemindInterval ne '' && oaNotifyRemindInterval ne '0'}">
			setInterval(getNotifyNum, ${oaNotifyRemindInterval}); //</c:if>
			
			$(".notifyLi").click(function () {
			 $("#mainFrame").attr("src","${ctx}/oa/oaNotify/self");
			});
		});
		// <c:if test="${tabmode eq '1'}"> 添加一个页签
		function addTab($this, refresh){
			$(".jericho_tab").show();
			$("#mainFrame").hide();
			$.fn.jerichoTab.addTab({
                tabFirer: $this,
                title: $this.text(),
                closeable: true,
                data: {
                    dataType: 'iframe',
                    dataLink: $this.attr('href')
                }
            }).loadData(refresh);
			return false;
		}// </c:if>
		
	</script>
	<style>
		.notifyLi{
			position: relative;
			width: 28px;
			height: 39px;
			background:url('${ctxStatic}/images/earlyWarningEmpty.svg') no-repeat;
			background-position: 0% 100%;
			cursor:pointer;
		}
		.notifyNum{
			position: absolute;
			top: 9px;
			right: 7px;
			text-align: center;
			font-size: 9px;
			padding: 2px 3px;
			line-height: .9;
		}
	</style>
</head>
<body>
	<div id="main">
		<div id="header" class="navbar navbar-fixed-top">
			<div class="navbar-inner" style="background-image: none; background:#fff; border:0px;">
				<span id="slider"></span>
				<div class="brand" style="color:transparent;"><img src="${ctxStatic}/images/logoNew.svg" id="logoImg"></div>
				<ul id="userControl" class="nav pull-right" >
					<li style="display:none;"><a href="${pageContext.request.contextPath}${fns:getFrontPath()}/index-${fnc:getCurrentSiteId()}.html" target="_blank" title="访问网站主页"><i class="icon-home"></i></a></li>
					<%--<li class="notifyLi">--%>
						<%--<span class="label label-danger notifyNum"></span>--%>
					<%--</li>--%>
					<li style="width:16px; height:16px; background:url('${ctxStatic}/images/earlyWarningEmpty.svg') no-repeat; background-position: 0% 100%; margin-top:17px;"></li>
					<li style="width:16px; height:16px; background:url('${ctxStatic}/images/systemBulletinEmpty.svg') no-repeat; background-position: 0% 100%; margin-top:17px; margin-left:20px;">
					</li>
					<li style="width:16px; height:16px; background:url('${ctxStatic}/images/toDoEmpty.svg') no-repeat; background-position: 0% 100%; margin-top:17px; margin-left:20px;"></li>
					<li id="userInfo" class="dropdown">
						<a style="padding:15px 30px 15px 70px; color:#969696; outline-color:#fff;" class="dropdown-toggle" href="javascript:void(0);" onclick="fadeInLeft()" title="个人信息">${fns:getUser().name}&nbsp;<span id="downPic"></span></a>
						<ul class="dropdown-menu fadeInLeft" style="border-top: 0px; border-radius: 0px 0px 4px 4px;">
							<li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
							<li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
							<li style="border-top: 1px solid rgba(0,0,0,0.2);margin-top:5px;"><a href="${ctx}/logout"><i class="icon-bell"></i>&nbsp;  退出</a></li>
						</ul>
					</li>
					<%--<li onclick="javascript:document.getElementById('exitA').click();" style="width:16px; height:16px; background:url('${ctxStatic}/images/setUp.svg'); background-size:100% 100%; margin-top:17px; margin-right:30px;"><a id="exitA" style="padding:0px;" href="${ctx}/logout" title="退出登录"></a></li>--%>
					<%--<li>&nbsp;</li>--%>
				</ul>
				<%-- <c:if test="${cookie.theme.value eq 'cerulean'}">
					<div id="user" style="position:absolute;top:0;right:0;"></div>
					<div id="logo" style="background:url(${ctxStatic}/images/logo_bg.jpg) right repeat-x;width:100%;">
						<div style="background:url(${ctxStatic}/images/logo.jpg) left no-repeat;width:100%;height:70px;"></div>
					</div>
					<script type="text/javascript">
						$("#productName").hide();$("#user").html($("#userControl"));$("#header").prepend($("#user, #logo"));
					</script>
				</c:if> --%>
				<div class="nav-collapse">
					<ul id="menu" class="nav" style="*white-space:nowrap;float:none;">
						<c:set var="firstMenu" value="true"/>
						<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
							<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
								<li class="menu ${not empty firstMenu && firstMenu ? ' active' : ''}">
									<c:if test="${empty menu.href}">
										<a onclick="moveSlider(this)" class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
									</c:if>
									<c:if test="${not empty menu.href}">
										<a onclick="moveSlider(this)" class="menu" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
									</c:if>
								</li>
								<c:if test="${firstMenu}">
									<c:set var="firstMenuId" value="${menu.id}"/>
								</c:if>
								<c:set var="firstMenu" value="false"/>
							</c:if>
						</c:forEach><%--
						<shiro:hasPermission name="cms:site:select">
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fnc:getSite(fnc:getCurrentSiteId()).name}<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<c:forEach items="${fnc:getSiteList()}" var="site"><li><a href="${ctx}/cms/site/select?id=${site.id}&flag=1">${site.name}</a></li></c:forEach>
							</ul>
						</li>
						</shiro:hasPermission> --%>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
	    </div>
	    <div class="container-fluid">
	    	<div id="left" style="background:#3d4652;"><%-- 
				<iframe id="menuFrame" name="menuFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%" height="650"></iframe> --%>
				<div id="searchDiv"><input type="text" id="searchInput" /><span id="searchSpan">菜单搜索</span></div>
			</div>
			<div id="content" class="row-fluid">
				<div id="openClose" class="close">&nbsp;</div>
				<div id="right">
					<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="98%" height="650"></iframe>
					<%--<div id="footer" class="row-fluid">--%>
			            <%--Copyright &copy; 2012-${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - Powered By <a href="http://jeesite.com" target="_blank">JeeSite</a> ${fns:getConfig('version')}--%>
					<%--</div>--%>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"> 
		var leftWidth = 184; // 左侧窗口大小
		var tabTitleHeight = 33; // 页签的高度
		var htmlObj = $("html"), mainObj = $("#main");
		var headerObj = $("#header"), footerObj = $("#footer");
		var frameObj = $("#openClose, #right, #right iframe");
		var leftObj = $("#left");
		function wSize(){
			var minHeight = 500, minWidth = 900;
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
			mainObj.css("width",strs[1] < minWidth ? minWidth - 10 : "auto");
			frameObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height() - footerObj.height() - (strs[1] < minWidth ? 42 : 28));
			leftObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height());
			$("#openClose").height($("#openClose").height() - 5);// <c:if test="${tabmode eq '1'}"> 
			$(".jericho_tab iframe").height($("#right").height() - tabTitleHeight); // </c:if>
			wSizeWidth();
		}
		function wSizeWidth(){
			if (!$("#openClose").is(":hidden")){
				var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
				$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
			}else{
				$("#right").width("100%");
			}
		}
		<c:if test="${tabmode eq '1'}">
		function openCloseClickCallBack(b){
			$.fn.jerichoTab.resize();
		}
		</c:if>
	</script>
	<script>
		$(document).ready(function(){
			$(document).click(function(){
				$(".fadeInLeft").css({"display":"none","right":"45px"});
			});
			$(".fadeInLeft").click(function(event){
			    event.stopPropagation();
			});
		});
		function fadeInLeft(){
			event.stopPropagation();
			if($(".fadeInLeft").css("display") != "block"){
				$(".fadeInLeft").css({"display":"block","opacity":"0"});
				$(".fadeInLeft").animate({"opacity":"1","right":"25px"},"1500");
			}
			else{
				$(".fadeInLeft").css({"display":"none","right":"45px"});
			}
		}
		function moveSlider(obj){
			var leftDistance = $(obj).offset().left + 10;
			var widthNum = $(obj).width();
			if(leftDistance < 200){
				leftDistance = 233;
			}
			$("#slider").animate({"left":leftDistance,"width":widthNum},200,"easeInOutCubic");
		}
		$("#searchInput").focus(function(){
			$("#searchSpan").css({"display":"none"});
		});
		$("#searchInput").blur(function(){
			if($("#searchInput").val() == ''){
				$("#searchSpan").css({"display":"block"});
			}
		});
		
		function threeLevelPullDown(pullObj){
			if($(pullObj).siblings("ul").css("display") == "none"){
				$(pullObj).find(".pullDown").removeClass("touchNoActive");
				$(pullObj).find(".pullDown").addClass("touchActive");
			}
			else{
				$(pullObj).find(".pullDown").removeClass("touchActive");
				$(pullObj).find(".pullDown").addClass("touchNoActive");
			}
		}
		$("#left").bind('DOMNodeInserted', function() {
			$(".accordion-body").each(function(){
				$(this).find(".accordion-inner").children("ul").children("li").each(function(){
					if($(this).children("ul").find("li").length == 0){
						$(this).children("a").children(".pullDown").removeClass("pullDown");
					}
				});
			});
		}); 
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>
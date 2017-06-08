<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
      html,body,table{background-color:#f5f5f5;width:100%;text-align:center;height:100%}.form-signin-heading{font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:36px;margin-bottom:20px;color:#0663a2;}
      body{
	  	background: url("${ctxStatic}/images/bg.png") 0 0 no-repeat;
	  	background-size:100% 100%;
      }
      .form-signin{
     	width:450px;
		/* height:440px; */
		text-align: center;
		margin:auto auto;
		background: url("${ctxStatic}/images/newBg.svg") 0 0 no-repeat;
		/* background-size:100% 100%; */
		padding-bottom:40px;
	  }
	  .top_div{
		background: transparent;
		width: 100%;
		height: 100%;
	  }
	  .ipt{
		border: 1px solid transparent !important;
		padding: 10px 0px !important;
		width: 83% !important;
		border-radius: 4px !important;
		padding-left: 35px !important;
		background:rgba(0,0,0,0.30) !important;
		color: #fff !important;
		font-size: 14px !important;
		height: 46px !important; 
    	line-height: 46px !important;
	  }
	  .iptNew{
	  	border: 1px solid transparent !important;
		padding: 10px 0px !important;
		width: 42% !important;
		border-radius: 4px !important;
		padding-left: 35px !important;
		background:rgba(0,0,0,0.30) !important;
		color: #fff !important;
		font-size: 14px !important;
		font-weight:300;
		height: 46px !important; 
    	line-height: 46px !important;
    	margin-right: 50px;
	  }
	  #p_logo1{
		background: url("${ctxStatic}/images/User - alt.png") no-repeat;
		background-size:100% 100%;
		padding: 10px 10px;
		position: absolute;
		top: 25%;
		left: 10%;
	  }
	  #p_logo2{
		background: url("${ctxStatic}/images/Key - alt.png") no-repeat;
		background-size:100% 100%;
		padding: 10px 10px;
		position: absolute;
		top: 25%;
		left: 10%;
	  }
	  .loginBtn{
		display:inline-block;
		height:46px;
		width:100% !important;
		background: #1eb4aa; 
		padding: 7px 0px; 
		font-size:16px;
		border-radius: 4px; 
		border-image: none; 
		border:0px;
		color: #fff; 
		font-weight: bold;
	  }
	  .denglu1 {
		width:83%;
		position:relative;
		left:8.5%;
		text-align:left;
		line-height:18px;
		margin-bottom:20px;
	  }
	  .denglu2 {
		width:83%;
		position:relative;
		left:8.5%;
	  }
      .form-signin .checkbox{margin-bottom:10px;color:#0663a2;} .form-signin .input-label{font-size:16px;line-height:23px;color:#999;}
      .form-signin .input-block-level{font-size:16px;height:auto;margin-bottom:15px;padding:7px;*width:283px;*padding-bottom:0;_padding:7px 7px 9px 7px;}
      .form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;}
      .form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
      .header{height:80px;padding-top:20px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
      label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0;}
    </style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body>
	<div class="top_div">
	<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
	
	<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
		<br><br><br><br><br><br>
		<p style=" position: relative;">
			<!-- <span title="用户名" id="p_logo1"></span>   -->  
			<input  class="ipt" type="text" id="username" name="username" class="input-block-level required" placeholder="请输入账号" value="${username}">
		</p>
		<p style="position: relative;">
			<!-- <span title="密码" id="p_logo2"></span> -->  
			<input  class="ipt" type="password" id="password" name="password" placeholder="请输入密码" class="input-block-level required">
		</p>
		<c:if test="${isValidateCodeLogin}"><div class="validateCode" style="margin-bottom:5px; position: relative;">
			<span title="密码" id="p_logo2"></span>
			<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div></c:if><%--
		<label for="mobile" title="手机登录"><input type="checkbox" id="mobileLogin" name="mobileLogin" ${mobileLogin ? 'checked' : ''}/></label> --%>
		<div class="denglu1" >
			<label for="rememberMe" title="下次不需要再登录" style="color:#fff;"><input type="checkbox" id="rememberMe" class="chk_1" name="rememberMe" ${rememberMe ? 'checked' : ''}/><label for="rememberMe" style="top: -1.5px;"></label> 记住我（公共场所慎用）</label>
		</div>
		<div class="denglu2" >
			<input class="loginBtn" type="submit" value="登 录"/>
		</div>
	</form>
	
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script>
		$("#validateCode").addClass("iptNew");
		$("#validateCode").attr("placeholder","输入验证码");
		$("#validateCode").siblings("span").css({"display":"none"});
		$("#validateCode").siblings("a").css({"color":"#fff","margin-left":"18px"});
	</script>
	</div>
</body>
</html>

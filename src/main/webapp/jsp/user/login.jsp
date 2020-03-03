<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="text/html;charset=utf-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
	<link rel="stylesheet" href="<c:url value='/jquery/bootstrap.min.js'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/user/login.css'/>">
	<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
	<script type="text/javascript" src="<c:url value='/js/jquery-1.8.0.js'/>"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/user/login.js"></script>
	<script src="<c:url value='/js/user/common.js'/>"></script>
<!-- 写在此处是为了方便EL表达式使用 -->
<script type="text/javascript">
	/* $(function() {/*Map<String(Cookie名称),Cookie(Cookie本身)>
		// 获取cookie中的用户名
		var loginname = window.decodeURI("${cookie.loginname.value}");//decodeURI() 函数可对 encodeURI() 函数编码过的 URI 进行解码
		if("${requestScope.user.loginname}") {
			loginname = "${requestScope.user.loginname}";
		}
		$("#loginname").val(loginname);
	}); */
	
	$(function() {
		
		/*
		 * 2. 给注册按钮添加submit()事件，完成表单校验
		 */
		$("#submit").submit(function(){
			$("#msg").text("");
			var bool = true;
			$(".input").each(function() {
				var inputName = $(this).attr("id");
				if(!invokeValidateFunction(inputName)) {
					bool = false;
				}
			});
			return bool;
		});
		
		/*
		 * 3. 输入框得到焦点时隐藏错误信息
		 */
		$(".inputClass").focus(function() {
			var inputName = $(this).attr("id");
			$("#" + inputName + "Error").css("display", "none");
		});
		
		/*
		 * 4. 输入框推动焦点时进行校验
		 */
		$(".inputClass").blur(function() {
			var inputName = $(this).attr("id");
			invokeValidateFunction(inputName);
			
		})
	});

	/*
	 * 输入input名称，调用对应的validate方法。
	 * 例如input名称为：loginname，那么调用validateLoginname()方法。
	 */
	function invokeValidateFunction(inputName) {
		alert(inputName);
		inputName = inputName.substring(0, 1).toUpperCase() + inputName.substring(1);
		var functionName = "validate" + inputName;
		return eval(functionName + "()");	
	}

	/*
	 * 校验登录名
	 */
	function validateLoginname() {
		var bool = true;
		var value = $("#loginname").val();
		if(!value) {// 非空校验
			$("#loginnameError").css("display", "");
			$("#loginnameError").text("用户名不能为空！");
			bool = false;
		} else if(value.length < 3 || value.length > 20) {//长度校验
			$("#loginnameError").css("display", "");
			$("#loginnameError").text("用户名长度必须在3 ~ 20之间！");
			bool = false;
		}
		return bool;
	}

	/*
	 * 校验密码
	 */
	function validateLoginpass() {
		var bool = true;
		var value = $("#loginpass").val();
		if(!value) {// 非空校验
			$("#loginpassError").css("display", "");
			$("#loginpassError").text("密码不能为空！");
			bool = false;
		} else if(value.length < 3 || value.length > 20) {//长度校验
			$("#loginpassError").css("display", "");
			$("#loginpassError").text("密码长度必须在3 ~ 20之间！");
			bool = false;
		}
		return bool;
	}

	/*
	 * 校验验证码
	 */
	function validateVerifyCode() {
		var bool = true;
		var value = $("#verifyCode").val();
		if(!value) {//非空校验
			$("#verifyCodeError").css("display", "");
			$("#verifyCodeError").text("验证码不能为空！");
			bool = false;
		} else if(value.length != 4) {//长度不为4就是错误的
			$("#verifyCodeError").css("display", "");
			$("#verifyCodeError").text("错误的验证码！");
			bool = false;
			
		} else {//验证码是否正确
			$.ajax({
				cache: false,
				async: false,
				type: "POST",
				dataType: "json",
				data: {method: "ajaxValidateVerifyCode", verifyCode: value},
				url: "/goodses/UserServlet",
				success: function(flag) {
					if(!flag) {
						$("#verifyCodeError").css("display", "");
						$("#verifyCodeError").text("错误的验证码！");
						bool = false;	
						
					}
				}
			});
		}
		return bool;
	}
</script>
<style type="text/css">
	* {
	    margin: 0;
	    padding: 0;
	}
	/* to remove the top and left whitespace */
	
	html,
	body {
	    width: 100%;
	    height: 100%;
	}
	/* just to be sure these are full screen*/
	
	canvas {
	    display: block;
	    z-index: 1000;
	    background-color: #f4f4f4;
	}
	/* To remove the scrollbars */
</style>
  </head>
  
  <body style="background-color: #f7f5da;">
  		<header class="header"style="position:fixed;">
			<span class="logo" style="float:left;">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px"/></a>
			</span>
		</header>
	<div class="main" style="position:fixed;">
	  
	  <div>
        <div class="login1" style="margin:15%;">
	      <div class="login2">
            <div class="loginTopDiv">
              <span class="loginTop" style="color: #000;font-weight: 100;letter-spacing: -0.5px;font-size: 29px;position: relative;left: 132px;top: 26px;opacity: 0.6">Sign in</span>
              <div>${vCode}</div>
            </div>
            <div>
              <form target="_top" action="${pageContext.request.contextPath}/user/login" method="post" id="loginForm">
                <input type="hidden" name="method" value="login" />
                  <table>
                    <tr>
                      <td width="50"></td>
                      <td><label class="error" id="msg">${msg }</label></td>
                    </tr>
                    <tr>
                      <td width="50" style="color: ">用户名</td>
                      <td><input class="inputClass form-control" type="text" name="loginname" id="loginname" /></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginnameError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td style="">密　码</td>
                      <td><input class="inputClass form-control" type="password" name="loginpass" id="loginpass" value=""/></td>
                    </tr>
                    <tr>
                      <td height="20">&nbsp;</td>
                      <td><label id="loginpassError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td style="color: ">验证码</td>
                      <td>
                        <input class="inputClass yzm " type="text" name="verifyCode" id="verifyCode" value=""/>
                        <img id="vCode" src="<c:url value='/user/verifyCode'/>"/>
                        <a id="verifyCode" href="${pageContext.request.contextPath}/jsp/user/login.jsp" style="color: #000">换张图</a>
                      </td>
                    </tr>
                    <tr>
                      <td height="20px">&nbsp;</td>
                      <td><label id="verifyCodeError" class="error"></label></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td align="left">
                        <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-10"style="position: relative;left: 14px;top:2px;">
					      <button type="submit" id="submit"class="btn btn-default" >登录</button>
					      <div class="btn btn-default"><a style="color:black;" href="${pageContext.request.contextPath}/course/tomain/5">取消</a></div>
    					</div>
                      </td>
                    </tr>																				
                 </table>
              </form>
            </div>
          </div>
        </div>
      </div>
	</div>
	
		<footer class="footer navbar-fixed-bottom">
			<div class="container" style="padding-left:0px;padding-right:0;margin-left:90px;">
				<a class="tu" href="">太原工业学院</a>
				<ul class="footer-100">
					<li style="float:left;">
						<span>关于我们</span>
						<ul>
							<li>
								<a href="">关于我们</a>
							</li>
							<li>
								<a href="">联系我们</a>
							</li>
							<li>
								<a href="">意见反馈</a>
							</li>
							<li>
								<a href="">学校云</a>
							</li>
							<li>
								<a href="">常见问题</a>
							</li>
							<li>
								<a href="">法律条款</a>
							</li>
						</ul>
					</li>
					<li style="float:left;margin-right:40px;">
						<span>关注我们</span>
						<ul>
							<li style="float:left;">
								<a href=""><img src="${pageContext.request.contextPath}/img/wechat.png" /></a>
							</li>
							<li style="float:left;">
								<a href=""><img src="${pageContext.request.contextPath}/img/sina.png" /></a>
							</li>
						</ul>
					</li>
					<li style="float:left;">
						<span>友情链接</span>
						<ul>
							<li>
								<a href="">网易卡搭</a>
							</li>
							<li>
								<a href="">网易云课堂</a>
							</li>
							<li>
								<a href="">网易100分</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</footer>
		<script src="http://wow.techbrood.com/libs/jquery/jquery-1.11.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sketch.js/1.1/sketch.js"></script>
		<script src="${pageContext.request.contextPath}/js/reveal.js"></script>
  </body>
</html>
	
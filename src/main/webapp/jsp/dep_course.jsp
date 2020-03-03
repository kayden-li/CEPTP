<%@page import="cn.edu.tit.user.bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dep_course.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
		<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
	    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</head>

	<body style="background: white;">
<% User user=(User)request.getAttribute("user"); %>
		<header class="header">
			<span class="fl logo">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px;float:left;margin-left:-35px;"/></a>
			</span>
			<div class="content">
				<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;" />
				<a class="content-1"href=""><span>搜索</span></a>
			</div>
			<div class="nav-100">
				<ul>
			<% if(user==null){%>
		        <li class="fl list"><a href="${pageContext.request.contextPath}/user/tomain/5">首页</a></li>
				<li class="fl list"><a href="${pageContext.request.contextPath}/jsp/user/login.jsp">登录</a></li>
			<% }else{ %>
					<li class="fl list"><a href="${pageContext.request.contextPath}/course/tomain/5">首页</a></li>
					<li class="fl list"><a
						href="${pageContext.request.contextPath}/user/changeInfo"> <img
							style="color: black; height: 50px; width: 50px; border: .5em;"
							src="<c:url value='/course/loadImage/${user.user_id}'/>" />
					</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit">退出</a></li> 
			<% } %>
				</ul>
			</div>
		</header>
		<div class="float container" id="float">
			<span class="fl logo"style="margin-top: -15px;margin-left: 180px;">
				<a href="#"style="color: rgb(255,255,255);margin-left: 10px;">太原工业学院</a>
			</span>
			<div class="content"style="margin-top: -20px;margin-left: 900px;">
				<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;" />
				<a class="content-1"href=""><span style="color: rgb(255,255,255);">搜索</span></a>
			</div>
			<div class="nav-100">
				<ul style="margin-right: 140px;">
			<% if(user==null){%>
					<li class="fl list"><a href="${pageContext.request.contextPath}/jsp/user/tomain/5" style="color: rgb(255,255,255);">首页</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="<%-- ${pageContext.request.contextPath}/jsp/user/login.jsp --%>#" style="color: rgb(255,255,255);" id="atten-btn">登录</a></li>
			<% }else{ %>
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/tomain/5">首页</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a
						href="${pageContext.request.contextPath}/user/changeInfo"> <img
							style="color: black; height: 50px; width: 50px; border: .5em;"
							src="<c:url value='/course/loadImage/${user.user_id}'/>" />
					</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit" style="color: rgb(255,255,255);">退出</a></li> 
			<% } %>
				</ul>
			</div>
		</div>
		<div class="Clable">
			<ul style="margin-left:-150px;">
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/1/1"><span class="lable_span">机械工程</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/2/1"><span class="lable_span">电子工程</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/3/1"><span class="lable_span">自动化</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/4/1"><span class="lable_span">化学与化工</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/5/1"><span class="lable_span">计算机工程</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/6/1"><span class="lable_span">环境与安全工程</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/7/1"><span class="lable_span">材料工程</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/8/1"><span class="lable_span">理学</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/9/1"><span class="lable_span">经济与管理</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/10/1"><span class="lable_span">外语</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/11/1"><span class="lable_span">设计艺术</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/12/1"><span class="lable_span">法学</span></a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/course/findCouByPage/13/1"><span class="lable_span">体育</span></a>
				</li>

			</ul>
		</div>
		<div class="sort" style="margin-left:104px;">
					<ul class="fl">
						<li class="fl">
							<a href="#"class="active-1">全部</a>
						</li>
						<li class="fl">
							<a href="#">正在进行</a>
						</li>
						<li class="fl">
							<a href="#">即将开始</a>
						</li>
						<li class="fl">
							<a href="#">已结束</a>
						</li>
					</ul>
					<ul class="fr">
						<li class="fl active-1">
							<a href="#">综合排序</a>
						</li>
						<li class="fl">
							<a href="#">热门</a>
						</li>
						<li class="fl">
							<a href="#">最新</a>
						</li>
					</ul>
		</div>
		<div class="blank container">
			<ul>
			<c:forEach items="${courseList}" var="course">
				<li class="blank-100">
				<a href="${pageContext.request.contextPath}/course/toCDetail/${course.course_id}">
					<div class="pictutu">
						<img src="<c:url value='/course/loadImage/${course.course_id}'/>" style="width:222px;height:125px;"/>
					</div>
					<ul class=" fr blank-50" style="margin-right:300px;padding-top:15px;">
						<li style="font-size:16px;color:black;">${course.getCourse_name()}</li>
						<li style="font-size:12px;color:gray;">${course.getPublisher()}</li>
						<li style=" width:700px; height:45px; line-height:24px; overflow:hidden;font-size:12px;color:gray;">${course.course_notes}</li>
						<li style="font-size:12px;color:gray;">${course.schoolTerm}</li>
					</ul>
				</li>
				</a>
			</c:forEach>
			</ul>
		</div>
		<div class="side">
			<ul class="fr">
				<li>
					<a href=""><img src="${pageContext.request.contextPath}/img/return.png" /></a>
				</li>
				<li>
					<a href=""><img src="${pageContext.request.contextPath}/img/mobileclass.png" /></a>
				</li>
				<li>
					<a href="" id="top"class="top"><img src="${pageContext.request.contextPath}/img/gototop.png" /></a>
				</li>
			</ul>
		</div>

<div style="height:320px;"></div>
		<footer class="footer">
			<div class="" style="padding-left:2%;overflow : hidden">
				<a class="tu" href="">太原工业学院</a>
				<ul class="footer-100" style="margin-left:640px;">
					<li class="fl">
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
						</ul>
						<ul>
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
					<li class="fl">
						<span>关注我们</span>
						<ul>
							<li class="fl">
								<a href=""><img src="${pageContext.request.contextPath}/img/wechat.png" /></a>
							</li>
							<li class="fl">
								<a href=""><img src="${pageContext.request.contextPath}/img/sina.png" /></a>
							</li>
						</ul>
					</li>
					<li class="fl">
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
	
		<script src="${pageContext.request.contextPath}/js/dep_course.js"></script>
		<script src="${pageContext.request.contextPath}/js/main.js"></script>
		<!-- 遮罩层 -->
		<div id="mask"></div>
		<!-- 登录表单 -->
			<form class="login-form" id="loginForm" style="display:none;top:350px;"
				enctype="multipart/form-data" method="post">
				<div class="error" id="msg">${msg}</div>
			    <div class="close" id="close-login">X</div>
			    <h3>登录</h3>
			    <input type="text" name="username" placeholder="用户名" id="username" />
			    <input type="password" name="password" placeholder="密码" id="password" />
			    <button type="submit" class="login-btn" id="login" onclick="log()">登录</button>
			</form>
		<!-- /登录表单 -->
		<script type="text/javascript">
		    // fadeModal();//显示登录框
		    window.onload = function(){
		        var atten = document.getElementById("atten-btn");
		        atten.onclick = function fadeModal() {
		            var mask = document.getElementById('mask');
		            console.log(mask);
		            mask.style.display = "block";
		            var loginForm = document.getElementsByClassName('login-form')[0];
		            console.log(loginForm);
		            loginForm.style.display = "block";
		            // atten.style.display = "none";
		        }
		    //关闭窗口
		        var close= document.getElementById("close-login");
		        close.onclick =function fadeOutLogin() {
		            var mask = document.getElementById('mask');
		            console.log(mask);
		            mask.style.display = "none";
		            var loginForm = document.getElementsByClassName('login-form')[0];
		            console.log(loginForm);
		            loginForm.style.display = "none";
		            // atten.style.display = "block";
		        }
		    }
		        function log(){
					var username = $("#username").val();
					var	password = $("#password").val();
					$.ajax({
					    async : false,
					    cache : true,
					    type : 'post',
					    url : '${pageContext.request.contextPath}/user/formlogin',
					    //dataType : 'text',
					    data : 'username='+username+'&password='+password,
					    /* error : function() {
					    	console.log("失败");
					    	window.location.reload();
					    },
					    success : function() {
					    	console.log("成功");
					    	window.location.reload();
					    } */
					});
					window.location.href = "${pageContext.request.contextPath}/user/tomain/5";
				}
		    
		</script>
	</body>

</html>
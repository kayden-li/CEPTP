<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Course"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta charset="utf-8" />
<title></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/main.css" />
<link rel="stylesheet"
	href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- 轮播图 -->
<link rel="stylesheet"
	href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--标签页带淡出效果-->

</head>

<body style="background: #eee;">
	<%
		User user = (User) session.getAttribute("user");
	%>
	<header class="header"> <span class="fl logo"> <a
		href="#"><img
			src="${pageContext.request.contextPath}/img/school_name.png"
			style="width: 250px; height: 100px" /></a>
	</span>
	<div class="content">
		<input type="text" placeholder="请输入要查询的内容" id="search" name="search"
			style="height: 25px;" /> <a class="content-1" href=""
			style="color: black;"><span>搜索</span></a>
	</div>
	<div class="nav-100">
		<ul>
			<%
				if (user == null) {
			%>
			<li class="fl list"><a style="color: black;"
				href="${pageContext.request.contextPath}/jsp/user/login.jsp"
				id="atten-bt">登录</a></li>
			<%
				} else {
			%>
			<li class="fl list"><a
				href="${pageContext.request.contextPath}/user/changeInfo"> <img
					style="color: black; height: 50px; width: 50px; border: .5em;"
					src="<c:url value='/course/loadImage/${user.user_id}'/>" />
			</a></li>
			<li class="fl list"><a style="color: black;"
				href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.getUser_name()}</a></li>
			<li class="fl list"><a style="color: black;"
				href="${pageContext.request.contextPath}/user/exit">退出</a></li>
			<%
				}
			%>
		</ul>
	</div>
	</header>
	<div class="float container" id="float">
		<span class="fl logo" style="margin-top: -15px; margin-left: 180px;">
			<a href="#" style="color: rgb(255, 255, 255); margin-left: 10px;">太原工业学院</a>
		</span>
		<div class="content" style="margin-top: -20px; margin-left: 900px;">
			<input type="text" placeholder="请输入要查询的内容" id="search" name="search"
				style="height: 25px;" /> <a class="content-1" href=""><span
				style="color: rgb(255, 255, 255);">搜索</span></a>
		</div>
		<div class="nav-100">
			<ul style="margin-right: 140px;">
				<%
					if (user == null) {
				%>
				<li class="fl list"><a
					href="<%-- ${pageContext.request.contextPath}/jsp/user/login.jsp --%>#"
					style="color: rgb(255, 255, 255);" id="atten-btn">登录</a></li>
				<li class="fl list"><a href=""
					style="color: rgb(240, 240, 240);">|</a></li>
				<%
					} else {
				%>
				<li class="fl list"><img
					style="height: 50px; width: 50px; border: .5em;"
					src="<c:url value='/course/loadImage/${user.user_id}'/>" /></li>
				<li class="fl list"><a
					href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.user_name}</a></li>
				<li class="fl list"><a href=""
					style="color: rgb(240, 240, 240);">|</a></li>
				<li class="fl list"><a
					href="${pageContext.request.contextPath}/user/exit"
					style="color: rgb(255, 255, 255);">退出</a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	<div id="myCarousel" class="carousel slide">
		<!-- 轮播（Carousel）指标 -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
			<li data-target="#myCarousel" data-slide-to="3"></li>
		</ol>
		<!-- 轮播（Carousel）项目 -->
		<div class="carousel-inner">
			<div class="item active container">
				<img src="${pageContext.request.contextPath}/img/banner1.jpg"
					style="width: 1260px; height: 380px;" alt="First slide">
			</div>
			<div class="item container">
				<img src="${pageContext.request.contextPath}/img/banner2.jpg"
					style="width: 1260px; height: 380px;" alt="Second slide">
			</div>
			<div class="item container">
				<img src="${pageContext.request.contextPath}/img/banner3.jpg"
					style="width: 1260px; height: 380px;" alt="Third slide">
			</div>
			<div class="item container">
				<img src="${pageContext.request.contextPath}/img/banner4.jpg"
					style="width: 1260px; height: 380px;" alt="Forth slide">
			</div>
		</div>
		<!-- 轮播（Carousel）导航 -->
		<a class="left carousel-control" href="#myCarousel" role="button"
			data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel" role="button"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	<div class="introduce container">
		<h2>推荐课程</h2>
		<div class="intro">
			<ul>
				<c:forEach items="${mycourses}" var="course">
					<a
						href="${pageContext.request.contextPath}/course/toCDetail/${course.course_id}">
						<li class="fl intro-pic">
							<div class="pictutu" style="height: 160px;">
								<img style="width: 100%; height: 100%;"
									src="<c:url value='/course/loadImage/${course.course_id}'/>" />
							</div>

							<div style="margin-top: 15px; margin-left: 15px;">
								<p style="font-size: 14px; color: black;">${course.course_name }</p>
								<p style="font-size: 12px; color: gray;">${course.publisher }</p>

								<p style="margin-top: 10px; font-size: 12px; color: gray;">${course.schoolTerm}</p>
							</div>
					</li>
					</a>

				</c:forEach>
			</ul>
		</div>
	</div>
	<div class="pic container" style="margin-top: 50px;">
		<ul>
			<li class="fl one"><a href=""><img
					src="${pageContext.request.contextPath}/img/pic1.png" /></a></li>
			<li class="fl two"><a href=""><img
					src="${pageContext.request.contextPath}/img/pic2.jpg" /></a></li>
		</ul>
	</div>

	<div class="depart container" style="margin-top: 45px;">
		<ul id="myTab" class="nav nav-tabs" style="width:400px;">
			<%
				String name = request.getAttribute("name").toString();
				if (name.equals("computer") || name.equals("")) {
			%>
			<li class="active"><a data-toggle="tab">计算机</a></li>
			<c:set var="depart_cho" value="5" />
			<%
				} else {
			%>
			<li><a href="${pageContext.request.contextPath}/course/tomain/5">计算机</a>
			</li>
			<%
				}
				if (name.equals("manage")) {
			%>
			<li class="active"><a data-toggle="tab">管理</a></li>
			<c:set var="depart_cho" value="9" />
			<%
				} else {
			%>
			<li><a href="${pageContext.request.contextPath}/course/tomain/9">管理</a>
			</li>
			<%
				}
				if (name.equals("electric")) {
			%>
			<li class="active"><a data-toggle="tab">电子</a></li>
			<c:set var="depart_cho" value="2" />
			<%
				} else {
			%>
			<li><a href="${pageContext.request.contextPath}/course/tomain/3">电子</a>
			</li>
			<%
				}
				if (name.equals("machine")) {
			%>
			<li class="active"><a data-toggle="tab">机械</a></li>
			<c:set var="depart_cho" value="1" />
			<%
				} else {
			%>
			<li><a href="${pageContext.request.contextPath}/course/tomain/1">机械</a>
			</li>
			<%
				}
				if (name.equals("auto")) {
			%>
			<li class="active"><a data-toggle="tab">自动化</a></li>
			<c:set var="depart_cho" value="3" />
			<%
				} else {
			%>
			<li><a href="${pageContext.request.contextPath}/course/tomain/2">自动化</a>
			</li>
			<%
				}
			%>
			<li></li>
		</ul>
		<div class="more">
			<a
				href="${pageContext.request.contextPath}/course/findCouByPage/${depart_cho}/1">
				<span style="color: red;">更多</span>
			</a>
		</div>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active">
				<ul>
					<%
						Course course_1 = (Course) request.getAttribute("course_1");
						List<Course> courses = (List<Course>) request.getAttribute("courses");
						if (course_1 != null) {
					%>
					<a
						href="${pageContext.request.contextPath}/course/toCDetail/${course_1.course_id}">
						<li class="fl first" style="width: 550px; margin-right: -16px;">
							<div class="pictutu-2">
								<img
									src="<c:url value='/course/loadImage/${course_1.course_id}'/>" />
							</div>

							<div class="cent-99">

								<p style="font-size: 25px;">${course_1.course_name }</p>
								<p>${course_1.publisher }</p>
								<p>${course_1.schoolTerm}</p>
							</div>

					</li>
					</a>
					<%
						}
					%>
					<div style="margin-left: -28px;">
						<c:forEach items="${courses}" var="course">
							<a
								href="${pageContext.request.contextPath}/course/toCDetail/${course.course_id}">
								<li class="fl cent">
									<div class="pictutu-1">
										<img
											src="<c:url value='/course/loadImage/${course.course_id}'/>" />
									</div>

									<div class="cent-100">
										<p style="font-size: 25px;">${course.course_name}</p>
										<p>${course.publisher}</p>
										<p>${course.schoolTerm}</p>
									</div>

							</li>
							</a>
						</c:forEach>
					</div>
				</ul>
			</div>
		</div>
	</div>
	<%-- <div class="side">
		<ul class="fr">
			<li><a href=""><img
					src="${pageContext.request.contextPath}/img/return.png" /></a></li>
			<li><a href=""><img
					src="${pageContext.request.contextPath}/img/mobileclass.png" /></a></li>
			<li><a href="" id="top" class="top"><img
					src="${pageContext.request.contextPath}/img/gototop.png" /></a></li>
		</ul>
	</div> --%>
	<div style="height: 70px;"></div>
	<footer class="footer">
	<div class="container">
		<a class="tu" href="">太原工业学院</a>
		<ul class="footer-100">
			<li class="fl"><span>关于我们</span>
				<ul>
					<li><a href="">关于我们</a></li>
					<li><a href="">联系我们</a></li>
					<li><a href="">意见反馈</a></li>
				</ul>
				<ul>
					<li><a href="">学校云</a></li>
					<li><a href="">常见问题</a></li>
					<li><a href="">法律条款</a></li>
				</ul></li>
			<li class="fl"><span>关注我们</span>
				<ul>
					<li class="fl"><a href=""><img
							src="${pageContext.request.contextPath}/img/wechat.png" /></a></li>
					<li class="fl"><a href=""><img
							src="${pageContext.request.contextPath}/img/sina.png" /></a></li>
				</ul></li>
			<li class="fl"><span>友情链接</span>
				<ul>
					<li><a href="">网易卡搭</a></li>
					<li><a href="">网易云课堂</a></li>
					<li><a href="">网易100分</a></li>
				</ul></li>
		</ul>
	</div>
	</footer>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/dep_course.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/main.js"></script>

	<!-- 遮罩层 -->
	<div id="mask"></div>
	<!-- 登录表单 -->
	<form class="login-form" id="loginForm" style="display: none;"
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
		window.onload = function() {
			var atten = document.getElementById("atten-btn");
			atten.onclick = function fadeModal() {
				var mask = document.getElementById('mask');
				console.log(mask);
				mask.style.display = "block";
				var loginForm = document.getElementsByClassName('login-form')[0];
				console.log(loginForm);
				loginForm.style.display = "block";
			}
			//关闭窗口
			var close = document.getElementById("close-login");
			close.onclick = function fadeOutLogin() {
				var mask = document.getElementById('mask');
				console.log(mask);
				mask.style.display = "none";
				var loginForm = document.getElementsByClassName('login-form')[0];
				console.log(loginForm);
				loginForm.style.display = "none";
			}
		};
		function log() {
			var username = $("#username").val();
			var password = $("#password").val();
			$.ajax({
				async : false,
				cache : true,
				type : 'post',
				url : '${pageContext.request.contextPath}/user/login',
				//dataType : 'text',
				data : 'username=' + username + '&password=' + password,
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
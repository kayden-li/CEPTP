<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Course" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/courseDetail.css" />
		<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
		<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<!--标签页淡出效果-->
	</head>

	<body style="background:#eee;">
	<% User user=(User)session.getAttribute("user"); %>
		<header class="header">
			<span class="fl logo">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px;float:left;margin-left:70px;"/></a>
			</span>
			<div class="content">
				<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;" />
				<a class="content-1"href=""><span>搜索</span></a>
			</div>
			<div class="nav-100">
				<ul>
		        <li class="fl list"><a href="${pageContext.request.contextPath}/user/tomain/5">首页</a></li>
			<% if(user==null){%>
				<li class="fl list"><a href="${pageContext.request.contextPath}/jsp/user/login.jsp">登录</a></li>
			<% }else{ %>
	       		<li class="fl list"><a
					href="${pageContext.request.contextPath}/user/changeInfo"> <img
						style="color: black; height: 50px; width: 50px; border: .5em;"
						src="<c:url value='/course/loadImage/${user.user_id}'/>" />
				</a></li> 
				<li class="fl list"><a href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.getUser_name()}</a></li>
				<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit">退出</a></li> 
			<% } %>
				</ul>
			</div>
		</header>
		<hr style="gray 1px solid;">
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
		        	<li class="fl list"><a href="${pageContext.request.contextPath}/user/tomain/5" style="color: rgb(255,255,255);">首页</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="<%-- ${pageContext.request.contextPath}/jsp/user/login.jsp --%>#" style="color: rgb(255,255,255);" id="atten-btn">登录</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/jsp/user/regiest.jsp" style="color: rgb(255,255,255);">注册</a></li>
			<% }else{ %>
		       		<li class="fl list"><a href="${pageContext.request.contextPath}/user/tomain/5" style="color: rgb(255,255,255);">首页</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
		       		<li class="fl list"><img style="color:black;height:50px;width:50px;border:.5em;" src="<c:url value='/course/loadImage/${user.user_id}'/>" /></li> 
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.user_name}</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit" style="color: rgb(255,255,255);">退出</a></li> 
			<% } %>
				</ul>
			</div>
		</div>
		
		<div class="container" style="margin-top: 20px;">
		<div class="container" style="padding-bottom: 15px;width:100%;background-color:#fff;height:400px;padding-top:50px;">
			<div class="nav-left" style="">
				<img src="<c:url value='/course/loadImage/${course.course_id}'/>" />
			</div>
			<div class="nav-right"style="margin-left:60%;">
				<p class="title" style="font-size:24px;">
					<b>${course.getCourse_name()}</b>
					<c:set value="${user.user_id}" var="userid" scope="request"/>
					<c:forEach items="${ids}" var="id">
					<c:set value="${id}" var="id" scope="request"/>
						<%
							String id = request.getAttribute("id").toString();
							String userid=null;
							if(request.getAttribute("userid") == null)
								request.setAttribute("joined", "no");
							else{
								userid = request.getAttribute("userid").toString();
							}
							if(id != null && id.equals(userid)){
								request.setAttribute("joined", true);
							}else{
								request.setAttribute("joined", false);
							}
						%>
						<c:if test="${joined}">
							<span style="font-size:smaller;color:cyan;">已加入</span>
						</c:if>
					</c:forEach>
				</p>
				<div class="nav-right-1" style="width:94%;">
					<p  style="font-size:14px;color:gray;">开课教师：${course.getPublisher()}</p>
					<p style="font-size:14px;color:gray;">${course.schoolTerm}</p>
					<span style="font-size:14px;color:gray;">
						授课班级：<ul style="margin-left:60px;"><li class="fl">${course.getClazz()}</li></ul>
					</span>
					<div style="margin-top:50px;height:35px;width:87px;background:#fb0;padding:3px;border-radius:.5em;color:white;float:left;">
						<a href="${pageContext.request.contextPath}/course/toIntoCourse/${course.course_id}/${course.create_user}" style="text-decoration:none; !important;width:100%;height:100%;">
						进入课程
						</a>
					</div>
					<c:if test="${!joined}">
						<div id="join-course" style="margin-top:50px;height:35px;width:87px;background:#fb0;padding:3px;border-radius:.5em;color:white;float:left;margin-left:100px;">
							加入课程
						</div>
					</c:if>
					<c:if test="${joined}">
						<div style="margin-top:50px;height:35px;width:87px;background:grey;padding:3px;border-radius:.5em;color:white;float:left;margin-left:100px;">
							加入课程
						</div>
					</c:if>
				</div>
			</div>
		</div>
			<div class="inner-left">
				<div class="depart container">
					<ul id="myTab" class="nav nav-tabs" style="width: 682px;background-color:#fff;margin-left:-2px;">
						<li class="active">
							<a href="#introduction" data-toggle="tab">课程介绍</a>
						</li>
						<li>
							<a href="#plan" data-toggle="tab">授课计划</a>
						</li>
						<li>
							<a href="#source" data-toggle="tab">资源</a>
						</li>
						<li>
							<a href="#exprience" data-toggle="tab">实验</a>
						</li>
						<li>
							<a href="#homework" data-toggle="tab">作业</a>
						</li>
						<li>
							<a href="#other" data-toggle="tab" style="background-color:#fff;">其他</a>
						</li>
					</ul>
					<div id="myTabContent" class="tab-content" style="margin-top:-10px;">
						<div class="tab-pane fade in active" id="introduction">
							<div class="introduct">
								<p>${course.course_notes}</p>
								<!-- <span class="fr">——课程团队</span> -->
							</div>
						</div>
						<div class="tab-pane fade" id="plan">
							<div class="plan-1">
								<div style="height: 600px;">
								${course.plan}
								</div>
							</div>
						</div>
						<div class="tab-pane fade" id="source">
							<div class="plan-2">
								<ul class="list-body fl">
									<li style="margin-left: 90px;float:left;width:70px;overflow:hidden;">资源名</li>
									<li style="margin-left: 75px;float:left;width:150px;overflow:hidden;">资源创建时间</li>
								</ul>
								<c:forEach items="${resourceList}" var="task">
									<ul class="list-body fl">
										<a>
											<li style="margin-left: 90px;float:left;width:70px;overflow:hidden;">${task.task_name}</li>
											<c:set value="${fn:substring(task.create_time, 0, 10)}" var="T" />
											<li style="margin-left: 75px;float:left;width:150px;overflow:hidden;">${T}</li>
										</a>
									</ul>
									<br>
								</c:forEach>
							</div>
						</div>
						<div class="tab-pane fade" id="exprience">
							<div class="plan-2">
								<ul class="list-body fl">
									<li style="margin-left: 90px;float:left;width:70px;overflow:hidden;">实验名</li>
									<li style="margin-left: 75px;float:left;width:150px;overflow:hidden;">实验创建时间</li>
								</ul>
								<c:forEach items="${course.testList}" var="task">
									<ul class="list-body fl">
										<a>
											<li style="margin-left: 90px;float:left;width:70px;overflow:hidden;">${task.task_name}</li>
											<c:set value="${fn:substring(task.create_time, 0, 10)}" var="T" />
											<li style="margin-left: 75px;float:left;width:150px;overflow:hidden;">${T}</li>
										</a>
									</ul>
									<br>
								</c:forEach>
							</div>
						</div>
						<div class="tab-pane fade" id="homework">
							 <div class="plan-2">
								<ul class="list-body fl">
									<li style="margin-left: 90px;float:left;width:70px;overflow:hidden;">任务名</li>
									<li style="margin-left: 75px;float:left;width:150px;overflow:hidden;">任务创建时间</li>
								</ul>
								<c:forEach items="${course.taskList}" var="task">
									<ul class="list-body fl">
										<a>
											<li style="margin-left: 90px;float:left;width:70px;overflow:hidden;">${task.task_name}</li>
											<c:set value="${fn:substring(task.create_time, 0, 10)}" var="T" />
											<li style="margin-left: 75px;float:left;width:150px;overflow:hidden;">${T}</li>
										</a>
									</ul>
									<br>
								</c:forEach>
							</div>
						</div>
						<div class="tab-pane fade" id="other">
							 <div class="plan-2">
								<c:forEach items="${course.otherList}" var="task">
									<ul class="list-body fl">
										<a>
											<li style="margin-left: 90px;float:left;width:70px;overflow:hidden;">${task.task_name}</li>
											<c:set value="${fn:substring(task.create_time, 0, 10)}" var="T" />
											<li style="margin-left: 75px;float:left;width:150px;overflow:hidden;">${T}</li>
										</a>
									</ul>
									<br>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="inner-right" style="background-color:#fff;">
				<span>相关课程</span>
				<div class="addclass">
					<ul>
					<c:forEach items="${courseList}" var="course">
						<li class="blank-100">
							<a href="${pageContext.request.contextPath}/course/toCDetail/${course.course_id}" style="text-decoration:none;">
								<div class="pictutu"style="width:50%;">
									<img src="<c:url value='/course/loadImage/${course.course_id}'/>" />
								</div>
								<ul class=" fr blank-50"style="width:50%;">
									<li style="margin-left:40px;">${course.course_name}</li>
									<li style="margin-left:40px;">${Cuser.user_name}</li>
									<li style="margin-left:40px;">${course.schoolTerm}</li>
								</ul>
							</a>
						</li>
					</c:forEach>
					</ul>
					<a class="related" href="${pageContext.request.contextPath}/course/findCouByPage/5/1">更多</a>
				</div>
			</div>
		</div>
		<div style="height:160px;"></div>
		<footer class="footer">
			<div class="container">
				<a class="tu" href="">太原工业学院</a>
				<ul class="footer-100">
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
		<div id="mask"></div>
		<div class="login-form" id="loginForm" style="display:none;">
		    <div class="close" id="close-login">X</div>
		    <h3>邀请码</h3>
		    <p style="margin-left:25px;">请输入邀请码：</p>
		    <input type="text" id="invite_code" />
		    <div class="login-btn" id="join" style="height:40px;width:115px;text-align:center;padding-top:9px;margin-left:120px;margin-top:50px;cursor: pointer;">确定加入</div>
		</div>
		<script type="text/javascript">
		   
			    window.onload = function(){
			        var atten = document.getElementById("join-course");
			        atten.onclick = function fadeModal() {
			            var mask = document.getElementById('mask');
			            console.log(mask);
			            mask.style.display = "block";
			            var loginForm = document.getElementsByClassName('login-form')[0];
			            console.log(loginForm);
			            loginForm.style.display = "block";
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
			        }
			        var join = document.getElementById("join");
			        join.onclick = function joinCou(){
			        	var code = document.getElementById('invite_code').value;
			        	if(code != "" && code != undefined && code != null){
			        		window.location.href='${pageContext.request.contextPath}/course/joinCourse/'+code;
			        	}else{
			        		alert("请输入邀请码");
			        	}
			        }
				};
		</script>
	</body>

</html>
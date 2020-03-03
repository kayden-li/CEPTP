<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Task"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fourth2.css" type="text/css">
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body class="container" style="height:90%;">
<% User user=(User)session.getAttribute("user"); %>
<header class="header" style="margin-left:-50px">
			<span class="fl logo">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px"/></a>
			</span>
			<div class="content">
				<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;" />
				<a class="content-1"href="" style="color:black;" ><span>搜索</span></a>
			</div>
			<div class="nav-100">
				<ul>
			        <li class="fl list"><a style="color:black;" href="${pageContext.request.contextPath}/user/tomain/5">首页</a></li>
			        <li class="fl list"><a
						href="${pageContext.request.contextPath}/user/changeInfo"> <img
							style="color: black; height: 50px; width: 50px; border: .5em;"
							src="<c:url value='/course/loadImage/${user.user_id}'/>" />
					</a></li>
					<li class="fl list"><a style="color:black;" href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.getUser_name()}</a></li>
					<li class="fl list"><a style="color:black;" href="${pageContext.request.contextPath}/user/exit">退出</a></li> 
				</ul>
			</div>
		</header>
		<div class="float container" id="float" style="margin-left:-12.5%;padding-left:5%">
			<span class="fl logo"style="margin-top: -15px;margin-left: 180px;">
				<a href="#"style="color: rgb(255,255,255);margin-left: 10px;">太原工业学院</a>
			</span>
			<div class="content"style="margin-top: -20px;margin-left: 800px;">
				<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;" />
				<a class="content-1"href=""><span style="color: rgb(255,255,255);">搜索</span></a>
			</div>
			<div class="nav-100">
				<ul style="margin-right: 50px;">
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/tomain/5" style="color: rgb(255,255,255);">首页</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<a href="${pageContext.request.contextPath}/user/changeInfo"> <img
							style="color: black; height: 50px; width: 50px; border: .5em;"
							src="<c:url value='/course/loadImage/${user.user_id}'/>" />
					</a>
					<li class="fl list"><a href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.user_name}</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit" style="color: rgb(255,255,255);">退出</a></li>
				</ul>
			</div>
		</div>
 <img src="${pageContext.request.contextPath}/img/head.png" style="height: 300px; width: 100%; margin-top: -143px; position: relative;z-index:-10;" />


<ul class="nav nav-tabs" style="height: 42px; margin-left: 70%; margin-top:-40px; font-size:20px;">
<% if(request.getAttribute("role").equals(true)){ %>
    <li class="CT" style="margin-top:-10px; margin-left:-30%;">
        <a href="${pageContext.request.contextPath}/course/toAddCourse" style="color:black;">
               创建课程
        </a>
    </li>
   <%} %>
    <li id="atten-btn" class="CT" style="margin-top:-10px;cursor: pointer;">
    	<a style="color:black;" class="CT">
    	加入课程
    	</a>
    </li>
    <li>
    	<div style="margin-top:-3px;color:black;">
		    选择学期：
		    <select style="margin-top:2px;">
		        <option value="0">全部</option>
		        <option value="1">第一学期</option>
		        <option value="2">第二学期</option>
		        <option value="3">第三学期</option>
		    </select>
		</div>
    </li>
</ul>
<c:forEach  items="${courseList}" var="course">
	<div class="whole container">
		<div class="photo">
		<% if(request.getAttribute("role").equals(true)){ %>
			<sql:setDataSource var="db"
							   driver="com.mysql.jdbc.Driver"
							   url="jdbc:mysql://localhost/ceptp"
							   user="root"
							   password="ABCCBA131uB" />
			<c:set value="${course.course_id}" var="courseid" scope="request"/>
			<sql:query var="code" dataSource="${db}">
				select invitation_code from ceptp_course where course_id='${courseid}';
			</sql:query>
			<span>邀请码:${code.rows[0].invitation_code}</span>
		<%} %>
			<a href="${pageContext.request.contextPath}/course/toIntoCourse/${course.course_id}/${course.create_user}" style="text-decoration:none;">
				<img src="<c:url value='/course/loadImage/${course.course_id}'/>" style="width:400px;" />
			</a>
		</div>
		<div class="task-list-1 fl" style="margin-left:430px;">
			<div class="title">
				<span>作业</span>
			</div>
			<div style="width:120%;margin-left:-25px;height:100%;">
			
				<ul style="height:30px;font-size:18px;">
                  	<li class="fl" style="width:35%;text-align:center;margin-top:10px;"><div style="text-align:left;">任务名</div></li>
					<li class="fl" style="width:37%;text-align:center;margin-top:10px;"><div style="text-align:center;">已完成(人数)</div></li>
					<li class="fl" style="width:28%;text-align:center;margin-top:10px;"><div style="text-align:right;padding-right:10px;">状态</div></li>
				</ul>
			<c:forEach  items="${course.taskList}" var="task">
				<ul style="height:30px;font-size:18px;">
	                <c:if test="${course.create_user ne user_id}">
                    	<a href="${pageContext.request.contextPath}/course/showTask/${task.getTask_id()}">
	                </c:if>
                    <c:if test="${course.create_user eq user_id}">
	                	<a href="${pageContext.request.contextPath}/course/toStudentUpList/${task.getTask_id()}">
                    </c:if>
                    		<li class="fl" style="width:40%;text-align:center;margin-top:10px;border-bottom:1px grey soild;"><div style="text-align:left;overflow:hidden;width:275px;">${task.task_name}</div></li>
							<li class="fl" style="width:20%;text-align:center;margin-top:10px;"><div style="text-align:center;">${task.num}</div></li>
							<li class="fl" style="width:40%;text-align:center;margin-top:10px;"><div style="text-align:right;">
							<c:if test="${'1' eq task.getStatus()}">进行中</c:if>
	                        <c:if test="${'2' eq task.getStatus()}">已结束</c:if></div>
						</li>
					</a>
				</ul>
			</c:forEach>
			</div>
		</div>
		<div class="task-list-2 fl" style="margin-left:790px;">
			<div class="title">
				<span>实验</span>
			</div>
			<div style="width:120%;margin-left:-25px;height:100%;">
			<ul style="height:30px;font-size:18px;">
                  	<li class="fl" style="width:35%;text-align:center;margin-top:10px;"><div style="text-align:left;">任务名</div></li>
					<li class="fl" style="width:37%;text-align:center;margin-top:10px;"><div style="text-align:center;">已完成(人数)</div></li>
					<li class="fl" style="width:28%;text-align:center;margin-top:10px;"><div style="text-align:right;padding-right:10px;">状态</div></li>
				</ul>
			<c:forEach  items="${course.testList}" var="task">
				<ul style="height:30px;font-size:18px;">
	                <c:if test="${course.create_user ne user_id}">
                    	<a href="${pageContext.request.contextPath}/course/showTest/${task.getTask_id()}">
	                </c:if>
                    <c:if test="${course.create_user eq user_id}">
	                	<a href="${pageContext.request.contextPath}/course/toStudentUpList/${task.getTask_id()}">
                    </c:if>
                    		<li class="fl" style="width:40%;text-align:center;margin-top:10px;border-bottom:1px grey soild;"><div style="text-align:left;overflow:hidden;width:275px;">${task.task_name}</div></li>
							<li class="fl" style="width:20%;text-align:center;margin-top:10px;"><div style="text-align:center;">${task.num}</div></li>
							<li class="fl" style="width:40%;text-align:center;margin-top:10px;"><div style="text-align:right;">
							<c:if test="${'1' eq task.getStatus()}">进行中</c:if>
	                        <c:if test="${'2' eq task.getStatus()}">已结束</c:if></div>
						</li>
					</a>
				</ul>
			</c:forEach>
			</div>
		</div>
		<div class="task-list-3 fl" style="margin-left:430px;">
			<div class="title fl">
				<span class="fl">资源</span>
			</div>
			<div class="fl" style="width:120%;margin-left:-25px;height:100%;">
			<ul style="height:30px;font-size:18px;">
                  	<li class="fl" style="width:30%;text-align:center;margin-top:10px;"><div style="text-align:left;">任务名</div></li>
					<li class="fl" style="width:35%;text-align:center;margin-top:10px;"><div style="text-align:center;">下载人数</div></li>
					<li class="fl" style="width:35%;text-align:center;margin-top:10px;"><div style="text-align:center;">发布时间</div></li>
				</ul>
			<c:forEach  items="${course.resourceList}" var="task">
				<ul style="height:30px;font-size:18px;">
	                <c:if test="${course.create_user ne user_id}">
                    	<a href="${pageContext.request.contextPath}/course/showRes/${task.getTask_id()}">
	                </c:if>
                    <c:if test="${course.create_user eq user_id}">
	                	<a href="${pageContext.request.contextPath}/course/toStudentUpList/${task.getTask_id()}">
                    </c:if>
                  	<li class="fl" style="width:35%;text-align:center;margin-top:10px;border-bottom:1px grey soild;"><div style="text-align:left;overflow:hidden;width:100%;">${task.task_name}</div></li>
                  	<li class="fl" style="width:25%;text-align:center;margin-top:10px;border-bottom:1px grey soild;"><div style="text-align:center;overflow:hidden;width:100%;">${task.download_num}</div></li>
					<li class="fl" style="width:40%;text-align:center;margin-top:10px;"><div style="text-align:center;padding-left:20px;">${fn:substring(task.create_time,0,10)}</div></li>
					<!-- <li class="fl" style="width:40%;text-align:center;margin-top:10px;"><div style="text-align:right;"></li> -->
					</a>
				</ul>
			</c:forEach>
			</div>
		</div>
		<div class="task-list-4 fl" style="margin-left:790px;">
			<div class="title fl">
				<span class="fl">其他</span>
			</div>
			<div class="fl" style="width:120%;margin-left:-25px;height:100%;">
				<ul style="height:30px;font-size:18px;">
                  	<li class="fl" style="width:35%;text-align:center;margin-top:10px;"><div style="text-align:left;">任务名</div></li>
					<li class="fl" style="width:37%;text-align:center;margin-top:10px;"><div style="text-align:center;">已完成(人数)</div></li>
					<li class="fl" style="width:28%;text-align:center;margin-top:10px;"><div style="text-align:right;padding-right:10px;">状态</div></li>
				</ul>
				<c:forEach  items="${course.otherList}" var="other">
					<ul style="height:30px;font-size:18px;">
					<c:if test="${course.create_user ne user_id}">
                    	<a href="${pageContext.request.contextPath}/course/showOther/${other.getTask_id()}">
	                </c:if>
                    <c:if test="${course.create_user eq user_id}">
	                	<a href="${pageContext.request.contextPath}/course/toStudentUpList/${other.getTask_id()}">
                    </c:if>
                  	<li class="fl" style="width:40%;text-align:center;margin-top:10px;border-bottom:1px grey soild;"><div style="text-align:left;overflow:hidden;width:275px;">${other.task_name}</div></li>
					<li class="fl" style="width:20%;text-align:center;margin-top:10px;"><div style="text-align:center;">${task.num}</div></li>
					<li class="fl" style="width:40%;text-align:center;margin-top:10px;"><div style="text-align:right;">
					<c:if test="${'1' eq other.getStatus()}">进行中</c:if>
                       <c:if test="${'2' eq other.getStatus()}">已结束</c:if></div>
					</li>
					</a>
					</ul>
				</c:forEach>
			</div>
		</div>
	</div>
</c:forEach>

<div style="height:100px;"></div>
<footer class="footer" style="width:1522px; margin-left:-17%;">
	<div class="" style="padding-left:24%;overflow : hidden">
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
<link href="${pageContext.request.contextPath}/css/mask.css"
	type="text/css" rel="stylesheet">
<div id="mask"></div>
		<div class="login-form" id="loginForm" style="display:none;">
		    <div class="close" id="close-login">X</div>
		    <h3>邀请码</h3>
		    <p style="margin-left:25px;">请输入邀请码：</p>
		    <input type="text" id="invite_code" />
		    <div class="login-btn" id="join" style="height:40px;width:115px;text-align:center;padding-top:9px;margin-left:120px;margin-top:50px;cursor: pointer;">确定加入</div>
		</div>
		<script type="text/javascript">
		    // fadeModal();//显示登录框
		    window.onload = function(){
		        var atten = document.getElementById("atten-btn");
		        atten.onclick = function fadeModal() {
		            var mask = document.getElementById('mask');
		            mask.style.display = "block";
		            var loginForm = document.getElementsByClassName('login-form')[0];
		            loginForm.style.display = "block";
		        }
		      //关闭窗口
		        var close= document.getElementById("close-login");
		        close.onclick =function fadeOutLogin() {
		            var mask = document.getElementById('mask');
		            mask.style.display = "none";
		            var loginForm = document.getElementsByClassName('login-form')[0];
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
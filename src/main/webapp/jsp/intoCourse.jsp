<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Task"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fourth.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" type="text/css">
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body class="container">
<% User user=(User)session.getAttribute("user"); %>
		<header class="header">
			<span class="fl logo">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px;float:left;"/></a>
			</span>
			<div class="content">
				<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;margin-left:-50px;" />
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
					<li class="fl list"><a href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.user_name}</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit" style="color: rgb(255,255,255);">退出</a></li> 
			<% } %>
				</ul>
			</div>
		</div>

    <img src="${pageContext.request.contextPath}/img/head.png" style="height: 180px; width: 100%; z-index:-1; margin-top: -100px; position: relative;" />

	<div style="font-size:35px;margin-top:-50px;">${Cname.course_name}</div>
    <ul id="myTab" class="nav nav-tabs" style="height: 42px; margin-left: 50%;margin-top:-35px;">
        <li><a href="#resources" data-toggle="tab">资源</a></li>
        <li><a href="#test" data-toggle="tab">实验</a></li>
        <li class="active"><a href="#homework" data-toggle="tab">作业</a></li>
        <li><a href="#member" data-toggle="tab">成员</a></li>
        <li><a href="#other" data-toggle="tab">其他</a></li>
        <%	String create_user = (String)request.getAttribute("create_user");
        	if(create_user.equals(user.getUser_id())){ %>
	    <li>
	        <a href="${pageContext.request.contextPath}/course/toAddTask/${course_id}">
	            发布
	        </a>
	    </li>
	    <% } %>
    </ul>

    <div id="myTabContent" class="tab-content col-md-offset-1">
        <div class="tab-pane fade" id="resources">
            <div class="blank" style="width:1180px">
                <ul style="margin-left:-15%;">
					<c:forEach items="${resourceList}" var="task">
        			<li class="fl">
						<div class="blank">
							<div class="pic">
								<img src="${pageContext.request.contextPath}/img/2.png" />
							</div>
							<div>
								<div class="date">
									<c:set var="date" value="${fn:substring(task.create_time, 0, 10)}" />
									${date}
									
								</div>
								<div class="cent">
									<p style="margin-top: -5px;margin-left: 20px;">${task.task_name}</p>
									<ul style="margin-top: -10px;margin-left: -40px;">
										<li class="fl">${task.delete_time}</li>
										<li class="fl" style="margin-left: 20px;">
											<a href="${pageContext.request.contextPath}/course/toStudentUpList/${task.getTask_id()}">查看</a>
										</li>
									</ul>
								</div>
							</div>
						</div>

					</li>
				</c:forEach>
                </ul>
            </div>
        </div>
        <div class="tab-pane fade" id="test">
            <div class="blank" style="width:1180px">
                <ul style="margin-left:-15%;">
	                <c:forEach items="${testList}" var="task">
	        			<li class="fl">
							<div class="blank">
								<div class="pic">
									<img src="${pageContext.request.contextPath}/img/2.png" />
								</div>
								<div>
									<div class="date">
										<c:set var="date" value="${fn:substring(task.create_time, 0, 10)}" />
										${date}
									</div>
									<div class="cent">
										<p style="margin-top: -5px;margin-left: 20px;">${task.task_name}</p>
										<ul style="margin-top: -10px;margin-left: -40px;">
											<li class="fl"style="color: #8BB8C7;">
												<c:if test="${'1' eq task.getStatus()}">进行中</c:if>
						                        <c:if test="${'2' eq task.getStatus()}">已结束</c:if>
											</li>
											<li class="fl">共${task.num}人作答</li>
											<li class="fl">|</li>
											<li class="fl">${task.delete_time}</li>
											<li class="fl" style="margin-left: 20px;">
				                                <% if(create_user.equals(user.getUser_id())){ %>
				                                    <a href="${pageContext.request.contextPath}/course/toStudentUpList/${task.getTask_id()}">查看</a>
				                                <% }else{ %>
				                                	<a href="${pageContext.request.contextPath}/course/showTest/${task.getTask_id()}">提交</a>
				                                <% } %>
											</li>
										</ul>
									</div>
								</div>
							</div>
	
						</li>
					</c:forEach>
                </ul>
            </div>
        </div>
        <div class="tab-pane fade  in active" id="homework">
			<div class="blank" style="width:1180px">
                <ul style="margin-left:-15%;">
	                <c:forEach items="${taskList}" var="task">
	        			<li class="fl">
							<div class="blank">
								<div class="pic">
									<img src="${pageContext.request.contextPath}/img/2.png" />
								</div>
								<div>
									<div class="date">
										<c:set var="date" value="${fn:substring(task.create_time, 0, 10)}" />
										${date}
									</div>
									<div class="cent">
										<p style="margin-top: -5px;margin-left: 20px;">${task.task_name}</p>
										<ul style="margin-top: -10px;margin-left: -40px;">
											<li class="fl"style="color: #8BB8C7;">
												<c:if test="${'1' eq task.getStatus()}">进行中</c:if>
						                        <c:if test="${'2' eq task.getStatus()}">已结束</c:if>
											</li>
											<li class="fl">共${task.num}人作答</li>
											<li class="fl">|</li>
											<li class="fl">${task.delete_time}</li>
											<li class="fl" style="margin-left: 20px;">
				                                <% if(create_user.equals(user.getUser_id())){ %>
				                                    <a href="${pageContext.request.contextPath}/course/toStudentUpList/${task.getTask_id()}">查看</a>
				                                <% }else{ %>
				                                	<a href="${pageContext.request.contextPath}/course/showTask/${task.getTask_id()}">提交</a>
				                                <% } %>
											</li>
										</ul>
									</div>
								</div>
							</div>
	
						</li>
					</c:forEach>
                </ul>
            </div>
        </div>
        <div class="tab-pane fade" id="member">
			<div class="blank" style="width:1180px">
                <ul style="margin-left:-15%;">
	                <c:forEach items="${memberList}" var="user">
	        			<li class="fl" style="margin-top:20px;">
							<div class="blank">
								<div class="pic">
									<img src="<c:url value='/course/loadImage/${user.user_id}'/>" style="margin-top:0px;" />
								</div>
								<div class="cent">
									<p style="margin-top: -5px;margin-left: 20px;">${user.user_name}</p>
								</div>
							</div>
						</li>
					</c:forEach>
                </ul>
            </div>
        </div>
         <div class="tab-pane fade" id="other">
			<div class="blank" style="width:1180px">
                <ul style="margin-left:-15%;">
	                <c:forEach items="${otherList}" var="user">
	        			<li class="fl" style="margin-top:20px;">
							<div class="blank">
								<div class="pic">
									<img src="${pageContext.request.contextPath}/img/2.png" style="margin-top:0px;" />
								</div>
								<div class="cent">
									<p style="margin-top: -5px;margin-left: 20px;">${user.task_name}</p>
								</div>
							</div>
						</li>
					</c:forEach>
                </ul>
            </div>
        </div>
    </div>
<div style="height:360px;float:left;"></div>
		
</body>
<footer class="footer" style="width:115%; margin-left:-22%;">
			<div class="" style="padding-left:7%;overflow : hidden">
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
</html>
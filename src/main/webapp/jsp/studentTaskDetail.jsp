<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.edu.tit.user.bean.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html">
<title>提交列表</title>
<link href="${pageContext.request.contextPath}/css/fourthpage.css"
	type="text/css" rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css"
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/fourthpage.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
<link rel="stylesheet"
	href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/BootFour-one.css">
<script
	src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
function AddMoreRow(){
		var theEvent = window.event || arguments.callee.caller.arguments[0];
		var theObj=theEvent.target || theEvent.srcElement;
		var oRow = theObj.parentNode.parentNode;
		var oTable = oRow.parentNode.parentNode;
		var rowCount = oTable.rows.length;
		oNewRow = oTable.insertRow(rowCount);
		oNewRow.insertCell(0).innerHTML = "附件"+rowCount;
		oNewRow.insertCell(1).innerHTML = "<input type='file' name='FilePath' size='75' onKeyDown='DisabledKeyInput()' />";
		/* oRow.all("DelBtn").disabled = false;
		oNewRow.all("DelBtn").disabled = false; */
	}
	
	


	/* function DeleteMoreRow() {
		var oRow = event.srcElement.parentNode.parentNode;
		var oTable = oRow.parentNode.parentNode;
		var rowCount = oTable.rows.length;
		if (oTable.rows.length > 1) {
			oTable.deleteRow(rowCount - 1);
			if (oTable.rows.length == 1) {
				oTable.all("DelBtn").disabled = true;
			}
		}
	} */
	
	function DisabledKeyInput() {
		var theEvent = window.event || arguments.callee.caller.arguments[0];
		if (theEvent.keyCode != 8 && theEvent.keyCode != 46) {
			theEvent.returnValue = false;
		}
	}
	
	function myfun()
	{
		var str = $("#task_details").val();
		document.getElementById('txt').innerHTML=str;
	}
	
	function downloadtest(id){
		var url = "<%=request.getContextPath()%>
	/course/download" + "/" + id;
		$("#pluginurl").attr("href", url);
	}
</script>

</head>
<body onload="myfun()" style="background: white;">
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
			style="height: 25px; margin-left: -50px;" /> <a class="content-1"
			href="" style="color: black;"><span>搜索</span></a>
	</div>
	<div class="nav-100">
		<ul>
			<li class="fl list"><a style="color: black;"
				href="${pageContext.request.contextPath}/course/tomain/5">首页</a></li>
			<li class="fl list"><a
				href="${pageContext.request.contextPath}/user/changeInfo"> <img
					style="color: black; height: 50px; width: 50px; border: .5em;"
					src="<c:url value='/course/loadImage/${user.user_id}'/>" />
			</a></li>
			<li class="fl list"><a style="color: black;"
				href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.getUser_name()}</a></li>
			<li class="fl list"><a style="color: black;"
				href="${pageContext.request.contextPath}/user/exit">退出</a></li>
		</ul>
	</div>
	</header>
	<hr style="">
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
					href="${pageContext.request.contextPath}/user/tomain/5"
					style="color: rgb(255, 255, 255);">首页</a></li>
				<li class="fl list"><a href=""
					style="color: rgb(240, 240, 240);">|</a></li>
				<li class="fl list"><a
					href="<%-- ${pageContext.request.contextPath}/jsp/user/login.jsp --%>#"
					style="color: rgb(255, 255, 255);" id="atten-btn">登录</a></li>
				<li class="fl list"><a href=""
					style="color: rgb(240, 240, 240);">|</a></li>
				<li class="fl list"><a
					href="${pageContext.request.contextPath}/jsp/user/regiest.jsp"
					style="color: rgb(255, 255, 255);">注册</a></li>
				<%
					} else {
				%>
				<li class="fl list"><a
					href="${pageContext.request.contextPath}/user/tomain/5"
					style="color: rgb(255, 255, 255);">首页</a></li>
				<li class="fl list"><a href=""
					style="color: rgb(240, 240, 240);">|</a></li>
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

	<!--body-->
	<div class="container body"
		style="width: 79%; margin-top: 50px; margin-left: 12%;">
		<!--作业详情-->
		<input type="hidden" name="course_id" value="${task.course_id }">
		<div
			style="padding-bottom: 5px; border-bottom: 1px dashed #7594a3; margin-bottom: 10px;">
			<p style="">作业内容：</p>
			<p>${task.uploadTask_details }</p>
		</div>
		<div style="padding-top: 15px;">
			<p style="position: relative; top: -12px; font-family: 微软雅黑">${name}的作业详情：</p>
			<textarea id="task_details" class="" disabled="disabled" cols="188"
				rows="10" placeholder="请输入" name="task_details"
				style="display: none;">${task.uploadTask_details }</textarea>
		</div>
		<div id="txt"
			style="margin-bottom: 10px; margin-top: -10px; border-bottom: 1px dashed #7594a3; padding-bottom: 15px;"></div>
		<p style="padding-top: 5px;">下载附件：</p>
		<c:forEach items="${task.uploadAccs }" var="acc">
			<a href="#" onclick="javascript:downloadtest('${acc.accessory_id}')"
				id="pluginurl"
				style="color: #83AFE2; text-decoration: underline; float: left;">${acc.accessory_name }</a>
			<div style="float: left; margin-left: 50px;">
				<a onclick="deleteAcc()">删除</a>
			</div>
			</br>
		</c:forEach>
		</br>
		<div style="margin-top: 28px;"></div>
		<div>
			<p>评分：</p>
			<form
				action="${pageContext.request.contextPath}/course/setGrade/${task.task_id}/${user.user_id}/${id}">
				<div class="input-group" style="width: 188px;">
					<input type="text" class="form-control" placeholder="评分"
						name="grade"> <span class="input-group-btn">
						<button class="btn btn-default" type="submit">确定</button>
					</span>
				</div>
			</form>
		</div>
		<div>
			<span>最后得分：</span> <span
				style="font-size: 32px; color: #ff6600; position: relative; top: 6px; left: -4px;">${grade}</span>
		</div>
		<div style="height: 360px; float: left;"></div>

	</div>





</body>
<footer class="footer" style="width:115%; margin-left:-15%;">
<div class="" style="padding-left: 7%; overflow: hidden">
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
</body>

</html>
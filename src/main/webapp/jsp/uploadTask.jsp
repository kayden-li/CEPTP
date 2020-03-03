<%@page import="cn.edu.tit.course.controller.CourseController"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Task"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html">
<title>提交作业</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fourth.css" type="text/css">
<!-- 弹窗 -->
<link href="${pageContext.request.contextPath}/css/mask.css"
	type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/fourthpage.css"
	type="text/css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}css/BootFour-one.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/fourthpage.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ueditor/zh-cn.js"></script>

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
		var url = "<%=request.getContextPath()%>/course/download" + "/" + id;
		$("#pluginurl").attr("href",url);
	}
	
	function downloadtest2(id){
		var url = "<%=request.getContextPath()%>/course/download" + "/" + id;
		$("#pluginurl2").attr("href",url);
	}
	
</script>

</head>
<body onload="myfun()">
<% User user=(User)session.getAttribute("user"); %>
		<header class="header">
			<span class="fl logo">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px"/></a>
			</span>
			<div class="content" style="margin-left:750px;">
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
	<!--body-->
	<div class="container body" style="margin-top:50px;">
		<!--搜索框-->
		<form action="<c:url value='/course/uploadTask/${uploadFlag }'/>"
			enctype="multipart/form-data" method="post">
			<input type="hidden" name="task_id" value="${task.task_id }">
			<input type="hidden" name="course_id" value="${task.course_id }">
			<div>
				<p>作业详情：</p>
				${detail}
				<!-- <textarea id="task_details" class="" disabled="disabled" style="width:1140px;height:160px;display: block;background: white;"placeholder="请输入" name="task_details">
					</textarea> -->
			</div>
			<div id="txt" style="margin-bottom: 10px;background-color: #efecec;"></div>
			<p>下载附件：</p>
			<c:forEach items="${task.pubAccs }" var ="acc">
				<a href="#" onclick="javascript:downloadtest('${acc.accessory_id}')"  id="pluginurl"  style="color: #83AFE2;text-decoration:underline;">${acc.accessory_name }</a>
				</br>
			</c:forEach>
			
			<div style="margin-top: 30px">
        		<p>提交任务：</p>
            	<textarea id = "uploadTask_details" cols="188" rows="10" placeholder="请输入" name="uploadTask_details"  >${upload_task.uploadTask_details }</textarea>
            	<p class="light">(选填)可输入文字或添加图片及其他类型附件</p>
        	</div>
			<table>
				<tr>
					<td>
						<!-- <div class="file"> --> <input type="button" id="upFile"
						value="添加附件" onclick="AddMoreRow()">

					</td>
				<ul>
				<c:forEach items="${upload_task.uploadAccs }" var ="acc">
				<li>
					<a href="#" onclick="javascript:downloadtest2('${acc.accessory_id}')"  id="pluginurl2"  style="color: #83AFE2;text-decoration:underline;">${acc.accessory_name }</a>
					<c:if test="${task.status == 1}">
						<a href="${pageContext.request.contextPath}/course/deleteAcc/${acc.accessory_id}/${task.task_id}" style="margin-left:50px;">删除</a>
					</c:if>
					</br>
				</li>
				</c:forEach>
				</ul>
				</tr>
			</table>
				<div class="crecan">
					<sql:setDataSource var="db"
									   driver="com.mysql.jdbc.Driver"
									   url="jdbc:mysql://localhost/ceptp"
									   user="root"
									   password="ABCCBA131uB" />
					<c:set value="${user.user_id}" var="userid" scope="request"/>
					<sql:query var="ismember" dataSource="${db}">
						select * from ceptp_cv where user_id='${userid}' and course_id='${couid}';
					</sql:query>
					<c:set var="joined" value="true"></c:set>
					<c:if test="${ismember.rows[0].user_id == userid}">
						<c:set var="joined" value="false"></c:set>
						<c:if test="${task.status == 1}">
							<button type="submit" style="width: 75px" class="choice-style cho fl creat">提交</button>
						</c:if>
					</c:if>
					<c:if test="${joined}">
						<script type="text/javascript">
							alert("该任务已结束");
						</script>
						<p style="margin-left:-50px;">您还没有加入本课程，加入课程后即可提交作业</p>
						<div  style="width: 75px" class="choice-style cho fl creat" id="atten-btn">立即加入</div>
					</c:if>
					<a href="${pageContext.request.contextPath}/course/toIntoCourse/${task.course_id}/${task.create_user}"><div style="width: 75px" class="choice-style fl cancel">取消</div></a>
				</div>
			</div>
		</form>
	</div>

	<div style="height:200px;"></div>
<footer class="footer" style="height:164px;">
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
					<li style="float:right;margin-top:-12%;">
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
		    // fadeModal();//显示登录框
		    window.onload = function(){
		    	
		        var atten = document.getElementById("atten-btn");
		        atten.onclick = function fadeModal() {
		        	var edit = document.getElementById('uploadTask_details');
		            var mask = document.getElementById('mask');
		            console.log(mask);
		            mask.style.display = "block";
		            edit.style.display = "none";
		            var loginForm = document.getElementsByClassName('login-form')[0];
		            console.log(loginForm);
		            loginForm.style.display = "block";
		        }
		      //关闭窗口
		        var close= document.getElementById("close-login");
		        close.onclick =function fadeOutLogin() {
		        	var edit = document.getElementById('uploadTask_details');
		            var mask = document.getElementById('mask');
		            console.log(mask);
		            mask.style.display = "none";
		            edit.style.display = "block";
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

<script type="text/javascript" charset="utf-8">
	UE.getEditor('uploadTask_details');
	
	
</script>
</html>
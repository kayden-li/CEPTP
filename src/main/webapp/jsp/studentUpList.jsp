<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Task"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html">
<title>提交列表</title>


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fourth.css" type="text/css">
	<link href="${pageContext.request.contextPath}/css/UplistTask.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" type="text/css">
	<link href="${pageContext.request.contextPath}/css/fourthpage.css" type="text/css" rel="stylesheet">
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
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
		var url = "<%=request.getContextPath()%>/course/download" + "/" + id;
		$("#pluginurl").attr("href",url);
	}
	
</script>

</head>
<body onload="myfun()" style="background: white;">
	<!--header-->
	<% User user=(User)session.getAttribute("user"); %>
<header class="header">
			<span class="fl logo">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px"/></a>
			</span>
			<div class="content"style="margin-left:600px;">
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
					<li class="fl list"><img style="color:black;height:50px;width:50px;border:.5em;" src="<c:url value='/course/loadImage/${user.user_id}'/>" /></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.user_name}</a></li>
					<li class="fl list"><a href="" style="color: rgb(240,240,240);">|</a></li>
					<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit" style="color: rgb(255,255,255);">退出</a></li>
				</ul>
			</div>
		</div>
		
    
		
	<!--body-->
	<div class="container body">
		<img src="${pageContext.request.contextPath}/img/head.png" style="height: 180px; width: 100%; z-index:-1; margin-top: -40px;" />
		<!--information-->
		<div class="information" style="margin-bottom: 32px;margin-top:-33px;">
			<ul id="myTab" class="nav nav-tabs" style="height: 42px;">

				<li class="active"><a href="#member" data-toggle="tab">
						提交列表（1） </a></li>

				<li><a href="#import" data-toggle="tab"> 导出/报告 </a></li>
			</ul>
		</div>
		<!--作业详情-->
		
		<ul class="prefixion">
			<li class="prefixionli"style="padding-left: 20px;">
				<input type="hidden" name="task_id" value="${task.task_id }">
				<div>
					<p>作业详情：</p>
					<textarea id="task_details" class="" disabled="disabled" cols="188"
						rows="10" placeholder="请输入" name="task_details"
						style="display: none;">${task.task_details }</textarea>
				</div>
				<div id="txt" style="margin-bottom: 10px;background-color: #efecec;"></div>
			</li>
			
			<li class="prefixionli1"style="padding-left: 20px;">
				<p style="margin-top:50px;">下载附件：</p>
				<c:forEach items="${task.pubAccs }" var ="acc">
					<a href="#" onclick="javascript:downloadtest('${acc.accessory_id}')"  id="pluginurl"  style="color: #83AFE2;text-decoration:underline;">${acc.accessory_name }</a>
					</br>
				</c:forEach>
			</li>
			<li class="prefixionli2"style="padding-left: 20px;">
				<div style="margin-top: 28px;">
				<p>提交列表：</p>
				<ul>
				<c:forEach items="${uploader }" var="user">
	            	<li>
						<div class="class">
			                <div class="panel panel-default">
			                    <div class="panel-body">
			                        <ul>
			                            <li class="user-info">
			                                <img src="img/1.png">
			                                <small style="font-size: 100%;">${user.user_name}</small>
			                            </li>
			                            <li class="inf">
			                                <div class="evaluate">
												${user.grade}
			                                </div>
			                            </li>
			                            <li class="inf">
			                                <a href="${pageContext.request.contextPath}/course/toStuTaskDetail/${task.task_id}/${user.user_id}" style="float: right; margin-right: 50px;">查看作业</a>
			                            </li>
			                        </ul>
			                    </div>
			                </div>
		            	</div>
					</li>   
	            </c:forEach>
					
				</ul>
			</div>
		
			</li>
		</ul>
	</div>
	<div style="height:200px;"></div>
<footer class="footer  navbar-fixed-bottom">
    <div>
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
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Course" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html">
    <title>添加作业</title>
    <link href="${pageContext.request.contextPath}/css/fourthpage.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/BootFour-one.css">
	<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" /> --%>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/fourthpage.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/zh-cn.js"></script>
     
    <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- 日期控件 -->
    <script type="text/javascript" src="<c:url value="/js/My97Date/WdatePicker.js"/>"></script>
    <script  type="text/javascript" >
    
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
	function toVaild(){
		var time = $('#DeleteTime').val();
		if(time == null || time == ""){
			alert("请设置过期时间!");
			return false;
		}
		return true;
	}
	
</script>
</head>
<body onload="myfun()" style="background: white;">
<!--header-->
    <% User user=(User)session.getAttribute("user"); %>

	<header class="header">
		<span class="fl logo">
			<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px;float:left;margin-left:50px;"/></a>
		</span>
		<div class="content">
			<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;margin-left:-50px;" />
			<a class="content-1"href=""><span>搜索</span></a>
		</div>
		<div class="nav-100">
			<ul>
				<li class="fl list"><a href="${pageContext.request.contextPath}/course/tomain/5">首页</a></li>
				<li class="fl list"><a
					href="${pageContext.request.contextPath}/user/changeInfo"> <img
						style="color: black; height: 50px; width: 50px; border: .5em;"
						src="<c:url value='/course/loadImage/${user.user_id}'/>" />
				</a></li>
				<li class="fl list"><a href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}">${user.getUser_name()}</a></li>
				<li class="fl list"><a href="${pageContext.request.contextPath}/user/exit">退出</a></li> 
			</ul>
		</div>
		<img src="${pageContext.request.contextPath}/img/head.png" style="height: 180px; width: 90%; margin-left:5%; margin-top: -70px; position: relative;z-index:-10;" />
	</header>
	
<!--body-->
    <div class="container body" style="margin-top:50px;">
        <!--搜索框-->
        <form  action="<c:url value='/course/publishTask'/>" onsubmit="return toVaild()" enctype="multipart/form-data" 
       method="post">
       		
        	<input type="hidden" name="course_id" value="${course_id }">
        	<div style="margin-top:70px;">
	        	<span>选择资源类型：</span></br>
				<div class="radio" style="line-height:22px;float:left;">
				  <label>
				    <input type="radio" name="task_type" id="optionsRadios3" value="2" >资源
				  </label>
				  <label>
				    <input type="radio" name="task_type" id="optionsRadios2" value="1" >实验
				  </label>
				  <label>
				    <input style="float:left;" type="radio" name="task_type" id="optionsRadios1" value="0" checked >作业
				  </label>
				  <label>
				    <input type="radio" name="task_type" id="optionsRadios4" value="3" >其他
				  </label>
				</div>
				<div style="float:right">
					<input style="height:30px;float:right;" type="text" name="delete_time" id="DeleteTime" onclick="WdatePicker({minDate:'%y-%M-%d'})"/>
					<div style="color:red;float:right;font-size:25px;">*</div><div style="float:right;">截止时间</div></p><p style="float:right;margin-top:12px;">
				</div>
				<div class="choice">
	                <span class="form-title" style="margin-top:50px;margin-left:0;border-top:1px dashed #7594a3">资源标题：</span>
	                <textarea placeholder="作业/小组标题" class="form-control" cols="188" name="task_name" style="height:35px;width:50%;id="title_name""></textarea>
	            </div>
        		<p style="margin-top:35px;">资源详情：</p>
            	<textarea id = "task_details" class=""   cols="198" rows="10" placeholder="请输入" name="task_details"style="width:100%;"  ></textarea>
            	<p class="light">(选填)可输入文字或添加图片及其他类型附件</p>
        	</div>
            <table>
            	<tr>
	            	<td>
	            		<!-- <div class="file"> -->
	            			<input type="button" id="upFile" value="添加附件" onclick="AddMoreRow()">
	           			 
	           		</td>
            	</tr>
            </table>
            
            
            <div class="crecan">
                <button type="submit" style="width: 75px;" class="choice-style cho fl creat">创建</button>
                <a href="${pageContext.request.contextPath}/course/toIntoCourse/${course_id}/${course.create_user}" style="text-decoration:none;"><div style="width: 75px" class="choice-style fl cancel">取消</div></a>
            </div>
        </form>
    </div>

	<footer class="footer" style="height:170px;">
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
</body>
<script type="text/javascript" charset="utf-8">
	UE.getEditor('task_details');
	 
</script>
<script type="text/javascript" language="JavaScript">
	var now = new Date(); 
	$('#DeleteTime').value=new Date().getFullYear() + '/' + (new Date().getMonth() + 1) + '/' + new Date().getDate();
</script>
</html>
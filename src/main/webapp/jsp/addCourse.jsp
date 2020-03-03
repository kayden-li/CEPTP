<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.edu.tit.user.bean.User"%>
<%@page import="cn.edu.tit.course.bean.Course" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>添加课程</title>
		
		
		<link href="${pageContext.request.contextPath}/css/fourthpage.css" type="text/css" rel="stylesheet">
		<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
		<script  type="text/javascript" >
		$(document).ready(function(){
			var date = new Date();
			var year=date.getFullYear();
			var month=date.getMonth()+1;
			var str = "";
			if(month < 2 || (month > 7 && month < 12)){
				str = year+"/"+(year+1)+"第一学期";
			}else{
				str = (year-1)+"/"+year+"第二学期";
			}
			$("#term").html(str);
			$("#schoolTerm").val(str);
			
			
		})
		function setImagePreview(avalue) {
			var docObj=document.getElementById("file");

			var imgObjPreview=document.getElementById("preview");
			if(docObj.files &&docObj.files[0])
			{
				//火狐下，直接设img属性
				imgObjPreview.style.display = 'block';
				imgObjPreview.style.width = '70%';
				imgObjPreview.style.height = '70%'; 

				//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
				imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
			}
			else
			{
				//IE下，使用滤镜
				docObj.select();
				var imgSrc = document.selection.createRange().text;
				var localImagId = document.getElementById("localImag");
				//必须设置初始大小
				localImagId.style.width = "70%";
				localImagId.style.height = "70%";
				//图片异常的捕捉，防止用户修改后缀来伪造图片
				try{
					localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
					localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
				}
				catch(e)
				{
					alert("您上传的图片格式不正确，请重新选择!");
					return false;
				}
				imgObjPreview.style.display = 'none';
				document.selection.empty();
			}
			return true;
		}
		</script>
	</head>
	  
	
	<body>
	
<% User user=(User)session.getAttribute("user"); %>
		<header class="header">
			<span class="fl logo">
				<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png" style="width:250px;height:100px"/></a>
			</span>
			<div class="content">
				<input type="text" placeholder="请输入要查询的内容" id="search" name="search"style="height: 25px;margin-left:-50px;" />
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
		<form action="<c:url value='/course/addCourse'/>" method="post"  enctype="multipart/form-data">
		<div class="detail">
			<span><strong style="float:left;">授课学期:</strong><div id="term" style="float:left;"></div></span><br/>
			<input name="schoolTerm" type="hidden" id="schoolTerm"/>
			<c:set value="${fn:substring(user.class_name, 3, 5)}" var="dep_str" />
			<fmt:formatNumber value="${dep_str}" var="dep" />
			<div><strong>系部:</strong>
				<c:forEach items="${departs}" var="depart">
					<c:if test="${depart.depart_id == dep}">
						<span>${depart.depart_name}</span>
					</c:if>
				</c:forEach>
			</div>
			<input name="course_label" type="hidden" id="depart" value="${dep}"></input>
			<span><strong>课程名*</strong></span><br/>
			<input type="text" class="form-control" name="course_name" /><br />
			<span><strong>授课班级*</strong></span><br />
			<input class="inputClass form-control" type="text" name="clazz" id="classname"/>
			<%-- <select id="depart" name="course_label" >
				<option vlaue="">请选择系部</option>
				<c:forEach items="${departs }" var="depart">
					<option value="${depart.depart_id }" name="course_label">${depart.depart_name }</option>
				</c:forEach>
			</select> --%>
			<br/>
			<span><strong>课程简介</strong></span><br />
			<textarea class="form-control" rows="3" name="course_notes"></textarea>
				
			</script>
			<span><strong>授课计划</strong></span><br />
			<textarea class="form-control" rows="3" name="plan"></textarea>
			<span><strong>添加课程图片</strong></span><br />
			<div class="clphoto">
				<!-- <label for="file" class="filephoto">+</label>
				<input type="file" id="file" style="display: none;" name="course_img"> -->
				
				<input type="file" name="file" id="file"
	 				 style="width:100%;display:block;" onchange="javascript:setImagePreview();">
				<lable for="file">
					<img id="preview" src="" style="display: block; width: 100%; height: 100%;">
				</lable>
			</div>
			<div class="sub">
				<button type="submit" class="btn btn-default" style="margin-right: 200px">提交</button>
				<a href="${pageContext.request.contextPath}/course/toIntoActivities/${user.getUser_id()}"><button type="button" class="btn btn-default">取消</button></a>
				
			</div>
		</div>
		</form>

<div style="height:400px;"></div>
		<footer class="footer">
			<div class="" style="padding-left:25%;overflow : hidden">
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
<script type="text/javascript" charset="utf-8">
	/* UE.getEditor('course_notes'); */
</script>
	</body>
</html>

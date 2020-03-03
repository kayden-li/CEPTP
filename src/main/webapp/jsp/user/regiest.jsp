<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改信息</title>


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/user/regist.css">
<script type="application/text"
	href="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" />

<script type="text/javascript">

function _hyz() {
	/*
	 * 1. 获取<img>元素
	 * 2. 重新设置它的src
	 * 3. 使用毫秒来添加参数
	 */
	$("#imgVerifyCode").attr("src", ${pageContext.request.contextPath}+"/user/verifyCode?a=" + new Date().getTime());
}
</script>

<style type="text/css">
* {
	margin: 0;
	padding: 0;
}
/* to remove the top and left whitespace */
html, body {
	width: 100%;
	height: 100%;
}
/* just to be sure these are full screen*/
canvas {
	display: block;
	background-color: ##f4f4f4;
	float: left;
	top: 0;
	left: 0;
	height: 600px;
	width: 1520px;
}
/* To remove the scrollbars */
</style>
</head>
<body>
	<div class="container">
		<header class="header"> 
		<span class="logo"style="float: left;"> 
		<a href="#"><img src="${pageContext.request.contextPath}/img/school_name.png"
				style="width: 250px; height: 100px" /></a>
		</span> </header>
	</div>
	<div id="divMain" style="position: absolute; top: 88px">
		<div id="divBody">
			<form action="<c:url value='/user/userSignUP'/>" method="post"
				id="registForm" enctype="multipart/form-data">
				<table id="tableForm"style="margin-left:150px;">
					<tr>
						<td class="tdText" style="color: #000">用户名*：</td>
						<td class="tdInput"><input class="inputClass form-control"
							type="text" readonly="readonly" name="user_id" id="loginname"
							value="${user.user_id}" /></td>
						<td class="tdError"><label class="errorClass"
							id="loginnameError">${errors.loginname }</label></td>
					</tr>
					<tr>
						<td class="tdText" style="color: #000">姓名*：</td>
						<td class="tdInput"><input class="inputClass form-control"
							type="text" readonly="readonly" name="user_name" id="username"
							value="${user.user_name}" /></td>
						<td class="tdError"><label class="errorClass"
							id="usernameError">${errors.username }</label></td>
					</tr>
					<tr>
						<td class="tdText" style="color: #000">新密码*：</td>
						<td><input class="inputClass form-control" type="password"
							name="password" id="loginpass" value="${user.password}" /></td>
						<td><label class="errorClass" id="loginpassError">${errors.loginpass }</label>
						</td>
					</tr>
					<tr>
						<td class="tdText" style="color: #000">重复密码*：</td>
						<td><input class="inputClass form-control" type="password"
							name="reloginpass" id="reloginpass" value="${user.password}" /></td>
						<td><label class="errorClass" id="reloginpassError">${errors.reloginpass}</label>
						</td>
					</tr>
					<tr>
						<td class="tdText" style="color: #000">班级：</td>
						<td class="tdInput"><input class="inputClass form-control"
							type="text" name="class_name" readonly="readonly" id="classname"
							value="${user.class_name}" /></td>
						<td class="tdError"></td>
					</tr>
					<tr>
						<td class="tdText" style="color: #000">职称：</td>
						<td class="tdInput"><input class="inputClass form-control"
							type="text" readonly="readonly" name="professional_title" id="pt"
							value="${user.professional_title}" /></td>
						<td class="tdError"></td>
					</tr>

					<tr>
						<td class="tdText" style="color: #000">专业：</td>
						<td class="tdInput"><input class="inputClass form-control"
							readonly="readonly" type="text" name="pro" id="pro"
							value="${user.pro}" /></td>
						<td class="tdError"></td>
					</tr>
					<tr>
						<td class="tdText" style="color: #000">手机号*：</td>
						<td class="tdInput"><input class="inputClass form-control"
							type="text" name="mobile" id="mb" value="${user.mobile}" /></td>
						<td class="tdError"><label class="errorClass" id="mbError">${errors.mb }</label>
						</td>
					</tr>

					<tr>
						<td class="tdText" style="color: #000">简介：</td>
						<td class="tdInput"><textarea class="inputClass form-control"
								rows="3" name="detail" id="cn" value="${user.detail}"></textarea>
						</td>
						<td class="tdError"></td>
					</tr>

					<tr>
						<td class="tdText" style="color: #000"><span>更换头像：</span></td>
						<td>
							<div class="clphoto"style="margin-top:20px;">
								<input type="file" name="file" id="file" style="display:none;"
									onchange="javascript:setImagePreview();"> 
								<label for="file" class="filephoto">
									<img id="preview" src="<c:url value='/course/loadImage/${user.user_id}'/>"
									style="display: block; width: 100%; height: 100%;" name="face" />
								</label>
							</div></td>
						<td>
						</td>

					</tr>
					<tr>
						<td class="tdText" style="color: #000">验证码*：</td>
						<td><input class="inputClass form-control" type="text"
							name="verifyCode" id="verifyCode" value="${form.verifyCode }" />
						</td>
						<td><label class="errorClass" id="verifyCodeError">${errors.verifyCode}</label>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div id="divVerifyCode">
								<img id="imgVerifyCode" src="<c:url value='/user/verifyCode'/>" />
							</div>
						</td>
						<td><label><a href="javascript:_hyz()"
								style="color: #fff">换一张</a></label></td>
					</tr>
					<tr>
						<td></td>
						<td>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10"
									style="position: relative; left: 27px; top: 53px">
									<button type="submit" class="btn btn-default"style="outline:none;margin-left:-320px;margin-top:-10px;">提交更改</button>
									<a href="${pageContext.request.contextPath}/user/tomain/5"
										style="margin-left: 90px; margin-top: -10px; float: left;"><button
											type="button" class="btn btn-default"
											style="margin-left: 15px;outline:none;">返回首页</button></a>
								</div>
							</div>
						</td>
						<td><label></label></td>
					</tr>
				</table>
			</form>
			<!-- <div style="height:250px;"></div> -->
		</div>
	</div>
	<footer class="footer fl" style="bottom:-450px;">
	<div class="container"
		style="padding-left: 0px; padding-right: 0; margin-left: 90px;">
		<a class="tu" href="">太原工业学院</a>
		<ul class="footer-100">
			<li style="float: left;"><span>关于我们</span>
				<ul>
					<li><a href="">关于我们</a></li>
					<li><a href="">联系我们</a></li>
					<li><a href="">意见反馈</a></li>
					<li><a href="">学校云</a></li>
					<li><a href="">常见问题</a></li>
					<li><a href="">法律条款</a></li>
				</ul></li>
			<li style="float: left; margin-right: 40px;"><span>关注我们</span>
				<ul>
					<li style="float: left;"><a href=""><img
							src="${pageContext.request.contextPath}/img/wechat.png" /></a></li>
					<li style="float: left;"><a href=""><img
							src="${pageContext.request.contextPath}/img/sina.png" /></a></li>
				</ul></li>
			<li style="float: left;"><span>友情链接</span>
				<ul>
					<li><a href="">网易卡搭</a></li>
					<li><a href="">网易云课堂</a></li>
					<li><a href="">网易100分</a></li>
				</ul></li>
		</ul>
	</div>
	</footer>
	<script src="http://wow.techbrood.com/libs/jquery/jquery-1.11.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sketch.js/1.1/sketch.js"></script>
	<script src="${pageContext.request.contextPath}/js/reveal.js"></script>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/user/regist.js"></script>
<script src="http://wow.techbrood.com/libs/jquery/jquery-1.11.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sketch.js/1.1/sketch.js"></script>
<script src="${pageContext.request.contextPath}/js/reveal.js"></script>
</html>
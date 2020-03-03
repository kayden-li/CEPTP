<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="utf-8">
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
		<meta name="keywords" content="">
		<meta name="description" content="">
		<title>网校在线学习平台</title>
		<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
		<link href="${pageContext.request.contextPath}/css/reset.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		
		
		<script type="text/javascript">
		CONETXT_PATH = '${s.base}';
		</script>
	</head>

	<body>
		<div class="f-header">
			<div class="f-header-box clearfix">
				<!-- <a href="${s.base}"  class="logo" title="网校在线学习平台"></a>
				<nav class="header-nav">
					<a href="${s.base}" class="header-nav-item">首 页</a>
					<a href="${s.base}/course/list.html" class="header-nav-item">课 程</a>
					<a href="${s.base}/course/learn.html" class="header-nav-item">Java</a>
					<a href="${s.base}/user/home.html" class="header-nav-item">我的</a>
					<a href="${s.base}/loadRegeist.htmlhtml" target="_blank" class="header-nav-item">教师端</a>
					<a href="${s.base}/loadRegeist.htmlhtml" target="_blank" class="header-nav-item">运营</a>
				</nav> -->
				
				<nav class="header-nav" style="float:right">
					<a href="#myModal" class="header-nav-item"  data-toggle="modal" onclick="login();"  style="margin-right:0px;font-size:14px;">登录</a>
					<a href="#myModal" class="header-nav-item" data-toggle="modal" onclick="registe();"  style="margin-left:0px;font-size:14px;">注册</a>
			        <a href="#" class="header-nav-item"  style="margin-left:0px;font-size:14px;" id="userdetail">头像</a>
				</nav>
				
			</div>
		</div>

		<script type="text/javascript">
			function login(){
				$('#loginTitle').css('color','#337Ab7');
				$('#loginForm').show();
				$('#registeTitle').css('color','#000');
				$('#registeForm').hide();
			}
			function registe(){
				$('#loginTitle').css('color','#000');
				$('#loginForm').hide();
				$('#registeTitle').css('color','#337Ab7');
				$('#registeForm').show();
			}
			
			 $(function(){
				$("#userdetail").popover({
		            trigger:'manual',
		            placement : 'bottom',
		            html: 'true',
		            content : '<div style="width:300px;height:300px;"></div>',
		            animation: false
		        }).on("mouseenter", function () {
		            var _this = this;
		            $(this).popover("show");
		            $(this).siblings(".popover").on("mouseleave", function () {
		                $(_this).popover('hide');
		            });
		        }).on("mouseleave", function () {
		            var _this = this;
		            setTimeout(function () {
		                if (!$(".popover:hover").length) {
		                    $(_this).popover("hide")
		                }
		            }, 0);
		        }); 
				
				//菜单
				$(".category").popover({
		            trigger:'manual',
		            placement : 'right',
		            html: 'true',
		            content : '',
		            animation: false
		        }).on("mouseenter", function () {
		            var cid = $(this).attr('c-id');
		            $('#' + cid).show();
		            $('#' + cid).hover(function(){
		            	$('#' + cid).show();
		            },function(){
		            	$('#' + cid).hide();
					});
		        }).on("mouseleave", function () {
		            var cid = $(this).attr('c-id');
		            $('#' + cid).hide();
		        });
			}); 
		</script>

	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  style="position:fixed; top:30%;">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	        
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true" style="font-size:18px;">×</span>
	                </button>
	                <h4 class="modal-title"  id="loginTitle"  style="float: left; color: #337Ab7;cursor: pointer; " onclick="login();">登 录</h4>
	                <h4 class="modal-title"  id="registeTitle"  style="float: left;margin-left: 20px;cursor: pointer;" onclick="registe();">注 册</h4>
	                <div class="clearfix"></div>
	            </div>
	            
	            <div class="modal-body">
	               	<form id="loginForm" class="form-horizontal" style="padding: 0px 20px;" action="${pageContext.request.contextPath}/user/login" method="post" ">
	                      <div class="form-group">
	                          <input type="text" class="form-control"  id="username" name="loginname"  placeholder="用户名">
	                      </div>
	                      <div class="form-group help">
	                          <input type="password" class="form-control"  id="password" name="loginpass"  placeholder="密　码">
	                      </div>
	                      <div class="form-group">
	                          <label>
	                           <input type="checkbox" value="None" id="checkbox1" name="check">
	                           <span class="text" style="color: #787D82;font-size: 14px;">下次自动登录</span>
	                          </label>
	                      </div>
	                      
	                      
	                      	<div class="header-login-btn">
	                      		<button type="submit" id="submit"class="btn btn-default" >登录</button>
	                      	</div>
	                     
	                  </form>
	                  
	                   <form id="registeForm" class="form-horizontal" style="padding: 0px 20px;display: none;" action="<c:url value='/user/userSignUP'/>" method="post" enctype="multipart/form-data">
	                       <div class="form-group">
	                           <input type="text" class="form-control"  id="username" name="user_id"  placeholder="用户名">
	                       </div>
	                       <div class="form-group help">
	                           <input type="password" class="form-control"  id="password" name="password"  placeholder="密　码">
	                       </div>
	                       <div class="form-group">
	                           <input type="text" class="form-control"  id="username" name="class_name"  placeholder="班级">
	                       </div>
	                       <div class="form-group">
	                           <input type="text" class="form-control"  id="username" name="professional_title"  placeholder="职称">
	                       </div>
	                       <div class="form-group">
	                           <input type="text" class="form-control"  id="username" name="pro"  placeholder="专业">
	                       </div>
	                       <div class="form-group">
	                           <input type="text" class="form-control"  id="username" name="mobile"  placeholder="手机号">
	                       </div>
	                       <div class="header-login-btn">
	                      		<button type="submit" id="submit"class="btn btn-default" >注册</button>
	                      		<a href="${pageContext.request.contextPath}/user/tomain/5"><button type="button" class="btn btn-default" style="margin-left:50px;">返回首页</button></a>
	                      	</div>
	                   </form>
	                  
	            </div>
				
	        </div>
	    </div>
	</div>
</html>

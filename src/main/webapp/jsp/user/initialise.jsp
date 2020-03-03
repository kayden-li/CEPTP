<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
<title>初始化页面</title>
<style>
::-ms-browse, [type='file'] {
	padding: .4em;
	line-height: 24px;
	border: 1px solid #a0b3d6;
	background: #f0f3f9;
	color: #34538b;
}

zz

::-webkit-file-upload-button {
	padding: .4em;
	line-height: 30px;
	border: 1px solid #a0b3d6;
	background: #f0f3f9;
	color: #34538b;
}
</style>

</head>
<script type="text/javascript">
	$("#ModelTeacher").css("background-color", "#B2E0FF");
</script>
<body>
	<div style="border: 1px black solid;width:40%;height:130px;margin-left:40px;">
		<span style="margin-left:-110px;">用户信息录入<small>(请按照模板填写excell表格)</small></span>
		<form action="${pageContext.request.contextPath}/input/ImportXls"
			method="post" enctype="multipart/form-data" style="float:left;margin-left:50px;margin-top:55px;">
			<div class="form-group">
				<div class="col-sm-10" style="margin-top:35px;">
					<label for="inputEmail3" class="col-sm-2 control-label"><input
						type="file" name="filename" />
				</div>
				<label for="inputEmail3" class="col-sm-2 control-label" style="margin-left:-145px;"> <input
					type="submit" class="btn btn-success" value="导入用户信息"
					style="margin-left: -450%;" />
				</label>
			</div>
		</form>
		<div style="margin-top:35px;">
			<small style="margin-left:-110px;position:absolute;margin-top:40px;"><strong>请勿更改模板列，否则将无法上传</strong></small>
			<a href="${pageContext.request.contextPath}/jsp/resources/123.xls" download="123.xls">
				<div class="btn btn-success" style="float:left;">点击下载模板</div>
			</a>
		</div>
	</div>
</body>
</html>

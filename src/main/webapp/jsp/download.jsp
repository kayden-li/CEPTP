<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教师导出界面</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
 <div class="container">
    <div id="toolbar" class="btn-group">
    <div>
       <a id="export" class="btn btn-default" href="${pageContext.request.contextPath}/input/export">
            <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出教师全部信息
        </a>
        </div>
        <%--  <div>
       <a id="export" class="btn btn-default" href="${pageContext.request.contextPath}/input/export1">
            <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出教师信息
        </a>
        </div> --%>
         <div>
       <a id="export" class="btn btn-default" href="${pageContext.request.contextPath}/input/exports1">
            <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出学生全部信息
        </a>
        </div>
        <%--  <div>
       <a id="export" class="btn btn-default" href="${pageContext.request.contextPath}/input/export">
            <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出教师全部信息
        </a>
        </div> --%>
    </div>
    <table id="table">
    </table>
</div>
</body>
</html>
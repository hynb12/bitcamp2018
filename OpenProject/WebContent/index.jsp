<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>회원가입 페이지</title>
<!--	WebContent폴더 안 css폴더를 만들어 default.css 안에 style을 따로 부여	 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>css/default.css">
</head>
<body>
	<%@include file="menu.jsp"%>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	request.getSession().invalidate();
	response.sendRedirect("index.jsp");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
<style>
</style>
<link rel="stylesheet" href="css/default.css">
</head>
<body>

</body>
</html>

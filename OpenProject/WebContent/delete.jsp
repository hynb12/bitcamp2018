<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!-- import -->
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");
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
<%
	//List 객체 선언
	//지역변수 개념이다. 초기화 꼭 필요함
	List members = null;
	members = new ArrayList();

	members = (List) application.getAttribute("k1");
	members.remove(Integer.parseInt(request.getParameter("index")));

	application.setAttribute("k1", members);
	response.sendRedirect("memberList.jsp");
%>
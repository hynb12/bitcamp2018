<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- import -->
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");

	//List 객체 선언
	//지역변수 개념이다. 초기화 꼭 필요함
	List members = null;
	members = new ArrayList();

	members = (List) application.getAttribute("k1");

	application.setAttribute("k1", members);

	String id = request.getParameter("u_id");
	String pw = request.getParameter("u_pw");
	String name = request.getParameter("u_name");
	String s_index = request.getParameter("u_index");

	int index = Integer.parseInt(s_index);

	MemberInfo m = (MemberInfo) members.get(index);
	m.setUserId(id);
	m.setUserName(name);
	m.setUserPw(pw);

	System.out.println(index);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>revise2</title>
<style>
</style>

</head>
<body>

</body>
</html>
<%
	application.setAttribute("k1", members);
	response.sendRedirect("memberList.jsp");
%>
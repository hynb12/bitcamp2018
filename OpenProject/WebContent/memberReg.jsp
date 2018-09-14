<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- import -->
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");

	String userId = request.getParameter("userId");
	String password = request.getParameter("password");
	String userName = request.getParameter("userName");
	String photoFile = request.getParameter("photoFile");

	//MemberInfo 객체 선언
	MemberInfo member = null;
	member = new MemberInfo();
	member.setUserId(userId);
	member.setUserPw(password);
	member.setUserName(userName);
	member.setUserPhoto(photoFile);

	//List 객체 선언
	//지역변수 개념이다. 초기화 꼭 필요함
	List members = null;
	members = new ArrayList();

	//application에 있는지 확인
	if (application.getAttribute("k1") != null) {
		members = (List) application.getAttribute("k1");
	}

	members.add(member);
	application.setAttribute("k1", members);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberReg</title>
<style>
</style>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<%@include file="menu.jsp"%>
	<table>
		<tr>
			<th>아이디(이메일)</th>
			<td><%=userId%></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><%=password%></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><%=userName%></td>
		</tr>
	</table>
</body>
</html>

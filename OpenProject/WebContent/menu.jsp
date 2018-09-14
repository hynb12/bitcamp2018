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
<title>menu</title>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<!--index-->
	<h1>
		<a href="index.jsp" id="tt">OpenProject</a>
	</h1>

	<ul id="gnb">
		<li><a href="index.jsp">메인</a></li>
		<li><a href="memberRegForm.jsp">회원가입</a></li>

		<!-- 로그인 여부에 따라 표시가 바뀜 -->
		<%
			String lid = (String) request.getSession().getAttribute("userId");
			if (lid == null) {
		%>
		<li><a href="loginForm.jsp">로그인</a></li>
		<%
			} else {
		%>
		<li><a href="logout.jsp">로그아웃</a></li>
		<%
			}
		%>
		<li><a href="myPage.jsp">마이 페이지</a></li>
		<li><a href="memberList.jsp">회원 리스트</a></li>
	</ul>
	<!--index-->
</body>
</html>
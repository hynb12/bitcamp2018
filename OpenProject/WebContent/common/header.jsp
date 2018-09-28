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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/default.css">
</head>
<body>
	<!--index-->
	<h1>
		<a href="<%=request.getContextPath()%>/index.jsp" id="tt">OpenProject</a>
	</h1>

	<ul id="gnb">
		<li><a href="<%=request.getContextPath()%>/index.jsp">메인</a></li>
		<li><a href="<%=request.getContextPath()%>/memberRegForm.jsp">회원가입</a></li>

		<!-- 로그인 여부에 따라 표시가 바뀜 -->
		<%
			String lid = (String) request.getSession().getAttribute("userId");
			if (lid == null) {
		%>
		<li><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></li>
		<%
			} else {
		%>
		<li><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
		<%
			}
		%>
		<li><a href="<%=request.getContextPath()%>/mypage/myPage.jsp">마이 페이지</a></li>
		<li><a href="<%=request.getContextPath()%>/memberList.jsp">회원
				리스트</a></li>
	</ul>
	<!--index-->
</body>
</html>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String ch = "";
	String i_id = "";

	Cookie[] cookies = request.getCookies();

	if (cookies != null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("c_id")) {
				i_id = (String) cookies[i].getValue();
				ch = "checked";
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<style>
</style>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/default.css">

</head>
<body>
	<%@include file="common/header.jsp"%>
	<div>
		<h2>로그인</h2>
		<hr>
		<form action="<%=request.getContextPath()%>/login.jsp" method="post">
			<table>
				<tr>
					<th>아이디(이메일)</th>
					<td><input type="text" name="userId" value="<%=i_id%>"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="password"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center"><label for="chb"><input
							type="checkbox" name="chb" id="chb" <%=ch%> />아이디 저장하기</label><input
						type="submit" value="로그인" text-align="center"></td>
				</tr>
			</table>
			"
		</form>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberRegForm</title>
<style>
</style>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<%@include file="menu.jsp"%>
	<div>
		<h2>회원가입</h2>
		<hr>
		<!--request.getContextPath() : /firstWeb (프로젝트위치)	-->
		<form action="<%=request.getContextPath()%>/memberReg.jsp"
			method="post">
			<table>
				<tr>
					<th>아이디(이메일)</th>
					<td><input type="text" name="userId"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="password"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="userName"></td>
				</tr>
				<tr>
					<th>사진</th>
					<td><input type="file" name="photoFile"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center"><input
						type="submit" value="회원가입"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
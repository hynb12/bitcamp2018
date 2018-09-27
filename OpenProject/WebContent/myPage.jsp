<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = (String) request.getSession(false).getAttribute("userId");
	String pw = (String) request.getSession(false).getAttribute("password");
	String name = "";

	if (id == null) {
%>
<script>
	alert("로그인 후 사용가능합니다.");
	location.href = 'loginForm.jsp';
</script>
<%
	} else {

		//List 객체 선언
		//지역변수 개념이다. 초기화 꼭 필요함
		List members = new ArrayList();

		members = (List) application.getAttribute("k1");

		for (int i = 0; i < members.size(); i++) {
			//메서드 사용하기위해 형변환
			MemberInfo m = (MemberInfo) members.get(i);

			if (id.equals(m.getUserId()) && pw.equals(m.getUserPw())) {

				name = m.getUserName();

				break;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>news</title>

<link rel="stylesheet" href="css/default.css">
<style>
#memberPhoto {
	background-image: url('images/image.jpg');
	background-size: 100%;
	width: 150px;
	height: 150px;
	border: 1px solid #333333;
	border-radius: 75px;
	margin: 20px 0;
}
</style>
</head>

<body>
	<%@include file="menu.jsp"%>
	<div id="contents">
		<h2>회원 정보</h2>
		<div id="memberPhoto"></div>
		<hr>
		<table>
			<tr>
				<th>아이디(이메일)</th>
				<td><%=id%></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><%=pw%></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=name%></td>
			</tr>
		</table>
	</div>
</body>
</html>
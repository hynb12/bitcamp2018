<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="javax.servlet.http.Cookie"%>
<!-- import -->
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");
	//로그인 아이디,비밀번호 받기
	String id = request.getParameter("userId");
	String pw = request.getParameter("password");

	//application에 있는지 확인
	if (application.getAttribute("k1") == null) {
		response.sendRedirect("index.jsp");
	}

	//아이디 저장하기 - 선언
	String chb = "";
	chb = request.getParameter("chb");

	Cookie cookie = new Cookie("c_id", "");

	//List 객체 선언
	List members = new ArrayList();

	members = (List) application.getAttribute("k1");

	if (id != null && pw != null && members != null) {

		for (int i = 0; i < members.size(); i++) {
			//메서드 사용하기위해 형변환
			MemberInfo m = (MemberInfo) members.get(i);
			if (id.equals(m.getUserId()) && pw.equals(m.getUserPw())) {

				//기존 세션 정보를 덮어씀
				request.getSession().setAttribute("userId", id);

				//비밀 번호
				request.getSession().setAttribute("password", pw);

				/* 	1. getSession(), getSession(true)
				 - HttpSession이 존재하면 현재 HttpSession을 반환하고
				 존재하지 않으면 새로이 세션을 생성합니다
				
				2. getSession(false)
				 - HttpSession이 존재하면 현재 HttpSession을 반환하고
				 존재하지 않으면 새로이 생성하지 않고 그냥 null을 반환합니다 */

				//아이디 저장 - 메서드
				if (chb != null) {
					cookie = new Cookie("c_id", id);
				} else {
					cookie.setMaxAge(0);
				}
				response.addCookie(cookie);

				//페이지를 다른곳으로 보냄
				response.sendRedirect("myPage.jsp");
			}
		}
	}
	//response.sendRedirect("myPage.jsp"); 가 실행되면 아래 문장들은 실행 되지 않음

	// 아이디 저장 - 쿠키제거
	cookie.setMaxAge(0);
	response.addCookie(cookie);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
</style>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<%@include file="menu.jsp"%>

	<div id="contents">
		<h2>로그인</h2>
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
		</table>
		<hr>
		<h1>아이디 또는 비밀번호가 틀립니다. 확인해주세요</h1>
		<h1>
			<a href="loginForm.jsp">다시로그인하기</a>
		</h1>

	</div>
</body>
</html>
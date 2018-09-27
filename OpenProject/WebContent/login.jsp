<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="javax.servlet.http.Cookie"%>
<!-- import -->
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");
	//로그인 아이디,비밀번호 받기
	String li_id = request.getParameter("userId");
	String li_pw = request.getParameter("password");

	//아이디 저장하기 - 선언
	String chb = "";
	chb = request.getParameter("chb");

	Cookie cookie = new Cookie("c_id", "");

	//1. 데이터베이스 드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1111"; */

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	try {
		// 2. 커넥션 객체 생성
		/* conn = DriverManager.getConnection(url, user, pw); */
		conn = DriverManager.getConnection(jdbcUrl);

		//3. Statement 객체 생성
		stmt = conn.createStatement();

		String list_sql = "select ID, PW from TT where id='" + li_id + "'";
		//스트링타입의 경우 작은따옴표 앞뒤로 써주어야 한다.

		// 4. 쿼리 실행
		rs = stmt.executeQuery(list_sql);

		String id = "";
		String pw = "";
		// 실행할 쿼리문 뒤로 실행문을 넣어준다.

		if (rs.next()) {
			id = rs.getString("id");
			pw = rs.getString("pw");
		}

		if (li_id != null && li_pw != null) {

			if (li_id.equals(rs.getString("id")) && li_pw.equals(rs.getString("pw"))) {

				//기존 세션 정보를 덮어씀
				request.getSession().setAttribute("userId", li_id);

				//비밀 번호
				request.getSession().setAttribute("password", li_pw);

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
				response.sendRedirect("mypage/myPage.jsp");
			}
		}

		// 아이디 저장 - 쿠키제거
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	} catch (Exception e) {
		e.printStackTrace();

	} finally {
		stmt.close();
		conn.close();
	}
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
				<td><%=li_id%></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><%=li_pw%></td>
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
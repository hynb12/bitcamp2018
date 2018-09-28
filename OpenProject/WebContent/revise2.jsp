<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- import -->
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");

	int idx = Integer.parseInt(request.getParameter("idx"));
	String userId = request.getParameter("userId");
	String password = request.getParameter("password");
	String userName = request.getParameter("userName");

	//1. 데이터베이스 드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	PreparedStatement pstmt = null;
	int resultCnt = 0;

	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1111"; */

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	try {
		// 2. 커넥션 객체 생성
		/* conn = DriverManager.getConnection(url, user, pw); */
		conn = DriverManager.getConnection(jdbcUrl);

		String sql = "update TT set pw = ?, name = ? where idx = ?";

		// 3. PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, password);
		pstmt.setString(2, userName);
		pstmt.setInt(3, idx);

		// 4. 쿼리실행
		resultCnt = pstmt.executeUpdate();

	} catch (Exception e) {
		e.printStackTrace();

	} finally {
		pstmt.close();
		conn.close();
	}
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
	<%@ include file="common/header.jsp"%>


	<div id="contents">

		<h2>회원가입 수정</h2>

		<hr>
		<table>
			<tr>
				<td>아이디(이메일)</td>
				<td><%=userId%></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><%=password%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=userName%></td>
			</tr>
			<tr>
				<td>사진</td>
				<td></td>
			</tr>
		</table>



	</div>
</body>
</html>
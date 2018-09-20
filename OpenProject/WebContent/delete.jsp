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
	int mno = Integer.parseInt(request.getParameter("mno"));

	// 1. JDBC 드라이버 로딩
	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	PreparedStatement pstmt = null;
	int resultCnt = 0;

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	try {
		// 2. 커넥션 객체 생성
		/* conn = DriverManager.getConnection(url, user, pw); */
		conn = DriverManager.getConnection(jdbcUrl);

		// 3. PreparedStatement 객체 생성
		String sql = "DELETE FROM TT WHERE mno = ? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, mno);

		resultCnt = pstmt.executeUpdate();
	} finally {
		pstmt.close();
		conn.close();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
<style>
</style>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<%
		if (resultCnt > 0) {
	%>삭제완료
	<%
		} else {
	%>
	삭제실패

	<%
		}
	%>
	<br />
	<a href="memberList.jsp"">돌아가기</a>
</body>
</html>
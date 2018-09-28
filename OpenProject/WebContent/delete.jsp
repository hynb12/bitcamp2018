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
	int indexNo = -1;
	String idx = request.getParameter("idx");

	if (idx != null) {
		indexNo = Integer.parseInt(idx);
	}
	if (indexNo < 0) {
%>
<script>
	alert('부적절한 인덱스값이 전달되었습니다.\n이전페이지로 돌아갑니다.');
	history.go(-1);
</script>
<%
	}
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
		String sql = "DELETE FROM TT WHERE idx = ? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, idx);

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
<title>Logout</title>
<style>
</style>
</head>
<body>
	<%
		if (resultCnt > 0) {
	%>삭제완료<%
		} else {
	%>삭제실패<%
		}
	%>
	<br>
	<a href="memberList.jsp">돌아가기</a>
</body>
</html>
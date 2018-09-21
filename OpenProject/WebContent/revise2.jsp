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
	int mno = Integer.parseInt(request.getParameter("u_num"));
	String id = (String) request.getParameter("u_id");
	String pw = (String) request.getParameter("u_pw");
	String name = (String) request.getParameter("u_name");
	String pic = (String) request.getParameter("u_pic");

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

		String sql = "update TT set id = ?, pw = ?, name = ?, pic = ? where mno = ?";

		// 3. PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setString(4, pic);
		pstmt.setInt(5, mno);

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
	<%
		if (resultCnt > 0) {
	%>수정완료<%
		} else {
	%>
	수정실패
	<%
		}
	%>
	<br>
	<a href="memberList.jsp">돌아가기</a>
</body>
</html>
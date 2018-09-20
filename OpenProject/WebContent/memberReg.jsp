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

	int mno = Integer.parseInt(request.getParameter("userno"));
	String id = request.getParameter("userId");
	String pw = request.getParameter("password");
	String name = request.getParameter("userName");
	String pic = request.getParameter("photoFile");

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

		String sql = "insert into TT(mno,id,pw,name,pic) values (?,?,?,?,?)";

		// 3. PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, mno);
		pstmt.setString(2, id);
		pstmt.setString(3, pw);
		pstmt.setString(4, name);
		pstmt.setString(5, pic);

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
<title>memberReg</title>
<style>
</style>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<%@include file="menu.jsp"%>
	<%
		if (resultCnt > 0) {
	%>추가완료
	<%
		} else {
	%>
	추가실패
	<%
		}
	%>
	<br />
	<a href="memberList.jsp">돌아가기</a>
</body>
</html>

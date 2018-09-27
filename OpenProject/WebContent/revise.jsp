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

	//1. 데이터베이스 드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1111"; */

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	//2. 커넥션 객체 생성
	conn = DriverManager.getConnection(jdbcUrl);

	//3. Statement 객체 생성
	stmt = conn.createStatement();

	String list_sql = "select * from TT where mno=" + mno;
	//스트링타입의 경우 작은따옴표 앞뒤로 써주어야 한다.

	// 4. 쿼리 실행
	rs = stmt.executeQuery(list_sql);
	// 실행할 쿼리문 뒤로 실행문을 넣어준다.
	String id = "";
	String pw = "";
	String name = "";
	String pic = "";

	if (rs.next()) {
		id = rs.getString("id");
		pw = rs.getString("pw");
		name = rs.getString("name");
		pic = rs.getString("pic");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<style>
</style>
<link rel="stylesheet" href="<%=request.getContextPath()%>css/default.css">
</head>
<body>
	<form action="<%=request.getContextPath()%>/revise2.jsp" method="post">
		<div id="rezone">
			<div>
				<p>회원번호</p>
				<input type="text" name="u_num" value="<%=rs.getInt("mno")%>"
					readonly />
			</div>
			<div>
				<p>아이디(이메일)</p>
				<input type="text" name="u_id" value="<%=rs.getString("id")%>" />
			</div>
			<div>
				<p>비밀번호</p>
				<input type="text" name="u_pw" value="<%=rs.getString("pw")%>" />
			</div>
			<div>
				<p>이름</p>
				<input type="text" name="u_name" value="<%=rs.getString("name")%>" />
			</div>
			<div>
				<p>이름</p>
				<input type="text" name="u_pic" value="<%=rs.getString("pic")%>" />
			</div>
			<div>
				<input type="reset" value="취소" name="cancel">
				<input type="submit" value="수정" name="revise">
			</div>
		</div>
	</form>
</body>
</html>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
%>
<%
	// 1. 데이터베이스 드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1111"; */

	List<MemberInfo> members = new ArrayList<MemberInfo>();

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";

	try {
		// 2. 커넥션 객체 생성
		/* conn = DriverManager.getConnection(url, user, pw); */
		conn = DriverManager.getConnection(jdbcUrl);

		// 3. Statement 객체 생성
		stmt = conn.createStatement();

		String list_sql = "select * from TT";

		// 4. 쿼리 실행
		rs = stmt.executeQuery(list_sql);

		while (rs.next()) {
			MemberInfo memberInfo = new MemberInfo();
			memberInfo.setIdx(rs.getInt("idx"));
			memberInfo.setUserId(rs.getString("id"));
			memberInfo.setUserPw(rs.getString("pw"));
			memberInfo.setUserName(rs.getString("name"));
			memberInfo.setUserPhoto(rs.getString("pic"));

			members.add(memberInfo);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		rs.close();
		stmt.close();
		conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<style>
td, th {
	margin: 0px;
	padding: 0px;
	border: 1px solid black;
}
</style>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/default.css">
</head>
<body>
	<%@include file="menu.jsp"%>
	<form action="">

		<!--     메인    -->
		<div id="header">Member Manager</div>
		<div id="warp">
			<div id="list">
				<div id="sub_title">회원리스트</div>
				<table>
					<tbody id="tt">
						<tr>
							<th>아이디</th>
							<th>비밀번호</th>
							<th>이름</th>
							<th>사진</th>
							<th>관리</th>
						</tr>
						<%
							for (int i = 0; i < members.size(); i++) {
								MemberInfo member = members.get(i);
						%>
						<tr>
							<td><%=member.getUserId()%></td>
							<td><%=member.getUserPw()%></td>
							<td><%=member.getUserName()%></td>
							<td><%=member.getUserPhoto()%></td>
							<td><a href="revise.jsp?idx=<%=member.getIdx()%>">수정</a> <a
								href="delete.jsp?idx=<%=member.getIdx()%>">삭제</a></td>
						</tr>
						<%
							}
						%>
					
				</table>

			</div>
		</div>

	</form>
</body>
</html>


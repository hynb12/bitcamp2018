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
	href="<%=request.getContextPath()%>css/default.css">
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
							<th>회원번호</th>
							<th>아이디</th>
							<th>비밀번호</th>
							<th>이름</th>
							<th>사진</th>
							<th>관리</th>
						</tr>
						<%
							// 1. 데이터베이스 드라이버 로드
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

								// 3. Statement 객체 생성
								stmt = conn.createStatement();

								String list_sql = "select * from TT order by mno";

								// 4. 쿼리 실행
								rs = stmt.executeQuery(list_sql);

								if (rs.next()) {
									do {
						%>
						<tr>
							<th><%=rs.getInt("MNO")%></th>
							<th><%=rs.getString("ID")%></th>
							<th><%=rs.getString("PW")%></th>
							<th><%=rs.getString("NAME")%></th>
							<th><%=rs.getString("PIC")%></th>
							<th><a
								href="<%=request.getContextPath()%>/revise.jsp?mno=<%=rs.getInt("MNO")%>"
								name="mno">수정</a> <a
								href="<%=request.getContextPath()%>/delete.jsp?mno=<%=rs.getInt("MNO")%>"
								name="mno">삭제</a></th>
						</tr>
						<%
							} while (rs.next());
								} else {
						%>
						<tr>
							<td colspan="6">등록된 사원정보가 없습니다.</td>
						</tr>
						<%
							}
							} finally {
								if (rs != null) {
									try {
										rs.close();
									} catch (SQLException se) {
										se.printStackTrace();
									}
								}
								if (stmt != null) {
									try {
										stmt.close();
									} catch (SQLException se) {
										se.printStackTrace();
									}
								}
								if (conn != null) {
									try {
										conn.close();
									} catch (SQLException se) {
										se.printStackTrace();
									}
								}
							}
						%>
					
				</table>

			</div>
		</div>

	</form>
</body>
</html>


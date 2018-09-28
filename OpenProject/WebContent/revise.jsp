<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
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
	
	MemberInfo memberInfo = new MemberInfo();

	//1. 데이터베이스 드라이버 로드
	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	/* String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "scott";
	String pw = "1111"; */

	String jdbcUrl = "jdbc:apache:commons:dbcp:open";
	try {
		//2. 커넥션 객체 생성
		conn = DriverManager.getConnection(jdbcUrl);

		String list_sql = "select * from TT where idx=?";
		//스트링타입의 경우 작은따옴표 앞뒤로 써주어야 한다.

		//3. PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(list_sql);
		pstmt.setInt(1, indexNo);

		// 4. 쿼리 실행
		rs = pstmt.executeQuery();

		// 실행할 쿼리문 뒤로 실행문을 넣어준다.
		if (rs.next()) {

			memberInfo = new MemberInfo();
			memberInfo.setIdx(rs.getInt("idx"));
			memberInfo.setUserId(rs.getString("id"));
			memberInfo.setUserPw(rs.getString("pw"));
			memberInfo.setUserName(rs.getString("name"));
			memberInfo.setUserPhoto(rs.getString("pic"));
		}
	} catch (Exception e) {
		e.printStackTrace();

	} finally {
		conn.close();
		pstmt.close();
		rs.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<style>
</style>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/default.css">
</head>
<body>
	<form action="<%=request.getContextPath()%>/revise2.jsp" method="post">
		<div id="rezone">
			<input type="hidden" name="idx"
				value="<%=request.getParameter("idx")%>">
			<div>
				<p>아이디(이메일)</p>
				<input type="text" name="userId" value="<%=memberInfo.getUserId()%>">
			</div>
			<div>
				<p>비밀번호</p>
				<input type="password" name="password"
					value="<%=memberInfo.getUserPw()%>">
			</div>
			<div>
				<p>이름</p>
				<input type="text" name="userName"
					value="<%=memberInfo.getUserName()%>">
			</div>
			<div>
				<p>회원사진</p>
				<input type="file" name="photoFile">
			</div>
			<div>
				<input type="reset" value="취소" name="cancel"> <input
					type="submit" value="수정" name="revise">
			</div>
		</div>
	</form>
</body>
</html>
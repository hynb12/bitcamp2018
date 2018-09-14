<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<link rel="stylesheet" href="css/default.css">
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
							<th>index</th>
							<th>아이디</th>
							<th>비밀번호</th>
							<th>이름</th>
							<th>사진</th>
							<th>관리</th>
						</tr>
						<%
							//List 객체 선언
							List members = new ArrayList();

							//application에 있는지 확인
							if (application.getAttribute("k1") != null) {
								members = (List) application.getAttribute("k1");

								for (int i = 0; i < members.size(); i++) {
									//메서드 사용하기위해 형변환
									MemberInfo m = (MemberInfo) members.get(i);
						%>
						<tr>
							<th><%=i + 1%></th>
							<th><%=m.getUserId()%></th>
							<th><%=m.getUserPw()%></th>
							<th><%=m.getUserName()%></th>
							<th><%=m.getUserPhoto()%></th>
							<th><a
								href="<%=request.getContextPath()%>/revise.jsp?index=<%=i%>"
								name="index">수정</a> <a
								href="<%=request.getContextPath()%>/delete.jsp?index=<%=i%>"
								name="index">삭제</a></th>
						</tr>
						<%
							}
							}
						%>
					</tbody>
				</table>

			</div>
		</div>

	</form>
</body>
</html>


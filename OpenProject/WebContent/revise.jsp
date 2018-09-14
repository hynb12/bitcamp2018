<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- import -->
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");
	int index = Integer.parseInt(request.getParameter("index"));

	//List 객체 선언
	//지역변수 개념이다. 초기화 꼭 필요함
	List members = null;
	members = new ArrayList();

	members = (List) application.getAttribute("k1");

	//메서드 사용하기위해 형변환
	MemberInfo m = (MemberInfo) members.get(index);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<style>
</style>
<link rel="stylesheet" href="css/default.css">
</head>
<body>
	<form action="<%=request.getContextPath()%>/revise2.jsp" method="post">
		<div id="rezone">
			<div>
				<p>아이디(이메일)</p>
				<input type="text" name="u_id" value="<%=m.getUserId()%>" />
			</div>
			<div>
				<p>비밀번호</p>
				<input type="text" name="u_pw" value="<%=m.getUserPw()%>" />
			</div>
			<div>
				<p>이름</p>
				<input type="text" name="u_name" value="<%=m.getUserName()%>" />
			</div>
			<div>
				<p>이름</p>
				<input type="hidden" name="u_index" value="<%=index%>" />
			</div>
			<div>
				<input type="reset" value="취소" name="cancel"> <input
					type="submit" value="수정" name="revise">
			</div>
		</div>
	</form>
</body>
</html>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="member.MemberInfo"%>
<%
	request.setCharacterEncoding("utf-8");

	String loid = (String) request.getSession(false).getAttribute("userId");
	String lopw = (String) request.getSession(false).getAttribute("password");

	String id = "";
	String pw = "";
	String name = "";
	// 실행할 쿼리문 뒤로 실행문을 넣어준다.

	if (loid == null) {

	} else {
		//1. 데이터베이스 드라이버 로드
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

			//3. Statement 객체 생성
			stmt = conn.createStatement();

			String list_sql = "select ID, PW, NAME from TT where id='" + loid + "'";
			//스트링타입의 경우 작은따옴표 앞뒤로 써주어야 한다.

			// 4. 쿼리 실행
			rs = stmt.executeQuery(list_sql);

			if (rs.next()) {
				id = rs.getString("id");
				pw = rs.getString("pw");
				name = rs.getString("name");
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			stmt.close();
			conn.close();
		}
	}

	//파일업로드
	// 1. multipart/form-data 여부 확인
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {// 2. 메모리나 파일로 업로드 파일 보관하는 FileItem의 Factory 설정
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 3. 업로드 요청을 처리하는 ServletFileUpload 생성
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 4. 업로드 요청 파싱해서 FileItem 목록 구함
		List<FileItem> items = upload.parseRequest(request);
		Iterator<FileItem> iter = items.iterator();
		while (iter.hasNext()) {
			FileItem item = iter.next();
			// 5. FileItem이 폼 입력 항목인지 여부에 따라 알맞은 처리
			if (item.isFormField()) { // 텍스트 입력인 경우
				String fName = item.getFieldName();
				String value = item.getString("euc-kr");
			} else { // 파일 업로드인 경우
				String fName = item.getFieldName();
				String fileName = item.getName();
				String contentType = item.getContentType();
				boolean isInMemory = item.isInMemory();
				long fileSize = item.getSize();

				String uploadURI = "/file";
				String dir = request.getSession().getServletContext().getRealPath(uploadURI);
				item.write(new File(dir, fileName));

				request.setAttribute("fileName", fileName);
				fileName = fName + " : " + contentType + " : " + fileSize;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>news</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/default.css">
<style>
#memberPhoto {
	background-image: url('images/image.jpg');
	background-size: 100%;
	width: 150px;
	height: 150px;
	border: 1px solid #333333;
	border-radius: 75px;
	margin: 20px 0;
}
</style>
</head>

<body>
	<%@include file="../menu.jsp"%>
	<div id="contents">
		<h2>회원 정보</h2>
		<div id="memberPhoto"></div>
		<hr>
		<table>
			<tr>
				<th>아이디(이메일)</th>
				<td><%=id%></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><%=pw%></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=name%></td>
			</tr>
			<tr>
				<th>사진</th>
				<td><img alt="이미지 없음"
					src="<%=request.getContextPath()%>/file/${fileName}"></td>
			</tr>
		</table>
	</div>
</body>
</html>
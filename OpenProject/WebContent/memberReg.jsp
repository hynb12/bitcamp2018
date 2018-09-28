<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
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

	//객체 생성
	MemberInfo memberInfo = new MemberInfo();

	//---------------------------------------------------------

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

				if (item.getFieldName().equals("userId")) {
					memberInfo.setUserId(item.getString("utf-8"));
				}
				if (item.getFieldName().equals("password")) {
					memberInfo.setUserPw(item.getString("utf-8"));
				}
				if (item.getFieldName().equals("userName")) {
					memberInfo.setUserName(item.getString("utf-8"));
				}

			} else { // 파일 업로드인 경우
				if (item.getFieldName().equals("photoFile") && item.getSize() > 0 && item.getName() != null
						&& item.getName().length() > 0) {

					// 저장하기위한 파일의 새로운 이름 생성
					String newFileName = "";
					String fileName = item.getName();
					newFileName = System.currentTimeMillis() + "_" + fileName;

					String uploadUri = "/uploadfile";
					String dir = request.getSession().getServletContext().getRealPath(uploadUri);

					File file = new File(dir, newFileName);

					// 물리적인 저장
					item.write(file);

					memberInfo.setUserPhoto(newFileName);
				}

			}
		}
	}

	//---------------------------------------------------------

	// 데이터베이스 입력 처리
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

		String sql = "insert into TT(idx,id,pw,name,pic) values (seq_member.nextval,?,?,?,?)";

		// 3. PreparedStatement 객체 생성
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberInfo.getUserId());
		pstmt.setString(2, memberInfo.getUserPw());
		pstmt.setString(3, memberInfo.getUserName());
		pstmt.setString(4, memberInfo.getUserPhoto());

		// 4. 쿼리실행
		resultCnt = pstmt.executeUpdate();

	} catch (Exception e) {
		e.printStackTrace();

	} finally {
		pstmt.close();
		conn.close();
		System.out.println(resultCnt);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberReg</title>
<style>
</style>
</head>
<body>
	<%@include file="common/header.jsp"%>
	<table>
		<tr>
			<th>아이디(이메일)</th>
			<td><%=memberInfo.getUserId()%></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><%=memberInfo.getUserPw()%></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><%=memberInfo.getUserName()%></td>
		</tr>
		<tr>
			<th>사진</th>
			<td><img alt="회원사진"
				src="<%=request.getContextPath() + "/uploadfile/" + memberInfo.getUserPhoto()%>"></td>
		</tr>
	</table>
	<a href="memberList.jsp">돌아가기</a>
</body>
</html>

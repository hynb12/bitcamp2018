<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
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
<title>Insert title here</title>
</head>
<body>
	<img alt="이미지" src="<%=request.getContextPath()%>/file/${fileName}">
</body>
</html>
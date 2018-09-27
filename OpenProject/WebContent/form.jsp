<%--
  Created by IntelliJ IDEA.
  User: JChan
  Date: 2018-09-27
  Time: 오후 4:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Title</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<form action="upload.jsp" method="post" enctype="multipart/form-data">
		학번 : <input type="text" name="sno"><br> 파일 : <input
			type="file" name="file"><br> <input type="submit"
			value="등록">


	</form>
</body>
</html>
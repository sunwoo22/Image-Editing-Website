<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- DB와 연결 -->
<%@ include file="dbconnect.jsp" %> 

<% 
	String user_id = (String)session.getAttribute("user_id");

	ResultSet rs = null;
	Statement stmt = conn.createStatement(); // 쿼리 명령문
	
	String sql = "UPDATE user SET image_num = image_num + 1 ";
	sql += "WHERE user_id = '" + user_id + "';";
	out.println(sql);
	
	stmt.executeUpdate(sql);
	
	sql = "SELECT image_num FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";
	
	// out.println(sql);
	
	rs = stmt.executeQuery(sql);
	String image_num = "0";
	
	while(rs.next())
		image_num = rs.getString("image_num");
	
	session.setAttribute("image_num", image_num);
	
	String filename = user_id + "_out (" + String.valueOf(image_num) + ").png";
	
	%> <script>
	alert("저장되었습니다.");
	history.go(-1);
	</script> <%
	
	//out.println("<a href='http://localhost:8080/jsp_project/download.jsp?file=" + filename + "'> 다운로드 </a>");
	
%>

</body>
</html>
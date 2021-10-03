<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	//JSP와 DB를 연결하는 교량
	Connection conn = null; 
	
	String url = "jdbc:mysql://localhost:3306/project_db"; // localhost = 127.0.0.1
	String user = "root";
	String pw = "1234";
	
	//jdbc 드라이버 로딩
	Class.forName("com.mysql.jdbc.Driver");
	
	// dbms 서버 접속
	conn = DriverManager.getConnection(url, user, pw);
	
	
%>
</body>
</html>
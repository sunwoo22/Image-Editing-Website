<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.imageio.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- DB와 연결 -->
<%@ include file="dbconnect.jsp"%>

<%
	String user_id = request.getParameter("user_id");	

	Pattern p = Pattern.compile("(^[a-zA-Z0-9]*$)");
	Matcher m_id = p.matcher(user_id);

	ResultSet rs = null;
	Statement stmt = conn.createStatement(); // 쿼리 명령문

	String sql = "SELECT user_id FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";

	// out.println(sql);

	rs = stmt.executeQuery(sql);
	if(!m_id.find()) {
		%> <script>
		window.alert("아이디는 영어, 숫자만 입력가능합니다.");
		history.go(-1);
		</script> <%			
	} else if(rs.next()) {
		%> <script>
		window.alert("이미 사용 중인 아이디입니다.");
		history.go(-1);
		</script> <%  
	} else {
		%> <script>
		window.alert("사용 가능한 아이디입니다.");
		history.go(-1);
		</script> <%	
	}
		
	stmt.close();
	conn.close();
	
%>
</body>
</html>
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
<!-- DB�� ���� -->
<%@ include file="dbconnect.jsp"%>

<%
	String user_id = request.getParameter("user_id");	

	Pattern p = Pattern.compile("(^[a-zA-Z0-9]*$)");
	Matcher m_id = p.matcher(user_id);

	ResultSet rs = null;
	Statement stmt = conn.createStatement(); // ���� ��ɹ�

	String sql = "SELECT user_id FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";

	// out.println(sql);

	rs = stmt.executeQuery(sql);
	if(!m_id.find()) {
		%> <script>
		window.alert("���̵�� ����, ���ڸ� �Է°����մϴ�.");
		history.go(-1);
		</script> <%			
	} else if(rs.next()) {
		%> <script>
		window.alert("�̹� ��� ���� ���̵��Դϴ�.");
		history.go(-1);
		</script> <%  
	} else {
		%> <script>
		window.alert("��� ������ ���̵��Դϴ�.");
		history.go(-1);
		</script> <%	
	}
		
	stmt.close();
	conn.close();
	
%>
</body>
</html>
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
	String user_id = (String)session.getAttribute("user_id");
	String user_pw_org = request.getParameter("user_pw_org");
	String user_pw = request.getParameter("user_pw");
	String user_pw_ck = request.getParameter("user_pw_ck");

	Pattern p = Pattern.compile("(^[a-zA-Z0-9]*$)");
	Matcher m_pw = p.matcher(user_pw);

	ResultSet rs = null;
	Statement stmt = conn.createStatement(); // ���� ���ɹ�

	String sql = "SELECT user_pw FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";
	
	rs = stmt.executeQuery(sql);
	
	String user_pw_org2 = "";
	
	while(rs.next())
		user_pw_org2 = rs.getString("user_pw");
	
	if(user_pw_org == "") {
		%> <script>
		alert("���� ��й�ȣ�� �Է����ּ���.");
		history.go(-1); 
		</script> <%
	} else if(user_pw == "") {
		%> <script>
		alert("������ ��й�ȣ�� �Է����ּ���.");
		history.go(-1); 
		</script> <%
	} else if(!user_pw_org.equals(user_pw_org2)) {
		%> <script>
		alert("���� ��й�ȣ�� ���� �ʽ��ϴ�.");
		history.go(-1); 
		</script> <%
	} else if(user_pw_org.equals(user_pw)) {
		%> <script>
		alert("���� ��й�ȣ�� ������ ��й�ȣ�� �����ϴ�.");
		history.go(-1); 
		</script> <%
		
	} else if(user_pw_ck == "") {
		%> <script>
		alert("������ ��й�ȣ�� �ٽ� Ȯ�����ּ���.");
		history.go(-1);
		</script> <%
	}
	else if(!user_pw.equals(user_pw_ck)) {
		%> <script>
		alert("������ ��й�ȣ�� �ٽ� Ȯ�����ּ���.");
		history.go(-1);
		</script> <% 	
	} else {
		sql = "UPDATE user ";
		sql += "SET user_pw = '" + user_pw + "' ";
		sql += "WHERE user_id = '" + user_id + "';"; 

		stmt.executeUpdate(sql);
	
		%><script>
		alert("����Ǿ����ϴ�.");
		window.location.href = 'mypage.jsp';
		</script><%
	}

	stmt.close();
	conn.close();
	
%>
</body>
</html>
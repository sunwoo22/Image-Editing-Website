<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<!-- DB�� ���� -->
<%@ include file="dbconnect.jsp" %> 

<%
	// client���� �޾ƿ� id pw
	String user_id = request.getParameter("user_id");
	String user_pw_input = request.getParameter("user_pw");
	
	// sql ������ ������ ���� statement ��ü ����
	ResultSet rs = null;
	Statement stmt = conn.createStatement();
	
	// sql ������
	String sql = "SELECT user_pw FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";
	
	// ������ ����
	rs = stmt.executeQuery(sql);
	
	// ���� ��� pw
	String user_pw = "";
	
	while(rs.next())
		user_pw = rs.getString("user_pw");
	
	if(user_id == "") {
		%><script>
		alert("���̵� �Է����ּ���.");
		history.go(-1); 
		</script><%
	} else if(user_pw_input == "") {
		%><script>
		alert("��й�ȣ�� �Է����ּ���.");
		history.go(-1); 
		</script><%
	} else if(user_pw_input.equals(user_pw)) {
		session.setAttribute("user_id", user_id);
		session.setAttribute("user_pw", user_pw_input);
		session.setAttribute("user_check", 1);
		%><script>
		alert("�α��� �Ǿ����ϴ�.");
		window.location.href = 'main-login.jsp';
		</script><%
	} else {
		%><script>
		alert("�������� ���� ���̵��̰ų�, �߸��� ��й�ȣ�Դϴ�.");
		history.go(-1); 
		</script><%
	}
	
	stmt.close();
	conn.close();

%>

</body>
</html>
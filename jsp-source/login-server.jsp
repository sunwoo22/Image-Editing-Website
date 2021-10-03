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
	// client에서 받아온 id pw
	String user_id = request.getParameter("user_id");
	String user_pw_input = request.getParameter("user_pw");
	
	// sql 쿼리문 전송을 위한 statement 객체 생성
	ResultSet rs = null;
	Statement stmt = conn.createStatement();
	
	// sql 쿼리문
	String sql = "SELECT user_pw FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";
	
	// 쿼리문 실행
	rs = stmt.executeQuery(sql);
	
	// 실행 결과 pw
	String user_pw = "";
	
	while(rs.next())
		user_pw = rs.getString("user_pw");
	
	if(user_id == "") {
		%><script>
		alert("아이디를 입력해주세요.");
		history.go(-1); 
		</script><%
	} else if(user_pw_input == "") {
		%><script>
		alert("비밀번호를 입력해주세요.");
		history.go(-1); 
		</script><%
	} else if(user_pw_input.equals(user_pw)) {
		session.setAttribute("user_id", user_id);
		session.setAttribute("user_pw", user_pw_input);
		session.setAttribute("user_check", 1);
		%><script>
		alert("로그인 되었습니다.");
		window.location.href = 'main-login.jsp';
		</script><%
	} else {
		%><script>
		alert("가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");
		history.go(-1); 
		</script><%
	}
	
	stmt.close();
	conn.close();

%>

</body>
</html>
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
	String user_pw = request.getParameter("user_pw");
	String user_pw_ck = request.getParameter("user_pw_ck");

	// ���ڿ� ���Խ� �˻�
	Pattern p = Pattern.compile("(^[a-zA-Z0-9]*$)");
	Matcher m_id = p.matcher(user_id);
	Matcher m_pw = p.matcher(user_pw);

	ResultSet rs = null;
	Statement stmt = conn.createStatement(); // ���� ��ɹ�

	String sql = "SELECT user_id FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";

	rs = stmt.executeQuery(sql);
	
	if(user_id == "") {
		%><script>
		alert("���̵� �Է����ּ���.");
		history.go(-1);
		</script><%
	} else if(!m_id.find()) {
		%><script>
		alert("���̵�� ����, ���ڸ� �Է°����մϴ�.");
		history.go(-1);
		</script><%			
	} else if(user_pw == "") {
		%><script>
		alert("��й�ȣ�� �Է����ּ���.");
		history.go(-1);
		</script><%
	} else if(user_pw_ck == "") {
		%><script>
		alert("��й�ȣ�� �ٽ� Ȯ�����ּ���.");
		history.go(-1);
		</script><%
	} else if(!user_pw.equals(user_pw_ck)) {
		%><script>
		alert("��й�ȣ�� �ٽ� Ȯ�����ּ���.");
		history.go(-1);
		</script><%
	} else if(!m_pw.find()) {
		%><script>
		alert("��й�ȣ�� ����, ���ڸ� �Է°����մϴ�.");
		history.go(-1);
		</script><%			
	} else if(user_id.equals(user_pw)) {
		%><script>
		alert("���̵�� ��й�ȣ�� �����ϴ�.");
		history.go(-1);
		</script><%	
	} else if(rs.next()) {
		%><script>
		alert("���̵� �ߺ� Ȯ���� ���ּ���.");
		history.go(-1);
		</script><%
	} else {
		sql = "INSERT INTO user VALUES (";
		sql += "'" + user_id + "', '" + user_pw + "', 0";
		sql += ");";

		stmt.executeUpdate(sql);
		
		session.setAttribute("user_id", user_id);
		session.setAttribute("image_num", 0);
		
		String defalutFname = "default.png";
		
		File inFp;
		FileInputStream inFs;
		inFp = new File("C:/eclipse-workspace/jsp_project/WebContent/upload/" + defalutFname);
		
		// Į�� �̹��� ó��
		BufferedImage cImage = ImageIO.read(inFp);
		int inW = cImage.getHeight();
		int inH = cImage.getWidth();
		// (2) JSP���� �迭 ó��
		int[][][] inImage = new int[3][inH][inW]; // �޸� �Ҵ�
		// ���� --> �޸�
		for (int i=0; i<inH; i++) 
			for (int k=0; k<inW; k++) {
				int rgb = cImage.getRGB(i,k);
				inImage[0][i][k] = (rgb >> 16) & 0xFF; // Red
				inImage[1][i][k] = (rgb >> 8) & 0xFF; // Green
				inImage[2][i][k] = (rgb ) & 0xFF; // Blue
			}
		
		int[][][] outImage = new int[3][inH][inW];
		for(int j=0; j<3; j++) 
			for (int i=0; i<inH; i++) 
				for (int k=0; k<inW; k++) 
					outImage[j][i][k] = inImage[j][i][k];
		
		// (4) ����� ���Ϸ� ����
		File outFp;
		FileOutputStream outFs;
		String joinFname = user_id + "_out.png";
		outFp = new File("C:/eclipse-workspace/jsp_project/WebContent/upload/" + joinFname);
		
		// Į�� �̹��� ����
		BufferedImage outCImage = new BufferedImage(inH, inW, BufferedImage.TYPE_INT_RGB);
		
		outFs = new FileOutputStream(outFp.getPath());
		// �޸� --> �����̹���
		for (int i=0; i<inH; i++) 
			for (int k=0; k<inW; k++) {
				int r = outImage[0][i][k];
				int g = outImage[1][i][k];
				int b = outImage[2][i][k];
				int px = 0;
				px = px | (r << 16);
				px = px | (g << 8);
				px = px | (b);		
				outCImage.setRGB(i,k,px);
			}
		
		ImageIO.write(outCImage, "png", outFp);
		
		%><script>
		alert("���ԵǾ����ϴ�.");
		window.location.href = 'login-client.jsp';
		</script><%
	}

	stmt.close();
	conn.close();
	
%>
</body>
</html>
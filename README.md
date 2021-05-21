# Image-Editing-Website-using-JSP
### JSP 기반의 이미지 편집 및 저장 웹사이트   
입니다.   
<br>
<hr>

## 🔥 프로젝트 개요
JSP를 통해 웹 브라우저와 서버, DB를 연결한 동적 웹페이지에 대해 공부했다.
앞서 배운 이미지 디지털 영상처리 알고리즘을 활용하여 이미지를 편집, 저장할 수 있는 웹사이트를 만들고자 했다.      
<br>
   
## 🛠 프로젝트 환경
✅ **사용 언어**: JSP / HTML5 / CSS3 / JAVASCRIPT   
✅ **개발 환경**: Eclipse / Visual Studio Code   
✅ **제작 기간**: 21.03.25 – 21.03.30   
✅ **JSP 환경 설정**: JDK 9.0.4 / Eclipse Java EE (Oxygen 2) / apache-tomcat-9.0.2   
✅ **데이터베이스**: MariaDB 10.5.9   
<br>
   
## 💻 화면 구성
💨 **main.jsp**: 로그인 전 메인 화면   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072215-17750280-ba26-11eb-9c9e-2bbdd6096982.png">
<br><br>
💨 **join-client.jsp**: 회원가입   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072234-1d6ae380-ba26-11eb-8b0f-cbb546b27d4e.png">
<br><br>
💨 **login-client.jsp**: 로그인   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072230-1c39b680-ba26-11eb-907e-6cbf03dcc9df.png">
<br><br>
💨 **main-login.jsp**: 로그인 후 메인 화면(이미지 선택)   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072289-307db380-ba26-11eb-8325-65ef0f2bc9c1.png">
<br><br>
💨 **photo-edit.jsp**: 이미지 편집 및 저장   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072238-1e9c1080-ba26-11eb-92df-97f5d971deed.png">
<br><br>
💨 **mypage.jsp**: 마이페이지(저장한 이미지 보기)   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072260-278ce200-ba26-11eb-9bf7-4ac5e8a20d8b.png">
<br><br>
💨 **changepw-client.jsp**: 비밀번호 변경   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072259-265bb500-ba26-11eb-93bd-2f199c60f4b4.png">
<br><br>
💨 **withdrawal-client.jsp**: 회원탈퇴   
<br>
<img src="https://user-images.githubusercontent.com/84164109/119072313-3a071b80-ba26-11eb-9fc5-2aa7ceb55bc6.png">
<br><br>

## 💾 서버 구성
💨 **join-server.jsp**: 회원가입(아이디 중복 확인)   
💨 **join-server2.jsp**: 회원가입   
💨 **login-server.jsp**: 로그인   
💨 **changepw-server.jsp**: 비밀번호 변경   
💨 **withdrawal-server.jsp**: 회원탈퇴   
💨 **photo-save.jsp**: 이미지 저장   
<br>
   
## 🎬 시연 영상
> https://youtu.be/DfDwhXcBNZY
<br>
<img src="https://user-images.githubusercontent.com/84164109/119073053-87d05380-ba27-11eb-9ff4-7c86ccabc28f.PNG">
<br>

## 💦 보완할 점
세션 사용법을 잘 몰라서 세션 스토리지를 사용했다...   
그래서 메인페이지가 두개가 되어버렸다.   
회원가입시 정보 추가   
마이페이지 이미지 가끔 오류나는 것 수정   
(eclipse refresh 오류인 듯)   
<br>
   
## 🍺 일기장
> https://mygummy2.tistory.com/45
<br>
   
## 💎 중요 코드
✔ **Maria DB 사용 및 테이블 생성**
```
C:\> mysql -u root -p
Enter pawwsord: 1234

MariaDB [(none)]> create project_db;
MariaDB [(none)]> use project_db;

MariaDB [project_db]> create table user(
                     user_id char(8) primary key,
                     user_pw char(8) not null,
                     image_num int(2) default 0
                     );
```
✔ **회원가입시 DB에 정보**
```JSP
<!-- DB와 연결 -->
<%@ include file="dbconnect.jsp"%>

<%
	// client에서 받아온 id, pw
   String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	String user_pw_ck = request.getParameter("user_pw_ck");

	// 문자열 정규식 검사
	Pattern p = Pattern.compile("(^[a-zA-Z0-9]*$)");
	Matcher m_id = p.matcher(user_id);
	Matcher m_pw = p.matcher(user_pw);

   // sql 쿼리문 전송을 위한 statement 객체 생성
	ResultSet rs = null;
	Statement stmt = conn.createStatement();

   // sql 쿼리문: 아이디 중복 체크
	String sql = "SELECT user_id FROM user ";
	sql += "WHERE user_id = '" + user_id + "';";

   // 쿼리문 실행
	rs = stmt.executeQuery(sql);
	
   // 회원가입 실패시 경고창 생성
	if(user_id == "") {
		%><script> alert("아이디를 입력해주세요."); history.go(-1); </script><%
	} else if(!m_id.find()) {
		%><script> alert("아이디는 영어, 숫자만 입력가능합니다."); history.go(-1); </script><%			
	} else if(user_pw == "") {
		%><script> alert("비밀번호를 입력해주세요."); history.go(-1); </script><%
	} else if(user_pw_ck == "") {
		%><script> alert("비밀번호를 다시 확인해주세요."); history.go(-1); </script><%
	} else if(!user_pw.equals(user_pw_ck)) {
		%><script> alert("비밀번호를 다시 확인해주세요."); history.go(-1); </script><%
	} else if(!m_pw.find()) {
		%><script> alert("비밀번호는 영어, 숫자만 입력가능합니다."); history.go(-1); </script><%			
	} else if(user_id.equals(user_pw)) {
		%><script> alert("아이디와 비밀번호가 같습니다."); history.go(-1); </script><%	
	} else if(rs.next()) {
		%><script> alert("아이디 중복 확인을 해주세요."); history.go(-1); </script><%
	} 
   
   // 회원가입 성공
   else {
      // sql 쿼리문: DB에 가입 정보 전달
		sql = "INSERT INTO user VALUES (";
		sql += "'" + user_id + "', '" + user_pw + "', 0";
		sql += ");";

		stmt.executeUpdate(sql);
		
      // 세션에 아이디 및 이미지 개수(0) 저장
		session.setAttribute("user_id", user_id);
		session.setAttribute("image_num", 0);
		
      // default 이미지 저장
		String defalutFname = "default.png";
		
      // (1) 파일 처리
		File inFp;
		FileInputStream inFs;
		inFp = new File("C:/eclipse-workspace/jsp_project/WebContent/upload/" + defalutFname);
		
		BufferedImage cImage = ImageIO.read(inFp);
		int inW = cImage.getHeight();
		int inH = cImage.getWidth();
      
		// (2) 배열 처리
		int[][][] inImage = new int[3][inH][inW]; // 메모리 할당
		// 파일 --> 메모리
		for (int i=0; i<inH; i++) 
			for (int k=0; k<inW; k++) {
				int rgb = cImage.getRGB(i,k);
				inImage[0][i][k] = (rgb >> 16) & 0xFF; // Red
				inImage[1][i][k] = (rgb >> 8) & 0xFF; // Green
				inImage[2][i][k] = (rgb ) & 0xFF; // Blue
			}
		
      // (3) 알고리즘 적용
		int[][][] outImage = new int[3][inH][inW];
		for(int j=0; j<3; j++) 
			for (int i=0; i<inH; i++) 
				for (int k=0; k<inW; k++) 
					outImage[j][i][k] = inImage[j][i][k];
		
		// (4) 파일 저장
		File outFp;
		FileOutputStream outFs;
		String joinFname = user_id + "_out.png";
		outFp = new File("C:/eclipse-workspace/jsp_project/WebContent/upload/" + joinFname);
		
		BufferedImage outCImage = new BufferedImage(inH, inW, BufferedImage.TYPE_INT_RGB);
		
		outFs = new FileOutputStream(outFp.getPath());
      
		// 메모리 --> 버퍼이미지
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
		
		%><script> alert("가입되었습니다.");
		window.location.href = 'login-client.jsp'; // 로그인 페이지로 이동
		</script><%
	}

	stmt.close();
	conn.close();
	
%>
```
✔ **마이페이지에 저장한 이미지 출력**
```java script
<script>
	function img_info(value) {
		// 세션 스토리지에 있던 사용자 user_id 받아옴
	    var user_id = sessionStorage.getItem("user_id");
		//var user_id = "aaaa";
		
		// 세션에 있던 사용자 image_num 받아옴(저장할 때마다 +1: 사용자가 저장한 이미지 총 개수)
		 var image_num = <%=session.getAttribute("image_num")%>;
	    //var max = 2;
	    
	    // 이미지 경로를 넣을 문자열 생성
	    var img_src = "";

	    // 출력될 사용자 이미지 number = 사용자 image_num - 이미지 순서value
        var num = image_num - value;
        if(num > 0) // 사용자가 저장한 이미지 출력
            img_src = 'upload/'+ user_id + '_out (' + num + ').png';
        else // 총 출력 이미지 개수인 8개보다 사용자가 저장한 이미지 개수가 적을 경우 default.png 출력
            img_src = 'upload/default.png';

        // 이미지 경로 반환
		return img_src;
	}

</script>
```
```html
<div class='img'>
   <img id='img0' class='img-in' src=''>
   <script>document.getElementById('img0').src=img_info(0)</script>
</div>

```


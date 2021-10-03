<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
  	@font-face {
        font-family: 'MapoFlowerIsland';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/MapoFlowerIslandA.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }
    @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
    .notosanskr * { 
        font-family: 'Noto Sans KR', sans-serif;
    }

    ._title {
        position: fixed;
        display: flex;
        top: 0;
        left: 50%;
        margin-left: -600px;
        width: 1200px;
        height: 100px;
        background-color: white;
        border-bottom: 2px solid #8C8C8C;
    } 
    .title-text {
        position: absolute;
        top: 0;
        left: 0;
        width: 1200px;
        height: 100px;
        text-align: center;
        line-height: 100px;
        font-family: 'MapoFlowerIsland';
        font-size: 40px;
        font-weight: bold;
    }
    .header-btn {
        position: absolute;
        display: grid;
        grid-template-columns: 100px 100px;
        top: 0;
        left: 1000px;
        margin-top: 30px;
    }
    
    ._content {
        position: absolute;
        top: 0;
        padding-top: 100px;
        left: 50%;
        margin-left: -600px;
        width: 1200px;
        height: 700px;
    }
    ._image {
        position: absolute;
        display: grid;
        grid-template-columns: 300px 300px 300px 300px;
     	grid-template-rows: 300px 300px;
     	top: 100px;
        left: 0;
        width: 100%;
        height: 700px;
    }

    .img {
        margin: 20px;
    }
    .img img {
        position: absolute;
        width: 260px;
        border: 1px solid #BDBDBD;
    }

    ._button {
        position: absolute;
        top: 700px;
        left: 0;
        width: 100%;
        height: 100px;
        border-top: 2px solid #BDBDBD;
    }

    a:hover, .btn:hover {
        cursor: pointer;
    }
    
    .btn {
        border-radius: 20px;
        width: 80px;
        height: 40px;
        text-align: center;
        border: 3px solid #BDBDBD;
        background-color: #EAEAEA;
        color: #5D5D5D;
        transition: 0.2s;
    }
    .btn:hover, .btn2:hover {
        border: 3px solid #BDBDBD;
        background-color: #BDBDBD;
        color: white;
    }
    .btn2 {
    	margin-top: 20px;
    	margin-right: 20px;
        border-radius: 30px;
        width: 150px;
        height: 60px;
        text-align: center;
        border: 3px solid #BDBDBD;
        background-color: #EAEAEA;
        color: #5D5D5D;
        transition: 0.2s;
    }

</style>
</head>

<body>

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
    
    <div class='_content'>
        <div class='_image'>
            <div class='img'>
                <img id='img0' class='img-in' src=''>
                <script>document.getElementById('img0').src=img_info(0)</script>
            </div>
            <div class='img'>
                <img id='img1' class='img-in' src=''>
                <script>document.getElementById('img1').src=img_info(1)</script>
            </div>
            <div class='img'>
                <img id='img2' class='img-in' src=''>
                <script>document.getElementById('img2').src=img_info(2)</script>
            </div>
            <div class='img'>
                <img id='img3' class='img-in' src=''>
                <script>document.getElementById('img3').src=img_info(3)</script>
            </div>
            <div class='img'>
                <img id='img4' class='img-in' src=''>
                <script>document.getElementById('img4').src=img_info(4)</script>
            </div>
            <div class='img'>
                <img id='img5' class='img-in' src=''>
                <script>document.getElementById('img5').src=img_info(5)</script>
            </div>
            <div class='img'>
                <img id='img6' class='img-in' src=''>
                <script>document.getElementById('img6').src=img_info(6)</script>
            </div>
            <div class='img'>
                <img id='img7' class='img-in' src=''>
                <script>document.getElementById('img7').src=img_info(7)</script>
            </div>
        </div>
        
        <div class='_button'>
            <input class='btn2' type='button' value="CHANGE PW" onclick='gochangepw()'>
            <input class='btn2' type='button' value="WITHDRAWAL" onclick='gowd()'>
        </div>
    </div>

	<div class='_title'>
	    <div class='title-text'>
	        MY PAGE
	    </div>
	    <div class='header-btn'>
	        <input class='btn' type='button' value='main' onclick='gomainlogin()'>
	        <input class='btn' type='button' value='logout' onclick='gomain()'>
	    </div>
	</div>


<script>

	function gowd() {
		window.location.href = 'withdrawal-client.jsp';
	}
	
	function gochangepw() {
		window.location.href = 'changepw-client.jsp';
	}
	
	function gomainlogin() {
		window.location.href = 'main-login.jsp';
	}
	
	function gomain() {
		alert("로그아웃 되었습니다.");
		window.location.href = 'main.jsp';
	}

    function imgSrc() {
        var user_id = sessionStorage("user_id");
        var filename = user_id ;
    }

</script>
</body>
</html>
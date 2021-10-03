<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    ._image {
        position: absolute;
        display: grid;
        grid-template-columns: 400px 400px 400px;
     	grid-template-rows: 400px 400px 400px;
        top: 0;
        padding-top: 100px;
        left: 50%;
        margin-left: -600px;
        width: 1200px;
        height: 1200px;
    }

    .img {
        margin: 30px;
    }
    .img img {
        position: absolute;
        width: 340px;
        border: 1px solid #BDBDBD;
    }
    .img:hover, .btn:hover {
        cursor: pointer;
    }
    .img > .img-mouse {
        opacity: 0;
        transition: opacity 0.5s
    }
    .img:hover > .img-mouse {
        opacity: 1;
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
    .btn:hover {
        border: 3px solid #BDBDBD;
        background-color: #BDBDBD;
        color: white;
    }

</style>
</head>
<body>
	<div class='_image'>
        <div class='img'>
            <img class='img-in' src='images/1.png'>
            <img class='img-mouse' src='images/1-1.png' onclick='selectImg(1);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/2.png'>
            <img class='img-mouse' src='images/2-1.png' onclick='selectImg(2);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/3.png'>
            <img class='img-mouse' src='images/3-1.png' onclick='selectImg(3);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/4.png'>
            <img class='img-mouse' src='images/4-1.png' onclick='selectImg(4);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/5.png'>
            <img class='img-mouse' src='images/5-1.png' onclick='selectImg(5);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/6.png'>
            <img class='img-mouse' src='images/6-1.png' onclick='selectImg(6);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/7.png'>
            <img class='img-mouse' src='images/7-1.png' onclick='selectImg(7);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/8.png'>
            <img class='img-mouse' src='images/8-1.png' onclick='selectImg(8);'>
        </div>
        <div class='img'>
            <img class='img-in' src='images/9.png'>
            <img class='img-mouse' src='images/9-1.png' onclick='selectImg(9);'>
        </div>
    </div>

	<div class='_title'>
	    <div class='title-text'>
	        IMAGE PROCESSING
	    </div>
	    <div class='header-btn'>
	        <input class='btn' type='button' value='logout' onclick='gomain()'>
	        <input class='btn' type='button' value='mypage' onclick='gomypg()'>
	    </div>
	</div>

<script>
	
	function gomain() {
		alert("로그아웃 되었습니다.");
		window.location.href = 'main.jsp';
	}
	
	function gomypg() {
		window.location.href = 'mypage.jsp';
	}
	
    function selectImg(image_num) {
        sessionStorage.setItem("image_num", image_num);
        window.location.href = 'photo-edit.jsp';
    }

</script>

</body>
</html>
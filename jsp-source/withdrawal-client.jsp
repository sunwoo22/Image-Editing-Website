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
    
    ._all {
        position: absolute;
        top: 50%;
        left: 50%;
        margin-top: -200px;
        margin-left: -180px;
        width: 360px;
        height: 400px;
    }
    ._title {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%; 
        height: 100px;
        background-color: white;
        border-bottom: 2px solid #8C8C8C;
        text-align: center;
        line-height: 100px;
        font-family: 'MapoFlowerIsland';
        font-size: 40px;
        font-weight: bold;
    }
    ._input {
        position: absolute;
        display: grid;
        grid-template-columns: 100px 300px;
        top: 100px;
        left: 0;
        width: 100%;
        height: 200px;
		font-size: 16px;
        line-height: 100px;
        text-align: center;
    }
    ._button {
        position: absolute;
        display: grid;
        grid-template-columns: 180px 180px;
        top: 300px;
        left: 0;
        width: 100%;
        height: 100px;
    }

    .input-text {
        margin: 10px;
        margin-top: 15px;
        text-align: center;
        border-radius: 40px;
        width: 230px;
        height: 60px;
        border: 3px solid #EAEAEA;
        background-color: #EAEAEA;
    }
    .btn {
        margin: 10px;
        margin-top: 15px;
        border-radius: 40px;
        width: 160px;
        height: 68px;
        text-align: center;
        line-height: 60px;
        border: 3px solid #BDBDBD;
        background-color: #EAEAEA;
        color: #5D5D5D;
        transition: 0.2s;
    }
    .btna {
        margin: 10px;
        margin-top: 15px;
        border-radius: 40px;
        width: 160px;
        height: 68px;
        text-align: center;
        line-height: 60px;
        border: 3px solid #BDBDBD;
        background-color: white;
        color: #5D5D5D;
        transition: 0.2s;
    }
    .id-btn:hover, .btn:hover, .btna:hover {
        border: 3px solid #BDBDBD;
        background-color: #BDBDBD;
        color: white;
    }
    .btn:hover, .btna:hover {
        cursor: pointer;
    }
    
</style>
    
</head>
<body>
	<div class='_all'>
        <div class='_title'>
            WITHDRAWAL
        </div>
        <form method="post" action="withdrawal-server.jsp" onsubmit='return loginchk()'>
            <div class='_input'>
                <a>PW</a> <input class='input-text' type='password' name='user_pw' id='user_pw'>
                <a>PW ckeck</a> <input class='input-text' type='password' name='user_pw_ck' id='user_pw_ck'>
            </div>
            <div class='_button'>
                <input class='btna' id='btn-join' type='button' value='CANCEL' onclick='gomypage()'>
                <input class='btn' id='btn-login' type='submit' value='WITHDRAWAL'>
            </div>
        </form>
	</div>

<script>

	function gomypage() {
		window.location.href = 'mypage.jsp';
	}
	
	function gojoin() {
		window.location.href = 'join-client.jsp';
	}

</script>
</body>
</html>
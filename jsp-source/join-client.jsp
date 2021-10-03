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
        margin-top: -250px;
        margin-left: -180px;
        width: 360px;
        height: 500px;
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
        height: 300px;
        font-size: 16px;
        line-height: 100px;
        text-align: center;
    }
    ._button {
        position: absolute;
        display: grid;
        grid-template-columns: 180px 180px;
        top: 400px;
        left: 0;
        width: 100%;
        height: 100px;
    }

    .input-id {
        display: flex;
      
    }
    .id-text {
        margin: 10px;
        margin-top: 20px;
        border-radius: 40px;
        width: 140px;
        height: 60px;
        text-align: center;
        border: 3px solid #EAEAEA;
        background-color: #EAEAEA;
    }
    .id-btn {
        margin-top: 20px;
        border-radius: 40px;
        width: 75px;
        height: 68px;
        text-align: center;
        line-height: 60px;
        border: 3px solid #BDBDBD;
        background-color: #EAEAEA;
        color: #5D5D5D;
        transition: 0.2s;
    }
    .pw-text {
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
    .id-btn:hover, #btn-cancel:hover, #btn-join:hover, .btna:hover {
        cursor: pointer;
    }
    
</style>
</head>

<body>
   <div class='_all'>
        <div class='_title'>
        JOIN
        </div>
        <form name="userform" method="post" action="join-server.jsp">
            <div class='_input'>
                <a>ID</a> 
                <div class='input-id'> 
                   <input class='id-text' type='text' name='user_id' id='user_id'>
                   <input class='id-btn' type="submit" value="check" onclick="javascript_:document.userform.action='join-server2.jsp';">
                </div>
                <a>PW</a> <input class='pw-text' type='password' name='user_pw' id='user_pw'>
                <a>PW check</a> <input class='pw-text' type='password' name='user_pw_ck' id='user_pw_ck'>
            </div>
            <div class='_button'>
                <input class='btna' id='btn-cancel' type='button' value='CANCEL' onclick='gomain()'>
                <input class='btn' id='btn-join' type='submit' value='JOIN'>
            </div>
        </form>
    </div>
   
<script>

   function gomain() {
      window.location.href = 'main.jsp';
   }

</script>
   
</body>
</html>
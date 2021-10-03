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
        grid-template-columns: 100px 100px 100px;
        top: 0;
        left: 900px;
        margin-top: 30px;
    }
    
    ._content {
        position: absolute;
        top: 0;
        padding-top: 100px;
        left: 50%;
        margin-left: -600px;
        width: 1200px;
        height: 800px;
    }
    ._image {
        position: absolute;
        padding-top: 100px;
        top: 0;
        left: 0;
        width: 1200px;
        height: 600px;
    }

    #inCanvas {
        position: absolute;
        top: 144px;
        left: 44px;
    }
    #outCanvas {
        position: absolute;
        top: 144px;
        left: 644px;
    }

    ._button {
        position: absolute;
        top: 700px;
        left: 0;
        width: 1200px;
        height: 200px;
        border-top: 2px solid #BDBDBD;
    }

    a:hover, .btn:hover, .btn2:hover, .btn2a:hover {
        cursor: pointer;
    }
    
    canvas {
    	border: 2px solid #BDBDBD;
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
    .btn:hover, .btn2:hover, .btn2a:hover {
        border: 3px solid #BDBDBD;
        background-color: #BDBDBD;
        color: white;
    }
    .btn2 {
    	position: relative;
    	margin-top: 20px;
    	margin-right: 15px;
        border-radius: 30px;
        width: 150px;
        height: 60px;
        text-align: center;
        border: 3px solid #BDBDBD;
        background-color: #EAEAEA;
        color: #5D5D5D;
        transition: 0.2s;
    }
    .btn2a {
    	position: relative;
    	margin-top: 20px;
    	margin-right: 15px;
        border-radius: 30px;
        width: 150px;
        height: 60px;
        text-align: center;
        border: 3px solid #BDBDBD;
        background-color: white;
        color: #5D5D5D;
        transition: 0.2s;
    }

</style>
</head>

<body onload='init()'>
    <div class='_content'>
        <div class='_button'>
            <input class='btn2a' type='button' value="POSTERIZING" onclick='pstImage()'>
            <input class='btn2a' type='button' value="GRAYSCALE" onclick='grayImage()'>
            <input class='btn2a' type='button' value="BLACK-WHITE" onclick='bnwImage()'>
            <input class='btn2a' type='button' value="EQUALIZATION" onclick='equalImage()'>
            <input class='btn2a' type='button' value="EMBOSSING" onclick='embossImage()'>
            <input class='btn2a' type='button' value="LAPLACIAN" onclick='maskImage(53)'>
            <button class='btn2'>
            	<a id="saveImage" type='button' download="image.png" onclick='saveImage()'>SAVE</a>
			</button>
        </div>
        <div class='_image'>
            <canvas id='inCanvas'></canvas>
            <canvas id='outCanvas'></canvas>
        </div>
    </div>

    <div class='_title'>
        <div class='title-text'>
            IMAGE PROCESSING
        </div>
        <div class='header-btn'>
            <input class='btn' type='button' value='main' onclick='gomainlogin()'>
            <input class='btn' type='button' value='logout' onclick='gomain()'>
            <input class='btn' type='button' value='mypage' onclick='gomypg()'>
        </div>
    </div>
        
<script>

	function gomainlogin() {
		window.location.href = 'main-login.jsp';
	}
	
	function gomain() {
		alert("로그아웃 되었습니다.");
		window.location.href = 'main.jsp';
	}

    function gomypg() {
    	window.location.href = 'mypage.jsp';
    }

    // 전역 변수(*중요*)
    var inCanvas, inCtx, outCanvas, outCtx;  // 입력 캔버스 관련
    var inFile, inImageArray, outImageArray;  // 입력 파일 및 배열
    var inWidth, inHeight, outWidth, outHeight;  // 입력 영상의 폭과 높이
    var inPaper, outPaper; // 캔버스에는 한점한점이 안찍힘. 대신 캔버스에 종이를 붙임.

    var user_id = sessionStorage.getItem("user_id");
    var image_num = sessionStorage.getItem("image_num");

    // ***** 이미지 저장 *******
    function saveImage() {
        console.log("saveImage()");
        var filename = user_id + "_out";
        console.log(filename.lenght);
        if (filename.length == 0) {
            filename = "image";
        }

        filename += ".png";
        var savedImage = document.getElementById("saveImage");
        var image = document
            .getElementById("outCanvas")
            .toDataURL("image/png")
            .replace("image/png", "image/octet-stream");

        savedImage.setAttribute("download", filename);
        savedImage.setAttribute("href", image);

        window.location.href = 'photo-save.jsp';
        
    }

    // 원본 이미지 오픈
    function init() {
        inCanvas = document.getElementById('inCanvas');
        inCtx = inCanvas.getContext('2d');
        outCanvas = document.getElementById('outCanvas');
        outCtx = outCanvas.getContext('2d'); 

        // 그림파일을 이미지 객체로 불러오기
        var inImage = new Image(); // 빈 이미지 객체 생성
        inImage.src = "images/" + image_num + ".png";

        inImage.onload = function() {
            // 입력 파일의 크기를 알아냄
            inWidth = inImage.width;
            inHeight = inImage.height;
            // 캔버스 크기를 결정
            inCanvas.width = inWidth;
            inCanvas.height = inHeight;
            inCtx.drawImage(inImage,0,0,inWidth,inHeight);
            // 입력 3차원 배열을 준비
            inImageArray = new Array(3); // 3장짜리 배열 (R, G, B)
            for(var j=0; j<3; j++) {
                inImageArray[j] = new Array(inHeight); // 256짜리 1차원 배열
                for(var i=0; i<inHeight; i++) 
                    inImageArray[j][i] = new Array(inWidth);
            }
            
            // 출력된 캔버스에서 픽셀값 뽑기
            var imageData = inCtx.getImageData(0,0,inWidth,inHeight);
            var R, G, B, A;
            for(var i=0; i<inHeight; i++) {
                for (var k=0; k<inWidth; k++) {
                    pixel = (i*inWidth + k)*4; // 1픽셀 = 4byte
                    R = imageData.data[pixel + 0];
                    G = imageData.data[pixel + 1];
                    B = imageData.data[pixel + 2];
                    //A = imageData.data[pixel + 3];
                    inImageArray[0][i][k] = String.fromCharCode(R);
                    inImageArray[1][i][k] = String.fromCharCode(G);
                    inImageArray[2][i][k] = String.fromCharCode(B);
                }
            }  

            // (중요!) 출력 영상의 크기를 결정... 알고리즘에 따름.
            outHeight = inHeight;
            outWidth = inWidth;
            // 출력 3차원 배열을 준비
            outImageArray = new Array(3); // 512짜리 1차원 배열
            for (var i=0; i<3; i++) {
                outImageArray[i] = new Array(outHeight); // 512짜리 1차원 배열
                for(var k=0; k<outHeight; k++) 
                    outImageArray[i][k] = new Array(outWidth);
            }
            
            // ***** 진짜 영상처리 알고리즘 *****
            for(var j=0; j<3; j++) {
                for(var i=0; i<inHeight; i++) 
                    for (var k=0; k<inWidth; k++) 
                        outImageArray[j][i][k] = inImageArray[j][i][k];
            }
            displayImage();
        }
        
    }

    // 이미지 출력
    function displayImage() {
        // 캔버스 크기를 결정
        outCanvas.height = outHeight;
        outCanvas.width = outWidth;
        var R, G, B;
        outPaper = outCtx.createImageData(outWidth, outHeight);
        for(var i=0; i<outHeight; i++) {
            for (var k=0; k<outWidth; k++) {
                R = outImageArray[0][i][k].charCodeAt(0); // Byte 문자를 숫자로.
                G = outImageArray[1][i][k].charCodeAt(0); // Byte 문자를 숫자로.
                B = outImageArray[2][i][k].charCodeAt(0); // Byte 문자를 숫자로.
                outPaper.data[(i*outWidth + k) * 4 + 0] = R;
                outPaper.data[(i*outWidth + k) * 4 + 1] = G;
                outPaper.data[(i*outWidth + k) * 4 + 2] = B;
                outPaper.data[(i*outWidth + k) * 4 + 3] = 255;
            }
        }
        outCtx.putImageData(outPaper, 0, 0);
    }

    // 적용하기
    function applyImage() {
        for(var j=0; j<3; j++) {
            for(var i=0; i<outHeight; i++) 
                for (var k=0; k<outWidth; k++) 
                    inImageArray[j][i][k] = outImageArray[j][i][k];
        }

        var R, G, B;
        inPaper = inCtx.createImageData(inWidth, inHeight);
        for(var i=0; i<inHeight; i++) {
            for (var k=0; k<inWidth; k++) {
                R = inImageArray[0][i][k].charCodeAt(0); // Byte 문자를 숫자로.
                G = inImageArray[1][i][k].charCodeAt(0); // Byte 문자를 숫자로.
                B = inImageArray[2][i][k].charCodeAt(0); // Byte 문자를 숫자로.
                inPaper.data[(i*inWidth + k) * 4 + 0] = R;
                inPaper.data[(i*inWidth + k) * 4 + 1] = G;
                inPaper.data[(i*inWidth + k) * 4 + 2] = B;
                inPaper.data[(i*inWidth + k) * 4 + 3] = 255;
            }
        }
        inCtx.putImageData(inPaper, 0, 0);
    }

    ///////  영상 처리 함수 모음 //////////

    // 포스터라이징
    function pstImage(prt) {
        var value = 6;
        //var value = parseInt(document.getElementById("pstSlider").value);
        // ***** 진짜 영상처리 알고리즘 *****
        var R, G, B;
        for(var i=0; i<inHeight; i++) {
            for (var k=0; k<inWidth; k++) {
                // 문자 --> 숫자
                R = inImageArray[0][i][k].charCodeAt(0);
                G = inImageArray[1][i][k].charCodeAt(0);
                B = inImageArray[2][i][k].charCodeAt(0);

                // ** 요기가 핵심 알고리즘. 
                for(var j=0 ; j<256 ; j+=256/value) {
                    if(R >= j && R < j + 256/value)
                        R = j + 256/value - 1;
                    if(G >= j && G < j + 256/value)
                        G = j + 256/value - 1;
                    if(B >= j && B < j + 256/value)
                        B = j + 256/value - 1;
                }

                // 숫자 --> 문자
                outImageArray[0][i][k] = String.fromCharCode(R);
                outImageArray[1][i][k] = String.fromCharCode(G);
                outImageArray[2][i][k] = String.fromCharCode(B);
            }
        }
        
        displayImage();
    }

    // 그레이스케일
    function grayImage() {
        
        // ***** 진짜 영상처리 알고리즘 *****
        var R, G, B;
        for(var i=0; i<inHeight; i++) {
            for (var k=0; k<inWidth; k++) {
                R = inImageArray[0][i][k].charCodeAt(0);
                G = inImageArray[1][i][k].charCodeAt(0);
                B = inImageArray[2][i][k].charCodeAt(0);

                var RGB =  parseInt((R+G+B) / 3);

                outImageArray[0][i][k] = String.fromCharCode(RGB);
                outImageArray[1][i][k] = String.fromCharCode(RGB);
                outImageArray[2][i][k] = String.fromCharCode(RGB);
            }
        }
        displayImage();
    }
    
    // 흑백
    function bnwImage() {
        // ***** 진짜 영상처리 알고리즘 *****
        var R, G, B;
        for(var i=0; i<inHeight; i++) {
            for (var k=0; k<inWidth; k++) {
                
                R = inImageArray[0][i][k].charCodeAt(0);
                G = inImageArray[1][i][k].charCodeAt(0);
                B = inImageArray[2][i][k].charCodeAt(0);

                var RGB =  parseInt((R+G+B) / 3);
                if(RGB > 127)
                    RGB = 255;
                else
                    RGB = 0;

                outImageArray[0][i][k] = String.fromCharCode(RGB);
                outImageArray[1][i][k] = String.fromCharCode(RGB);
                outImageArray[2][i][k] = String.fromCharCode(RGB);
            }
        }
        displayImage();
    }
    
    // 평활화
    function equalImage() {
        // 1단계: 히스토그램 생성\
        var histo = new Array(3);
        for(var i=0; i<3; i++) {
            histo[i] = new Array(256);
            for(var k=0; k<256; k++)
                histo[i][k] = 0;
        }
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight; i++) {
                for(var k=0; k<inWidth; k++) {
                    // 문자 --> 숫자
                    value = inImageArray[j][i][k].charCodeAt(0);
                    // **** 요기가 핵심 알고리즘.
                    histo[j][value]++;
                }
            }
        }
        // 2단계: 누적히스토그램 생성
        var sumHisto = new Array(3);
        for(var i=0; i<3; i++) 
            sumHisto[i] = new Array(256);
       
        for(var j=0; j<3; j++) {
            for(var i=0; i<256; i++) {
                if(i == 0)
                    sumHisto[j][i] = histo[j][i];
                else
                    sumHisto[j][i] = sumHisto[j][i - 1] + histo[j][i];
            }
        }
        // 3단계: 누적히스토그램 정규화
        // ns = s*(1/총픽셀수)*(화소최대밝기)
        var normalHisto = new Array(3);
        for(var i=0; i<3; i++) 
            normalHisto[i] = new Array(256);
         
        for(var j=0; j<3; j++) 
            for(var i=0; i<256; i++) 
                normalHisto[j][i] = sumHisto[j][i]*(1/(inWidth*inHeight))*255;
        
        // ***** 진짜 영상처리 알고리즘 *****
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight; i++) {
                for(var k=0; k<inWidth; k++) {
                    // 문자 --> 숫자
                    inVal = inImageArray[j][i][k].charCodeAt(0);
                    // **** 요기가 핵심 알고리즘. 
                    outVal = parseInt(normalHisto[j][inVal]);
                    if(outVal > 255)
                        outVal = 255;
                    if(outVal < 0)
                        outVal = 0;
                    // 숫자 --> 문자
                    outImageArray[j][i][k] = String.fromCharCode(outVal);
                }
            }
        }
        displayImage();
    }
    
 	// 엠보싱
    function embossImage() {
        // 화소 영역 처리
        var mask = [[-1.,0.,0.],[0.,0.,0.],[0.,0.,1.]];
        //var mask = [[0.,1.,0.],[1.,-4.,1.],[0.,1.,0.]];
        // 임시 입력 배열
        tempInArray = new Array(3);
        for(var j=0; j<3; j++) {
            tempInArray[j] = new Array(inHeight + 2);
                for(var i=0; i<inHeight + 2; i++) 
                    tempInArray[j][i] = new Array(inWidth + 2);
        }
        // 배열 초기화
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight + 2; i++) 
                for(var k=0; k<inWidth + 2; k++) 
                    tempInArray[j][i][k] = String.fromCharCode(127);
            for(var i=0; i<inHeight; i++) 
                for (var k=0; k<inWidth; k++) 
                    tempInArray[j][i+1][k+1] = inImageArray[j][i][k];
        }
        // ***** 진짜 영상처리 알고리즘 *****
        for(var i=0; i<inHeight; i++) {
            for(var k=0; k<inWidth; k++) {
                var SR = 0.0;
                var SG = 0.0;
                var SB = 0.0;
                for(var m=0; m<3; m++) 
                    for(var n=0; n<3; n++) {
                        SR += mask[m][n]*tempInArray[0][i+m][k+n].charCodeAt(0);
                        SG += mask[m][n]*tempInArray[1][i+m][k+n].charCodeAt(0);
                        SB += mask[m][n]*tempInArray[2][i+m][k+n].charCodeAt(0);
                    }
                // 만약, 마스크의 합계가 0이면 너무 안보이니까 결과에 127을 더하자.
                outValR = SR + 127;
                outValG = SG + 127;
                outValB = SB + 127;

                if(outValR > 255)
                    outValR = 255;
                if(outValR < 0)
                    outValR = 0;
                if(outValG > 255)
                    outValG = 255;
                if(outValG < 0)
                    outValG = 0;
                if(outValB > 255)
                    outValB = 255;
                if(outValB < 0)
                    outValB = 0;
                // 숫자 --> 문자
                outImageArray[0][i][k] = String.fromCharCode(outValR);
                outImageArray[1][i][k] = String.fromCharCode(outValG);
                outImageArray[2][i][k] = String.fromCharCode(outValB);
            }
        }
        displayImage();
    }
    
 // 마스크 선택
    function maskImage(value) {
        switch(value) {
            case 0:
                // 블러링3
                mask = [[1/9.,1/9.,1/9.],[1/9.,1/9.,1/9.],[1/9.,1/9.,1/9.]];
                break;
            case 1:
                // 가우시안 필터
                mask = [[1/16.,1/8.,1/16.],[1/8.,1/4.,1/8.],[1/16.,1/8.,1/16.]]
                break;
            case 21:
                // 샤프닝 회선 마스크 1
                mask = [[-1.,-1.,-1.],[-1.,9.,-1.],[-1.,-1.,-1.]];
                break;
            case 22:
                // 샤프닝 회선 마스크 2
                mask = [[0.,-1.,0.],[-1.,5.,-1.],[0.,-1.,0.]];
                break;
            case 3:
                // 고주파 필터 샤프닝
                mask = [[-1/9.,-1/9.,-1/9.],[-1/9.,8/9.,-1/9.],[-1/9.,-1/9.,-1/9.]];
                break;
            case 41:
                // 수직 에지 검출 마스크
                mask = [[0.,0.,0.],[-1.,1.,0.],[0.,0.,0.]];
                break;
            case 42:
                // 수평 에지 검출 마스크
                mask = [[0.,-1.,0.],[0.,1.,0.],[0.,0.,0.]];
                break;
            case 43:
                // 수직 수평 에지 검출 마스크
                mask = [[0.,-1.,0.],[-1.,2.,0.],[0.,0.,0.]];
            case 51:
                // 라플라시안 회선 마스크 1
                mask = [[0.,1.,0.],[1.,-4.,1.],[0.,1.,0.]];
                break;
            case 52:
                // 라플라시안 회선 마스크 2
                mask = [[1.,1.,1.],[1.,-8.,1.],[1.,1.,1.]];
                break;
            case 53:
                // 라플라시안 회선 마스크 23
                mask = [[-1.,-1.,-1.],[-1.,8.,-1.],[-1.,-1.,-1.]];
                break;
        }
        pixelImage(mask);
    }

    // 마스크 입력 받아 처리
    function pixelImage(maskmask) {
        // 임시 입력 배열
        tempInArray = new Array(3);
        for(var j=0; j<3; j++) {
            tempInArray[j] = new Array(inHeight + 2);
                for(var i=0; i<inHeight + 2; i++) 
                    tempInArray[j][i] = new Array(inWidth + 2);
        }
        // 배열 초기화
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight + 2; i++) 
                for(var k=0; k<inWidth + 2; k++) 
                    tempInArray[j][i][k] = String.fromCharCode(127);
            for(var i=0; i<inHeight; i++) 
                for (var k=0; k<inWidth; k++) 
                    tempInArray[j][i+1][k+1] = inImageArray[j][i][k];
        }
        // ***** 진짜 영상처리 알고리즘 *****
        for(var i=0; i<inHeight; i++) {
            for(var k=0; k<inWidth; k++) {
                var SR = 0.0;
                var SG = 0.0;
                var SB = 0.0;
                for(var m=0; m<3; m++) 
                    for(var n=0; n<3; n++) {
                        SR += mask[m][n]*tempInArray[0][i+m][k+n].charCodeAt(0);
                        SG += mask[m][n]*tempInArray[1][i+m][k+n].charCodeAt(0);
                        SB += mask[m][n]*tempInArray[2][i+m][k+n].charCodeAt(0);
                    }
                // 만약, 마스크의 합계가 0이면 너무 안보이니까 결과에 127을 더하자.
                outValR = SR;
                outValG = SG;
                outValB = SB;

                if(outValR > 255)
                    outValR = 255;
                if(outValR < 0)
                    outValR = 0;
                if(outValG > 255)
                    outValG = 255;
                if(outValG < 0)
                    outValG = 0;
                if(outValB > 255)
                    outValB = 255;
                if(outValB < 0)
                    outValB = 0;
                // 숫자 --> 문자
                outImageArray[0][i][k] = String.fromCharCode(outValR);
                outImageArray[1][i][k] = String.fromCharCode(outValG);
                outImageArray[2][i][k] = String.fromCharCode(outValB);
            }
        }
        displayImage();
    }

</script>
    
</body>
</html>
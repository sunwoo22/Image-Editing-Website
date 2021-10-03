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
		alert("�α׾ƿ� �Ǿ����ϴ�.");
		window.location.href = 'main.jsp';
	}

    function gomypg() {
    	window.location.href = 'mypage.jsp';
    }

    // ���� ����(*�߿�*)
    var inCanvas, inCtx, outCanvas, outCtx;  // �Է� ĵ���� ����
    var inFile, inImageArray, outImageArray;  // �Է� ���� �� �迭
    var inWidth, inHeight, outWidth, outHeight;  // �Է� ������ ���� ����
    var inPaper, outPaper; // ĵ�������� ���������� ������. ��� ĵ������ ���̸� ����.

    var user_id = sessionStorage.getItem("user_id");
    var image_num = sessionStorage.getItem("image_num");

    // ***** �̹��� ���� *******
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

    // ���� �̹��� ����
    function init() {
        inCanvas = document.getElementById('inCanvas');
        inCtx = inCanvas.getContext('2d');
        outCanvas = document.getElementById('outCanvas');
        outCtx = outCanvas.getContext('2d'); 

        // �׸������� �̹��� ��ü�� �ҷ�����
        var inImage = new Image(); // �� �̹��� ��ü ����
        inImage.src = "images/" + image_num + ".png";

        inImage.onload = function() {
            // �Է� ������ ũ�⸦ �˾Ƴ�
            inWidth = inImage.width;
            inHeight = inImage.height;
            // ĵ���� ũ�⸦ ����
            inCanvas.width = inWidth;
            inCanvas.height = inHeight;
            inCtx.drawImage(inImage,0,0,inWidth,inHeight);
            // �Է� 3���� �迭�� �غ�
            inImageArray = new Array(3); // 3��¥�� �迭 (R, G, B)
            for(var j=0; j<3; j++) {
                inImageArray[j] = new Array(inHeight); // 256¥�� 1���� �迭
                for(var i=0; i<inHeight; i++) 
                    inImageArray[j][i] = new Array(inWidth);
            }
            
            // ��µ� ĵ�������� �ȼ��� �̱�
            var imageData = inCtx.getImageData(0,0,inWidth,inHeight);
            var R, G, B, A;
            for(var i=0; i<inHeight; i++) {
                for (var k=0; k<inWidth; k++) {
                    pixel = (i*inWidth + k)*4; // 1�ȼ� = 4byte
                    R = imageData.data[pixel + 0];
                    G = imageData.data[pixel + 1];
                    B = imageData.data[pixel + 2];
                    //A = imageData.data[pixel + 3];
                    inImageArray[0][i][k] = String.fromCharCode(R);
                    inImageArray[1][i][k] = String.fromCharCode(G);
                    inImageArray[2][i][k] = String.fromCharCode(B);
                }
            }  

            // (�߿�!) ��� ������ ũ�⸦ ����... �˰��� ����.
            outHeight = inHeight;
            outWidth = inWidth;
            // ��� 3���� �迭�� �غ�
            outImageArray = new Array(3); // 512¥�� 1���� �迭
            for (var i=0; i<3; i++) {
                outImageArray[i] = new Array(outHeight); // 512¥�� 1���� �迭
                for(var k=0; k<outHeight; k++) 
                    outImageArray[i][k] = new Array(outWidth);
            }
            
            // ***** ��¥ ����ó�� �˰��� *****
            for(var j=0; j<3; j++) {
                for(var i=0; i<inHeight; i++) 
                    for (var k=0; k<inWidth; k++) 
                        outImageArray[j][i][k] = inImageArray[j][i][k];
            }
            displayImage();
        }
        
    }

    // �̹��� ���
    function displayImage() {
        // ĵ���� ũ�⸦ ����
        outCanvas.height = outHeight;
        outCanvas.width = outWidth;
        var R, G, B;
        outPaper = outCtx.createImageData(outWidth, outHeight);
        for(var i=0; i<outHeight; i++) {
            for (var k=0; k<outWidth; k++) {
                R = outImageArray[0][i][k].charCodeAt(0); // Byte ���ڸ� ���ڷ�.
                G = outImageArray[1][i][k].charCodeAt(0); // Byte ���ڸ� ���ڷ�.
                B = outImageArray[2][i][k].charCodeAt(0); // Byte ���ڸ� ���ڷ�.
                outPaper.data[(i*outWidth + k) * 4 + 0] = R;
                outPaper.data[(i*outWidth + k) * 4 + 1] = G;
                outPaper.data[(i*outWidth + k) * 4 + 2] = B;
                outPaper.data[(i*outWidth + k) * 4 + 3] = 255;
            }
        }
        outCtx.putImageData(outPaper, 0, 0);
    }

    // �����ϱ�
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
                R = inImageArray[0][i][k].charCodeAt(0); // Byte ���ڸ� ���ڷ�.
                G = inImageArray[1][i][k].charCodeAt(0); // Byte ���ڸ� ���ڷ�.
                B = inImageArray[2][i][k].charCodeAt(0); // Byte ���ڸ� ���ڷ�.
                inPaper.data[(i*inWidth + k) * 4 + 0] = R;
                inPaper.data[(i*inWidth + k) * 4 + 1] = G;
                inPaper.data[(i*inWidth + k) * 4 + 2] = B;
                inPaper.data[(i*inWidth + k) * 4 + 3] = 255;
            }
        }
        inCtx.putImageData(inPaper, 0, 0);
    }

    ///////  ���� ó�� �Լ� ���� //////////

    // �����Ͷ���¡
    function pstImage(prt) {
        var value = 6;
        //var value = parseInt(document.getElementById("pstSlider").value);
        // ***** ��¥ ����ó�� �˰��� *****
        var R, G, B;
        for(var i=0; i<inHeight; i++) {
            for (var k=0; k<inWidth; k++) {
                // ���� --> ����
                R = inImageArray[0][i][k].charCodeAt(0);
                G = inImageArray[1][i][k].charCodeAt(0);
                B = inImageArray[2][i][k].charCodeAt(0);

                // ** ��Ⱑ �ٽ� �˰���. 
                for(var j=0 ; j<256 ; j+=256/value) {
                    if(R >= j && R < j + 256/value)
                        R = j + 256/value - 1;
                    if(G >= j && G < j + 256/value)
                        G = j + 256/value - 1;
                    if(B >= j && B < j + 256/value)
                        B = j + 256/value - 1;
                }

                // ���� --> ����
                outImageArray[0][i][k] = String.fromCharCode(R);
                outImageArray[1][i][k] = String.fromCharCode(G);
                outImageArray[2][i][k] = String.fromCharCode(B);
            }
        }
        
        displayImage();
    }

    // �׷��̽�����
    function grayImage() {
        
        // ***** ��¥ ����ó�� �˰��� *****
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
    
    // ���
    function bnwImage() {
        // ***** ��¥ ����ó�� �˰��� *****
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
    
    // ��Ȱȭ
    function equalImage() {
        // 1�ܰ�: ������׷� ����\
        var histo = new Array(3);
        for(var i=0; i<3; i++) {
            histo[i] = new Array(256);
            for(var k=0; k<256; k++)
                histo[i][k] = 0;
        }
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight; i++) {
                for(var k=0; k<inWidth; k++) {
                    // ���� --> ����
                    value = inImageArray[j][i][k].charCodeAt(0);
                    // **** ��Ⱑ �ٽ� �˰���.
                    histo[j][value]++;
                }
            }
        }
        // 2�ܰ�: ����������׷� ����
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
        // 3�ܰ�: ����������׷� ����ȭ
        // ns = s*(1/���ȼ���)*(ȭ���ִ���)
        var normalHisto = new Array(3);
        for(var i=0; i<3; i++) 
            normalHisto[i] = new Array(256);
         
        for(var j=0; j<3; j++) 
            for(var i=0; i<256; i++) 
                normalHisto[j][i] = sumHisto[j][i]*(1/(inWidth*inHeight))*255;
        
        // ***** ��¥ ����ó�� �˰��� *****
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight; i++) {
                for(var k=0; k<inWidth; k++) {
                    // ���� --> ����
                    inVal = inImageArray[j][i][k].charCodeAt(0);
                    // **** ��Ⱑ �ٽ� �˰���. 
                    outVal = parseInt(normalHisto[j][inVal]);
                    if(outVal > 255)
                        outVal = 255;
                    if(outVal < 0)
                        outVal = 0;
                    // ���� --> ����
                    outImageArray[j][i][k] = String.fromCharCode(outVal);
                }
            }
        }
        displayImage();
    }
    
 	// ������
    function embossImage() {
        // ȭ�� ���� ó��
        var mask = [[-1.,0.,0.],[0.,0.,0.],[0.,0.,1.]];
        //var mask = [[0.,1.,0.],[1.,-4.,1.],[0.,1.,0.]];
        // �ӽ� �Է� �迭
        tempInArray = new Array(3);
        for(var j=0; j<3; j++) {
            tempInArray[j] = new Array(inHeight + 2);
                for(var i=0; i<inHeight + 2; i++) 
                    tempInArray[j][i] = new Array(inWidth + 2);
        }
        // �迭 �ʱ�ȭ
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight + 2; i++) 
                for(var k=0; k<inWidth + 2; k++) 
                    tempInArray[j][i][k] = String.fromCharCode(127);
            for(var i=0; i<inHeight; i++) 
                for (var k=0; k<inWidth; k++) 
                    tempInArray[j][i+1][k+1] = inImageArray[j][i][k];
        }
        // ***** ��¥ ����ó�� �˰��� *****
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
                // ����, ����ũ�� �հ谡 0�̸� �ʹ� �Ⱥ��̴ϱ� ����� 127�� ������.
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
                // ���� --> ����
                outImageArray[0][i][k] = String.fromCharCode(outValR);
                outImageArray[1][i][k] = String.fromCharCode(outValG);
                outImageArray[2][i][k] = String.fromCharCode(outValB);
            }
        }
        displayImage();
    }
    
 // ����ũ ����
    function maskImage(value) {
        switch(value) {
            case 0:
                // ����3
                mask = [[1/9.,1/9.,1/9.],[1/9.,1/9.,1/9.],[1/9.,1/9.,1/9.]];
                break;
            case 1:
                // ����þ� ����
                mask = [[1/16.,1/8.,1/16.],[1/8.,1/4.,1/8.],[1/16.,1/8.,1/16.]]
                break;
            case 21:
                // ������ ȸ�� ����ũ 1
                mask = [[-1.,-1.,-1.],[-1.,9.,-1.],[-1.,-1.,-1.]];
                break;
            case 22:
                // ������ ȸ�� ����ũ 2
                mask = [[0.,-1.,0.],[-1.,5.,-1.],[0.,-1.,0.]];
                break;
            case 3:
                // ������ ���� ������
                mask = [[-1/9.,-1/9.,-1/9.],[-1/9.,8/9.,-1/9.],[-1/9.,-1/9.,-1/9.]];
                break;
            case 41:
                // ���� ���� ���� ����ũ
                mask = [[0.,0.,0.],[-1.,1.,0.],[0.,0.,0.]];
                break;
            case 42:
                // ���� ���� ���� ����ũ
                mask = [[0.,-1.,0.],[0.,1.,0.],[0.,0.,0.]];
                break;
            case 43:
                // ���� ���� ���� ���� ����ũ
                mask = [[0.,-1.,0.],[-1.,2.,0.],[0.,0.,0.]];
            case 51:
                // ���ö�þ� ȸ�� ����ũ 1
                mask = [[0.,1.,0.],[1.,-4.,1.],[0.,1.,0.]];
                break;
            case 52:
                // ���ö�þ� ȸ�� ����ũ 2
                mask = [[1.,1.,1.],[1.,-8.,1.],[1.,1.,1.]];
                break;
            case 53:
                // ���ö�þ� ȸ�� ����ũ 23
                mask = [[-1.,-1.,-1.],[-1.,8.,-1.],[-1.,-1.,-1.]];
                break;
        }
        pixelImage(mask);
    }

    // ����ũ �Է� �޾� ó��
    function pixelImage(maskmask) {
        // �ӽ� �Է� �迭
        tempInArray = new Array(3);
        for(var j=0; j<3; j++) {
            tempInArray[j] = new Array(inHeight + 2);
                for(var i=0; i<inHeight + 2; i++) 
                    tempInArray[j][i] = new Array(inWidth + 2);
        }
        // �迭 �ʱ�ȭ
        for(var j=0; j<3; j++) {
            for(var i=0; i<inHeight + 2; i++) 
                for(var k=0; k<inWidth + 2; k++) 
                    tempInArray[j][i][k] = String.fromCharCode(127);
            for(var i=0; i<inHeight; i++) 
                for (var k=0; k<inWidth; k++) 
                    tempInArray[j][i+1][k+1] = inImageArray[j][i][k];
        }
        // ***** ��¥ ����ó�� �˰��� *****
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
                // ����, ����ũ�� �հ谡 0�̸� �ʹ� �Ⱥ��̴ϱ� ����� 127�� ������.
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
                // ���� --> ����
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
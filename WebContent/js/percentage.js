/**
 * 
 */

    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
   
    var width = canvas.clientWidth;
    var height = canvas.clientHeight;

    var value = [100, 200, 300, 200];
    var degree = 360;
    var radius = width * 0.7 / 2;

    if(radius > height * 0.7 / 2){
        radius = height * 0.7 / 2;
    }



    var sum = value.reduce((a, b) => a + b);
    var conv_array = value.slice().map((data)=>{
        var rate = data / sum;
        var myDegree = degree * rate;
        return myDegree;
    });


    degree = 0;
    var event_array = value.slice().map( arg=> []);
    for(var i=0;i < conv_array.length;i++){
        var item = conv_array[i];
        ctx.save();
        ctx.beginPath();
        ctx.moveTo(width/2, height/2);
        if(i == 0){
            ctx.arc(width/2, height/2, radius, (Math.PI/180)*0, (Math.PI/180)* item , false);
            degree = item;
            event_array[i] = [0, degree];
        } else {
            ctx.arc(width/2, height/2, radius, (Math.PI/180)*degree, (Math.PI/180)*(degree + item), false);
            event_array[i] = [degree, degree+item];
            degree =  degree + item;
        }
        ctx.closePath();
        ctx.stroke();
        ctx.restore();
    }

    var drawed = false;
    canvas.addEventListener('mousemove', function (event) {
        var x1 = event.clientX - canvas.offsetLeft;
        var y1 = event.clientY - canvas.offsetTop;
        var inn = isInsideArc(x1, y1);
        //console.log(inn);
        if(inn.index > -1){
            drawed = true;
            hoverCanvas(inn.index);
            makeText(inn.index);
        } else {
            if(drawed){
                hoverCanvas(-1);
                makeText(-1);
            }
            drawed = false;
        }
    }); 

    function isInsideArc(x1, y1){
        var result1 = false;
        var result2 = false;
        var index = -1;
        var circle_len = radius;
        var x = width/2 - x1;
        var y = height/2 - y1;
        var my_len = Math.sqrt(Math.abs(x * x) + Math.abs(y * y));  //삼각함수
        if(circle_len >= my_len){
            result1 = true;
        }            
        
        var rad = Math.atan2(y, x);
        rad = (rad*180)/Math.PI;  //음수가 나온다
        rad += 180;  //캔버스의 각도로 변경

        if(result1){
            event_array.forEach( (arr,idx) => {   //각도 범위에 해당하는지 확인
                if( rad >= arr[0] && rad <= arr[1]){
                    result2 = true;
                    index = idx;
                }
            });
        }
        return {result1:result1, result2:result2 ,index:index, degree : rad};
    }


    function hoverCanvas(index){
        ctx.clearRect(0,0,width, height);
        for (var i = 0; i < conv_array.length; i++) {
            var item = conv_array[i];
            ctx.save();
            ctx.beginPath();
            var innRadius = radius;
            ctx.moveTo(width / 2 , height / 2 );
            if(index == i){  
                ctx.lineWidth = 2;
                ctx.strokeStyle='blue';
                innRadius = radius * 1.1;
            } 
            if (i == 0) {
                ctx.arc(width / 2, height / 2, innRadius, (Math.PI / 180) * 0, (Math.PI / 180) * item, false);
                degree = item;
            } else {
                ctx.arc(width / 2, height / 2, innRadius, (Math.PI / 180) * degree, (Math.PI / 180) * (degree + item), false);
                degree = degree + item;
            }
            ctx.closePath();
            ctx.stroke();
            ctx.restore();
        }
    }


    //도(degree)를 라디안(radian)으로 바꾸는 함수
    function degreesToRadians(degrees) {
        const pi = Math.PI;
        return degrees * (pi / 180);
    }

    function makeText(index){
        event_array.forEach((itm, idx) => {
            var half = (itm[1] - itm[0]) / 2;
            var degg = itm[0] + half;
            var xx = Math.cos(degreesToRadians(degg)) * radius * 0.7 + width / 2;
            var yy = Math.sin(degreesToRadians(degg)) * radius * 0.7 + height / 2;

            var txt = value[idx] + '';
            var minus = ctx.measureText(txt).width / 2;  //텍스트 절반길이
            ctx.save();
            if(index == idx){
                ctx.font = "normal bold 20px serif";
                ctx.fillStyle = 'blue';
            } else {
                ctx.font = "normal 14px serif";
            }
            ctx.fillText(txt, xx - minus, yy);
            ctx.restore();
        });
    }
    makeText(-1);  //최초 호출


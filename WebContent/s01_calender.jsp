<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<style>
			#schedule {
				position: relative;
                border: 3px dotted green;
                left:600px;
				width: 524px;
				height:395px;
				bottom: 418px;
				border: 1px solid #c0c0c0;
				border-radius: 5px;
			}
			#hacsa {
				text-align: center;	
			}
			table{
                margin-top: 10px;
                
            }
            
            table,td,th{
                border: 1px solid black;
                /*각 라인을 합쳐 준다.*/
                border-collapse: collapse;
                text-align: center;
             /*    border-right:none;
                border-left:none;
                border-top:none;
                border-bottom:none;  */
            }
            td,th{
                padding: 5px 10px;
            }
		</style>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	</head>
	<body>
		<br/>
		<br/>
		<br/>
		<br/>
		<br/>
		
		<div id="datepicker"></div>
		<input type="text" id="getdate" name="getdate">
		<div id="schedule"><h1 id="hacsa">학사일정</h1>		
			<table>
	            <tr>
	                <th id ="schedule_date" width="520px">날짜</th>	         
	            </tr>
	            <tr>
	               <th id="schedule_content" height="265px">일정</th>
	            </tr>
        	</table>
		</div>
		
		
		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		
	</body>
	<script>
	 	
	    $('#datepicker').datepicker({
	        altField : '#getdate',
	        dateFormat : 'yy-mm-dd'       
		});
	  
	    
	    $('#datepicker').change(function() {
          
		  $.ajax({
				type: "post",
				url: "./dateEvent",
				dataType: "json",
				
				data: {
					"schedule": $(this).val() 
				},
				success: function(data) {
					// 태그에 가져온 데이터 넣기
					$("#schedule_date").html(data.dto.schedule_date); //data.dto.schedule_date
					$("#schedule_content").html(data.dto.schedule_content);
				} 
		  });
		  console.log(document.getElementById("datepicker").value);
		});
	   

	     //-- Font-size를 40px 설정해보니 상단의 년도와 , 월~토요일까지가 글자의 크기가 변경되는 것을 확인하였습니다. 
	    $('.ui-datepicker').css('font-size', '30px');
  
	    //-- 년도 SelectList 의 높이 조정과 넓이 조정  
	    //$('.ui-datepicker select.ui-datepicker-year').css('width', '40%').css('height', '50px').css('font-size','40px');
	     
	    //-- 일자의 글자 크기 조정
	    //$('.ui-datepicker td span, .ui-datepicker td a').css('font-size', '40px');
	       
	</script>
</html>
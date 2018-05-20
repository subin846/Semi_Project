 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<script src =" https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
			body{
				margin: 0px; /* body와 div 사이 공백 제거 */
			}
			#menu{
				overflow:hidden;
				float: right;
				font-weight: 600;
				font-size:12px;
				margin: 15px 0px 15px 0px;
			}
			#menu a{
				text-decoration: none;
				border-left: 1px solid #c0c0c0;
				padding: 0px 10px 0px 14px;
				color: black;
			}
			#navi{
				width: 100%;
				height: 60px;
				background-color: #9DCFFF;
				margin-top: 20px;
				overflow:hidden;
			}
			#navi div{
				display: inline;
				height: 30px;
				padding: 17px 50px 13px 50px;
				background-color: #9DCFFF;
				float: left;
			}
			#navi div:hover{
				background-color: #4375DB;
			}
			#navi a{
				text-decoration: none;
				color: white;
				font-size: large;
				font-weight: bold;
			}
			#navi #navi3{
				background-color: #4375DB;
			}
 			#sub a{
				text-decoration: none;
				font-size: 17px;
				font-weight: bold;
				color: black;
				margin-left: 10px;
			}
			#sub{
				margin-top: 1%;
				width: 230px;
				height: 400px;
				border: 1px solid #c0c0c0;
				margin-left: 1%;
				background-color: #F6F6F6;
				float: left; 
			}
			 #sub div{
				height: 40px;
				padding-top: 50px;
			} 
			#sub div:hover {
				 text-decoration: underline; 
			}
			tr,th{
				border: 1px solid black;
				border-collapse: collapse;
				padding:10px 15px;
				margin:2%;
			} 
		#s16{
			text-decoration: underline;
		}
		#btn{
			cursor: pointer;
		}
		/* 과목 Id 는 수강 신청 목록에서 숨기기*/
		.display{
			display:none;
		}
		table{
			width: 1800px;
			}
		table,th,td{
			border-collapse: collapse;
			border : 1px solid black;
			padding : 5px 10px;
			margin:20px;
			text-align: center;
		}
	</style>
</head>
<body>
			<div id="menu">
					<span>${sessionScope.loginId}</span>님 환영합니다
					<a href="#">HOME</a>
					<a href="#">비밀번호변경</a>
					<a href="#">LOGOUT</a>
			</div>
			<div id="navi">
				<div><a href="#">학적</a></div>
				<div><a href="#">과목게시판</a></div>
				<div id="navi3"><a href="./s15-main.jsp">수강신청</a></div>
			</div>
			<div id="sub">
				<div><a href="./s15-main.jsp">과목조회</a></div>
				<div id="s16"><a href="./s16.jsp">수강신청</a></div>
				<div><a href="./s17.jsp">신청과목조회</a></div>
			</div>
		<div>
				<select id="optSelect">
					<option value="entry" selected>전체</option>
					<option value="pro">교수별</option>
					<option value="maj">학과명</option>
					<option value="sub">과목명</option>
				</select>
				<input type="text" id ="inp"  placeholder="조회 버튼을 클릭해주세요"/>
				<input type="button" id="btn" value="조회"/>
			</div>
		<table> <!-- id OR class="tabAppend" -->
			<tr id="initialEntry">
				<th class="display">과목Id</th>
				<th>학기</th>
				<th>학과명</th>
				<th>과목명</th>
				<th>교수명</th>
				<th>강의실</th>
				<th>강의시간</th>
				<th>이수구분</th>
				<th>학점</th>
				<th>제한인원</th>
				<th>수강 신청 가능 인원</th>
				<th>수강신청</th>
			</tr>
			</table>
			<div>
				최소학점 : <input type="text" value="2" readonly size="10" style="background-color: #e2e2e2"/>	
				최대학점 : <input type="text" id="maxCredit" value="10" readonly  size="10" style="background-color: #e2e2e2"/>	
				내 신청학점 : <input id="stdCredit"  type="text" value="" size="10" style="background-color: #e2e2e2"/>	
			</div>
			<table> 
			<tr id="stdEnroll">
				<th class="display">과목Id</th>
				<th>학기</th>
				<th>학과명</th>
				<th>과목명</th>
				<th>교수명</th>
				<th>강의실</th>
				<th>강의시간</th>
				<th>이수구분</th>
				<th>학점</th>
				<th>제한인원</th>
				<th>수강 신청 가능 인원</th>
				<th>수강정정</th>
			</tr>
			</table>
</body>
<script>
	$(document).ready(function(){

			//개별적으로 ajax 호출하기위해 공통된 부분만 object 로 담는 변수선언
			var obj ={};
			obj.type ="POST";
			obj.dataType="JSON";
			obj.error=function(e){console.log(e)};
			
			//ready 되면서 전체 과목 리스트 조회
			initialEntry(obj);
			//ready 되면서 특정학생이 수강 신청한 과목 조회
			stdEnroll(obj);
			//ready 되면서 특정학생의 신청 학점 조회
			stdCredit(obj);

			 /* 필터링 검색 */
			$("#btn").click(function(){
				console.log("조회 버튼 클릭");
				obj.url="./subjectSearch";
				obj.optValue = $("#optSelect option:selected").val();
				obj.inpValue = $("#inp").val();
				obj.term_id = " >'2018-1' ";
				obj.data={
						//getParameter()메서드 : name 을 통해서 value를 얻을 수 있음
						//2개 파라메터로 보내서 opt 를 기준으로 sql 분류
						"optValue"  :obj.optValue,
						"inpValue" : obj.inpValue,
						"term_id" : obj.term_id
					}; 
				obj.success =function(data){
					if(".trRemove1"!=null){
						//tr 제거
						console.log("tr제거");
						$(".trRemove1").remove();
					}
					// 수강신청 과목 리스트 담을 변수 선언
					var listAppend;
					for(var i =0; i<data.searchList.length; i++){
						listAppend+="<tr class='trRemove1'>"
						listAppend+="<td class='display'>"+data.searchList[i].subject_id+"</td>"
						listAppend+="<td>"+data.searchList[i].term_id+"</td>"
						listAppend+="<td>"+data.searchList[i].major_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_name+"</td>"
						listAppend+="<td>"+data.searchList[i].pro_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_room+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_time+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_type+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_credit+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_limit+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_count+"</td>"
						listAppend+="<td><input type='button' class='enroll'  value='수강신청'></td>" 
						listAppend+="</tr>"
					}
						$("#initialEntry").after(listAppend);
				};
				ajaxCall(obj);
			});
			/* 수강 신청 버튼 hover  이벤트*/ 
			$(document).on("mouseover",".enroll",function(){
				$(this).css({"text-decoration":"underline","color":"blue","cursor":"pointer"});
			});
			$(document).on("mouseleave",".enroll",function(){
				$(this).css({"text-decoration":"none","color":"black"});
			}); 
			/* 수강 신청 버튼 클릭 이벤트*/
			$(document).on("click",".enroll",function(){
				console.log(" 버튼 클릭");
				if("${sessionScope.loginId}" !=""){
					if( confirm("수강 신청 하시겠습니까?")){
						var trChilds= $(this).parent().parent().children();
						var tdValue = [];
						trChilds.each(function(i){
							tdValue.push(trChilds.eq(i).text());
						});
						tdValue.push($("#maxCredit").val());
						console.log("tdValue");
						console.log(tdValue);
						//아작스 호출 
						obj.url ="./enroll";
						obj.data={
							"loginId" : "${sessionScope.loginId}",
							"tdValue" : tdValue
						};
						obj.success=function(data){	
							console.log(data);
							 //쿼리 성공 여부 반환 변수 --	data.result[0]  
							 //최대학점 기준 성공 여부 반환 변수--data.result[1] 
							 //중복된 과목이 있는지 구분하여 반환하는  변수---data.result[2] 
							//중복된 강의시간이  있는지 구분하여 반환하는  변수  --data.result[3] 
							 //신청 인원이 마감 되었는지 확인 하는  변수  --data.result[4] 
								if(data.result[1] >0 ){
									if(data.result[2] >0 ){
										if(data.result[3] >0 ){
											if(data.result[4]> 0){
												if(data.result[0] >0 ){
													alert("수강 신청이 완료되었습니다.");
												}
											}else{
												alert("신청 인원이 마감되었습니다.");
											}
										}else{
											alert("기존 신청하신 과목과 강의시간이 중복됩니다. ");
										}
									}else{
										alert("이미 수강 신청하신 과목입니다.");
									}
								}else{
									alert("최대 20학점까지 수강 신청 가능합니다.");
								}
							 //
							 initialEntry(obj);
							//특정학생의 수강 신청한 학점 조회
							stdCredit(obj);
							//특정학생의 수강 신청한 과목 조회
							stdEnroll(obj);		
						}
						//수강 신청 클릭 이벤트 ajax 호출
				 		ajaxCall(obj);
					 }	
			}else{
				alert("로그인이 필요한 서비스 입니다.");
				location.href="index.jsp";
				}
			}); 
			
			/* 수강 정정 버튼 이벤트 */
			$(document).on("click",".enrollChange",function(){
				var trChilds = $(this).parent().parent().children();
				//json 형태로 로그인 아이디와 유일한 키 과목 eq(0).text()를 전송
				var subject_id = trChilds.eq(0).text();
				if(confirm("선택한 과목을 삭제 하시겠습니까?")){
					obj.url="./enrollChange";
					obj.data={
							"loginId":"${sessionScope.loginId}",
							"subject_id":subject_id,
					}
					obj.success=function(data){
						console.log("수강정정 반환값");
						console.log(data);
						if(data.success>0){
							alert("선택한 과목을 삭제 하였습니다.");
						}else{
							alert("삭제 실패 했습니다. 다시 시도해주세요.");
						}
						//
						initialEntry(obj)
						//특정학생의 수강 신청한 학점 조회
						stdCredit(obj);
						//특정학생의 수강 신청한 과목 조회
						stdEnroll(obj);		
					}
					ajaxCall(obj);
				}
			});
		});
		/* ready 되면서 전체 과목 리스트 조회*/
		function initialEntry(obj){
				console.log("initialEntry 함수 호출");
				obj.url="./subjectSearch";
				obj.term_id = " > '2018-1' ";
				obj.optValue = $("#optSelect option:selected").val();
				obj.inpValue = $("#inp").val();
				obj.data={
						//getParameter()메서드 : name 을 통해서 value를 얻을 수 있음
						//2개 파라메터로 보내서 opt 를 기준으로 sql 분류
						"optValue"  :obj.optValue,
						"inpValue" : obj.inpValue,
						"term_id" : obj.term_id
				};
				/*이전 학기 평점조회 와 
				신학기 수강신청 과목 분류 하기위해 분류할수있는 데이터 함께 전송*/
				obj.success =function(data){
					console.log("initialEntry 성공!");
					console.log(data);
					console.log(data.searchList);
					console.log(data.searchList.length);
					if(".trRemove1"!=null){
						//tr 제거
						console.log("tr제거");
						$(".trRemove1").remove();
					}
					// 수강신청 과목 리스트 담을 변수 선언
					var listAppend;
					for(var i =0; i<data.searchList.length; i++){

						listAppend+="<tr class='trRemove1'>"
						listAppend+="<td class='display'>"+data.searchList[i].subject_id+"</td>"
						listAppend+="<td>"+data.searchList[i].term_id+"</td>"
						listAppend+="<td>"+data.searchList[i].major_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_name+"</td>"
						listAppend+="<td>"+data.searchList[i].pro_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_room+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_time+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_type+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_credit+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_limit+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_count+"</td>"
						listAppend+="<td><input type='button' class='enroll'  value='수강신청'></td>" 
						listAppend+="</tr>"
					}
						$("#initialEntry").after(listAppend);
				};
				ajaxCall(obj);
		}
		
		/* ready 되면서 특정학생이 수강 신청한 과목 조회 */
		function stdEnroll(obj){
				console.log("stdEnroll 함수 호출");
				obj.url="./stdEnroll";
				obj.term_id ="2018-2";
	 			obj.data={
						"loginId" :"${sessionScope.loginId}",
						"term_id":obj.term_id
				}; 
				obj.success =function(data){
					console.log(data);
					if(".trRemove2"!=null){
						//tr 제거
						console.log("tr제거");
						$(".trRemove2").remove();
					}
					// 수강신청 과목 리스트 담을 변수 선언
					var listAppend;
					for(var i =0; i<data.searchList.length; i++){
						listAppend+="<tr class='trRemove2'>"
						listAppend+="<td class='display'>"+data.searchList[i].subject_id+"</td>"
						listAppend+="<td>"+data.searchList[i].term_id+"</td>"
						listAppend+="<td>"+data.searchList[i].major_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_name+"</td>"
						listAppend+="<td>"+data.searchList[i].pro_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_room+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_time+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_type+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_credit+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_limit+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_count+"</td>"
						listAppend+="<td><input type='button' class='enrollChange' value='수강정정'></td>" 
						listAppend+="</tr>"
					}
						$("#stdEnroll").after(listAppend);
				};
				ajaxCall(obj);
		}
		/* ready 되면서 특정학생의 신청 학점 조회 */
		function stdCredit(obj){
			console.log("stdCredit 함수 호출");
			obj.url ="./stdCredit";
			obj.term_id ="2018-2";
			obj.data={
				"loginId":"${sessionScope.loginId}",
				"term_id" : obj.term_id,
			};
			obj.success=function(data){
				console.log(data.stdCredit);
				console.log($("#stdCredit").val());
				$("#stdCredit").val(data.stdCredit) ;
			};
			ajaxCall(obj);
		}
		
		 /* ajax실행 */
		function ajaxCall(obj){
			console.log(obj);
			console.log("ajax호출");
			$.ajax(obj);
		}
</script>
</html>
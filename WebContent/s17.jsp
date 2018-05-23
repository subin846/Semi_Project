 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<script src =" https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
			body{
				margin: 0px; 
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
		#s17{
			text-decoration: underline;
		}
		table{
			width: 1000px;
			position:absolute;
			top:140px;
			left:250px;
			}
		table,th,td{
			border-collapse: collapse;
			border : 1px solid black;
			padding : 5px 10px;
			margin:10px;
		}
		#stdEnroll th{
		    border-right: 1px solid #ccc;
		    border-bottom: 1px solid #ccc;
		    border-top: 1px solid #fff;
		    border-left: 1px solid #fff;
			background: #eee;
		}
		.trRemove td{
			border-left: 1px solid #ccc;
		 	border-right: 1px solid #ccc;
		    border-bottom: 1px solid #ccc;
		}
		#span{
			width:1000px;
			height:30px;
			background-color :#e2e2e2;
			position : absolute;
			left :260px;
			top:115px;
		}
	</style>
</head>
<body>
			<div id="menu">
					<span>${sessionScope.loginId}</span>님 환영합니다.
					<a href="./s01.jsp">HOME</a>
					<a href="./m02.jsp">비밀번호변경</a>
					<a href="./logout">LOGOUT</a>
			</div>
			<div id="navi">
				<div><a href="./s02-main.jsp">학적</a></div>
				<div><a href="./s08.jsp">과목게시판</a></div>
				<div id="navi3"><a href="./s15-main.jsp">수강신청</a></div>
			</div>
			<div id="sub">
				<div><a href="./s15-main.jsp">과목조회</a></div>
				<div ><a href="./s16.jsp">수강신청</a></div>
				<div id="s17"><a href="./s17.jsp">신청과목조회</a></div>
			</div>
			<div id=span>
				<span  style="font-weight:bold">${sessionScope.loginId}</span>학생의 수강 신청 과목 조회 내역
			</div>
			<table> 
			<tr id="stdEnroll">
				<th>학기</th>
				<th>학과명</th>
				<th>과목명</th>
				<th>교수명</th>
				<th>강의실</th>
				<th>강의시간</th>
				<th>이수구분</th>
				<th>학점</th>
				<th>제한인원</th>
			</tr>
			</table>
</body>
<script>
	$(document).ready(function(){

			/* ready 되면서 특정학생이 수강 신청한 과목 조회 */
			$.ajax({
				type:"POST",
				url:"./stdEnroll",
				data:{
					"loginId" :"${sessionScope.loginId}",
					"term_id":"2018-2"
				},
				dataType:"JSON",
				success:function(data){
					console.log(data);
					if(".trRemove"!=null){
						//tr 제거
						console.log("tr제거");
						$(".trRemove2").remove();
					}
					// 수강신청 과목 리스트 담을 변수 선언
					var listAppend;
					for(var i =0; i<data.searchList.length; i++){
						listAppend+="<tr class='trRemove'>"
						listAppend+="<td>"+data.searchList[i].term_id+"</td>"
						listAppend+="<td>"+data.searchList[i].major_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_name+"</td>"
						listAppend+="<td>"+data.searchList[i].pro_name+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_room+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_time+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_type+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_credit+"</td>"
						listAppend+="<td>"+data.searchList[i].subject_limit+"</td>"
						listAppend+="</tr>"
					}
						$("#stdEnroll").after(listAppend);
				},
				error:function(error){
					console.log(error);
				}
			});
	});
	


</script>
</html>
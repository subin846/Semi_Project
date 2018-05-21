<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title></title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>    
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
				color: white;
				font-size: large;
				font-weight: bold;
			}
			#navi div:hover{
				background-color: #4375DB;
			}
			#update{
				position: absolute;
				left:700px;
				top:720px;
			}
		</style>
	</head>
	<body>
		<div id="menu">
			<span></span><!-- 님 환영합니다 -->
				<script>
					var loginId ="${sessionScope.loginId}";
					if(loginId == ""){
						alert("로그인이 필요한 서비스 입니다.");
						location.href="index.jsp";
					}else{
						var content = loginId+" 님 환영합니다 ";
						document.getElementById("menu").innerHTML = content;
					}
				</script>
			<a href="./s01.jsp">HOME</a>
			<a href="./m02.jsp">비밀번호변경</a>
			<a href="./logout">LOGOUT</a>
		</div>
		<div id="navi">
			<div id="std">학적</div>
			<div id="subBbs">과목게시판</div>
			<div id="enroll">수강신청</div>
		</div>
	</body>
	<div>
		<jsp:include page="s08_main2.jsp"></jsp:include>
		<jsp:include page="p03_std.jsp"></jsp:include>
	</div>
	<form action="slecturePlanUpdateForm" method="get">
		<div>
			<button id="update" >수정</button>
		</div>
	</form>
	<script>
	$(document).ready(function() {
		//수정 버튼 감추기
		$("#update").hide();
		// 학생이 신청한 과목 select 태그에 추가
		$.ajax({
			type: "post",
			url: "./selectStdSubject",
			dataType: "json",
			data: {
				"loginId": "${sessionScope.loginId}"
			},
			 success: function(data) {
				var str = "";
				for (var i = 0; i < data.subjectList.length; i++) {
					str += "<option value='" + data.subjectList[i] + "'>" 
						+ data.subjectList[i] 
						+ "</option>";
						console.log(data.subjectList[i]);
				}
				$("#list").append(str);
			} 
		});
	

	// 과목 선택 시
	 $("#list").change(function() {
		//수정 버튼 보여주기
		 $("#update").show();
		// 과목 선택이 아닌 실제 과목을 선택한 경우
		if ($(this).val() != "default") {
		
			$.ajax({
				type: "post",
				url: "./slecturePlan",
				dataType: "json",
				data: {
					"loginId": "${sessionScope.loginId}",
					"subject": $(this).val() 
				},
				success: function(data) {
					// 태그에 가져온 데이터 넣기
				
					$("#major").html(data.dto.major_name);
					$("#term").html(data.dto.term_id);
					$("#subject").html(data.dto.subject_name);
					$("#class").html(data.dto.std_year);
					$("#major_type").html(data.dto.subject_type);
					$("#score").html(data.dto.subject_credit.toLocaleString());
					$("#pro").html(data.dto.pro_name);
					$("#time").html(data.dto.subject_time);
					$("#email").html(data.dto.pro_email);
					$("#classroom").html(data.dto.subject_room);
					$("#cu").html(data.dto.plan_cu);
					$("#planbook").html(data.dto.plan_book);
					$("#objective").html(data.dto.subject_objective);
					$("#sub_book").html(data.dto.plan_sub_book);
				}
			});
		} 
	}); 
});
	</script>
</html>
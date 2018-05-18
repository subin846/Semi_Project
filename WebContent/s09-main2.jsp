<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title></title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>    
		<style>
			select {
				width: 150px;
				height: 30px;
				margin-bottom: 15px;
				margin-top: 15px;
				margin-left: 10px
			}
 			#sub a{
				text-decoration: none;
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
				padding-top: 15px;
				font-size: 17px;
				font-weight: bold;
				color: black;
				margin-left: 10px;
			}
			#sub div:hover {
				text-decoration: underline;
			}
		</style>
	</head>
	<body>
		<div id="sub">
			<select id="list">
			<option value="" selected="selected">과목선택</option>
			</select>
			<!-- <div id="plan"><a href="s09-main.jsp">강의계획서</a></div>
			<div id="lectureNote"><a href="./list">강의자료</a></div>
			<div id="upload"><a href="./list">과제</a></div>
			<div id="grade"><a href="#">강의평가</a></div>
		</div> -->
			<div id="plan"><a href="s09-main.jsp">강의계획서</a></div>
			<div id="lectureNote"><a href="s09.jsp">강의자료</a></div>
			<div id="upload"><a href="s11.jsp">과제</a></div>
			<div id="grade"><a href="s14.jsp">강의평가</a></div>
		</div>
	</body>
	</body>
		<script>
		$(document).ready(function() {
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
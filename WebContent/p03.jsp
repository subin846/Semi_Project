<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="loginCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<style>
			table, tr, th, td {
				border: thin solid black;
				border-collapse: collapse;
				padding: 5px;
				text-align: center;
			}
			th, td {
				width: 150px;
				height: 40px;
			}
			th {
				background-color: #F6F6F6;
			}
			#termSel {
				width: 150px;
				height: 30px;
			}
			#s04 {
				text-decoration: underline;
			}
			#major {
				text-align: right;
				background-color: white;
				border-left-color: white;
				border-right-color: white;
			}
			#plan {
				text-decoration: underline;
			}
			#listTable{
				width: 75%;
				margin-top: 1%;
				margin-left: 22%;
				margin-right: 20%;
				font-size: small;
			}
			#btn button{
				float: right;
				margin-right: 1%;
				margin-top: 1%;
			}
		</style>
	</head>
	<body>
	<div>
		<jsp:include page="p04-main.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="p04-main2.jsp"></jsp:include>
	</div>
		<table id="listTable">
			<tr>
				<th id="plan" colspan="6">강 의 계 획 서</th>
			</tr>
			<tr>
				<th id="major" colspan="6"></th>
			</tr>
			<tr>
				<th>학기</th>
				<td id="term" colspan="2"></td>
				<th>교과목명</th>
				<td id="subject" colspan="2"></td>
			</tr>
			<tr>
				<th>학년-분반</th>
				<td id="class"></td>
				<th>이수구분</th>
				<td id="major_type"></td>
				<th>학점</th>
				<td id="score"></td>
			</tr>
			<tr>
				<th>담당교수</th>
				<td id="pro" colspan="3"></td>
				<th>시수</th>
				<td id="time"></td>
			</tr>
			<tr>
				<th>E-Mail</th>
				<td id="email" colspan="2"></td>
				<th>교육장소</th>
				<td id="classroom" colspan="2"></td>
			</tr>
			<tr>
				<th colspan="6">교과목 개요 및 특징</th>
			</tr>
			<tr>
				<td colspan="6" id="cu"></td>
			</tr>
			<tr>
				<th colspan="6">교과목표</th>
			</tr>
			<tr>
				<td colspan="6" id="objective"></td>
			</tr>
			<tr>
				<th colspan="3" rowspan="2">교재</th>
				<th>주교재</th>
				<td colspan="2" id ="planbook"></td>
			</tr>
			<tr>
				<th>부교재</th>
				<td colspan="2" id ="sub_book"></td>
			</tr>
		</table>
		<div id="btn">
		<button id="update">수정</button>
		<button id="regist">등록</button>
		</div>
	</body>
	<script>
		$(document).ready(function() {
			// 교수가 강의 하는 과목 select 태그에 추가
			$.ajax({
				type: "post",
				url: "./selectProSubject",
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
					 /* success: function(data) {
						var str = "";
						for (var i = 0; i < data.subjectList.length; i++) {
							str += "<option value='" + data.subjectList[i] + "'>" 
								+ data.subjectList[i]
								+ "</option>";
								console.log(data.subjectList[i]);
						}  */
					$("#list").append(str);
				} 
			});
		
			// 과목 선택 시
		 $("#list").change(function() {
			// 과목 선택이 아닌 실제 과목을 선택한 경우
			if ($(this).val() != "default") {
				
				$.ajax({
					type: "post",
					url: "./plecturePlan",
					dataType: "json",
					data: {
						"loginId": "${sessionScope.loginId}",
						"subject": $("#list option:selected").val() //과목이름 : sub1~sub4 들어감.
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
						
						
						/* if(data){
							listPrint(data.subjectList)
						}else{
							alert("과목을 다시 선택해주세요");
						
					}
					ajaxCall(obj); */
				
				
				
					
				}
			});
		} 
	}); 
});
		$("#regist").click(function(){
			var subject_id =  $("#list option:selected").val();
			console.log(subject_id);
			
			/* $.ajax({
				type: "post",
				url: "./plecturePlan",
				dataType: "json",
				data: {
					"loginId": "${sessionScope.loginId}",
					"subject": $("#list option:selected").val() //과목이름 : sub1~sub4 들어감.
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
					$("#sub_book").html(data.dto.plan_sub_book); */
					
			
			location.href="p03w.jsp?subject_id="+subject_id;
				
			
		 
	}); 

		
		$("#update").click(function(){
			var loginId = "${sessionScope.loginId}";
			var subject_id =  $("#list option:selected").val();
			console.log(subject_id);
			/* location.href="./planUpdatePage?loginId="+loginId+"&subject_id="+subject_id; */
			location.href="./p03u.jsp?loginId="+loginId+"&subject_id="+subject_id;
		});
		
/* 		function listPrint(subjectList){
	   		var content ="";
	   		 $("#listTable").html("<table id='listTable'><tr><th id='plan' colspan='6'>강 의 계 획 서</th></tr>"
	   		+"<tr><th id='major' colspan='6'></th></tr><tr><th>학기</th><td id='term' colspan='2'></td>"
			+"<th>교과목명</th><td id='subject' colspan='2'></td></tr><tr><th>학년-분반</th>"
			+"<th>이수구분</th><td id='major_type'></td><th>학점</th><td id='score'></td></tr>"
			+"<tr><th>담당교수</th><td id='pro' colspan='3'></td><th>시수</th><td id='time'></td>"
			+"</tr><tr><th>E-Mail</th><td id='email' colspan='2'></td><th>교육장소</th>"
			+"<td id='classroom' colspan='2'></td></tr><tr><th colspan='6'>교과목 개요 및 특징</th>"
			+"</tr><tr><td colspan='6' id='cu'></td></tr><tr><th colspan='6'>교과목표</th>"
			+"</tr><tr><td colspan='6' id='objective'></td></tr><tr><th colspan='3' rowspan='2'>교재</th>"
			+"<th>주교재</th><td colspan='2' id ='planbook'></td></tr><th>부교재</th>"
			+"<td colspan='2' id ='sub_book'></td><tr></tr></table>"); //테이블 초기화
	
	   		subjectList.forEach(function(item){
	   		    content += "<tr>";
	   			content += "<td>"+item.schedule_content+"</td>";
	   			content += "</tr>";  
	   			
	   			content += "<tr>";
	   			content += "<td>"+item.term_id+"</td>";
	   			content += "</tr>";
	   			
	   		});
	   		$("#listTable").append(content);
	   	}
		
		function ajaxCall(param){
			console.log("ajax 호출")
			$.ajax(obj);
		} */
		
	</script>
</html>
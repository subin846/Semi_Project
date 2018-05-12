<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="loginCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			#content {
				float: left;
				margin: 10px 0px;
			}
			table, tr, th, td {
				border: thin solid lightgray;
				border-collapse: collapse;
				padding: 5px 10px;
				text-align: center;
			}
			th {
				background-color: #F6F6F6;
			}
			#container {
				width: 1920px;
			}
			#sub1 {
				text-decoration: underline;
			}
			/* 최초에는 테이블이 안보임 */
			#tableList {
				visibility: hidden;
				width: 800px;
			}
		</style>
	</head>
	<body>
		<jsp:include page="p_top_menu.jsp"/>
		<div id="container">
			<jsp:include page="p_sub_menu3.jsp"/>
			<div id="content">
				<div id="msg">과목을 선택하세요.</div>
				<table id="tableList">
				</table>
			</div>
		</div>
	</body>
	<script>
		// 파라미터를 통해 과목 선택
		$("#selSubject").val("${ param.subject_id }").prop("selected", true);
		// 리스트 출력
		loadStudent();
	
		// 과목 변경 시
		$("#selSubject").change(function() {
			loadStudent();
		});
		
		// 학생 리스트 출력 함수
		function loadStudent() {
			// 과목을 선택하지 않았을 경우
			if ($("#selSubject").val() == "default") {
				$("#msg").show(); // 과목 선택 메시지 보여줌
				$("#tableList").css("visibility", "hidden"); // 테이블 숨김
			}
			// 과목을 선택했을 경우
			else {
				$("#msg").hide(); // 과목 선택 메시지 숨김
				$("#tableList").css("visibility", "visible"); // 테이블 보여줌
				
				// 과목 아이디를 보내고 수강하는 학생 리스트 받아옴
				$.ajax({
					url: "./studentSearch",
					type: "post",
					data: {"subjectId": $("#selSubject").val()},
					dataType: "json",
					success: function(data) {
						// 수강생이 없는 경우
						if (data.studentList.length == 0) {
							$("#tableList").css("visibility", "hidden"); // 테이블 숨김
							alert("수강생이 없습니다.");
						}
						// 수강생이 있는 경우
						else {
							var str = "<tr><th></th><th>학번</th><th>학년</th><th>이름</th>"
								+ "<th>전공</th><th>연락처</th><th>이메일</th></tr>";
							for (var i = 0; i < data.studentList.length; i++) {
								var dto = data.studentList[i];
								var index = i+1;
								str += "<tr><td>"+index+"</td><td>"+dto.std_id
									+"</td><td>"+dto.std_year+"</td><td>"+dto.std_name+"</td>"
									+"<td>"+dto.major_name+"</td><td>"+dto.std_phone
									+"</td><td>"+dto.std_email+"</td></tr>";
							}
							$("#tableList").html(str);
						}
					}
				});
			}
		}
		/*
		// 과목 변경 시
		$("#selSubject").change(function() {
			// 과목을 선택하지 않았을 경우
			if ($("#selSubject").val() == "default") {
				$("#msg").show(); // 과목 선택 메시지 보여줌
				$("#tableList").css("visibility", "hidden"); // 테이블 숨김
			}
			// 과목을 선택했을 경우
			else {
				$("#msg").hide(); // 과목 선택 메시지 숨김
				$("#tableList").css("visibility", "visible"); // 테이블 보여줌
				
				// 과목 아이디를 보내고 수강하는 학생 리스트 받아옴
				$.ajax({
					url: "./studentSearch",
					type: "post",
					data: {"subjectId": $("#selSubject").val()},
					dataType: "json",
					success: function(data) {
						// 수강생이 없는 경우
						if (data.studentList.length == 0) {
							$("#tableList").css("visibility", "hidden"); // 테이블 숨김
							alert("수강생이 없습니다.");
						}
						// 수강생이 있는 경우
						else {
							var str = "<tr><th></th><th>학번</th><th>학년</th><th>이름</th>"
								+ "<th>전공</th><th>연락처</th><th>이메일</th></tr>";
							for (var i = 0; i < data.studentList.length; i++) {
								var dto = data.studentList[i];
								var index = i+1;
								str += "<tr><td>"+index+"</td><td>"+dto.std_id
									+"</td><td>"+dto.std_year+"</td><td>"+dto.std_name+"</td>"
									+"<td>"+dto.major_name+"</td><td>"+dto.std_phone
									+"</td><td>"+dto.std_email+"</td></tr>";
							}
							$("#tableList").html(str);
						}
					}
				});
			}
		});
		*/
	</script>
</html>
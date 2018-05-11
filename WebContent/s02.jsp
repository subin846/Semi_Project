<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="loginCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
	table, tr, th, td {
		border: thin solid lightgray;
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
	#s02 {
		text-decoration: underline;
	}
</style>
</head>
<body>
	<div id="subdiv">
		<table>
			<tr>
				<th>학번</th>
				<td id="std_id"></td>
			</tr>
			<tr>
				<th>학년</th>
				<td id="std_year"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td id="std_name"></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td id="std_birthday"></td>
			</tr>
			<tr>
				<th>전공</th>
				<td id="major_name"></td>
			</tr>
			<tr>
				<th>상태</th>
				<td id="std_state"></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td id="std_phone"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td id="std_email"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td id="std_address"></td>
			</tr>
		</table>
	</div>
</body>
<script>
	$(document).ready(function() {
		// 신상정보 가져오기
		$.ajax({
			type: "post",
			url: "./sProfile",
			dataType: "json",
			data: {
				"loginId": '${sessionScope.loginId}'
			},
			success: function(data) {
				$("#std_id").html(data.dto.std_id);
				$("#std_year").html(data.dto.std_year);
				$("#std_name").html(data.dto.std_name);
				$("#std_birthday").html(data.dto.std_birthday);
				$("#major_name").html(data.dto.major_name);
				$("#std_state").html(data.dto.std_state);
				$("#std_phone").html(data.dto.std_phone);
				$("#std_email").html(data.dto.std_email);
				$("#std_address").html(data.dto.std_address);
			}
		});
	});
</script>
</html>

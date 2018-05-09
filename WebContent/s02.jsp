<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<style>
	table, tr, th, td {
		border: thin solid black;
		border-collapse: collapse;
		padding: 5px;
	} 
</style>
</head>
<body>
	<div id="subdiv">
		<table>
			<tr>
				<td>학번</td>
				<td id="std_id"></td>
			</tr>
			<tr>
				<td>학년</td>
				<td id="std_year"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td id="std_name"></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td id="std_birthday"></td>
			</tr>
			<tr>
				<td>전공</td>
				<td id="major_name"></td>
			</tr>
			<tr>
				<td>상태</td>
				<td id="std_state"></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td id="std_phone"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td id="std_email"></td>
			</tr>
			<tr>
				<td>주소</td>
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

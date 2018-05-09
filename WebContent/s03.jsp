<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				width: 80px;
				height: 40px;
			}
		</style>
	</head>
	<body>
		<table>
			<tr>
				<th></th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
			</tr>
			<tr id="1">
				<th>1교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="2">
				<th>2교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="3">
				<th>3교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="4">
				<th>4교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="5">
				<th>5교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="6">
				<th>6교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="7">
				<th>7교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="8">
				<th>8교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
			<tr id="9">
				<th>9교시</th>
				<td class="월"></td>
				<td class="화"></td>
				<td class="수"></td>
				<td class="목"></td>
				<td class="금"></td>
			</tr>
		</table>
	</body>
	<script>
		$(document).ready(function() {
			$.ajax({
				type: "post",
				url: "./sTimetable",
				dataType: "json",
				data: {
					"loginId": '${sessionScope.loginId}'
				},
				success: function(data) {
					for (var i = 0; i < data.list.length; i++) {
						var str = data.list[i].subject_time;
						var week = str.charAt(0); // 요일
						var time1 = str.substring(1,2); // 시간1
						var time2 = str.substring(2); // 시간2
						var name = data.list[i].subject_name; // 과목이름
						var room = data.list[i].subject_room; // 강의실
						
						$("#" + time1 + " ."+week).html(name+"<br/>"+room);
						$("#" + time2 + " ."+week).html(name+"<br/>"+room);
					}
				}
			});
		});
	</script>
</html>
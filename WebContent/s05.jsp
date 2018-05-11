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
				width: 200px;
				height: 40px;
			}
			th {
				background-color: #F6F6F6;
			}
			#s05 {
				text-decoration: underline;
			}
		</style>
	</head>
	<body>
		<table id="scholarTable">
			<tr>
				<th>학기</th>
				<th>장학금 종류</th>
				<th>장학금 금액</th>
			</tr>
		</table>
	</body>
	<script>
		$(document).ready(function() {
			// 장학금 정보 가져오기
			$.ajax({
				type: "post",
				url: "./scholar",
				dataType: "json",
				data: {
					"loginId": "${sessionScope.loginId}"
				},
				success: function(data) {
					var str = "";
					for (var i = 0; i < data.scholarList.length; i++) {
						// 장학금이 있는 경우만 출력(0원이 아닌 경우)
						if (data.scholarList[i].scholar_money != 0) {
							str += "<tr>"
								+ "<td>" + data.scholarList[i].term_id + "</td>"
								+ "<td>" + data.scholarList[i].scholar_name + "</td>"
								+ "<td>" + data.scholarList[i].scholar_money.toLocaleString() + "</td>"
								+ "</tr>";
						}
					}
					$("#scholarTable").append(str);
				}
			});
		});
	</script>
</html>
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
				margin-top: 10px;
			}
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
			#container {
				width: 1920px;
			}
			#sub1 {
				text-decoration: underline;
			}
		</style>
	</head>
	<body>
		<jsp:include page="p_top_menu.jsp"/>
		<div id="container">
			<jsp:include page="p_sub_menu1.jsp"/>
			<div id="content">
				<table>
					<tr>
						<th>사번</th>
						<td>${ dto.pro_id }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${ dto.pro_name }</td>
					</tr>
					<tr>
						<th>학과</th>
						<td>${ dto.major_name }</td>
					</tr>
					<tr>
						<th>연구실</th>
						<td>${ dto.pro_room }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${ dto.pro_phone }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${ dto.pro_email }</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
	<script>
	</script>
</html>
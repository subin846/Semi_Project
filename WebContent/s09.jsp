<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>|||강의자료|||</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
	table,th,td{
		border-top: 2px solid #D5D5D5;
		border-bottom: 2px solid #D5D5D5;
		color: #4C4C4C;
		border-collapse: collapse;
		text-align: center;
		padding: 10px;
	}
	#bbs th{
		font-size: 15px;
	}
	#bbs{
				width: 75%;
				margin-top: 3%;
				margin-left: 22%;
				margin-right: 20%;
				font-size: small;
			}
</style>
</head>
<body>
	<div id="main">
		<jsp:include page="s09-main.jsp"/>
	</div>

	<div id="bbs">
		<table id="listTable" width="100%">
			<tr>
				<th width="15%">글번호</th>
				<th width="50%">제목</th>
				<th width="20%">작성자</th>
				<th width="15%">작성일</th>
			</tr>
			<c:forEach items="${list}" var="lecturebbs">
				<tr>
					<td>${lecturebbs.bbs_number}</td>
					<td><a href="./detail?bbs_number=${lecturebbs.bbs_number}">${lecturebbs.bbs_title}</a> </td>
					<td>${lecturebbs.bbs_writer}</td>
					<td>${lecturebbs.bbs_date}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>
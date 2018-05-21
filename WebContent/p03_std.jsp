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
				background-color: white;
				font-size: 25px;
			}
			#p{
				margin-left: 22%;
				margin-top: 3%;
			}
		</style>
	</head>
	<body>
	<div>
		<jsp:include page="p03-main.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="p03_lecture2.jsp"></jsp:include>
	</div>
		<table id="p">
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
				<th>부교재</th>
				<td colspan="2" id ="sub_book"></td>
			<tr>
			</tr>
		</table>
	</body>
	<script>
		
	</script>
</html>
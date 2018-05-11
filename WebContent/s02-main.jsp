<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="loginCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>학적</title>
		<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
		<style>
			body{
				margin: 0px; /* body와 div 사이 공백 제거 */
			}
			#menu{
				overflow:hidden;
				float: right;
				font-weight: 600;
				font-size:12px;
				margin: 15px 0px 15px 0px;
			}
			#menu a{
				text-decoration: none;
				border-left: 1px solid #c0c0c0;
				padding: 0px 10px 0px 14px;
				color: black;
			}
			#navi{
				width: 100%;
				height: 60px;
				background-color: #9DCFFF;
				margin-top: 20px;
				overflow:hidden;
			}
			#navi div{
				display: inline;
				height: 30px;
				padding: 17px 50px 13px 50px;
				background-color: #9DCFFF;
				float: left;
			}
			#navi div:hover{
				background-color: #4375DB;
			}
			#navi a{
				text-decoration: none;
				color: white;
				font-size: large;
				font-weight: bold;
			}
 			#sub a{
				text-decoration: none;
				font-size: 17px;
				font-weight: bold;
				color: black;
				margin-left: 10px;
			}
			#sub{
				margin: 10px;
				width: 230px;
				height: 400px;
				border: 1px solid #c0c0c0;
				background-color: #F6F6F6;
				float: left;
			}
			#sub div{
				height: 40px;
				padding-top: 15px;
				cursor: pointer;
			}
			#sub div:hover {
				text-decoration: underline;
			}
			#navi #navi1 {
				background-color: #4375DB;
			}
			#subPage {
				float: left;
				margin:10px;
			}
		</style>
	</head>
	<body>
		<div id="menu">
				<span>${ sessionScope.loginId }</span>님 환영합니다
				<a href="./s01.jsp">HOME</a>
				<a href="#">비밀번호변경</a>
				<a href="./logout">LOGOUT</a>
		</div>
		<div id="navi">
			<div id="navi1"><a href="#">학적</a></div>
			<div><a href="#">과목게시판</a></div>
			<div><a href="#">수강신청</a></div>
		</div>
		<div id="sub">
			<div id="s02"><a>신상조회</a></div>
			<div id="s03"><a>시간표조회</a></div>
			<div id="s04"><a>등록금고지서</a></div>
			<div id="s05"><a>장학금조회</a></div>
			<div id="s06"><a>성적조회</a></div>
			<div id="s07"><a>학점계산기</a></div>
		</div>
		<div id="subPage">
			<jsp:include page="s02.jsp"></jsp:include>
		</div>
	</body>
	<script>
		// 신상조회 클릭
		$("#s02").click(function() {
			$("#subPage").load("s02.jsp");
		});
		
		// 시간표 조회 클릭
		$("#s03").click(function() {
			$("#subPage").load("s03.jsp");
		});
		
		// 등록금고지서 클릭
		$("#s04").click(function() {
			$("#subPage").load("s04.jsp");
		});
		
		// 장학금조회 클릭
		$("#s05").click(function() {
			$("#subPage").load("s05.jsp");
		});
		
		// 성적조회 클릭
		$("#s06").click(function() {
			$("#subPage").load("s06.jsp");
		});
		
		// 학점계산기 클릭
		$("#s07").click(function() {
			$("#subPage").load("s07.jsp");
		});
	</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src =" https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<title>Insert title here</title>
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
			#navi #navi3{
				background-color: #4375DB;
			}
 			#sub a{
				text-decoration: none;
				font-size: 17px;
				font-weight: bold;
				color: black;
				margin-left: 10px;
			}
			#sub{
				margin-top: 1%;
				width: 230px;
				height: 400px;
				border: 1px solid #c0c0c0;
				margin-left: 1%;
				background-color: #F6F6F6;
				float: left; 
			}
			 #sub div{
				height: 40px;
				padding-top: 50px;
			} 
			#sub div:hover {
				 text-decoration: underline; 
			}
		</style>
	</head>
	<body>
			<div id="menu">
					<span>${sessionScope.loginId}</span>님 환영합니다
					<a href="./s01.jsp">HOME</a>
					<a href="./m02.jsp">비밀번호변경</a>
					<a href="./logout">LOGOUT</a>
			</div>
			<div id="navi">
				<div><a href="./s02-main.jsp">학적</a></div>
				<div><a href="./s08.jsp">과목게시판</a></div>
				<div id="navi3"><a href="./s15-main.jsp">수강신청</a></div>
			</div>
			<div id="sub">
				<div id="s15"><a href="./s15-main.jsp">과목조회</a></div>
				<div><a href="./s16.jsp">수강신청</a></div>
				<div><a href="./s17.jsp">신청과목조회</a></div>
			</div>
			<div id ="import">
				<%@include file="s15.jsp" %> 
			</div>
	<script>
		/* 과목 조회 메뉴 클릭시 */
		$("#s15").click(function(){
			$("#import").load("s15.jsp");
		});
	</script>
</html>



















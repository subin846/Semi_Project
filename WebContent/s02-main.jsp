<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
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
			select {
				width: 150px;
				height: 30px;
				margin-bottom: 15px;
				margin-top: 15px;
				margin-left: 10px
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
				padding-top: 15px;
			}
			#sub div:hover {
				text-decoration: underline;
			}
			#navi #navi1 {
				background-color: #4375DB;
			}
			
			#imp {
				margin-top: 1%;
				margin-left: 1%;
			}
		</style>
	</head>
	<body>
		<div id="menu">
				<span></span>님 환영합니다
				<a href="#">HOME</a>
				<a href="#">비밀번호변경</a>
				<a href="#">LOGOUT</a>
		</div>
		<div id="navi">
			<div id="navi1"><a href="#">학적</a></div>
			<div><a href="#">과목게시판</a></div>
			<div><a href="#">수강신청</a></div>
		</div>
		<div id="sub">
			<div><a href="#">신상조회</a></div>
			<div><a href="#">시간표조회</a></div>
			<div><a href="#">등록금고지서</a></div>
			<div><a href="#">장학금</a></div>
			<div><a href="#">성적</a></div>
			<div><a href="#">학점계산기</a></div>
		</div>
		<div id="imp">
			<%@ include file="s02.jsp" %>
		</div>
	</body>
	<script>
	
	</script>
</html>
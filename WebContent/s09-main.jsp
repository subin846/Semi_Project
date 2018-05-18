<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title></title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>    
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
				color: white;
				font-size: large;
				font-weight: bold;
			}
			#navi div:hover{
				background-color: #4375DB;
			}
		</style>
	</head>
	<body>
		<div id="menu">
			<span>${sessionScope.loginId}</span>님 환영합니다
			<a href="#">HOME</a>
			<a href="#">비밀번호변경</a>
			<a href="#">LOGOUT</a>
		</div>
		<div id="navi">
			<div id="std">학적</div>
			<div id="subBbs">과목게시판</div>
			<div id="enroll">수강신청</div>
		</div>
	</body>
</html>
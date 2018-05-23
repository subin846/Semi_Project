<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
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
				cursor: pointer;
			}
			#navi div:hover{
				background-color: #4375DB;
			}
		</style>
	</head>
	<body>
		<div id="menu">
			<span>${ sessionScope.loginId }</span>님 환영합니다
			<a href="./pmain">HOME</a>
			<a href="./m02.jsp">비밀번호변경</a>
			<a href="./logout">LOGOUT</a>
		</div>
		<div id="navi">
			<div id="navi1">내 정 보</div>
			<div id="navi2">과목게시판</div>
			<div id="navi3">강 의</div>
		</div>
	</body>
	<script>
		// 내정보 클릭
		$("#navi1").click(function() {
			location.href="pProfile";
		});
		// 과목게시판 클릭
		$("#navi2").click(function() {
			location.href="./p03.jsp";
		});
		// 강의 클릭
		$("#navi3").click(function() {
			location.href="studentSearchPage?subject_id=default";
		});
	</script>
</html>
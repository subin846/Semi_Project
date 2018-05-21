<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
				display: none;
			}
			#sub{
				margin-top: 1%;
				width: 230px;
				height: 400px;
				border: 1px solid #c0c0c0;
				margin-left: 1%;
				background-color: #F6F6F6;
				float: left;
				display: none;
			}
			#sub div{
				height: 40px;
				padding-top: 15px;
				display: none;
			}
			#sub div:hover {
				text-decoration: underline;
				display: none;
			}
		</style>
	</head>
	<body>
		<div id="menu">
			<span></span>
				<script>
					var loginId ="${sessionScope.loginId}";
					if(loginId == ""){
						alert("로그인이 필요한 서비스 입니다.");
						location.href="index.jsp";
					}else{
						var content = loginId+" 님 환영합니다 ";
						document.getElementById("menu").innerHTML = content;
					}
				</script>
					<a href="./s01.jsp">HOME</a>
					<a href="./m02.jsp">비밀번호변경</a>
					<a href="./logout">LOGOUT</a>
		</div>
		<div id="navi">
			<div><a href="./s02-main.jsp">학적</a></div>
			<div><a href="./s08.jsp">과목게시판</a></div>
			<div><a href="./s15-main.jsp">수강신청</a></div>
		</div>
		<div id="sub">
			<select>
				<option>과목선택</option>
				<option>과목1</option>
				<option>과목2</option>
				<option>과목3</option>
			</select>
			<div><a href="#">강의계획서</a></div>
			<div><a href="#">강의자료</a></div>
			<div><a href="#">과제제출</a></div>
			<div><a href="#">강의평가</a></div>
		</div>
		<jsp:include page="s01_calender.jsp"></jsp:include>
	</body>
</html>
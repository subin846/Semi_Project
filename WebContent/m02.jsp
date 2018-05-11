<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>비밀번호 변경</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<style></style>
	</head>
	<body>
	<form action="passChange" method="post">
		현재 비밀번호 	 	  : <input id="writePass" type="password" name="Pass"> <input type ="button" id="passCheck" value="현재 비밀번호 확인">
		<br/>
		새로운 비밀번호 	  : <input id ="writeNewPass" type="password" name="newPw">
		<br/>
		새로운 비밀번호 확인 : <input id = "newPassCheck" type="password" name="newPwCheck">
		<br/>
		<!-- <input type="submit" value="저장">  -->
		<button id = "save">저장</button>
		<input type ="hidden" name="loginId" value="${sessionScope.loginId}">
	</form>
	</body>
	<script>
	var loginPw ="${sessionScope.loginPw}";
	
	$("#passCheck").click(function(){
		if(loginPw==document.getElementById("writePass").value){
			alert("현재의 비밀번호가 일치합니다.");
		}else{
			alert("현재의 비밀번호가 일치하지 않습니다. 다시 확인 해 주세요.");
		}
		//console.log(loginPw);
		//console.log(document.getElementById("writePass").value);
		//console.log(document.getElementById("writeNewPass").value);
		//console.log(document.getElementById("newPassCheck").value);
    });
	
	$("#save").click(function(){
		if(document.getElementById("writeNewPass").value!=document.getElementById("newPassCheck").value){
			alert("새 비밀번호가 일치하지 않습니다. 다시 확인 해 주세요.");
		}else{
			alert("저장이 완료 되었습니다.");
		}
		//console.log(loginPw);
		//console.log(document.getElementById("writePass").value);
		//console.log(document.getElementById("writeNewPass").value);
		
    });
	
	</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
  table,tr,th,td{
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
                width: 1200px;
            }
</style>
</head>
<body>
	<form action="register">
		<table>
			<tr>
				<th>학번</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>학년</th>
				<th>상태</th>
				<th>생일</th>
				<th>핸드폰번호</th>
				<th>주소</th>
				<th>이메일</th>
				<th>전공번호</th>
			</tr>
			<tr>
				<td><input type="text" name="std_id" ></td>
				<td><input type="text" name="std_pw" ></td>
				<td><input type="text" name="std_name" ></td>
				<td><input type="text" name="std_year" ></td>
				<td><input type="text" name="std_state" ></td>
				<td><input type="text" name="std_birthday" ></td>
				<td><input type="text" name="std_phone" ></td>
				<td><input type="text" name="std_address" ></td>
				<td><input type="text" name="std_email" ></td>
				<td><input type="text" name="major_id" ></td>
				<td><input type="submit" value="완료"/> </td>
			</tr>
		</table>
	
	</form>
</body>
</html>
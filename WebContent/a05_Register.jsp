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
	<form action="pAdd">
		<table>
			<tr>
				<th>사번</th>
				<th>비밀번호</th>
	            <th>이름</th>
	            <th>연락처</th>
	            <th>이메일</th>
	            <th>연구실</th>
	            <th>전공</th>
	            <th>완료</th>
			</tr>
			<tr>
				<td><input type="text" name="pro_id" ></td>
				<td><input type="text" name="pro_pw" ></td>
				<td><input type="text" name="pro_name" ></td>
				<td><input type="text" name="pro_phone" ></td>
				<td><input type="text" name="pro_email" ></td>
				<td><input type="text" name="pro_room" ></td>
				<td><input type="text" name="major_id" ></td>
				<td><input type="submit" value="완료"/> </td>
			</tr>
		</table>
	
	</form>
</body>
</html>
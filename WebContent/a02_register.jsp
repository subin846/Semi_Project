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
	<form action="tAdd">
		<table>
			<tr>
				<th>학기</th>
	            <th>학번</th>
	            <th>장학금 코드번호</th>
	            <th>등록금</th>
	            <th>등록</th>
			</tr>
			<tr>
				<td><input type="text" name="term_id" ></td>
				<td><input type="text" name="std_id" ></td>
				<td><input type="text" name="scholar_id" ></td>
				<td><input type="text" name="tuition_money" ></td>
				<td><input type="submit" value="완료"/> </td>
			</tr>
		</table>
	</form>
</body>
</html>
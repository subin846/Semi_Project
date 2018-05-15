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
	<form action="gAdd">
		<table>
			<tr>
	            <th>질문</th>
	            <th>저장</th>
			</tr>
			<tr>
				<td><textarea rows="5" cols="30" name="question_question">내용을 입력하세요.</textarea></td>
				<td><input type="submit" value="완료"/> </td>
			</tr>
		</table>
	</form>
</body>
</html>
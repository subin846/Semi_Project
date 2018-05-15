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
	<form action="suAdd">
		<table>
			<tr>
				<th>과목코드</th>
	            <th>학기</th>
	            <th>학과 코드</th>
	            <th>사번</th>
	            <th>과목명</th>
	            <th>강의실</th>
	            <th>강의시간</th>
	            <th>전공/교양</th>
	            <th>평점</th>
	            <th>학점</th>
	            <th>제한인원</th>
	            <th>저장</th>
			</tr>
			<tr>
				<td><input type="text" name="subject_id" ></td>
				<td><input type="text" name="term_id" ></td>
				<td><input type="text" name="major_id" ></td>
				<td><input type="text" name="pro_id" ></td>
				<td><input type="text" name="subject_name" ></td>
				<td><input type="text" name="subject_room" ></td>
				<td><input type="text" name="subject_time" ></td>
				<td><input type="text" name="subject_type" ></td>
				<td><input type="text" name="subject_grade" ></td>
				<td><input type="text" name="subject_credit" ></td>
				<td><input type="text" name="subject_limit" ></td>
				<td><input type="submit" value="완료"/> </td>
			</tr>
		</table>
	</form>
</body>
</html>
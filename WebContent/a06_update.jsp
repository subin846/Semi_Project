 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
   table,tr,th,td{
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
                width: 1200px;
            }
</style>
 <body>
	    <table id="updateForm">
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
	       		<form action="suUpdate" method="get">
		      		<tr >
		      			<td>${ form.subject_id }<input  type="hidden" name="subject_id" value="${ form.subject_id }"/></td>
		      			<td><input  type="text" name="term_id" value="${ form.term_id }"/></td>
		      			<td><input  type="text" name="major_id" value="${ form.major_id }"/></td>
		      			<td><input  type="text" name="pro_id" value="${ form.pro_id }"/></td>
			            <td><input  type="text" name="subject_name" value="${ form.subject_name }"/></td>
			            <td><input  type="text" name="subject_room" value="${ form.subject_room }"/></td>
			            <td><input  type="text" name="subject_time" value="${ form.subject_time }"/></td>
			            <td><input  type="text" name="subject_type" value="${ form.subject_type }"/></td>
			            <td><input  type="text" name="subject_grade" value="${ form.subject_grade }"/></td>
			            <td><input  type="text" name="subject_credit" value="${ form.subject_credit }"/></td>
			            <td><input  type="text" name="subject_limit" value="${ form.subject_limit }"/></td>
			            <td>
			           		<input type="submit" onclick="click()" value="저장"/>
			            </td>
		       		</tr>
		        </form>
	    </table>
	
</body>
<script>
</script>

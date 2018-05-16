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
	            <th>질문 번호</th>
	            <th>질문 내용</th>
	            <th>저장</th>
	        </tr>
	       		<form action="gUpdate" method="get">
		      		<tr >
		      			<td>${ form.question_id }<input  type="hidden" name="question_id" value="${ form.question_id }"/></td>
			            <td>
			            	<textarea rows="5" cols="30" name="question_question">${ form.question_question }</textarea>
			            </td>
			            <td>
			           		<input type="submit" onclick="click()" value="저장"/>
			            </td>
		       		</tr>
		        </form>
	    </table>
	
</body>
<script>
</script>

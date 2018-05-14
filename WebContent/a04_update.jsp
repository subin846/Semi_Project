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
	            <th>학기</th>
	            <th>학번</th>
	            <th>이름</th>
	            <th>장학금 코드번호</th>
	            <th>저장</th>
	        </tr>
	       		<form action="eUpdate" method="get">
		      		<tr >
			            <input type="hidden" name="tuition_id" value="${form.tuition_id}"/>
			            <td><input type="text" name="term_id" value="${form.term_id}"/></td>
			            <td>${form.std_id}<input type="hidden" name="std_id" value="${form.std_id}"/></td>
			            <td>${form.std_name}</td>
			            <td><input type="text" name="scholar_id" value="${form.scholar_id}"/></td>
			            <td>
			           		<input type="submit" onclick="click()" value="저장"/>
			            </td>
		       		</tr>
		        </form>
	    </table>
	
</body>
<script>
</script>

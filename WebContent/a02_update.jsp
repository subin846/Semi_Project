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
	            <th></th>
	            <th>학기</th>
	            <th>학번</th>
	            <th>이름</th>
	            <th>장학금 종류</th>
	            <th>장학금 금액</th>
	            <th>등록금</th>
	            <th>저장</th>
	        </tr>
	       		<form action="tUpdate" method="get">
		      		<tr >
			            <td></td>
			            <td>${form.term_id}<input type="hidden" name="term_id" value="${form.term_id}"/></td>
			            <td>${form.std_id}<input type="hidden" name="std_id" value="${form.std_id}"/></td>
			            <td>${form.std_name}</td>
			            <td>${form.scholar_name}</td>
			            <td>${form.scholar_money}</td>
			            <td><input type="text" name="tuition_money" value="${form.tuition_money}"/></td>
			            <td>
			           		<input type="submit" onclick="click()" value="저장"/>
			            </td>
		       		</tr>
		        </form>
	    </table>
	
</body>
<script>
</script>

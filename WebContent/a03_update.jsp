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
	            <th>장학금 코드</th>
	            <th>장학금 종류</th>
	            <th>장학금 금액</th>
	            <th>저장</th>
	        </tr>
	       		<form action="scUpdate" method="get">
		      		<tr >
			            <td>${form.scholar_id}<input type="hidden" name="scholar_id" value="${form.scholar_id}"/></td>
			            <td><input type="text" name="scholar_name" value="${form.scholar_name}"/></td>
			            <td><input type="text" name="scholar_money" value="${form.scholar_money}"/></td>
			            <td>
			           		<input type="submit" onclick="click()" value="저장"/>
			            </td>
		       		</tr>
		        </form>
	    </table>
	
</body>
<script>
</script>

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
	            <th>학번</th>
	            <th>학년</th>
	            <th>이름</th>
	            <th>생년 월일</th>
	            <th>상태</th>
	            <th>연락처</th>
	            <th>이메일</th>
	            <th>주소</th>
	            <th>수정</th>
	        </tr>
       		<form action="update" method="get">
	      		<tr >
		            <td></td>
		            <td>${form.std_id}<input type="hidden" name="std_id" value="${form.std_id}"/></td>
		            <td><input type="text" name="std_year" value="${form.std_year}"/></td>
		            <td><input type="text" name="std_name" value="${form.std_name}"/></td>
		            <td><input type="text" name="std_birthday" value="${form.std_birthday}"/></td>
		            <td><input type="text" name="std_state" value="${form.std_state}"/></td>
		            <td><input type="text" name="std_phone" value="${form.std_phone}"/></td>
		            <td><input type="text" name="std_email" value="${form.std_email}"/></td>
		            <td><input type="text" name="std_address" value="${form.std_address}"/></td>
		            <td>
		           		<input type="submit" onclick="click()" value="저장"/>
		            </td>
	       		</tr>
	        </form>
	    </table>
	
</body>
<script>
</script>

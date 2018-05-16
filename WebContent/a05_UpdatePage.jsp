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
	            <th>사번</th>
	            <th>이름</th>
	            <th>연락처</th>
	            <th>이메일</th>
	            <th>연구실</th>
	            <th>전공 코드 번호</th>
	            <th>수정</th>
	        </tr>
       		<form action="pUpdate" method="get">
	      		<tr >
		            <td>${form.pro_id}<input type="hidden" name="pro_id" value="${form.pro_id}"/></td>
		            <td><input type="text" name="pro_name" value="${form.pro_name}"/></td>
		            <td><input type="text" name="pro_phone" value="${form.pro_phone}"/></td>
		            <td><input type="text" name="pro_email" value="${form.pro_email}"/></td>
		            <td><input type="text" name="pro_room" value="${form.pro_room}"/></td>
		            <td><input type="text" name="major_id" value="${form.major_id}"/></td>
		            <td>
		           		<input type="submit" onclick="click()" value="저장"/>
		            </td>
	       		</tr>
	        </form>
	    </table>
	
</body>
<script>
	
</script>
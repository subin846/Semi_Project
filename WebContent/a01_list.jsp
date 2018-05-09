 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <body>
	<div id="div3">
            <form id="selectbox" action="search">
                <input type="radio" name="select" value="studentId"/>학번
                <input type="radio" name="select" value="studentId"/>이름
                <input type="radio" name="select" value="studentId"/>  전공
                <input type="text"/>
                <input type="submit" value="조회"/>
                <input type="button" onclick="location.href='a01_Register.jsp'" value="등록">
            </form>
        </div>
	    <table>
	        <tr>
	            <th>학번</th>
	            <th>학년</th>
	            <th>이름</th>
	            <th>생년 월일</th>
	            <th>상태</th>
	            <th>연락처</th>
	            <th>이메일</th>
	            <th>주소</th>
	            <th>수정</th>
	            <th>삭제</th>
	        </tr>
	        
	        <c:forEach items="${list}" var="bbs">
	       		<form action="updateForm" method="get">
		      		<tr >
			            <td>${bbs.std_id}<input  type="hidden" name="std_id" value="${ bbs.std_id }"/></td>
			            <td>${bbs.std_year}</td>
			            <td>${bbs.std_name}</td>
			            <td>${bbs.std_birthday}</td>
			            <td>${bbs.std_state}</td>
			            <td>${bbs.std_phone}</td>
			            <td>${bbs.std_email}</td>
			            <td>${bbs.std_address}</td>
			            <td>
			           		<input  type="submit" value="수정"/>
			            </td>
			            <td>
			           		<input type="button" onclick="location.href='del?std_id=${bbs.std_id}'" value="삭제"/>
			            </td>
		       		</tr>
		        </form>
	        </c:forEach>
	    </table>
	
</body>
<script>
</script>

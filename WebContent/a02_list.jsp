 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <body>
	<div id="div3">
            <form id="select" action="tSearch">
            	<select name="selectbox">
  					<option value="std_id">학번</option>
				  	<option value="std_name">이름</option>
				 	<option value="term_id">학기</option>
				 	<option value="none"  selected="selected" >-선택하세요-</option>
				</select>
                <input type="text" name="val"/>
                <input type="submit" value="조회"/>
                <input type="button" onclick="location.href='a02_register.jsp'" value="등록">
            </form>
        </div>
	    <table>
	        <tr>
	            <th>학기</th>
	            <th>학번</th>
	            <th>이름</th>
	            <th>장학금 종류</th>
	            <th>장학금 금액</th>
	            <th>등록금</th>
	            <th>실납입액</th>
	            <th>수정</th>
	            <th>삭제</th>
	            
	        </tr>
	        <c:forEach items="${list}" var="bbs">
	       		<form action="tUpdateForm" method="get">
		      		<tr>
			            <td>${bbs.term_id}<input  type="hidden" name="term_id" value="${ bbs.term_id }"/></td>
			            <td>${bbs.std_id}<input  type="hidden" name="std_id" value="${ bbs.std_id }"/></td>
			            <td>${bbs.std_name}</td>
			            <td>${bbs.scholar_name}</td>
			            <td>${bbs.scholar_money}<input  type="hidden" name="scholar_money" value="${ bbs.scholar_money }"/></td>
			            <td>${bbs.tuition_money}<input  type="hidden" name="tuition_money" value="${ bbs.tuition_money }"/></td>
			            <td>${bbs.totalMoney}</td>
			            <td>
			           		<input  type="submit" value="수정"/>
			            </td>
			            <td>
			           		<input type="button" onclick="location.href='tDell?term_id=${bbs.term_id}&std_id=${bbs.std_id}'" value="삭제"/>
			            </td>
		       		</tr>
		        </form>
	        </c:forEach>
	        <c:forEach items="${search}" var="search">
	       		<form action="tUpdateForm" method="get">
		      		<tr >
			            <td>${search.term_id}<input  type="hidden" name="term_id" value="${ search.term_id }"/></td>
			            <td>${search.std_id}<input  type="hidden" name="std_id" value="${ search.std_id }"/></td>
			            <td>${search.std_name}</td>
			            <td>${search.scholar_name}</td>
			            <td>${search.scholar_money}<input  type="hidden" name="scholar_money" value="${ search.scholar_money }"/></td>
			            <td>${search.tuition_money}<input  type="hidden" name="tuition_money" value="${ search.tuition_money }"/></td>
			            <td >${search.totalMoney }</td>
			            <td>
			           		<input  type="submit" value="수정"/>
			            </td>
			            <td>
			           		<input type="button" onclick="location.href='tDell?term_id=${search.term_id}&std_id=${search.std_id}'" value="삭제"/>
			            </td>
		       		</tr>
		        </form>
	        </c:forEach>
	    </table>
</body>

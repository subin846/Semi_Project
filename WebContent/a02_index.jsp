<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>J-QUERY</title>
         <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
       <!--  <script src="jquery-3.3.1.min.js"></script> -->
        <style>
            #div1{
                padding: 20px;
                border: 1px solid black;
                width: 200px;
                height: 90%;
                position: absolute;
            }
            #div2{
                position: relative;
                left: 1320px;
                display: inline;
            }
            #div3{
                background: gray;
                position: relative;
                width: 1200px;
                height: 50px;
                border: none solid black;
                top: 40px;
                left: 300px;
            }
            table,tr,th,td{
                border: 1px solid black;
                border-collapse: collapse;
                text-align: center;
                width: 1200px;
            }
            table{
             position: relative;
                top: 50px;
                left: 300px;
            }
            #selectbox{
                margin: 17px;
            }
        </style>
    </head>
    <body>
        <div id="div1">
            <h3><a href="student">학생 관리</a></h3><br/>
            <h3><a href="tuition"> 등록금 관리</a></h3><br/>
            <h3>장학금 종류 관리</h3><br/>
            <h3>장학금 관리</h3><br/>
            <h3>교수 관리</h3><br/>
            <h3>과목 관리 </h3><br/>
            <h3>강의평가 질문 관리</h3><br/>
            <h3>학사일정 관리 </h3>
        </div>
        <div id="div2">
            학번 /<a href="#"> 비밀번호 변경</a> / <a href="#"> 로그아웃</a>
        </div>
        <div id="subPage" >
       	 	<%@ include file="a02_list.jsp" %>
        </div>
    </body>
    <script>
    </script>
</html>
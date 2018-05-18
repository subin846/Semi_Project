<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>|||강의자료|||</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
		table,th,td{
			border-top: 2px solid #D5D5D5;
			border-bottom: 2px solid #D5D5D5;
			color: #4C4C4C;
			border-collapse: collapse;
			text-align: center;
			padding: 10px;
		}
		#bbs th{
			font-size: 15px;
		}
		#bbs{
					width: 75%;
					margin-top: 3%;
					margin-left: 22%;
					margin-right: 20%;
					font-size: small;
				}
		#bbs button{
			float: right;
			margin-top: 10px;
		}
	</style>
	</head>
	<body>
		<div id="main">
			<jsp:include page="p04-main.jsp"/>
		</div>
		<div>
			<jsp:include page="p04-main2.jsp"/>
		</div>
		<div id="bbs">
			<table id="listTable" width="100%">
				<tr>
					<th width="15%">글번호</th>
					<th width="50%">제목</th>
					<th width="20%">작성자</th>
					<th width="15%">작성일</th>
				</tr>
			</table>
			<button onclick="move()">글작성</button>
		</div>
	</body>
	<script>
	var obj={};
	obj.type="post";
	obj.dataType="json";
	obj.error=function(e){console.log(e)};
	
	//신청과목 셀렉트 박스에 넣기
	$(document).ready(function(){
		obj.url="./prosubjectTab";
		obj.data={
				"id":'${sessionScope.loginId}'
		}
		obj.success=function(data){
			if(data){
				console.log("성공");
				 selectbox(data.prosublist); 
			}else{
				location.href="index.jsp";
			}
		}
		ajaxCall(obj);
	});
	
	$(document).ready(function(){
		obj.url="./listback";
		obj.success=function(data){
			console.log(data);
			if(data){
				console.log(data.main);
				mainPrint(data.main)
			}else{
				alert("과목을 다시 선택해주세요");
			}
		}
		ajaxCall(obj);
	});
	
	//셀렉트 박스에 넣는 반복문
	function selectbox(prosublist) {
		var content ="";
		console.log(prosublist);
		$("#list").html("<option value='과목선택'>과목선택</option>");
		prosublist.forEach(function(item){
				console.log(item);
				content += "<option value="+item.subject_id+">";
				content += item.subject_name;
				content += "</option>";
			});
			$("#list").append(content);
	}
	
	//셀렉트 박스 선택시 리스트 출력
	$("#list").change(function(){
		obj.url="./prolist?mName=강의자료";
		obj.data={selected:$("#list option:selected").val()};
		console.log(obj.data);
		obj.success=function(data){
			if(data){
				console.log(data.list);
				mainPrint(data.list)
			}else{
				alert("과목을 다시 선택해주세요");
			}
		}
		ajaxCall(obj);
	});
	
	function mainPrint(list){
		var content="";
		$("#listTable").html("<table id='listTable' width='100%'><tr>"+"<th width='15%''>글번호</th>"
		+"<th width='50%''>제목</th>"
		+"<th width='20%''>작성자</th>"
		+"<th width='15%'>작성일</th></tr></table>"); //테이블 초기화
		list.forEach(function(item){
			content += "<tr>";
			content += "<td>"+item.bbs_id+"</td>"
			content += "<td><a href='prodetail?idx="+item.bbs_id+"&mName=강의자료&selected="+item.subject_id+"'>"+item.bbs_title+"</td>"
			content += "<td>"+item.bbs_writer+"</td>"
			content += "<td>"+item.bbs_date+"</td>"
		});
		$("#listTable").append(content);
	}
	
	function ajaxCall(param){
		console.log("ajax 호출")
		$.ajax(obj);
	}
	function move(){
		var selected = $("#list option:selected").val();
		location.href="p06.jsp?subject_id="+selected+"&mName=강의자료";
	}
	</script>
</html>
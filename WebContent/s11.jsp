<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>|||과제제출|||</title>
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
	#bbs button{
		float: right;
		margin-top: 10px;
	}
	#bbs{
				width: 75%;
				margin-top: 3%;
				margin-left: 22%;
				margin-right: 20%;
				font-size: small;
			}
</style>
</head>
<body>
<div>
	<jsp:include page="s09-main.jsp"></jsp:include>
</div>
<div>
	<jsp:include page="s09-main2.jsp"/>
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
	
	var sNum=1;
	var eNum=10;
	var idx = "${lecturebbs.bbs_id}";
	
	$(document).ready(function(){
		obj.url="./subjectTab";
		obj.data={
				"id":'${sessionScope.loginId}'
		}
		obj.success=function(data){
			//console.log(data);
			if(data){
				console.log("성공");
				//console.log(data.sublist);
				 selectbox(data.sublist); 
			}else{
				location.href="index.jsp";
			}
		}
		ajaxCall(obj);
	});
	
	function selectbox(list) {
		var content ="";
		console.log(list);
		$("#list").html("<option value='과목선택'>과목선택</option>");
			list.forEach(function(item){
				console.log(item);
				content += "<option value="+item.subject_id+">";
				content += item.subject_name;
				content += "</option>";
			});
			$("#list").append(content);
	}
	
	//셀렉트 박스 선택시 리스트 출력
	$("#list").change(function(){
		obj.url="./uploadlist?mName=과제&sNum=1&eNum=10";
		console.log($("#list option:selected").val());
		obj.data={selected:$("#list option:selected").val()};
		console.log(obj.data);
		obj.success=function(data){
			if(data){
				console.log(data.main);
				mainPrint(data.main)
			}else{
				alert("과목을 다시 선택해주세요");
			}
		}
		ajaxCall(obj);
	});
	
	function mainPrint(main){
		var content="";
		$("#listTable").html("<table id='listTable' width='100%'><tr>"+"<th width='15%''>글번호</th>"
		+"<th width='50%''>제목</th>"
		+"<th width='20%''>작성자</th>"
		+"<th width='15%'>작성일</th></tr></table>"); //테이블 초기화
		main.forEach(function(item){
			content += "<tr>";
			content += "<td>"+item.bbs_id+"</td>"
			content += "<td><a href='uploaddetail?idx="+item.bbs_id+"&mName=과제&selected="+item.subject_id+"'>"+item.bbs_title+"</td>"
			content += "<td>"+item.bbs_writer+"</td>"
			content += "<td>"+item.bbs_date+"</td>"
		});
		$("#listTable").append(content);
	}
	
	$("#before").click(function(){
		sNum-=10;
		eNum-=10;
		obj.url="./paging";
		obj.data={
				"sNum":sNum,
				"eNum":eNum,
				"idx":idx,
				"mName":"과제",
				"selected":$("#list option:selected").val()
		};
		obj.success=function(data){
			if(data.page.length == 0){
				alert("첫 페이지");
				sNum=1;
				eNum=10;
			}else{
				$("listTable").empty(); //테이블 안에 있는 것을 비우고
	           mainPrint(data.page); //리스트를 뽑는 함수호출
			}
		};
		ajaxCall(obj);
	});
	
	$("#next").click(function(){
		sNum+=10;
		eNum+=10;
		obj.url="./paging";
		obj.data={
				"sNum":sNum,
				"eNum":eNum,
				"idx":idx,
				"mName":"과제",
				"selected":$("#list option:selected").val()
		};
		obj.success=function(data){
			if(data.page.length == 0){
				alert("마지막 페이지");
				sNum-=10;
				eNum-=10;
			}else{
				$("listTable").empty(); //테이블 안에 있는 것을 비우고
	           mainPrint(data.page); //리스트를 뽑는 함수호출
			}
		};
		ajaxCall(obj);
	});
	
	function ajaxCall(param){
		console.log("ajax 호출")
		$.ajax(obj);
	}
	
	function move(){
		var selected = $("#list option:selected").val()
		location.href="s13.jsp?subject_id="+selected+"&mName=과제";
	}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<style>
			#grade{
				margin-left: 22%;
				margin-right: 3%;
				margin-top: 1%;
			}
			table,td,th{
				border: 1px solid;
				border-collapse: collapse;
			}
			ul{
				color: red;
				font-size: x-small;
			}
			#grade input[type='button']{
			 	float: right;
			 	margin-top: 1%;
			}
			#grade{
				text-decoration: underline;
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
		<div id="grade">
			<table width="100%">
				<tr>
					<th colspan="4"><h3>강&nbsp;의&nbsp;평&nbsp;가&nbsp;서</h3></th>
				</tr>
				<tr>
					<td>담당교수</td>
					<td>${pro_name}</td>
					<td>과목명</td>
					<td>${s_name}</td>
				</tr>
				<tr>
					<td colspan="4">
						<ul>
							<li>※공지사항(필독)</li>
							<li>평가를 완료한 후에는 수정이 불가능합니다. 설문항목을 정확하게 확인하시고 체크하시길 바랍니다.</li>
							<li>해당 설문은 강의 평점에 반영됩니다.</li>
						</ul>
					</td>
				</tr>
				<tr>
					<td colspan="4"><h3>${quest0}</h3></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="radio" name="s0" value="1"/>매우 그렇지 않다
						<input type="radio" name="s0" value="2"/>그렇지 않다
						<input type="radio" name="s0" value="3"/>보통이다
						<input type="radio" name="s0" value="4"/>그렇다
						<input type="radio" name="s0" value="5"/>매우 그렇다
					</td>
				</tr>
				<tr>
					<td colspan="4"><h3>${quest1}</h3></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="radio" name="s1" value="1"/>매우 그렇지 않다
						<input type="radio" name="s1" value="2"/>그렇지 않다
						<input type="radio" name="s1" value="3"/>보통이다
						<input type="radio" name="s1" value="4"/>그렇다
						<input type="radio" name="s1" value="5"/>매우 그렇다
					</td>
				</tr>
				<tr>
					<td colspan="4"><h3>${quest2}</h3></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="radio" name="s2" value="1"/>매우 그렇지 않다
						<input type="radio" name="s2" value="2"/>그렇지 않다
						<input type="radio" name="s2" value="3"/>보통이다
						<input type="radio" name="s2" value="4"/>그렇다
						<input type="radio" name="s2" value="5"/>매우 그렇다
					</td>
				</tr>
				<tr>
					<td colspan="4"><h3>${quest3}</h3></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="radio" name="s3" value="1"/>매우 그렇지 않다
						<input type="radio" name="s3" value="2"/>그렇지 않다
						<input type="radio" name="s3" value="3"/>보통이다
						<input type="radio" name="s3" value="4"/>그렇다
						<input type="radio" name="s3" value="5"/>매우 그렇다
					</td>
				</tr>
				<tr>
					<td colspan="4"><h3>${quest4}</h3></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="radio" name="s4" value="1"/>매우 그렇지 않다
						<input type="radio" name="s4" value="2"/>그렇지 않다
						<input type="radio" name="s4" value="3"/>보통이다
						<input type="radio" name="s4" value="4"/>그렇다
						<input type="radio" name="s4" value="5"/>매우 그렇다
					</td>
				</tr>
			</table>
			<button>평가완료</button>
		</div>
	</body>
	<script>
	var obj={};
	obj.type="post";
	obj.dataType="json";
	obj.error=function(e){console.log(e)};
	
	//신청과목 셀렉트 박스에 넣기
	$(document).ready(function(){
		obj.url="./subjectTab";
		obj.data={
				"id":'${sessionScope.loginId}'
		}
		obj.success=function(data){
			if(data){
				 selectbox(data.sublist); 
			}else{
				location.href="index.jsp";
			}
		}
		ajaxCall(obj);
	});
	
	//셀렉트 박스에 넣는 반복문
	function selectbox(list) {
		var content ="";
		$("#list").html("<option value='과목선택'>과목선택</option>");
			list.forEach(function(item){
				content += "<option value="+item.subject_id+">";
				content += item.subject_name;
				content += "</option>";
			});
			$("#list").append(content);
	}
	
	//셀렉트 박스 선택시 리스트 출력
	$("#list").change(function(){
		obj.url="./list?mName=강의자료&sNum=1&eNum=10";
		obj.data={selected:$("#list option:selected").val()};
		obj.success=function(data){
			if(data){
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
		+"<th width='15%'>작성일</th></tr>"); //테이블 초기화
		main.forEach(function(item){
			content += "<tr>";
			content += "<td>"+item.bbs_id+"</td>"
			content += "<td><a href='detail?idx="+item.bbs_id+"&mName=강의자료&selected="+item.subject_id+"'>"+item.bbs_title+"</td>"
			content += "<td>"+item.bbs_writer+"</td>"
			content += "<td>"+item.bbs_date+"</td>"
		});
		$("#listTable").append(content);
	}

	function ajaxCall(param){
		console.log("ajax 호출")
		$.ajax(obj);
	}
	
	$("button").click(function(){
		alert("이미 평가가 끝난 과목입니다");
	});
	</script>
</html>
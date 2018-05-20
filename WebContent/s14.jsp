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
			.info{
				border:none;
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
<%-- 		<form name="form" method="get">
		<input type="hidden" name="selected" value="${main.subject_id}"/>
		<input type="hidden" name="std_id" value="${sessionScope.loginId}"/> --%>
		<div id="grade">
			<table id="listTable" width="100%">
				<tr>
					<th colspan="4"><h3>강&nbsp;의&nbsp;평&nbsp;가&nbsp;서</h3></th>
				</tr>
				<tr>
					<td>담당교수</td>
					<td><input class="info" type="text" id="pro_name" readonly/></td>
					<td>과목명</td>
					<td><input class="info" type="text" id="subject_name" readonly/></td>
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
				</table>
				<h3>강의 진행이 체계적이었는가?</h3>
						<input type="radio" name="s0" value="1"/>매우 그렇지 않다
						<input type="radio" name="s0" value="2"/>그렇지 않다
						<input type="radio" name="s0" value="3"/>보통이다
						<input type="radio" name="s0" value="4"/>그렇다
						<input type="radio" name="s0" value="5"/>매우 그렇다
				
				<h3>강의 내용이 강의계획서대로 진행되었는가?</h3>
						<input type="radio" name="s1" value="1"/>매우 그렇지 않다
						<input type="radio" name="s1" value="2"/>그렇지 않다
						<input type="radio" name="s1" value="3"/>보통이다
						<input type="radio" name="s1" value="4"/>그렇다
						<input type="radio" name="s1" value="5"/>매우 그렇다

				<h3>교재 선택(또는 보로자료 제시)이 적절하였는가?</h3>
						<input type="radio" name="s2" value="1"/>매우 그렇지 않다
						<input type="radio" name="s2" value="2"/>그렇지 않다
						<input type="radio" name="s2" value="3"/>보통이다
						<input type="radio" name="s2" value="4"/>그렇다
						<input type="radio" name="s2" value="5"/>매우 그렇다

				<h3>강의 시간을 준수하였는가?</h3>
						<input type="radio" name="s3" value="1"/>매우 그렇지 않다
						<input type="radio" name="s3" value="2"/>그렇지 않다
						<input type="radio" name="s3" value="3"/>보통이다
						<input type="radio" name="s3" value="4"/>그렇다
						<input type="radio" name="s3" value="5"/>매우 그렇다
				
				<h3>이 수업이 전체적으로 만족스러웠는가?</h3>
						<input type="radio" name="s4" value="1"/>매우 그렇지 않다
						<input type="radio" name="s4" value="2"/>그렇지 않다
						<input type="radio" name="s4" value="3"/>보통이다
						<input type="radio" name="s4" value="4"/>그렇다
						<input type="radio" name="s4" value="5"/>매우 그렇다
			<button>평가완료</button>
		</div>
		<!-- </form> -->
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
		obj.url="./gradePage";
		obj.data={selected:$("#list option:selected").val()};
		obj.success=function(data){
			if(data){
				PrintInfo(data.main)
			}else{
				alert("과목을 다시 선택해주세요");
			}
		}
		ajaxCall(obj);
	});
	
	function PrintInfo(main){
		$("#pro_name").val(main.pro_name);
		$("#subject_name").val(main.subject_name);
	}
	
	$("button").click(function(){
		if(!$("input[name='s0']:checked").val()){
			alert("점수를 선택하세요");
			return;
		}else if(!$("input[name='s1']:checked").val()){
			alert("점수를 선택하세요");
			return;
		}else if(!$("input[name='s2']:checked").val()){
			alert("점수를 선택하세요");
			return;
		}else if(!$("input[name='s3']:checked").val()){
			alert("점수를 선택하세요");
			return;
		}else if(!$("input[name='s4']:checked").val()){
			alert("점수를 선택하세요");
			return;
		}
		obj.url="./grade";
		obj.data={
				"id":"${sessionScope.loginId}",
				"selected" :$("#list option:selected").val(),
				"s0":$("input[name='s0']").val(),
				"s1":$("input[name='s1']").val(),
				"s2":$("input[name='s2']").val(),
				"s3":$("input[name='s3']").val(),
				"s4":$("input[name='s4']").val()
		}
		obj.success=function(data){
			if(data){
				location.href="s14f.jsp"
			}else{
				alert("평가를 다시 해주세요");
			}
		}
		ajaxCall(obj);
	});
	
	function ajaxCall(param){
		console.log("ajax 호출")
		$.ajax(obj);
	}
	</script>
</html>
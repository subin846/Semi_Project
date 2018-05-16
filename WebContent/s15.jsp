 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<script src =" https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
 		#s15{
			text-decoration: underline;
		}
		#btn{
			cursor: pointer;
		}		 
	</style>
</head>
<body>
		<div>
				<select id="optSelect">
					<option value="entry" selected>전체</option>
					<option value="term">학기별</option>
					<option value="pro">교수별</option>
					<option value="maj">학과명</option>
					<option value="sub">과목명</option>
				</select>
				<input type="text" id ="inp"  placeholder="조회 버튼을 클릭해주세요"/>
				<input type="button" id="btn" value="조회"/>
			</div>
		<table> <!-- id OR class="tabAppend" -->
			<tr id="trAppend">
				<th>학기</th>
				<th>학과명</th>
				<th>과목명</th>
				<th>교수명</th>
				<th>강의실</th>
				<th>강의시간</th>
				<th>이수구분</th>
				<th>학점</th>
				<th>제한인원</th>
				<th>평점</th>
			</tr>
			</table>
</body>
<script>
	$(document).ready(function(){
		//ready 되자마자 이전 과목 리스트 요청
		var optSel = $("#optSelect option:selected").val();
		var selId = $("#inp").val();
		/*이전 학기 평점조회 와 
		신학기 수강신청 과목 분류 하기위해 분류할수있는 데이터 함께 전송*/
		var term_id = "AND S.term_id < '2018-2' "
		ajaxCall();
		/* 조회 버튼 클릭 시 text의 value 가져오기 */
		$("#btn").click(function(){
			console.log("조회 버튼 클릭");
			optSel = $("#optSelect option:selected").val();
			selId = $("#inp").val();
			ajaxCall();
		}); 

 		function ajaxCall(){
			 $.ajax({
				type:"post",
				url:"./subjectSearch",
				data:{
					//getParameter()메서드 : name 을 통해서 value를 얻을 수 있음
					//2개 파라메터로 보내서 opt 를 기준으로 sql 분류
					"optSel"  :optSel,
					"selId" : selId,
					"term_id" : term_id
				},
				dataType:"JSON",
					success:function(data){
						console.log("성공!");
						console.log(data);
						console.log(data.searchList);
						console.log(data.searchList.length);
						//부모 , 자식 요소 삭제 - tr을 삭제 후 새로운 tr 생성
	 					if($(".trRemove")!=null){
							$(".trRemove").remove();
							console.log("tr제거");
						} 
						var listAppend;
						for(var i =0; i<data.searchList.length; i++){
							listAppend+="<tr class='trRemove'>"
							listAppend+="<td>"+data.searchList[i].term_id+"</td>"
							listAppend+="<td>"+data.searchList[i].major_name+"</td>"
							listAppend+="<td>"+data.searchList[i].subject_name+"</td>"
							listAppend+="<td>"+data.searchList[i].pro_name+"</td>"
							listAppend+="<td>"+data.searchList[i].subject_room+"</td>"
							listAppend+="<td>"+data.searchList[i].subject_time+"</td>"
							listAppend+="<td>"+data.searchList[i].subject_type+"</td>"
							listAppend+="<td>"+data.searchList[i].subject_credit+"</td>"
							listAppend+="<td>"+data.searchList[i].subject_limit+"</td>"
							listAppend+="<td><strong>"+data.searchList[i].subject_grade+"</strong></td>"
							listAppend+="</tr>"
						}
							$("#trAppend").after(listAppend);
					},
					error:function(data){
							console.log("error");
							console.log(data);
					}
			});
		} 
	});

</script>
</html>
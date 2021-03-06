 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
	html {
		box-sizing: inherit;
		background: -webkit-linear-gradient(right, #8e9eab, #eef2f3);
		background: linear-gradient(to left, #8e9eab, #eef2f3);
	}
 	div{
		position: relative;
		width: 500px;
		min-height: 5%;
		margin: 0 auto 0;
		background: #fff;
		font-size: 17px;	
		z-index: 10;
	}
	#div1{
	 	padding : 10px;
	 	text-align:left;
	    border: solid 1px #dadada;
	 }
	input{
		padding : 10px 5px;
		font-size: 17px;
		width: 78%;
		z-index: 10;
		height: 35px;
		border: none;
		background: #fff;
		border: 1px solid #dadada;
	}
	#div3{
	    height: 55px;
	    width : 520px;
	   	border: solid 1px none;
	    -webkit-background-size: 108px auto;
	    background: white;	
	  }
	  #div3 input{
	  		border: 1px solid #dadada;
	 		width: 100%;
	 		height: 100%;
			font-size: 17px;
			border: none;
			background: #fff;
	  }
	  h2,h4{
	  		cursor: pointer;
	  }
</style>
 <body>
 	<h2  onclick="location.href='aTuition'">Total Information System</h2>
	<h4 onclick="location.href='aTuition'" >등록금 수정</h4>
	    <form action="tUpdate" method="post">
			<div id="div1">
				<div>
					&nbsp; 학기 : ${form.term_id}
					<input type="hidden" name="term_id" value="${form.term_id}"/>
				</div>
				<hr/>
				<div>
					&nbsp; 학번 : ${form.std_id}
					<input type="hidden" name="std_id"  value="${form.std_id}">
				</div>
				<hr/>
				<div>
					&nbsp; 이름 : ${form.std_name}
				</div>
				<hr/>
				<div>
					&nbsp; 장학금 종류 : ${form.scholar_name}
				</div>
				<hr/>
				<div>
					&nbsp; 장학금 금액 : ${form.scholar_money}
				</div>
				<hr/>
				<div>
					&nbsp; 등록금 : <input id="tuition_money" type="text" name="tuition_money"  value="${form.tuition_money}">
				</div>
				<hr/>
			</div>
			<br/>
			<div id="div3">
				<input id="ok"  type="submit" value="완료"/> 
			</div>
		</form>
</body>
<script>
	$("#ok").click(function(){
		if(!$("#tuition_money").val()){
			alert("등록금액을 입력하세요");
		}
	});
</script>
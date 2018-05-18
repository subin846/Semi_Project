<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	html {
		box-sizing: inherit;
		background: -webkit-linear-gradient(right, #8e9eab, #eef2f3);
		background: linear-gradient(to left, #8e9eab, #eef2f3);
	}
 	div{
		position: relative;
		width: 500px;
		min-height: 100%;
		margin: 0 auto 0;
		background: #fff;
	}
	#div1{
	 	padding : 10px;
	 	text-align:left;
	    border: solid 1px #dadada;
	 }
	input{
		padding : 10px 5px;
		font-size: 17px;
		width: 80%;
		z-index: 10;
		height: 16px;
		border: none;
		background: #fff;
	}
	#div3{
	    height: 61px;
	    width : 520px;
	   	border: solid 1px none;
	    -webkit-background-size: 108px auto;
	    background: white;	
	}
	#div3 input{
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
</head>
<body>
	<h2  onclick="location.href='suManagePage'">Total Information System</h2>
	<h4 onclick="location.href='suManagePage'" >과목 등록</h4>
	<br/><br/><br/>
	<form action="suAdd">
		<div id="div1">
			<div>
				<input type="text" name="subject_id"  placeholder="과목코드">
			</div>
			<hr/>
			<div>
				<input type="text" name="term_id"   placeholder="학기">
			</div>
			<hr/>
			<div>
				<input type="text" name="major_id"   placeholder="학과 코드">
			</div>
			<hr/>
			<div>
				<input type="text" name="pro_id"  placeholder="사번">
			</div>
			<hr/>
			<div>
				<input type="text" name="subject_name"   placeholder="과목명">
			</div>
			<hr/>
			<div>
				<input type="text" name="subject_room"   placeholder="강의실">
			</div>
			<hr/>
			<div>
				<input type="text" name="subject_time"  placeholder="강의시간">
			</div>
			<hr/>
			<div>
				<input type="text" name="subject_type"  placeholder="전공/교양">
			</div>
			<hr/>
			<div>
				<input type="text" name="subject_grade"   placeholder="평점">
			</div>
			<hr/>
			<div>
				<input type="text" name="subject_credit"   placeholder="학점">
			</div>
			<hr/>
			<div>
				<input type="text" name="subject_limit"  placeholder="제한인원">
			</div>
			<hr/>
		</div>
		<br/>
		<div id="div3">
			<input  type="submit" value="완료"/> 
		</div>
	</form>
</body>
</html>
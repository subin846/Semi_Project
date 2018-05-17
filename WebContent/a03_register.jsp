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
		<h2  onclick="location.href='scScholar'">Total Information System</h2>
		<h4 onclick="location.href='scScholar'" >장학금 종류 등록</h4>
		<br/><br/><br/>
		<form action="scAdd">
			<div id="div1">
				<div id="div2">
					<input type="text" name="scholar_name"  placeholder="장학금 종류">
				</div>
				<hr/>
				<div id="div2">
					<input type="text" name="scholar_money"   placeholder="장학금 금액">
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
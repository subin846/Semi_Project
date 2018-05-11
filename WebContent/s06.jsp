<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="loginCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<style>
			table, tr, th, td {
				border: thin solid black;
				border-collapse: collapse;
				padding: 5px;
				text-align: center;
			}
			th {
				background-color: #F6F6F6;
			}
			#s06 {
				text-decoration: underline;
			}
			table {
				width: 600px;
			}
		</style>
	</head>
	<body id="body06">
		<div id="s06Div"></div>
	</body>
	<script>
		$(document).ready(function() {
			// 성적 가져오기
			$.ajax({
				type: "post",
				url: "./score",
				dataType: "json",
				data: {
					"loginId": "${sessionScope.loginId}"
				},
				success: function(data) {
					var term = ""; // 학기
					var termCount = 0; // 학기 개수
					var str = ""; // append할 String
					var sumCredit = 0; // 학기별 총 신청학점
					var sumScore = 0; // 학기별 성적*학점 합
					
					for (var i = 0; i < data.scoreList.length; i++) {
						// 기존 학기와 다를 경우
						if (data.scoreList[i].term_id != term) {
							if (i != 0) {
								str += "</table>";
								str += "<table><th>신청학점</th>"
									+ "<td>" + sumCredit + "</td>"
									+ "<th>평균평점</th>"
									+ "<td>" + sumScore/sumCredit + "</td></table><br/><br/>";
							}
							term = data.scoreList[i].term_id;
							// 새 테이블 생성
							str += "<table><th>학기</th><th>과목명</th><th>이수구분</th><th>학점</th><th>등급</th>"
							// 신청학점, 성적합 초기화
							sumCredit = 0;
							sumScore = 0;
						}
						
						str += "<tr><td>" + data.scoreList[i].term_id +"</td>"
							+ "<td>" + data.scoreList[i].subject_name +"</td>"
							+ "<td>" + data.scoreList[i].subject_type +"</td>"
							+ "<td>" + data.scoreList[i].subject_credit +"</td>"
							+ "<td>" + data.scoreList[i].score_score +"</td></tr>";
						
						sumCredit += data.scoreList[i].subject_credit; // 신청학점 더하기
						sumScore += data.scoreList[i].subject_credit * scoreToInt(data.scoreList[i].score_score); // 학점*성적 더하기
							
						// 마지막 후처리
						if (i == data.scoreList.length - 1) {
							str += "</table>";
							str += "<table><th>신청학점</th>"
								+ "<td>" + sumCredit + "</td>"
								+ "<th>평균평점</th>"
								+ "<td>" + sumScore/sumCredit + "</td></table><br/>";
						}
					}
					$("#s06Div").html(str);
				}
			});
			
			function scoreToInt(score) {
				if (score == "A+") {
					return 4.5;
				} else if (score == "A0") {
					return 4.0;
				} else if (score == "B+") {
					return 3.5;
				} else if (score == "B0") {
					return 3.0;
				} else if (score == "C+") {
					return 2.5;
				} else if (score == "C0") {
					return 2.0;
				} else {
					return 0.0;
				}
					
			}
		});
	</script>
</html>
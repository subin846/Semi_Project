package com.semi2.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.semi2.dao.EnrollDAO;
import com.semi2.dto.DTO;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;


public class EnrollService {
	HttpServletRequest request =null;
	HttpServletResponse response =null;
	public EnrollService(HttpServletRequest request, HttpServletResponse response) 
			throws UnsupportedEncodingException  {
		this.request =request;
		this.response=response;
		//한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
	}

	/*이전 학기과목 평점조회 or 신 학기 수강신청 과목 조회 필터링으로 분류  */
	public void subjectSearch() throws IOException {
		String optSel  = request.getParameter("optSel");
		String selId = request.getParameter("selId");
		String term_id = request.getParameter("term_id");
		System.out.println(optSel+"/"+selId);
		//DB접속을 통해서 optSel에 맞는 쿼리문 구분.->데이터가 많으므로 DTO에 담음.
		EnrollDAO dao = new EnrollDAO();
		ArrayList<DTO> searchList = new ArrayList<DTO>();
		searchList = dao.subjectSearch(optSel,selId,term_id);
		System.out.println("필터링 반환 받았나?");
		System.out.println(searchList);
		System.out.println("반환 개수: "+searchList.size());
		/*라이브러리에 추가한 Gson 형태로 반환  why ? ajax로 요청을 받을떄 json 타입으로 받는다고 했음
		 * 자바 언어로 그냥 response로 보내면 안될까? - JSON 은 자바스크립트 언어의 하나이기 때문에 java와 다르므로 변환이 필요*/
		//1.Gson 객체 생성
		Gson json = new Gson();
		//2. json 과 최대한 유사한 형태로 java를 변환 K:V
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("searchList", searchList);
		//3.변환
		String transJson= json.toJson(map);
		//4.response 로 반환
		//옵션  1 : 만약 한글이 들어가 있다면 한글깨짐 방지
		response.setContentType("text/html; charset=UTF-8");
		/*옵션  2: Cross domain 허용 : 서로 다른 IP 가 접속을 해도 접속을 허용 시킨다.
		 * (localhost내에서 사용할 경우에는 옵션 안써도되지만,
		여러 IP와 통신할 경우에 크로스 도메인을 허용시켜야 외부 Ip가 접속이 가능하다*/
		response.setHeader("Access-Control-Allow-Origin", "*");
		//필수  -- 요청 한 페이지로  getWriter()  transJson을 success | error 로 반환해줌
		response.getWriter().println(transJson);
	}
	
	/*로그인 학생의 수강 신청 과목 조회*/
	public void stdEnroll() throws IOException {
		String loginId = request.getParameter("loginId");
		String term_id = request.getParameter("term_id");
		//요청한 내용을 이용해 DB접속->수강 신청 과목 조회하기
		EnrollDAO dao =new EnrollDAO();
		//수강신청한 과목의 list를 받기 때문에 배열 변수를 선언하고 반환값을 담아주자
		ArrayList<DTO> list =new ArrayList<DTO>();
		list = dao.stdEnroll(loginId,term_id);
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("searchList", list);
		System.out.println(list);
		Gson json = new Gson();
		String transJson = json.toJson(map);
		//response 로 반환
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.getWriter().println(transJson);
	}
	/*로그인 학생의 수강 과목 학점 조회*/
	public void stdCredit() throws IOException {
		String loginId  =request.getParameter("loginId");
		String term_id   =request.getParameter("term_id");
		//요청한 내용을 이용해 DB접속->수강 과목의 학점 조회하기
		EnrollDAO dao  =new EnrollDAO();
		//수강 과목의 학점을 반환 받아야 하기 때문에 받아줄 int 변수선언
		int stdCredit = dao.stdCredit(loginId,term_id);
		System.out.println(loginId+" 학생의 신청학점은? "+stdCredit);
		//ajax 에서 요청한 dataType으로 변환
		HashMap<String, Integer> map =new HashMap<String, Integer>();
		map.put("stdCredit", stdCredit);
		Gson json = new Gson();
		String transJson = json.toJson(map);
		//response 로 반환
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.getWriter().println(transJson);
	}
	/*로그인 학생의 수강 신청 */
	public void enroll() throws IOException {
		//ajax 로 호출 한 내용을 파라메터로 받기
		String loginId = request.getParameter("loginId");
		String[] tdValue  = request.getParameterValues("tdValue[]"); 
		System.out.println(loginId);
		System.out.println("request 개수 : "+tdValue.length);
		//해당 학생 id를 기준으로 수강 신청 과목을 Insert해주고 신청 학점을 update해주자. ->DB 접속 필요
		EnrollDAO dao =new EnrollDAO();
		int[] result =  dao.enroll(loginId,tdValue);
		System.out.println("반환값 "+result[0]+" / "+result[1]);
		//결과값을 JSON 형태로 반환해야함 
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", result[0]);
		map.put("subject_id", result[1]);
		String transJson = json.toJson(map);
		//response 로 반환
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.getWriter().println(transJson);
	
	}
	/*로그인 학생의 수강 정정 */
	public void enrollChange() throws IOException {
		String loginId = request.getParameter("loginId");
		String subject_id = request.getParameter("subject_id");
		//로그인 학생의 id 와 과목id를 기준으로 sql 구문을 실행시켜야 함 -> DB접속 필요
		EnrollDAO dao =new EnrollDAO();
		int success = dao.enrollChange(loginId,subject_id);
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("success", success);
		Gson json = new Gson();
		String transJson = json.toJson(map);
		//response 로 반환
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.getWriter().println(transJson);
	}



}

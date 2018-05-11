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
	
	/*조회 버튼 클릭시 필터링 */
	public void subjectSearch() throws IOException {
		String optSel  = request.getParameter("optSel");
		String selId = request.getParameter("selId");
		System.out.println(optSel+"/"+selId);
		//DB접속을 통해서 optSel에 맞는 쿼리문 구분.->데이터가 많으므로 DTO에 담음.
		EnrollDAO dao = new EnrollDAO();
		ArrayList<DTO> searchList = new ArrayList<DTO>();
		searchList = dao.subjectFilter(optSel,selId);
		System.out.println("필터링 반환 받았나?");
		System.out.println(searchList);
		System.out.println(searchList.size());
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
		/*옵션  2: Cross domain 허용 : 서로 다른 IP 가 접속을 해도 접속을 허용 시킨다.(localhost내에서 사용할 경우에는 옵션 안써도되지만,
		여러 IP와 통신할 경우에 크로스 도메인을 허용시켜야 외부 Ip가 접속이 가능하다*/
		response.setHeader("Access-Control-Allow-Origin", "*");
		//필수  -- s15-main.jsp 가 요청을 했고 반환 해주면서 getWriter() 페이지에 transJson을 success | error 로 반환해줌
		response.getWriter().println(transJson);
	}


}

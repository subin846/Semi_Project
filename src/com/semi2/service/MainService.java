package com.semi2.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.semi2.dao.MainDAO;
import com.semi2.dto.DTO;
import com.semi2.dto.PwDTO;

public class MainService extends PwDTO{
	HttpServletRequest request;
	HttpServletResponse response;

	public MainService(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		this.request = request;
		this.response = response;
	}

	//로그인
	public void login() throws IOException, ServletException {
		String id = request.getParameter("userId");
		String pw = request.getParameter("userPw");
		System.out.println(id+pw);
		//DB 작업이 필요 하기 때문에 BbsDAO 객체화.
		MainDAO dao = new MainDAO();
		Boolean result = dao.login(id,pw);
		DTO dto = new DTO();
		PwDTO pwdto = new PwDTO();
		pwdto.setLoginidDTO(id);
		
		System.out.println("pwdto.getLoginidDTO() : "+pwdto.getLoginidDTO());
		
		String msg = "아이디 또는 비밀번호를 확인해주세요";
		
		if(result==true) {
			System.out.println("로그인 성공");
			//JAVA에서 내장객체가 아니기 때문에 session 불러오자
			HttpSession session = request.getSession();
			session.setAttribute("loginId", id);
			session.setAttribute("loginPw", pw);
			if(id.startsWith("s")) {
				response.sendRedirect("smain");
			}else if(id.startsWith("p")) {
				response.sendRedirect("pmain");
			}else {
				response.sendRedirect("amain");
			}
		}else {
			System.out.println("로그인 실패");
			request.setAttribute("msg", msg);
			RequestDispatcher dis =request.getRequestDispatcher("index.jsp");
			dis.forward(request, response);
		}
	}

	//로그아웃
	public void logout() throws IOException, ServletException {
		HttpSession session = request.getSession();
		session.removeAttribute("loginId");
		response.sendRedirect("index.jsp");
	}

	//학생 메인
	public void smain() throws IOException, ServletException {
		HttpSession session = request.getSession();
		response.sendRedirect("s01.jsp");
	}

	//교수 메인
	public void pmain() throws IOException, ServletException {
		HttpSession session = request.getSession();
		response.sendRedirect("p01_main.jsp");
	}

	//관리자 메인
	public void amain() throws IOException, ServletException {
		HttpSession session = request.getSession();
		response.sendRedirect("a01.jsp");
	}

	//새 비밀번호로 변경 
	public void passChange() throws IOException, ServletException{
		HttpSession session = request.getSession();
		
		System.out.println("이곳으로 오는가");
		
		request.setCharacterEncoding("UTF-8");//한글깨짐방지
		MainDAO dao = new MainDAO();
		String npw = request.getParameter("newPw");
		PwDTO pwdto = new PwDTO();
		pwdto.setnewPw(npw);
		pwdto.setLoginidDTO(request.getParameter("loginId"));
		
		System.out.println("받아온 newPw :"+npw);
		System.out.println("dto에서 받아온 newPw :"+pwdto.getnewPw());
		System.out.println("pwdto.getLoginidDTO() 2 : "+ pwdto.getLoginidDTO());
		
		DTO dto = new DTO();
		String npwcheck = request.getParameter("newPwCheck");
		System.out.println("npw : "+npw+"/"+"npwcheck : "+npwcheck);
		System.out.println("같은가 : " + npw.equals(npwcheck));
		if(npw.equals(npwcheck)) {
			if(dao.passChange(dto, pwdto)>0) {
				System.out.println("비밀번호 변경 완료");
			}else {
				System.out.println("실패");
				response.sendRedirect("m02.jsp");
			}
		}else {
			System.out.println("새 비밀번호가 일치하지 않습니다.");
			response.sendRedirect("m02.jsp");
		}		
	}

	//학사일정 조회
	public void dateEvent() throws IOException {

		String schedule = request.getParameter("schedule");
		System.out.println(schedule+"sad");
		MainDAO dao = new MainDAO();
		ArrayList<DTO> dateList = dao.dateEvent(schedule);
		
		// map에 dto 담기
		HashMap<String, Object> map = new HashMap<>();
		map.put("dateList", dateList);
		
		// json 전송
		Gson gson = new Gson();
		String obj = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}
	
	// 강의계획서 조회
	public void lecturePlan() throws IOException {
		String loginId = request.getParameter("loginId");
		String subject = request.getParameter("subject");

		MainDAO dao = new MainDAO();
		DTO planDTO = new DTO();
		planDTO.setPro_id(loginId);
		planDTO.setSubject_name(subject);
		System.out.println("planDTOㄴㄴㄴㄴㄴ: " +planDTO.getSubject_name());
		DTO dto = dao.lecturePlan(planDTO);

		// map에 dto 담기
		HashMap<String, Object> map = new HashMap<>();
		map.put("dto", dto);

		// json 전송
		Gson gson = new Gson();
		String json = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(json);
	}
	
	/*
	// 페이징(예시)
	public void pagingList() throws ServletException, IOException {
		 // 파라미터 get 
		String paramPage = request.getParameter("page");  // 현재 페이지
		String paramListCount = request.getParameter("listCount");  // 페이지의 리스트 개수
		String paramPageCount = request.getParameter("pageCount");  // 화면의 페이지 개수

		//// 기본값 설정(파라미터로 받지 못했을 경우) ////
		// 현재 페이지
		int page; 
		if (paramPage == null) {
			page = 1;
		} else {
			page = Integer.parseInt(paramPage);
		}
		// 한 페이지에 보여줄 리스트 개수
		int listCount;
		if (paramListCount == null) {
			listCount = 10;
		} else {
			listCount = Integer.parseInt(paramListCount);
		}
		// 한 화면에 보여줄 페이지 개수
		int pageCount;
		if (paramPageCount == null) {
			pageCount = 10;
		} else {
			pageCount = Integer.parseInt(paramPageCount);
		}

		// DB에서 리스트의 총 개수 가져오기
		DAO dao = new DAO();
		int totalCount = dao.totalCount();

		// PageInfo 생성(보여줄 글번호, 보여줄 페이지, 총 페이지수 등 계산)
		PageInfo pageInfo = new PageInfo(page, listCount, pageCount, totalCount);
		int startNum = pageInfo.getStartNum();  // 시작 글번호
		int endNum = pageInfo.getEndNum();  // 마지막 글번호

		// startNum ~ endNum 구간 리스트 가져옴
		dao = new DAO();
		ArrayList<DTO> list = dao.pagedList(startNum, endNum);

		request.setAttribute("list", list);
		request.setAttribute("pageInfo", pageInfo);

		RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
		rd.forward(request, response);
	}*/

	
}


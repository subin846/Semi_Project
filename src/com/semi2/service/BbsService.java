package com.semi2.service;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.semi2.dao.BbsDAO;
import com.semi2.dto.DTO;

public class BbsService {
	
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	String savePath = null;

	public BbsService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		String root = request.getSession().getServletContext().getRealPath("/");
		savePath = root+"upload";
	}

	//과목게시판 클릭시 select에 신청과목 들어가는 메서드
	public void subjectTab() throws IOException {
		BbsDAO dao = new BbsDAO();
		String id = "s16160001"; //세션이나 아이디값을 입력받아서 저장
		ArrayList<DTO> sublist =  dao.sublist(id);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("sublist", sublist);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	//select(과목 선택)에서 과목을 클릭했을 시 세션에 값 저장
	public void subjectSel() throws IOException, ServletException {
		String selected = request.getParameter("selected");
		//System.out.println(selected); 

		HttpSession session = request.getSession();
		session.setAttribute("selected", selected);
	}
	
	//게시판 리스트 호출 메서드
	//리스트 호출 시 과목명(session에 select 값 저장), 게시판 종류 조건으로 하는 쿼리 작성
	//게시판 타입을 세션에 담아 파라미터에 넣어줄것
	public void list() throws ServletException, IOException {
		String selected = (String) request.getSession().getAttribute("selected");
		BbsDAO dao = new BbsDAO();
		ArrayList<DTO> list = dao.list(selected);
		
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("s09.jsp");
		dis.forward(request, response);
	}
	
	//글쓰기 메서드
	public void write() throws IOException {
		UploadService upload = new UploadService(request,response);
		DTO dto = upload.regist();
		//값 확인용 출력문
		System.out.println(dto.getBbs_title());
		System.out.println(dto.getBbs_writer());
		System.out.println(dto.getBbs_date());
		System.out.println(dto.getBbs_content());
		
		BbsDAO dao = new BbsDAO();
		int pk = dao.write(dto);
	}

	//상세보기 메서드
	public void detail() throws ServletException, IOException {
		int bbs_number = Integer.parseInt(request.getParameter("bbs_number"));
		String selected = (String) request.getSession().getAttribute("selected");
		System.out.println(bbs_number);
		System.out.println(selected);
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.detail(bbs_number,selected);
		
		if(dto != null) {
			request.setAttribute("detail", dto);
		}else {
			request.setAttribute("msg", "해당 게시글이 없습니다");
		}
		RequestDispatcher dis = request.getRequestDispatcher("s10.jsp");
		dis.forward(request, response);
	}

}

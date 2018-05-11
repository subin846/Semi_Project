package com.semi2.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi2.dao.AdminDAO;
import com.semi2.dto.DTO;


public class AdminService {
	HttpServletRequest request=null;
	HttpServletResponse response=null;
	
	public AdminService(HttpServletRequest request,HttpServletResponse response){
		this.request =request;
		this.response=response;
	}
	public void sManagePage() throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> sManagePage=dao.sManagePage();
		request.setAttribute("list", sManagePage);
		RequestDispatcher dis = request.getRequestDispatcher("a01.jsp");
		dis.forward(request, response);
	}
	/**수정************************************/
	public void sUpdate() throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		String std_id =request.getParameter("std_id");
		int std_year = Integer.parseInt(request.getParameter("std_year"));
		String std_name = request.getParameter("std_name");
		String std_birthday = request.getParameter("std_birthday");
		String std_state = request.getParameter("std_state");
		String std_phone = request.getParameter("std_phone");
		String std_email = request.getParameter("std_email");
		String std_address = request.getParameter("std_address");
		AdminDAO dao = new AdminDAO();
		DTO dto = new DTO();
		dto.setStd_id(std_id);
		dto.setStd_year(std_year);
		dto.setStd_name(std_name);
		dto.setStd_birthday(std_birthday);
		dto.setStd_state(std_state);
		dto.setStd_phone(std_phone);
		dto.setStd_email(std_email);
		dto.setStd_address(std_address);
		// 데이터 수정
		int success = dao.sUpdate(dto);
		// 결과 확인
		if (success > 0) {
			System.out.println("성공");
			RequestDispatcher rd = request.getRequestDispatcher("student");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("a01_UpdatePage.jsp");
			rd.forward(request, response);
		}
				
	}
	/**수정폼********************/
	public void sUpdatePage() throws ServletException, IOException {
		String studentId =request.getParameter("std_id");
		AdminDAO dao = new AdminDAO();
		DTO dto = dao.sUpdatePage(studentId);
		if (dto != null) {
			request.setAttribute("form", dto);
		} else {
			System.out.println("오류");
			/*request.setAttribute("msg", "원하는 값을 찾을 수 없습니다.");*/
		}
		RequestDispatcher rd = request.getRequestDispatcher("a01_UpdatePage.jsp");
		rd.forward(request, response);
	}
	/**등록***************************/
	public void sAdd() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		AdminDAO dao =new AdminDAO();
		DTO dto= new DTO();
		dto.setStd_id(request.getParameter("std_id"));
		dto.setStd_year(Integer.parseInt(request.getParameter("std_year")));
		dto.setStd_name(request.getParameter("std_name"));
		dto.setStd_birthday(request.getParameter("std_birthday"));
		dto.setStd_state(request.getParameter("std_state"));
		dto.setStd_phone(request.getParameter("std_phone"));
		dto.setStd_email(request.getParameter("std_email"));
		dto.setStd_address(request.getParameter("std_address"));
		dto.setStd_pw(request.getParameter("std_pw"));
		if(dao.sAdd(dto)>0) {
			System.out.println("저장완료");
		}
		RequestDispatcher dis = request.getRequestDispatcher("student");
		dis.forward(request, response);
	}
	/**삭제********************************/
	public void sDel() throws ServletException, IOException{
		String std_id= request.getParameter("std_id");
		AdminDAO dao = new AdminDAO();
		if(dao.sDel(std_id) >0) {
			System.out.println("삭제성공");
		}
		RequestDispatcher dis = request.getRequestDispatcher("student");
		dis.forward(request, response);
	}
	/**검색*********************************/
	public void sSearch() throws ServletException, IOException{
		String selectbox = request.getParameter("selectbox");
		String val=request.getParameter("val");
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> list=dao.sSearch(selectbox,val);
		request.setAttribute("search", list);
		RequestDispatcher dis = request.getRequestDispatcher("a01.jsp");
		dis.forward(request, response);
	}
	/**등록금 리스트 ***************************/
	public void tMangePage() throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> tMangePage=dao.tMangePage();
		request.setAttribute("list", tMangePage);
		RequestDispatcher dis = request.getRequestDispatcher("a02_index.jsp");
		dis.forward(request, response);
	}
	/**등록금 수정폼********************/
	public void tUpdatePage() throws ServletException, IOException {
		String studentId =request.getParameter("std_id");
		String term_id = request.getParameter("term_id");
		AdminDAO dao = new AdminDAO();
		DTO dto = dao.tUpdatePage(studentId,term_id);
		if (dto != null) {
			request.setAttribute("form", dto);
		} else {
			System.out.println("오류");
		}
		RequestDispatcher rd = request.getRequestDispatcher("a02_update.jsp");
		rd.forward(request, response);
	}
	/**등록금 수정 ********************/
	public void tUpdate() throws ServletException, IOException {
		String std_id =request.getParameter("std_id");
		int tuition_money=Integer.parseInt(request.getParameter("tuition_money"));
		String term_id = request.getParameter("term_id");
		AdminDAO dao = new AdminDAO();
		DTO dto = new DTO();
		dto.setStd_id(std_id);
		dto.setTuition_money(tuition_money);
		dto.setTerm_id(term_id);
		// 데이터 수정
		int success = dao.tUpdate(dto);
		// 결과 확인
		if (success > 0) {
			System.out.println("성공");
			RequestDispatcher rd = request.getRequestDispatcher("aTuition");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("a02_update.jsp");
			rd.forward(request, response);
		}
	}
	/**등록금 삭제***********/
	public void tDell() throws ServletException, IOException {
		String std_id= request.getParameter("std_id");
		String term_id =request.getParameter("term_id");
		AdminDAO dao = new AdminDAO();
		if(dao.tDell(std_id,term_id) >0) {
			System.out.println("삭제성공");
		}
		RequestDispatcher dis = request.getRequestDispatcher("aTuition");
		dis.forward(request, response);
	}
	/**등록금 등록****************/
	public void tAdd() throws ServletException, IOException {
		AdminDAO dao =new AdminDAO();
		DTO dto= new DTO();
		dto.setTerm_id(request.getParameter("term_id"));
		dto.setScholar_id(Integer.parseInt(request.getParameter("scholar_id")));
		dto.setStd_id(request.getParameter("std_id"));
		dto.setTuition_money(Integer.parseInt(request.getParameter("tuition_money")));
		if(dao.tAdd(dto)>0) {
			System.out.println("저장완료");
		}
		RequestDispatcher dis = request.getRequestDispatcher("aTuition");
		dis.forward(request, response);
		
	}
	/** 등록금 검색 ********************/
	public void tSearch() throws ServletException, IOException {
		String selectbox = request.getParameter("selectbox");
		String val=request.getParameter("val");
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> list=dao.tSearch(selectbox,val);
		request.setAttribute("search", list);
		//request.setAttribute("result", result);
		RequestDispatcher dis = request.getRequestDispatcher("a02_index.jsp");
		dis.forward(request, response);
		
	}
}

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
	/**학생 리스트 출력***************/
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
			request.setAttribute("update", "수정 완료!!");
			RequestDispatcher rd = request.getRequestDispatcher("student");
			rd.forward(request, response);
		} else {
			request.setAttribute("update", "수정 실패!!");
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
		int tuition_id=Integer.parseInt(request.getParameter("tuition_id"));
		AdminDAO dao = new AdminDAO();
		if(dao.tDell(tuition_id) >0) {
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
	/**장학금 리스트**********************/
	public void scPage() throws ServletException, IOException{
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> list=dao.scPage(); 
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("a03_index.jsp");
		dis.forward(request, response);
	}
	/**장학금 수정페이지**********************/
	public void scUpdatePage() throws ServletException, IOException{
		int scholar_id =Integer.parseInt(request.getParameter("scholar_id"));
		AdminDAO dao = new AdminDAO();
		DTO dto = dao.scUpdatePage(scholar_id);
		if (dto != null) {
			request.setAttribute("form", dto);
		} else {
			System.out.println("오류");
		}
		RequestDispatcher rd = request.getRequestDispatcher("a03_update.jsp");
		rd.forward(request, response);
	}
	/**장학금 수정**********************/
	public void scUpdate() throws ServletException, IOException{
		int scholar_id =Integer.parseInt(request.getParameter("scholar_id"));
		String scholar_name=request.getParameter("scholar_name");
		int scholar_money =Integer.parseInt(request.getParameter("scholar_money"));
		AdminDAO dao = new AdminDAO();
		DTO dto = new DTO();
		dto.setScholar_id(scholar_id);
		dto.setScholar_name(scholar_name);
		dto.setScholar_money(scholar_money);
		// 데이터 수정
		int success = dao.scUpdate(dto);
		// 결과 확인
		if (success > 0) {
			System.out.println("성공");
			RequestDispatcher rd = request.getRequestDispatcher("scScholar");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("a03_update.jsp");
			rd.forward(request, response);
		}
	}
	/**장학금 삭제**********************/
	public void scDel()  throws ServletException, IOException{
		int scholar_id =Integer.parseInt(request.getParameter("scholar_id"));
		AdminDAO dao = new AdminDAO();
		if(dao.scDel(scholar_id) >0) {
			System.out.println("삭제성공");
		}
		RequestDispatcher dis = request.getRequestDispatcher("scScholar");
		dis.forward(request, response);
		
	}
	/**장학금 등록**********************/
	public void scAdd() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		AdminDAO dao =new AdminDAO();
		DTO dto= new DTO();
		dto.setScholar_name(request.getParameter("scholar_name"));
		dto.setScholar_money(Integer.parseInt(request.getParameter("scholar_money")));
		if(dao.scAdd(dto)>0) {
			System.out.println("저장완료");
		}
		RequestDispatcher dis = request.getRequestDispatcher("scScholar");
		dis.forward(request, response);
	}
	
	/**장학금 관리 리스트********************/
	public void ePage()  throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> ePage=dao.ePage();
		request.setAttribute("list", ePage);
		RequestDispatcher dis = request.getRequestDispatcher("a04_index.jsp");
		dis.forward(request, response);
	}
	/**장학금 관리 등록************/
	public void eAdd() throws ServletException, IOException {
		AdminDAO dao =new AdminDAO();
		DTO dto= new DTO();
		dto.setTerm_id(request.getParameter("term_id"));
		dto.setScholar_id(Integer.parseInt(request.getParameter("scholar_id")));
		dto.setStd_id(request.getParameter("std_id"));
		if(dao.eAdd(dto)>0) {
			System.out.println("저장완료");
		}
		RequestDispatcher dis = request.getRequestDispatcher("ePage");
		dis.forward(request, response);
	}
	/**장학금 관리 삭제************/
	public void eDel() throws ServletException, IOException {
		int tuition_id=Integer.parseInt(request.getParameter("tuition_id"));
		AdminDAO dao = new AdminDAO();
		if(dao.tDell(tuition_id) >0) {
			System.out.println("삭제성공");
		}
		RequestDispatcher dis = request.getRequestDispatcher("ePage");
		dis.forward(request, response);
		
	}
	/**장학금 관리 수정 폼***************/
	public void eUpdatePage() throws ServletException, IOException {
		int tuition_id =Integer.parseInt(request.getParameter("tuition_id"));
		AdminDAO dao = new AdminDAO();
		DTO dto = dao.eUpdatePage(tuition_id);
		if (dto != null) {
			request.setAttribute("form", dto);
		} else {
			System.out.println("오류");
		}
		RequestDispatcher rd = request.getRequestDispatcher("a04_update.jsp");
		rd.forward(request, response);
	}	
	/**장학금 관리 수정 ***************/
	public void eUpdate() throws ServletException, IOException {
		int scholar_id=Integer.parseInt(request.getParameter("scholar_id"));
		String term_id = request.getParameter("term_id");
		int tuition_id=Integer.parseInt(request.getParameter("tuition_id"));
		AdminDAO dao = new AdminDAO();
		DTO dto = new DTO();
		dto.setScholar_id(scholar_id);
		dto.setTerm_id(term_id);
		dto.setTuition_id(tuition_id);
		// 데이터 수정
		int success = dao.eUpdate(dto);
		// 결과 확인
		if (success > 0) {
			System.out.println("성공");
			RequestDispatcher rd = request.getRequestDispatcher("ePage");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("a04_update.jsp");
			rd.forward(request, response);
		}
	}
	/**장학금 관리 검색 ******************/
	public void eSearch() throws ServletException, IOException {
		String selectbox = request.getParameter("selectbox");
		String val=request.getParameter("val");
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> list=dao.eSearch(selectbox,val);
		request.setAttribute("search", list);
		RequestDispatcher dis = request.getRequestDispatcher("a04_index.jsp");
		dis.forward(request, response);
	}
	/**교수 리스트******************/
	public void pManagePage() throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> pManagePage=dao.pManagePage();
		request.setAttribute("list", pManagePage);
		RequestDispatcher dis = request.getRequestDispatcher("a05_index.jsp");
		dis.forward(request, response);
	}
	/**교수 수정페이지******************/
	public void pUpdatePage() throws ServletException, IOException {
		String pro_id =request.getParameter("pro_id");
		AdminDAO dao = new AdminDAO();
		DTO dto = dao.pUpdatePage(pro_id);
		if (dto != null) {
			request.setAttribute("form", dto);
		} else {
			System.out.println("오류");
		}
		RequestDispatcher rd = request.getRequestDispatcher("a05_UpdatePage.jsp");
		rd.forward(request, response);
	}
	/**교수 수정******************/
	public void pUpdate() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String pro_id =request.getParameter("pro_id");
		String pro_name = request.getParameter("pro_name");
		String pro_phone = request.getParameter("pro_phone");
		String pro_email = request.getParameter("pro_email");
		String pro_room = request.getParameter("pro_room");
		String major_id=request.getParameter("major_id");
		AdminDAO dao = new AdminDAO();
		DTO dto = new DTO();
		dto.setPro_id(pro_id);
		dto.setPro_name(pro_name);
		dto.setPro_email(pro_email);
		dto.setPro_phone(pro_phone);
		dto.setPro_room(pro_room);
		dto.setMajor_id(major_id);
		// 데이터 수정
		int success = dao.pUpdate(dto);
		// 결과 확인
		if (success > 0) {
			System.out.println("성공");	
			request.setAttribute("update", "수정 완료!!");
			RequestDispatcher rd = request.getRequestDispatcher("pManagePage");
			rd.forward(request, response);
		} else {
			request.setAttribute("update", "수정 실패!!");
			RequestDispatcher rd = request.getRequestDispatcher("a05_UpdatePage.jsp");
			rd.forward(request, response);
		}
	}
	/** 교수 삭제********/
	public void pDel() throws ServletException, IOException {
		String pro_id= request.getParameter("pro_id");
		AdminDAO dao = new AdminDAO();
		if(dao.pDel(pro_id) >0) {
			System.out.println("삭제성공");
		}
		RequestDispatcher dis = request.getRequestDispatcher("pManagePage");
		dis.forward(request, response);
	}
	/** 교수 등록********/
	public void pAdd() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		AdminDAO dao =new AdminDAO();
		DTO dto= new DTO();
		dto.setPro_id(request.getParameter("pro_id"));
		dto.setPro_pw(request.getParameter("pro_pw"));
		dto.setPro_name(request.getParameter("pro_name"));
		dto.setPro_email(request.getParameter("pro_email"));
		dto.setPro_phone(request.getParameter("pro_phone"));
		dto.setPro_room(request.getParameter("pro_room"));
		dto.setMajor_id(request.getParameter("major_id"));
		if(dao.pAdd(dto)>0) {
			System.out.println("저장완료");
		}
		RequestDispatcher dis = request.getRequestDispatcher("pManagePage");
		dis.forward(request, response);
	}
	/** 교수 검색********/
	public void pSearch() throws ServletException, IOException {
		String selectbox = request.getParameter("selectbox");
		String val=request.getParameter("val");
		AdminDAO dao = new AdminDAO();
		ArrayList<DTO> list=dao.pSearch(selectbox,val);
		request.setAttribute("search", list);
		RequestDispatcher dis = request.getRequestDispatcher("a05_index.jsp");
		dis.forward(request, response);
		
	}
}

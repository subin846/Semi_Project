package com.semi2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi2.service.AdminService;
import com.semi2.service.MainService;
import com.semi2.service.InfoService;

@WebServlet({"/", "/login", "/logout", "/smain", "/pmain", "/amain"})
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dual(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dual(request, response);
	}

	private void dual(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 인코딩 설정
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String uri = request.getRequestURI();
		String cp = request.getContextPath();
		String sub = uri.substring(cp.length());
		System.out.println("sub : " + sub);
		/**AdminService  민철******************************/
		AdminService adservice = new AdminService(request, response);
		
		/**MainService  수빈******************************/
		MainService mservice = new MainService(request, response);
		
		InfoService infoService = null;
		
		switch (sub) {
		
		case "/sProfile" :
			System.out.println("sProfile 요청");
			infoService = new InfoService(request, response);
			infoService.sProfile();
			break;
/**민철******************************************************/
		case "/student":
			System.out.println("학생 리스트 요청");
			adservice.sManagePage();
			break;
		case "/update":
			System.out.println("수정 페이지 요청");
			adservice.sUpdate();
			break;
		case "/updateForm":
			System.out.println("수정폼 요청");
			adservice.sUpdatePage();
			break;
		case "/register":
			System.out.println("학생등록 요청");
			adservice.sAdd();
			break;
		case "/del":
			System.out.println("삭제 요청");
			adservice.sDel();
			break;
		case "/search":
			System.out.println("검색 요청");
			adservice.sSearch();
			break;
		
		
/**********************************************************************/			
		//수빈			
		case "/login" :
			System.out.println("login 요청");	
			mservice.login();
			break;
		case "/logout" :
			System.out.println("logout 요청");
			mservice.logout();
			break;
		case "/smain" :
			System.out.println("학생 main 페이지 이동");
			mservice.smain();
			break;
		case "/pmain" :
			System.out.println("교수 main 페이지 이동");
			mservice.pmain();
			break;
		case "/amain" :
			System.out.println("관리자 main 페이지 이동");
			mservice.amain();
			break;
/**********************************************************************/				
			
			
		case "/sTimetable" :
			System.out.println("sTimetable 요청");
			infoService = new InfoService(request, response);
			infoService.sTimetable();
			break;	
			
		default :
			System.out.println("Input error");
		}
	}

}

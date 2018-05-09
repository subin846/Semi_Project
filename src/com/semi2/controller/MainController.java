package com.semi2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		switch (sub) {
		
		case "/sProfile" :
			System.out.println("sProfile 요청");
			InfoService service = new InfoService(request, response);
			service.sProfile();
			break;
		
		
/**********************************************************************/			
		//수빈			
		case "/login" :
			System.out.println("login 요청");
			MainService mservice = new MainService(request, response);
			mservice.login();
			break;
		case "/logout" :
			System.out.println("logout 요청");
			mservice = new MainService(request, response);
			mservice.logout();
			break;
		case "/smain" :
			System.out.println("학생 main 페이지 이동");
			mservice = new MainService(request, response);
			mservice.smain();
			break;
		case "/pmain" :
			System.out.println("교수 main 페이지 이동");
			mservice = new MainService(request, response);
			mservice.pmain();
			break;
		case "/amain" :
			System.out.println("관리자 main 페이지 이동");
			mservice = new MainService(request, response);
			mservice.amain();
			break;
/**********************************************************************/				
			
			
		default :
			System.out.println("Input error");
		}
	}

}

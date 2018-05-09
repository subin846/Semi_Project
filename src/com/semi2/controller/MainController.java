package com.semi2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi2.service.InfoService;

@WebServlet("/")
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
		
		InfoService infoService = null;
		
		switch (sub) {
		
		case "/sProfile" :
			System.out.println("sProfile 요청");
			infoService = new InfoService(request, response);
			infoService.sProfile();
			break;
			
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

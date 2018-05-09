package com.semi2.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.semi2.dao.MainDAO;

public class MainService {
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
		String msg = "아이디 또는 비밀번호를 확인해주세요";
		
		if(result==true) {
			System.out.println("로그인 성공");
			//JAVA에서 내장객체가 아니기 때문에 session 불러오자
			HttpSession session = request.getSession();
			session.setAttribute("loginId", id);
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
		response.sendRedirect("p01.jsp");
	}

	//관리자 메인
	public void amain() throws IOException, ServletException {
		HttpSession session = request.getSession();
		response.sendRedirect("a01.jsp");
	}

	
	

	
}


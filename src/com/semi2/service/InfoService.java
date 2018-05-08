package com.semi2.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi2.dao.InfoDAO;
import com.semi2.dto.DTO;

public class InfoService {
	HttpServletRequest request;
	HttpServletResponse response;
	
	// 생성자
	public InfoService(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		this.request = request;
		this.response = response;
		// 인코딩 설정
		request.setCharacterEncoding("UTF-8");
	}

	// 학생 신상조회
	public void sProfile() throws ServletException, IOException {
		InfoDAO dao = new InfoDAO();
		DTO dto = dao.sProfile();
		
		request.setAttribute("dto", dto);
		RequestDispatcher rd = request.getRequestDispatcher("s02-main.jsp");
		rd.forward(request, response);
	}

}

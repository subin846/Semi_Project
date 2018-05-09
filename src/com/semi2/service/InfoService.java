package com.semi2.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
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
		String loginId = (String) request.getSession().getAttribute("loginId");

		InfoDAO dao = new InfoDAO();
		DTO dto = dao.sProfile(loginId);

		// map에 dto 담기
		HashMap<String, Object> map = new HashMap<>();
		map.put("dto", dto);

		// json 전송
		Gson gson = new Gson();
		String json = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(json);
	}

	// 학생 시간표 조회
	public void sTimetable() throws IOException {
		String loginId = (String) request.getSession().getAttribute("loginId");

		InfoDAO dao = new InfoDAO();
		ArrayList<DTO> list = dao.sTimetable(loginId);

		// map에 list 담기
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);

		// json 전송
		Gson gson = new Gson();
		String json = gson.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(json);
	}

}

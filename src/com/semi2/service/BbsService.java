package com.semi2.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
		String id = request.getParameter("id");
		BbsDAO dao = new BbsDAO();
		ArrayList<DTO> sublist =  dao.sublist(id);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("sublist", sublist);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}
	
	//강의자료 게시판 리스트 호출 메서드
	public void list() throws ServletException, IOException {
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");
		BbsDAO dao = new BbsDAO();
		ArrayList<DTO> list = dao.list(selected,bbssort_type);

		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("main", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);

	}
	
	//강의자료 상세보기 메서드
		public void detail() throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			
			int bbs_id = Integer.parseInt(request.getParameter("idx"));
			int selected = Integer.parseInt(request.getParameter("selected"));
			String bbssort_type = request.getParameter("mName");

			System.out.println(bbs_id+"/"+selected+"/"+bbssort_type);
			
			BbsDAO dao = new BbsDAO();
			DTO dto = dao.detail(bbs_id,selected,bbssort_type);
			
			if(dto != null) {
				request.setAttribute("detail", dto);
				request.setAttribute("selected", selected);
			}else {
				System.out.println("dto값이 없음");
			}
			RequestDispatcher dis = request.getRequestDispatcher("s10.jsp");
			dis.forward(request, response);
		}
	
	//학생 - 강의자료글쓰기 메서드
	public void write() throws IOException {
		
		UploadService upload = new UploadService(request);
		DTO dto = upload.regist();
		
		BbsDAO dao = new BbsDAO();
		int pk = dao.write(dto);

		String page = "s13.jsp";
		if(pk > 0) {
			page = "./uploaddetail?idx="+pk+"&mName="+ java.net.URLEncoder.encode("과제","UTF-8")+"&selected="+dto.getSubject_id();
		}
		response.sendRedirect(page);
	}

	//학생 - 과제 게시판 요청 메서드
	public void uploadlist() throws ServletException, IOException {
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");
		
		BbsDAO dao = new BbsDAO();
		ArrayList<DTO> uploadlist = dao.list(selected,bbssort_type);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("main", uploadlist);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	//학생 - 과제 상세보기 리스트
	public void uploaddetail() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int bbs_id = Integer.parseInt(request.getParameter("idx"));
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");
		
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.detail(bbs_id,selected,bbssort_type);
		
		if(dto != null) {
			request.setAttribute("uploaddetail", dto);
		}else {
			System.out.println("dto값이 없음");
		}
		RequestDispatcher dis = request.getRequestDispatcher("s12.jsp");
		dis.forward(request, response);
	}
	
	//학생 - 과제 게시판 수정 폼 메서드
	public void updatePage() throws ServletException, IOException {
		int bbs_id = Integer.parseInt(request.getParameter("idx"));
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");
		
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.detail(bbs_id, selected, bbssort_type);
		request.setAttribute("update", dto);
		RequestDispatcher dis = request.getRequestDispatcher("s13u.jsp");
		dis.forward(request, response);
	}
	
	//학생 - 과제 게시판 수정 메서드
	public void update() throws IOException {
		UploadService upload = new UploadService(request);
		DTO dto = upload.regist();
		
		BbsDAO dao = new BbsDAO();
		String oldFileName = null;
		dao.update(dto);
		
		System.out.println("newFileName : "+dto.getUpload_name());
		if(dto.getUpload_name() != null) {
			dao = new BbsDAO();
			oldFileName = dao.fileNameCall(dto.getBbs_id());
			dao = new BbsDAO();
			dao.fileNameUpdate(dto.getBbs_id(),dto.getUpload_name(),oldFileName);
			upload.del(oldFileName);
		}
		response.sendRedirect("uploaddetail?idx="+dto.getBbs_id()+"&mName="+ java.net.URLEncoder.encode("과제","UTF-8")+"&selected="+dto.getSubject_id());
	}

	//학생 - 과제 게시판 삭제 메서드
	public void del() throws IOException, ServletException {
		int bbs_id = Integer.parseInt(request.getParameter("idx"));
		System.out.println(bbs_id+"번을 삭제하기 위해 삭제 메서드에 접근");
		
		BbsDAO dao = new BbsDAO();
		String fileName = dao.fileNameCall(bbs_id);
		if(dao.del(bbs_id) > 0) {
			if(fileName != null) {
				UploadService upload = new UploadService(request);
				upload.del(fileName);
			}
		}
		request.setAttribute("msg", "과목을 다시 선택하세요");
		RequestDispatcher dis = request.getRequestDispatcher("s09.jsp");
		dis.forward(request, response);
	}	

	//학생 - 강의 평가 메서드
	public void gradePage() throws ServletException, IOException {
		int subject_id = Integer.parseInt(request.getParameter("selected"));
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.gradePage(subject_id);
		/*request.setAttribute("info", dto);*/
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("main", dto);
		String obj = json.toJson(map);
		System.out.println(obj);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	//학생 - 강의 평가 저장 메서드
	public void grade() throws IOException {
		int selected = Integer.parseInt(request.getParameter("selected"));
		String std_id = request.getParameter("id");
		int num1 = Integer.parseInt(request.getParameter("s0"));
		int num2 = Integer.parseInt(request.getParameter("s1"));
		int num3 = Integer.parseInt(request.getParameter("s2"));
		int num4 = Integer.parseInt(request.getParameter("s3"));
		int num5 = Integer.parseInt(request.getParameter("s4"));
		
		int aver = (num1+num2+num3+num4+num5) / 5;
		
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.grade(selected, std_id, aver);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("main", dto);
		String obj = json.toJson(map);
		System.out.println(obj);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}
	
	/*************************************************교수**********************************************************/
	
	//교수 - 과목게시판 클릭시 select에 신청과목 들어가는 메서드
	public void prosubjectTab() throws IOException {
		String id = request.getParameter("id");
		BbsDAO dao = new BbsDAO();
		ArrayList<DTO> prosublist =  dao.prosublist(id);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("prosublist", prosublist);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	//교수 - 강의자료 게시판 조회 메서드
	public void prolist() throws ServletException, IOException {
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");

		BbsDAO dao = new BbsDAO();
		ArrayList<DTO> list = dao.list(selected,bbssort_type);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}
	
	//교수 - 강의자료 상세보기 메서드
	public void prodetail() throws ServletException, IOException {
		int bbs_id = Integer.parseInt(request.getParameter("idx"));
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");
		
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.detail(bbs_id,selected,bbssort_type);
		
		if(dto != null) {
			request.setAttribute("detail", dto);
		}else {
			System.out.println("dto값이 없음");
		}
		RequestDispatcher dis = request.getRequestDispatcher("p05.jsp");
		dis.forward(request, response);
	}

	//교수 - 과제 게시판 조회 메서드
	public void prouploadlist() throws ServletException, IOException {
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");

		BbsDAO dao = new BbsDAO();
		ArrayList<DTO> uploadlist = dao.list(selected,bbssort_type);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", uploadlist);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	//교수 - 과제 게시판 상세보기 메서드
	public void prouploaddetail() throws ServletException, IOException {
		int bbs_id = Integer.parseInt(request.getParameter("idx"));
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");
		
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.detail(bbs_id,selected,bbssort_type);
		
		if(dto != null) {
			request.setAttribute("detail", dto);
		}else {
			System.out.println("dto값이 없음");
		}
		RequestDispatcher dis = request.getRequestDispatcher("p08.jsp");
		dis.forward(request, response);
	}

	//교수 - 강의 자료 글작성 메서드
	public void prowrite() throws IOException {
		UploadService upload = new UploadService(request);
		DTO dto = upload.regist();
		
		BbsDAO dao = new BbsDAO();
		int pk = dao.write(dto);

		String page = "p06.jsp";
		if(pk > 0) {
			page = "./prodetail?idx="+pk+"&mName="+ java.net.URLEncoder.encode("강의자료","UTF-8")+"&selected="+dto.getSubject_id();
		}
		response.sendRedirect(page);
	}
	
	//교수 - 강의 자료 글 폼 요청 메서드
	public void proupdatePage() throws ServletException, IOException {
		int bbs_id = Integer.parseInt(request.getParameter("idx"));
		int selected = Integer.parseInt(request.getParameter("selected"));
		String bbssort_type = request.getParameter("mName");
		
		BbsDAO dao = new BbsDAO();
		DTO dto = dao.detail(bbs_id, selected, bbssort_type);
		request.setAttribute("update", dto);
		RequestDispatcher dis = request.getRequestDispatcher("p06u.jsp");
		dis.forward(request, response);
	}
	
	//교수 - 강의 자료 글 수정 메서드
	public void proupdate() throws IOException {
		UploadService upload = new UploadService(request);
		DTO dto = upload.regist();
		
		BbsDAO dao = new BbsDAO();
		String oldFileName = null;
		dao.update(dto);
		
		System.out.println("newFileName : "+dto.getUpload_name());
		if(dto.getUpload_name() != null) {
			dao = new BbsDAO();
			oldFileName = dao.fileNameCall(dto.getBbs_id());
			dao = new BbsDAO();
			dao.fileNameUpdate(dto.getBbs_id(),dto.getUpload_name(),oldFileName);
			upload.del(oldFileName);
		}
		response.sendRedirect("prodetail?idx="+dto.getBbs_id()+"&mName="+ java.net.URLEncoder.encode("강의자료","UTF-8")+"&selected="+dto.getSubject_id());
	}

	//교수 - 강의 자료 글 삭제 메서드
	public void prodel() throws IOException {
		int bbs_id = Integer.parseInt(request.getParameter("idx"));
		
		BbsDAO dao = new BbsDAO();
		String fileName = dao.fileNameCall(bbs_id);
		if(dao.del(bbs_id) > 0) {
			if(fileName != null) {
				UploadService upload = new UploadService(request);
				upload.del(fileName);
			}
		}
		response.sendRedirect("p04.jsp");
	}

}

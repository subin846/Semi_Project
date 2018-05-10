package com.semi2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi2.service.AdminService;
import com.semi2.service.BbsService;
import com.semi2.service.MainService;
import com.semi2.service.InfoService;
import com.semi2.service.LectureService;

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
		LectureService lectureService = null;
		
		switch (sub) {
		/******************* 준도 *******************/
		case "/sProfile" :
			System.out.println("학생 신상조회 요청");
			infoService = new InfoService(request, response);
			infoService.sProfile();
			break;
		case "/sTimetable" :
			System.out.println("학생 시간표 요청");
			infoService = new InfoService(request, response);
			infoService.sTimetable();
			break;
		case "/tuitionTerm" :
			System.out.println("등록금 학기 가져오기");
			infoService = new InfoService(request, response);
			infoService.tuitionTerm();
			break;
		case "/tuition" :
			System.out.println("등록금고지서 요청");
			infoService = new InfoService(request, response);
			infoService.tuition();
			break;
		case "/scholar" :
			System.out.println("장학금조회 요청");
			infoService = new InfoService(request, response);
			infoService.scholar();
			break;
		case "/score" :
			System.out.println("성적조회 요청");
			infoService = new InfoService(request, response);
			infoService.score();
			break;
		case "/calPage" :
			System.out.println("학점계산기 페이지 요청");
			infoService = new InfoService(request, response);
			infoService.calPage();
			break;
		case "/cal" :
			System.out.println("학점계산 요청");
			infoService = new InfoService(request, response);
			infoService.cal();
			break;
		case "/pTimetable" :
			System.out.println("교수 시간표 요청");
			infoService = new InfoService(request, response);
			infoService.pTimetable();
			break;
		case "/pProfile" :
			System.out.println("교수 신상정보 요청");
			infoService = new InfoService(request, response);
			infoService.pProfile();
			break;
		case "/studentSearch" :
			System.out.println("수강생조회 요청");
			lectureService = new LectureService(request, response);
			lectureService.studentSearch();
			break;
		case "/scoreRegistPage" :
			System.out.println("성적등록 페이지 요청");
			lectureService = new LectureService(request, response);
			lectureService.scoreRegistPage();
			break;
		case "/scoreRegist" :
			System.out.println("성적등록 요청");
			lectureService = new LectureService(request, response);
			lectureService.scoreRegist();
			break;
			
		/******************* 준도 *******************/
			
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
			//은경
			BbsService bbs;
			
			case "/subjectTab":
				System.out.println("select에 신청과목 들어가도록 요청");
				bbs = new BbsService(request,response);
				bbs.subjectTab();
				break;
				
			case "/subjectSel":
				System.out.println("select값을 가져와 옵션 채워넣기");
				bbs = new BbsService(request, response);
				bbs.subjectSel();
				break;
				
			case "/list":
				System.out.println("게시판 리스트 요청");
				bbs = new BbsService(request, response);
				bbs.list();
				break;	
				
			case "/write":
				System.out.println("글쓰기 요청");
				bbs = new BbsService(request,response);
				bbs.write();
				break;	
				
			case "/detail":
				System.out.println("상세보기 요청");
				bbs = new BbsService(request,response);
				bbs.detail();
				break;	
			
		default :
			System.out.println("Input error");
		}
	}

}

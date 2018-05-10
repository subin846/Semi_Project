package com.semi2.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.semi2.dto.DTO;

public class UploadService {
	
	HttpServletRequest request = null;
	String savePath= null;
	
	public UploadService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		String root = request.getSession().getServletContext().getRealPath("/");
		savePath = root+"upload";
	}

	//파일 등록 메서드
	public DTO regist() {
		DTO dto = new DTO();
		File dir = new File(savePath);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		try {
			//MultipartRequest는 파일 업로드를 위해 사용한다
			//MultipartRequest(request, 저장경로, 용량, 인코딩, 중복정책(생략) --> 이름을 변경해줄것이기 때문에 필요가 없음)로 변환 
			MultipartRequest multi = new MultipartRequest(request, savePath, 1024*1024*10, "UTF-8");
			
			//MultipartRequest 에서 제목, 내용, 작성자 추출해서 DTO에 추가
			//writeForm에서 -> write() 호출 -> write()에서 regist() 호출되기 때문에 writeForm에서 파라미터 값을 받아옴
			dto.setBbs_title(multi.getParameter("bbs_title"));
			dto.setBbs_writer(multi.getParameter("bbs_writer"));
			dto.setBbs_date(multi.getParameter("bbs_date"));
			dto.setBbs_content(multi.getParameter("bbs_content"));
			
			//파일명 추출
			String oriFileName = multi.getFilesystemName("document");
			//가져온 파일명이 null이 아니라는 것은 업로드된 파일이 있다는 뜻
			if(oriFileName != null) {
				//확장자 추출
				String ext = oriFileName.substring(oriFileName.indexOf("."));
				
				//새파일명 만들기(새파일명 + 확장자)
				String newFileName = System.currentTimeMillis()+ext;
				
				//파일명 변경
				//파일을 객체화하여 사용할 때에는 File 변수명 = new File(파일 경로)
				File oldFile = new File(savePath+"/"+oriFileName);
				File newFile = new File(savePath+"/"+newFileName);
				oldFile.renameTo(newFile);
				
				//변경된 파일명 DTO에 추가
				dto.setUpload_name(newFileName);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return dto;
	}

}

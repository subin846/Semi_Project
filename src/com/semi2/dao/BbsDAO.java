package com.semi2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.semi2.dto.DTO;

public class BbsDAO {
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	//DB 연결
	public BbsDAO(){
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//자원반납 메서드
	public void resClose() {
			try {
				if (rs != null) {
				rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}

	//게시판 타입을 세션에 담아 파라미터에 넣어줄것
	public ArrayList<DTO> list(String selected) {
		System.out.println(selected);
		ArrayList<DTO> list = new ArrayList<DTO>();
		DTO dto= null;
		String sql = "SELECT B.bbs_number, B.bbs_title, B.bbs_writer, B.bbs_date FROM bbs B JOIN bbssort bs ON bs.bbssort_type = B.bbssort_type "
				+ "JOIN subject sub ON sub.subject_id = B.subject_id "
				+"JOIN bbssort bs ON bs.bbssort_type = B.bbssort_type"
				+ "WHERE sub.subject_name=?  AND bs.bbssort_type=? ORDER BY B.bbs_number DESC";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, selected);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new DTO();
				dto.setBbs_number(rs.getInt("bbs_number"));
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_writer(rs.getString("bbs_writer"));
				dto.setBbs_date(rs.getString("bbs_date"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}

	//신청과목 리스트
	public ArrayList<DTO> sublist(String id) {
		ArrayList<DTO> sublist = new ArrayList<>();
		String sql = "SELECT sub.subject_name FROM subject sub JOIN enroll e ON e.subject_id = sub.subject_id WHERE e.std_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				DTO dto = new DTO();
				dto.setSubject_name(rs.getString("subject_name"));
				sublist.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("sql 에러");
			e.printStackTrace();
		}finally {
			resClose();
		}
		return sublist;
	}

	//글쓰기 메서드
	public int write(DTO dto) {
		long fk = 0;
		String sql = "INSERT INTO bbs VALUES(seq_bbs_id.NEXTVAL, seq_bbssort1_number.NEXTVAL,?,?,?,SYSDATE,?,?)";
		try {
			ps = conn.prepareStatement(sql, new String[] {"bbs_id"});
			ps.setString(1, dto.getBbs_title());
			ps.setString(2, dto.getBbs_content());
			ps.setString(3, dto.getBbs_writer());
			ps.setInt(4, dto.getSubject_id());
			ps.setString(5, dto.getSubject_name());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			String fileName = dto.getUpload_name();
			System.out.println("업로드된 파일 : "+fileName);
			fk = rs.getLong("bbs_id");
			if (fileName != null) {
				sql = "INSERT INTO upload(upload_id, upload_name, bbs_id) VALUES (seq_upload_id.NEXTVAL,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, dto.getUpload_name());
				ps.setLong(2, fk);
				ps.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return (int) fk;
	}

	public DTO detail(int bbs_number, String selected) {
		DTO dto = null;
		String sql = "SELECT B.bbs_title, B.bbs_writer, B.bbs_date, B.bbs_content, U.upload_name FROM bbs B "
				+ "JOIN upload U ON u.bbs_id = B.bbs_id JOIN subject S ON S.subject_id = B.subject_id "
				+ "WHERE B.bbs_number=? AND subject_name=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbs_number);
			ps.setString(2, selected);
			rs = ps.executeQuery();
			while(rs.next()) {
				dto = new DTO();
				dto.setBbs_title(rs.getString("bbs_title"));
				dto.setBbs_writer(rs.getString("bbs_writer"));
				dto.setBbs_date(rs.getString("bbs_date"));
				dto.setBbs_content(rs.getString("bbs_content"));
				dto.setUpload_name(rs.getString("upload_name"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return dto;
	}


}

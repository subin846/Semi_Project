package com.semi2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.semi2.dto.DTO;

public class InfoDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	// 생성자 : DB 연결
	public InfoDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 자원 반납
	public void resClose() {
		try {
			if (rs != null) rs.close();
			if (ps != null) ps.close();
			if (conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 학생 신상조회
	public DTO sProfile(String loginId) {
		DTO dto = new DTO();
		String sql = "SELECT s.std_id, s.std_name, m.major_name, s.std_year, s.std_state, s.std_birthday, s.std_phone, s.std_email, s.std_address " 
				+ "FROM major M JOIN std S ON M.major_id = S.major_id "
				+ "WHERE s.std_id = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				dto.setStd_id(rs.getString("std_id"));
				dto.setStd_year(rs.getInt("std_year"));
				dto.setStd_name(rs.getString("std_name"));
				dto.setStd_birthday(rs.getString("std_birthday"));
				dto.setMajor_name(rs.getString("major_name"));
				dto.setStd_state(rs.getString("std_state"));
				dto.setStd_phone(rs.getString("std_phone"));
				dto.setStd_email(rs.getString("std_email"));
				dto.setStd_address(rs.getString("std_address"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		
		return dto;
	}

	// 학생 시간표 조회
	public ArrayList<DTO> sTimetable(String loginId) {
		ArrayList<DTO> list = new ArrayList<>();
		String sql = "SELECT sub.subject_name, sub.subject_time, sub.subject_room " + 
				"FROM enroll E " + 
				"JOIN subject sub ON e.subject_id = sub.subject_id " + 
				"JOIN pro P ON P.pro_id = sub.pro_id " + 
				"WHERE std_id = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				DTO dto = new DTO();
				dto.setSubject_name(rs.getString("subject_name"));
				dto.setSubject_time(rs.getString("subject_time"));
				dto.setSubject_room(rs.getString("subject_room"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return list;
	}

}

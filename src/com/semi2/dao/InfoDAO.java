package com.semi2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	
	public DTO sProfile() {
		DTO dto = new DTO();
		String sql = "SELECT s.std_id, s.std_name, m.major_name, s.std_year, s.std_state, s.std_birthday, s.std_phone, s.std_email, s.std_address " + 
				"FROM major M JOIN std S ON M.major_id = S.major_id ";
		
		try {
			ps = conn.prepareStatement(sql);
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

}

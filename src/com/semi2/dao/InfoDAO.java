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
		String sql = "SELECT * FROM std";
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				dto.setStd_id(rs.getString("std_id"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		
		return dto;
	}

}

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

public class AdminDAO {
	Connection conn=null;
	ResultSet rs=null;
	PreparedStatement ps= null;
	public AdminDAO(){
		try {
			Context cont= new InitialContext();
			DataSource ds=(DataSource) cont.lookup("java:comp/env/jdbc/Oracle");
			conn=ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//리스트
		public ArrayList<DTO> sManagePage() {
			ArrayList<DTO> list = new ArrayList<>();
			String sql="SELECT * FROM std";
			DTO dto = null;
			System.out.println("쿼리실행");
			try {
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				while(rs.next()) {
					dto=new DTO();
					dto.setStd_id(rs.getString("std_id"));
					dto.setStd_year(rs.getInt("std_year"));
					dto.setStd_name(rs.getString("std_name"));
					dto.setStd_birthday(rs.getString("std_birthday"));
					dto.setStd_state(rs.getString("std_state"));
					dto.setStd_phone(rs.getString("std_phone"));
					dto.setStd_email(rs.getString("std_email"));
					dto.setStd_address(rs.getString("std_address"));		
					list.add(dto);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}finally {
				close();
			}
			return list;
		}
		/**자원반납***************************/
		public void close() {
			try {
				if(rs  !=null) {
					rs.close();
				}
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		/**수정***************************/
		public int sUpdate(DTO dto) {
			String sql="UPDATE std SET  std_year=?,std_name=?,std_birthday=?,std_state=?,std_phone=?,std_email=?,std_address=? WHERE std_id=?" ;
			int success=0;
			try {
				ps =conn.prepareStatement(sql);
				ps.setInt(1, dto.getStd_year());
				ps.setString(2, dto.getStd_name());
				ps.setString(3, dto.getStd_birthday());
				ps.setString(4, dto.getStd_state());
				ps.setString(5, dto.getStd_phone());
				ps.setString(6, dto.getStd_email());
				ps.setString(7, dto.getStd_address());
				ps.setString(8, dto.getStd_id());
				success=ps.executeUpdate();
				System.out.println(dto.getStd_id());
			} catch (SQLException e) {
				e.printStackTrace();
				return 0;
			}finally {
				close();
			}
			return success;
		}
		/**수정폼*************/
		public DTO sUpdatePage(String studentId) {
			DTO dto=null;
			String sql = "SELECT * FROM std WHERE std_id=?";
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, studentId);
				rs=ps.executeQuery();
				if(rs.next()) {
					dto=new DTO();
					System.out.println(rs.getString("std_id"));
					dto.setStd_id(rs.getString("std_id"));
					
					dto.setStd_year(rs.getInt("std_year"));
					dto.setStd_name(rs.getString("std_name"));
					dto.setStd_birthday(rs.getString("std_birthday"));
					dto.setStd_state(rs.getString("std_state"));
					dto.setStd_phone(rs.getString("std_phone"));
					dto.setStd_email(rs.getString("std_email"));
					dto.setStd_address(rs.getString("std_address"));		
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return dto;
			}finally {
				close();
			}
			return dto;
		}
		/**학생 등록************************/
		public int sAdd(DTO dto) {
			int success=0;
			String sql = "INSERT INTO std(std_id, std_phone, std_address, std_year, std_state, std_birthday, std_email, std_name, std_pw, major_id) " + 
					"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, dto.getStd_id());
				ps.setString(2, dto.getStd_phone());
				ps.setString(3, dto.getStd_address());
				ps.setInt(4, dto.getStd_year());
				ps.setString(5, dto.getStd_state());
				ps.setString(6, dto.getStd_birthday());
				ps.setString(7, dto.getStd_email());
				ps.setString(8, dto.getStd_name());
				ps.setString(9, dto.getStd_pw());
				ps.setString(10, dto.getMajor_name());
				success=ps.executeUpdate();
				System.out.println(success);
			} catch (SQLException e) {
				e.printStackTrace();
				success=0;
			}finally {
				close();
			}
			return success;
		}
		/**삭제****************************/
		public int sDel(String std_id) {
			String sql="DELETE FROM std WHERE std_id = ?" ;
			int success =0;
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, std_id);
				success = ps.executeUpdate();
				System.out.println(std_id);
			} catch (SQLException e) {
				e.printStackTrace();
				success=0;
			}finally {
				close();
			}
			return success;
		}
		/**검색 ****************/
		public ArrayList<DTO> sSearch(String selectbox, String val) {
			ArrayList<DTO> list = new ArrayList<>();
			try {
				if(selectbox.equals("std_id")) {
					ps=conn.prepareStatement("SELECT * FROM std WHERE std_id = ?");
					ps.setString(1, val);
				}else if(selectbox.equals("std_name")) {
					ps=conn.prepareStatement("SELECT * FROM std WHERE std_name=?");
					ps.setString(1, val);
				}else if(selectbox.equals("std_state")) {
					ps=conn.prepareStatement("SELECT * FROM std WHERE std_state=?");
					ps.setString(1, val);
				}
				rs=ps.executeQuery();
				System.out.println("/////////////");
				while(rs.next()) {
					DTO dto=new DTO();
					System.out.println(rs.getString("std_id"));
					dto.setStd_id(rs.getString("std_id"));
					dto.setStd_year(rs.getInt("std_year"));
					dto.setStd_name(rs.getString("std_name"));
					dto.setStd_birthday(rs.getString("std_birthday"));
					dto.setStd_state(rs.getString("std_state"));
					dto.setStd_phone(rs.getString("std_phone"));
					dto.setStd_email(rs.getString("std_email"));
					dto.setStd_address(rs.getString("std_address"));		
					list.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}finally {
				close();
			}
			return list;
		}
}

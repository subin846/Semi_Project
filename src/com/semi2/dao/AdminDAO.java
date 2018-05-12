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
		/**등록금*****************************/
		public ArrayList<DTO> tMangePage() {
			ArrayList<DTO> list = new ArrayList<DTO>();
			String sql="SELECT t.term_id,s.std_id,s.std_name,sc.scholar_name,sc.scholar_money,t.tuition_money "
					+ "FROM scholar sc JOIN tuition t ON sc.scholar_id = t.scholar_id JOIN std s ON t.std_id = s.std_id"; 
			DTO dto = null;
			try {
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				while(rs.next()) {
					dto=new DTO();
					dto.setTerm_id(rs.getString("term_id"));
					dto.setStd_id(rs.getString("std_id"));
					dto.setStd_name(rs.getString("std_name"));
					dto.setScholar_name(rs.getString("scholar_name"));
					dto.setScholar_money(rs.getInt("scholar_money"));
					dto.setTuition_money(rs.getInt("tuition_money"));
					dto.setTotalMoney(rs.getInt("tuition_money")-rs.getInt("scholar_money"));
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
		/**등록금수정폼 **********/
		public DTO tUpdatePage(String studentId, String term_id) {
				DTO dto=null;
				String sql = "SELECT t.term_id,s.std_id,s.std_name,sc.scholar_name,sc.scholar_money,t.tuition_money " + 
					 "FROM scholar sc JOIN tuition t ON sc.scholar_id = t.scholar_id JOIN std s ON t.std_id = s.std_id WHERE t.std_id=? AND t.term_id=?"; 
				try {
					ps=conn.prepareStatement(sql);
					ps.setString(1, studentId);
					ps.setString(2, term_id);
					rs=ps.executeQuery();
					
					if(rs.next()) {
						dto=new DTO();
						dto.setTerm_id(rs.getString("term_id"));
						dto.setStd_id(rs.getString("std_id"));
						dto.setStd_name(rs.getString("std_name"));
						dto.setScholar_name(rs.getString("scholar_name"));
						dto.setScholar_money(rs.getInt("scholar_money"));
						dto.setTuition_money(rs.getInt("tuition_money"));
					}
				} catch (SQLException e) {
					e.printStackTrace();
					return dto;
				}finally {
					close();
				}
				return dto;
		}
		/**등록금수정**********/
		public int tUpdate(DTO dto) {
			String sql="UPDATE tuition SET tuition_money=? WHERE std_id=? AND term_id=?";
			int success = 0;
			try {
				ps=conn.prepareStatement(sql);
				ps.setInt(1, dto.getTuition_money());
				ps.setString(2, dto.getStd_id());
				ps.setString(3, dto.getTerm_id());
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
		/**등록금 삭제************/
		public int tDell(String std_id, String term_id) {
			String sql="DELETE FROM tuition WHERE std_id = ? AND term_id=?" ;
			int success =0;
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, std_id);
				ps.setString(2, term_id);
				System.out.println(term_id);
				System.out.println(std_id);
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
		/**등록금 등록*****************/
		public int tAdd(DTO dto) {
			int success=0;
			String sql = "INSERT INTO tuition(tuition_id, tuition_money,std_id,scholar_id,term_id) VALUES (seq_tuition_id.NEXTVAL,?,?,?,?) ";
			try {
				ps=conn.prepareStatement(sql);
				ps.setInt(1, dto.getTuition_money());
				ps.setString(2, dto.getStd_id());
				ps.setInt(3, dto.getScholar_id());
				ps.setString(4, dto.getTerm_id());
				success=ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				success=0;
			}finally {
				close();
			}
			return success;
		}
		/**등록금 검색*************/
		public ArrayList<DTO> tSearch(String selectbox, String val) {
			ArrayList<DTO> list = new ArrayList<>();
			try {
				if(selectbox.equals("std_id")) {
					ps=conn.prepareStatement("SELECT t.term_id,s.std_id,s.std_name,sc.scholar_name,sc.scholar_money,t.tuition_money " + 
							"FROM scholar sc JOIN tuition t ON sc.scholar_id = t.scholar_id JOIN std s ON t.std_id = s.std_id WHERE t.std_id=?");
					ps.setString(1, val);
				}else if(selectbox.equals("std_name")) {
					ps=conn.prepareStatement("SELECT t.term_id,s.std_id,s.std_name,sc.scholar_name,sc.scholar_money,t.tuition_money " + 
							"FROM scholar sc JOIN tuition t ON sc.scholar_id = t.scholar_id JOIN std s ON t.std_id = s.std_id WHERE s.std_name=?");
					ps.setString(1, val);
				}else if(selectbox.equals("term_id")) {
					ps=conn.prepareStatement("SELECT t.term_id,s.std_id,s.std_name,sc.scholar_name,sc.scholar_money,t.tuition_money " + 
							"FROM scholar sc JOIN tuition t ON sc.scholar_id = t.scholar_id JOIN std s ON t.std_id = s.std_id WHERE t.term_id=?");
					ps.setString(1, val);
				}
				rs=ps.executeQuery();
				while(rs.next()) {
					DTO dto=new DTO();
					dto.setTerm_id(rs.getString("term_id"));
					dto.setStd_id(rs.getString("std_id"));
					dto.setStd_name(rs.getString("std_name"));
					dto.setScholar_name(rs.getString("scholar_name"));
					dto.setScholar_money(rs.getInt("scholar_money"));
					dto.setTuition_money(rs.getInt("tuition_money"));
					dto.setTotalMoney(rs.getInt("tuition_money")-rs.getInt("scholar_money"));
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
		/**장학금 리스트****************/
		public ArrayList<DTO> scPage() {
			ArrayList<DTO> list = new ArrayList<>();
			String sql="SELECT * FROM scholar";
			DTO dto = null;
			try {
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				while(rs.next()) {
					dto=new DTO();
					dto.setScholar_id(rs.getInt("scholar_id"));
					dto.setScholar_name(rs.getString("scholar_name"));
					dto.setScholar_money(rs.getInt("scholar_money"));
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
		/**장학금 수정폼****************/
		public DTO scUpdatePage(int scholar_id) {
			DTO dto=null;
			String sql = "SELECT * FROM scholar WHERE scholar_id=?"; 
			try {
				ps=conn.prepareStatement(sql);
				ps.setInt(1, scholar_id);
				rs=ps.executeQuery();
				if(rs.next()) {
					dto=new DTO();
					dto.setScholar_id(rs.getInt("scholar_id"));
					dto.setScholar_name(rs.getString("scholar_name"));
					dto.setScholar_money(rs.getInt("scholar_money"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return dto;
			}finally {
				close();
			}
			return dto;
		}
		/**장학금 수정***************/
		public int scUpdate(DTO dto) {
			String sql="UPDATE scholar SET scholar_name=?, scholar_money=? WHERE scholar_id=?";
			int success = 0;
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, dto.getScholar_name());
				ps.setInt(2, dto.getScholar_money());
				ps.setInt(3, dto.getScholar_id());
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
		/**장학금 삭제***************/
		public int scDel(int scholar_id) {
			String sql="DELETE FROM scholar WHERE scholar_id = ?" ;
			int success =0;
			try {
				ps=conn.prepareStatement(sql);
				ps.setInt(1, scholar_id);
				success = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				success=0;
			}finally {
				close();
			}
			return success;
		}
		/**장학금 등록***************/
		public int scAdd(DTO dto) {
			int success=0;
			String sql = "INSERT INTO scholar (scholar_id,scholar_name,scholar_money) VALUES (seq_scholar_id.NEXTVAL,?,?) ";
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, dto.getScholar_name());
				ps.setInt(2, dto.getScholar_money());
				success=ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				success=0;
			}finally {
				close();
			}
			return success;
		}
}

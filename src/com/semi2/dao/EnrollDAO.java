package com.semi2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.semi2.dto.DTO;

public class EnrollDAO {
	Connection conn = null;
	PreparedStatement ps =null;
	ResultSet rs = null;
	/*생성자 : 객체화 시 가장 먼저 실행*/
	public EnrollDAO()  {
		
		try {
			//1.DB 정보가 담겨있는 context.xml과 객체화
			Context ctx = new InitialContext();
			//2.데이터를 추출 하고 데이터를 통해 커넥션을 추출한다.
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/*DB접속을 통해 이전 학기 과목 데이터 조회*/
	public ArrayList<DTO> subjectSearch() {
		ArrayList<DTO> list  = new ArrayList<DTO>();
		String sql = " SELECT  term_id ,M.major_name, subject_name, P.pro_name, subject_room, subject_time, "
				+" subject_type, subject_credit, subject_limit, subject_grade "  
				+" FROM subject S " 
				+" JOIN major M " 
				+" ON S.major_id = M.major_id "  
				+" JOIN pro P" 
				+" ON S.pro_id = P.pro_id ORDER BY term_id DESC ";
		try {
			ps = conn.prepareStatement(sql);
			rs =ps.executeQuery();
			while(rs.next()) {
				System.out.println("반복문 실행!");
				DTO dto =new DTO();
				dto.setTerm_id(rs.getString("term_id"));
				dto.setMajor_name(rs.getString("major_name"));
				dto.setSubject_name(rs.getString("subject_name"));
				dto.setPro_name(rs.getString("pro_name"));
				dto.setSubject_room(rs.getString("subject_room"));
				dto.setSubject_time(rs.getString("subject_time"));
				dto.setSubject_type(rs.getString("subject_type"));
				dto.setSubject_credit(rs.getInt("subject_credit"));
				dto.setSubject_limit(rs.getInt("subject_limit"));
				dto.setSubject_grade(rs.getDouble("subject_grade"));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("예외 발생");
			e.printStackTrace();
			return null;
		}finally {
			resClose();
		}
		System.out.println("dto 배열 반환");
		return list;
	}
	
	/*자원 반납*/
	private void resClose() {
		try {
			if(rs !=null) {
				//executeQuery 만 쓰이기 때문에 항상 rs.close() 해줄 필요 없음. 사용시에만 닫아줌
				rs.close();
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<DTO> subjectFilter(String optSel, String selId) {
		ArrayList<DTO> list = new ArrayList<DTO>();
		String sql ="";
		if(optSel.equals("entry")) {
			System.out.println("전체");
			sql =" SELECT  term_id ,M.major_name, subject_name, P.pro_name, subject_room, subject_time, "
					+" subject_type, subject_credit, subject_limit, subject_grade "  
					+" FROM subject S " 
					+" JOIN major M " 
					+" ON S.major_id = M.major_id "
					+" JOIN pro P" 
					+" ON S.pro_id = P.pro_id ORDER BY term_id DESC ";
		}else if(optSel.equals("term")) {
			System.out.println("학기");
			sql=" SELECT term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time,"
					+"  subject_type, subject_credit, subject_limit,subject_grade"  
					+ " FROM subject S"  
					+ " JOIN major M" 
					+ " ON S.major_id = M.major_id"  
					+ " JOIN pro P"  
					+ " ON S.pro_id = P.pro_id"  
					+ " WHERE S.term_id Like '%"+selId+"%' ORDER BY term_id DESC" ;
		}else if(optSel.equals("pro")) {
			System.out.println("교수");
			sql =" SELECT term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time, "
					+" subject_type, subject_credit, subject_limit,subject_grade " 
					+" FROM subject S" 
					+" JOIN major M"  
					+" ON S.major_id = M.major_id"  
					+" JOIN pro P "  
					+" ON S.pro_id = P.pro_id"  
					+" WHERE P.pro_name LIKE '%"+selId+"%' ORDER BY term_id DESC" ;
			
		}else if(optSel.equals("maj")) {
			System.out.println("학과");
			sql =" SELECT term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time,"
					+" subject_type, subject_credit, subject_limit,subject_grade" 
					 +" FROM subject S"  
					 +" JOIN major M"  
					 +" ON S.major_id = M.major_id"  
					 +" JOIN pro P "  
					 +" ON S.pro_id = P.pro_id"  
					 +" WHERE M.major_name LIKE '%"+selId+"%' ORDER BY term_id DESC" ;
		}else {
			System.out.println("과목");
			sql=" SELECT term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time, "
					+" subject_type, subject_credit, subject_limit,subject_grade"  
					+" FROM subject S"  
					+" JOIN major M"  
					+" ON S.major_id = M.major_id" 
					+" JOIN pro P"  
					+" ON S.pro_id = P.pro_id" 
					+" WHERE S.subject_name LIKE '%"+selId+"%' ORDER BY term_id DESC" ;
		}
		try {
			ps =conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println("반복문 실행!");
				DTO dto =new DTO();
				dto.setTerm_id(rs.getString("term_id"));
				dto.setMajor_name(rs.getString("major_name"));
				dto.setSubject_name(rs.getString("subject_name"));
				dto.setPro_name(rs.getString("pro_name"));
				dto.setSubject_room(rs.getString("subject_room"));
				dto.setSubject_time(rs.getString("subject_time"));
				dto.setSubject_type(rs.getString("subject_type"));
				dto.setSubject_credit(rs.getInt("subject_credit"));
				dto.setSubject_limit(rs.getInt("subject_limit"));
				dto.setSubject_grade(rs.getDouble("subject_grade"));
				list.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("예외");
			e.printStackTrace();
			return null;
		}finally {
			resClose();
		}
		return list;
	}

}

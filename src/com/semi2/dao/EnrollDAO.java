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
import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;

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
	
	/*이 전 학기의 과목 평점 조회 필터링 검색*/
	public ArrayList<DTO> subjectSearch(String optSel, String selId, String term_id) {
		System.out.println("subjectSearch DAO");
		ArrayList<DTO> list = new ArrayList<DTO>();
		String sql ="";
		if(optSel.equals("entry")) {
			System.out.println("전체");
			sql =" SELECT  S.subject_id,term_id ,M.major_name, subject_name, P.pro_name, subject_room, subject_time, "
					+" subject_type, subject_credit, subject_limit, subject_grade "  
					+" FROM subject S " 
					+" JOIN major M " 
					+" ON S.major_id = M.major_id "
					+" JOIN pro P" 
					+" ON S.pro_id = P.pro_id "
					+term_id+ "ORDER BY term_id DESC ";
		}else if(optSel.equals("term")) {
			System.out.println("학기");
			sql=" SELECT term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time,"
					+"  subject_type, subject_credit, subject_limit,subject_grade"  
					+ " FROM subject S"  
					+ " JOIN major M" 
					+ " ON S.major_id = M.major_id"  
					+ " JOIN pro P"  
					+ " ON S.pro_id = P.pro_id"  
					+ " WHERE S.term_id Like '%"+selId+"%'"+term_id+ "ORDER BY term_id DESC" ;
		}else if(optSel.equals("pro")) {
			System.out.println("교수");
			sql =" SELECT S.subject_id,term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time, "
					+" subject_type, subject_credit, subject_limit,subject_grade " 
					+" FROM subject S" 
					+" JOIN major M"  
					+" ON S.major_id = M.major_id"  
					+" JOIN pro P "  
					+" ON S.pro_id = P.pro_id"  
					+" WHERE P.pro_name LIKE '%"+selId+"%'"+term_id+ "ORDER BY term_id DESC" ;
			
		}else if(optSel.equals("maj")) {
			System.out.println("학과");
			sql =" SELECT S.subject_id,term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time,"
					+" subject_type, subject_credit, subject_limit,subject_grade" 
					 +" FROM subject S"  
					 +" JOIN major M"  
					 +" ON S.major_id = M.major_id"  
					 +" JOIN pro P "  
					 +" ON S.pro_id = P.pro_id"  
					 +" WHERE M.major_name LIKE '%"+selId+"%'"+term_id+" ORDER BY term_id DESC" ;
		}else {
			System.out.println("과목");
			sql=" SELECT S.subject_id,term_id,M.major_name, subject_name, P.pro_name, subject_room, subject_time, "
					+" subject_type, subject_credit, subject_limit,subject_grade"  
					+" FROM subject S"  
					+" JOIN major M"  
					+" ON S.major_id = M.major_id" 
					+" JOIN pro P"  
					+" ON S.pro_id = P.pro_id" 
					+" WHERE S.subject_name LIKE '%"+selId+"%'"+term_id+" ORDER BY term_id DESC" ;
		}
		try {
			ps =conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				System.out.println("반복문 실행!");
				//System.out.println("과목 id"+rs.getString("subject_id"));
				DTO dto =new DTO();
				/*dto.setSubject_id(rs.getInt("subject_id"));*/
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
			System.out.println("전체과목 검색 에러");
			e.printStackTrace();
			return null;
		}finally {
			resClose();
		}
		return list;
	}
	/*로그인 학생의 수강 신청 과목 조회*/
	public ArrayList<DTO> stdEnroll(String loginId, String term_id) {
		System.out.println("stdEnroll DAO");
		ArrayList<DTO> list = new ArrayList<DTO>();
		String sql = " SELECT S.subject_id,term_id,M.major_name, subject_name, P.pro_name, "
				+" subject_room,subject_time,subject_type, subject_credit, subject_limit,subject_grade "
				+" FROM enroll E  JOIN subject S ON E.subject_id = S.subject_id "
				+" JOIN major M ON S.major_id = M.major_id "
				+" JOIN pro P ON S.pro_id = P.pro_id "
				+" WHERE E.std_id = ? AND S.term_id= ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			ps.setString(2, term_id);
			System.out.println("실행 전");
			rs = ps.executeQuery();
			System.out.println("실행 후");
			while(rs.next()) {
				System.out.println("과목 조회 반복!!");
				DTO dto = new DTO();
				dto.setSubject_id(rs.getInt("subject_id"));
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
				System.out.println("수강과목 조회 dto 담겼나?"+dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("과목 조회 에러");
			return null;
		}finally {
			resClose();
		}
		 return list;
	}
	
	
	/*로그인 학생의 수강 과목 학점 조회*/
	public int stdCredit(String loginId, String term_id) {
		System.out.println("stdCredit DAO");
		int resultCredit =0;
		System.out.println("stdCredit 호출");
		String sql = " SELECT C.subject_credit FROM"
		+ " std S,enroll E,subject C "  
		+" WHERE S.std_id = E.std_id AND E.subject_id = C.subject_id" 
		+" AND S.std_id =? AND C.term_id =? "; 
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			System.out.println(loginId);
			ps.setString(2, term_id);
			System.out.println(term_id);
			rs =ps.executeQuery();
			while(rs.next()) {
				//학점 더하기
				resultCredit +=rs.getInt("subject_credit");
				System.out.println("resultCredit : "+resultCredit);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(" 학점 조회 에러");
		}finally {
			//자원 반납
			resClose();
		}
		return resultCredit;
	}

	/*로그인 학생의 수강 신청 */
	public int[] enroll(String loginId, String[] tdValue) {
		System.out.println("enroll DAO");
		 //배열로 반환하는 이유는 . 수강신청 시 성공 여부와 신청학점을 출력하기 위해 배열로 선언하였다.
		//이때 크기는 2 로 잡은 이유는 2개만 반환 할 것이기 때문에 고정시켜줬다.
		int[] result =new int[3];
		//학생ID를 기준으로 배열에 담긴 값을 sql Insert문에 일일히 대응해 넣어줘야 한다.
		System.out.println(loginId +tdValue[0]);
		System.out.println("과목 id :"+tdValue[0]);
		String sql = " INSERT INTO enroll(enroll_id,std_id,subject_id) "
				+ " VALUES(seq_enroll_id.NEXTVAL,?,?)";
		System.out.println("sql 문 실행");
		System.out.println(loginId +tdValue[0]);
		try {
			//sql을 실행시키기위해
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			ps.setString(2, tdValue[0]);
			result[0]=	ps.executeUpdate();
			result[1] =Integer.parseInt(tdValue[0]);
		} catch (SQLException e) {
			System.out.println(" 수강신청 에러");
			e.printStackTrace();
			result[0] =0;
		}finally {
			//자원 반납
			resClose();
		}
		return result;
	}
	/*로그인 학생의 수강 정정 */
	public int enrollChange(String loginId, String subject_id) {
		System.out.println("enrollChange DAO");
		int success =0;
		String sql = " DELETE FROM enroll WHERE  std_id=? AND subject_id =?  " ;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			ps.setString(2,subject_id);
			success =ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("수강 정정 에러");
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
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
}

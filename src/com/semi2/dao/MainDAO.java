package com.semi2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.semi2.dto.DTO;
import com.semi2.dto.PwDTO;

public class MainDAO {
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public MainDAO() {
		try {
			// DB 연결
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void resClose() {
		System.out.println("자원 반납");
		try {
			if(rs != null) {//rs 가 사용해서 있을 경우만 닫아 준다.
				rs.close();
			}			
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	// 로그인
	public Boolean login(String id, String pw) {
		boolean result = false;
		if(id.startsWith("s")) {//id가 s로 시작하면 (학생 로그인 체크)
			//ID, PW 가 맞는 지 확인하기위해 쿼리문 준비
			String sql = "SELECT std_id FROM std WHERE std_id =? AND std_pw=? ";
			try {
				//쿼리 실행하기 위해 PrepareStatement 준비
				ps =conn.prepareStatement(sql);
				//실행 하기 전에 ? 대응
				ps.setString(1, id);
				ps.setString(2, pw);
				System.out.println(id + " "+ pw);
				//쿼리 실행
				rs =ps.executeQuery();
				result =rs.next();
				System.out.println(rs.next());
				System.out.println(result);			
			} catch (SQLException e) {
				e.printStackTrace();
				return false;				
			}finally {
				resClose(); 
			}
			
		}else if(id.startsWith("p")){//id가 p로 시작 하면 (교수 로그인 체크)
			//ID, PW 가 맞는 지 확인하기위해 쿼리문 준비
			String sql = "SELECT pro_id FROM pro WHERE pro_id =? AND pro_pw=? ";
			try {
				//쿼리 실행하기 위해 PrepareStatement 준비
				ps =conn.prepareStatement(sql);
				//실행 하기 전에 ? 대응
				ps.setString(1, id);
				ps.setString(2, pw);
				System.out.println(id + " "+ pw);
				//쿼리 실행
				rs =ps.executeQuery();
				result =rs.next();
				System.out.println(rs.next());
				System.out.println(result);			
			} catch (SQLException e) {
				e.printStackTrace();
				return false;	
			}finally {
				resClose();
			}
			
		}else {//그 외는 (관리자 로그인 체크)
			//ID, PW 가 맞는 지 확인하기위해 쿼리문 준비
			String sql = "SELECT admin_id FROM admin WHERE admin_id =? AND admin_pw=? ";
			try {
				//쿼리 실행하기 위해 PrepareStatement 준비
				ps =conn.prepareStatement(sql);
				//실행 하기 전에 ? 대응
				ps.setString(1, id);
				ps.setString(2, pw);
				System.out.println(id + " "+ pw);
				//쿼리 실행
				rs =ps.executeQuery();
				result =rs.next();
				System.out.println(rs.next());
				System.out.println(result);
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}finally {
				resClose();
			}
		}
		return result;
	}

	//비밀번호 변경
	public int passChange(DTO dto,PwDTO pwdto) {
		
		int success = 0;
		try {
			if(pwdto.getLoginidDTO().startsWith("s")) {
				String sql = "UPDATE std SET std_pw=? WHERE std_id=?";
				ps = conn.prepareStatement(sql);			
				ps.setString(1, pwdto.getnewPw());
				ps.setString(2, pwdto.getLoginidDTO());
			}else if(pwdto.getLoginidDTO().startsWith("p")) {
				String sql = "UPDATE pro SET pro_pw=? WHERE pro_id=?";
				ps = conn.prepareStatement(sql);			
				ps.setString(1, pwdto.getnewPw());
				ps.setString(2, pwdto.getLoginidDTO());
			}else {
				String sql = "UPDATE admin SET admin_pw=? WHERE admin_id=?";
				ps = conn.prepareStatement(sql);			
				ps.setString(1, pwdto.getnewPw());
				ps.setString(2, pwdto.getLoginidDTO());
			}
			System.out.println(pwdto.getnewPw());
			System.out.println(pwdto.getLoginidDTO());
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			resClose();
		}
		return success;
	}

}
			



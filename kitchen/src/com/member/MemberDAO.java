package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBConn;

public class MemberDAO {
	//권한 0 관리자 , 1 회원
	Connection conn = DBConn.getConnection();
	
	
	
	public int checkUserId(String userId) {
		int result=0;
		PreparedStatement pstmt = null;
		StringBuffer sb=new StringBuffer();
		ResultSet rs=null;
		try {
			sb.append("SELECT COUNT(*) cnt FROM member WHERE userId=?");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt("cnt");
			}
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	

	
	public MemberDTO readMember(String userId) {
		MemberDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT m.userId, userName, userPwd,");
			sb.append("      enabled, created_date, modify_date, email, point,");
			sb.append("      TO_CHAR(birth, 'YYYY-MM-DD') birth, ");
			sb.append("      email, tel, ");
			sb.append("      zip, addr_1, addr_2 ");
			sb.append("      FROM member m ");
			sb.append("      LEFT OUTER JOIN MEMBER_DETAIL md ");
			sb.append("      ON m.userId=md.userId ");
			sb.append("      WHERE m.userId=? ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto=new MemberDTO();
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setEnabled(rs.getString("enabled"));
				dto.setCreated_date(rs.getString("created_date"));
				dto.setModify_date(rs.getString("modify_date"));
				dto.setPoint(rs.getString("point"));
				dto.setEmail(rs.getString("email"));
				dto.setBirth(rs.getString("birth"));
				dto.setTel(rs.getString("tel"));
				dto.setZip(rs.getString("zip"));
				dto.setAddr_1(rs.getString("addr_1"));
				dto.setAddr_2(rs.getString("addr_2"));
			}
			rs.close();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

		public int insertMember(MemberDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
			try {
				String sql="INSERT INTO member (userId,userName,userPwd,enabled) VALUES (?,?,?,?)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getUserId());
				pstmt.setString(2, dto.getUserName());
				pstmt.setString(3, dto.getUserPwd());
				pstmt.setString(4, "1");
				result=pstmt.executeUpdate();
				pstmt.close();
				
				sql="INSERT INTO member_detail (userId,birth,email,tel,zip,addr_1,addr_2) VALUES(?,?,?,?,?,?,?)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getUserId());
				pstmt.setString(2, dto.getBirth());
				pstmt.setString(3, dto.getEmail());
				pstmt.setString(4, dto.getTel());
				pstmt.setString(5, dto.getZip());
				pstmt.setString(6, dto.getAddr_1());
				pstmt.setString(7, dto.getAddr_2());
				
				pstmt.executeUpdate();
				pstmt.close();
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			return result;
		}

	public int updateMember(MemberDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql="UPDATE member SET userPwd=? WHERE userId=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserPwd());
			pstmt.setString(2, dto.getUserId());
			result=pstmt.executeUpdate();
			pstmt.close();
			sql="UPDATE member_detail SET email=? , tel=? WHERE userId=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getUserId());
			result=pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}

	public int deleteMember(String userId) {
		int result=0;
		
		
		PreparedStatement pstmt=null;
		try {
			String sql="DELETE member2 WHERE userId=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			result=pstmt.executeUpdate();
			pstmt.close();
			sql="DELETE member1 WHERE userId=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	}
	
	
	
	
	


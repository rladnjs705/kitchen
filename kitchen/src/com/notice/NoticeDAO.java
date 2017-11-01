package com.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class NoticeDAO {
	Connection conn = DBConn.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql;
	
	public int insertNotice(NoticeDTO dto) {
		StringBuffer sb = new StringBuffer();
		int result=0;
		
		try {
			sb.append("INSERT INTO notice(num,notice,userId,subject,content,saveFileName,originalFileName,pwd) ");
			sb.append("VALUES(notice_seq.NEXTVAL,?,?,?,?,?,?,?)");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, dto.getNotice());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getSaveFileName());
			pstmt.setString(6, dto.getOriginalFileName());
			pstmt.setInt(7, dto.getPwd());
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
		}
		return result;
	}
	
	public int dataCount() {
		int data = 0;
		try {
			sql = "SELECT NVL(COUNT(num),0) cnt FROM notice";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				data = rs.getInt("cnt");
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	public int dataCount(String searchKey, String searchValue) {
		int data = 0;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("SELECT NVL(COUNT(num),0) cnt FROM notice ");
			if(searchKey.equals("subject")||searchKey.equals("content"))
				sb.append("WHERE INSTR("+searchKey+",?)>=1");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				data = rs.getInt("cnt");
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	public List<NoticeDTO> list(int start, int end) {
		StringBuffer sb = new StringBuffer();
		List<NoticeDTO> list = new ArrayList<>();
		NoticeDTO dto = null;
		try {
			sb.append("SELECT * FROM (");
			sb.append("	SELECT ROWNUM rnum, tb.* FROM(");
			sb.append("SELECT num,notice,n.userId,userName,subject,content,saveFileName,originalFileName, ");
			sb.append("hitCount,TO_CHAR(created,'YYYY-MM-DD') created FROM notice n ");
			sb.append("JOIN member m ON n.userId=m.userId");
			sb.append("		ORDER BY num DESC");
			sb.append("	) tb WHERE ROWNUM<=?");
			sb.append(") WHERE rnum>=?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("notice"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<NoticeDTO> list(int start, int end,String searchKey, String searchValue) {
		StringBuffer sb = new StringBuffer();
		List<NoticeDTO> list = new ArrayList<>();
		NoticeDTO dto = null;
		try {
			sb.append("SELECT * FROM (");
			sb.append("	SELECT ROWNUM rnum, tb.* FROM(");
			sb.append("SELECT num,notice,n.userId,userName,subject,content,saveFileName,originalFileName, ");
			sb.append("hitCount,TO_CHAR(created,'YYYY-MM-DD') created FROM notice n ");
			sb.append("JOIN member m ON n.userId=m.userId ");
			if(searchKey.equals("subject")||searchKey.equals("content"))
				sb.append("WHERE INSTR("+searchKey+",?)>=1 ");
			sb.append("		ORDER BY num DESC");
			sb.append("	) tb WHERE ROWNUM<=?");
			sb.append(") WHERE rnum>=?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("notice"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<NoticeDTO> listNotice() {
		List<NoticeDTO> list = new ArrayList<>();
		NoticeDTO dto = null;
		try {
			sql="SELECT num,notice,n.userId,userName,subject,content,saveFileName,originalFileName, hitCount,TO_CHAR(created,'YYYY-MM-DD') created FROM notice n \r\n" + 
					"JOIN member m ON n.userId=m.userId WHERE notice=1 ORDER BY num DESC";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("notice"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public NoticeDTO readNotice(int num) {
		NoticeDTO dto = null;
		try {
			sql = "SELECT num,notice,n.userId,userName,subject,content,saveFileName,originalFileName,hitCount,pwd,TO_CHAR(created,'YYYY-MM-DD') created FROM notice n "+ 
					"JOIN member m ON n.userId=m.userId WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("notice"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				dto.setPwd(rs.getInt("pwd"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public NoticeDTO preRead(int num,String searchKey, String searchValue) {
		NoticeDTO dto = null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("SELECT ROWNUM, tb.* FROM(");
			sb.append("SELECT num,notice,n.userId,userName,subject,content,saveFileName,originalFileName, ");
			sb.append("hitCount,TO_CHAR(created,'YYYY-MM-DD') created FROM notice n ");
			sb.append("JOIN member m ON n.userId=m.userId ");
			if(searchValue.length()==0) {
				sb.append("	WHERE num>?	ORDER BY num");
				sb.append("	) tb WHERE ROWNUM=1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}
				
			else if(searchKey.equals("subject")||searchKey.equals("content")) {
				sb.append(" WHERE INSTR("+searchKey+",?)>=1 AND num>? ");
				sb.append("		ORDER BY num");
				sb.append("	) tb WHERE ROWNUM=1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, searchValue);
				pstmt.setInt(2, num);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("notice"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public NoticeDTO nextRead(int num,String searchKey, String searchValue) {
		NoticeDTO dto = null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("SELECT ROWNUM, tb.* FROM(");
			sb.append("SELECT num,notice,n.userId,userName,subject,content,saveFileName,originalFileName, ");
			sb.append("hitCount,TO_CHAR(created,'YYYY-MM-DD') created FROM notice n ");
			sb.append("JOIN member m ON n.userId=m.userId ");
			if(searchValue.length()==0) {
				sb.append("	 WHERE num<? ORDER BY num DESC");
				sb.append("	) tb WHERE ROWNUM=1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
			}
				
			else if(searchKey.equals("subject")||searchKey.equals("content")) {
				sb.append(" WHERE INSTR("+searchKey+",?)>=1 AND num<?");
				sb.append("		ORDER BY num DESC");
				sb.append("	) tb WHERE ROWNUM=1");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, searchValue);
				pstmt.setInt(2, num);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("notice"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public int updateHit(int num) {
		int result=0;
		
		try {
			sql = "UPDATE notice SET hitCount=hitCount+1 WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int deleteNotice(int num) {
		int result = 0;
		
		try {
			sql = "DELETE notice WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
			} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateNotice(NoticeDTO dto) {
		int result = 0;
		try {
			sql = "UPDATE notice SET notice=?,subject=?,content=?,saveFileName=?,originalFileName=? WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNotice());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSaveFileName());
			pstmt.setString(5, dto.getOriginalFileName());
			pstmt.setInt(6, dto.getNum());
			
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}














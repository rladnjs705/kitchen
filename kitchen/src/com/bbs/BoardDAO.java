package com.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class BoardDAO {
	Connection conn = DBConn.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql;
	int seq;
	
	public int insertInquiry(BoardDTO dto, String mode) {
		int result = 0;
		StringBuffer sb = new StringBuffer();
		try {
			sql = "SELECT question_seq.NEXTVAL seq FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			seq=0;
			if(rs.next())
				seq = rs.getInt("seq");
			rs.close();
			pstmt.close();
			
			dto.setQuestionNum(seq);
			
			if(mode.equals("created")) {
				dto.setGroupNum(seq);
				dto.setOrderNo(0);
				dto.setDepth(0);
				dto.setParent(0);
			}
			else if(mode.equals("reply")) {
				//오더넘버 업데이트해줘야한다
				//답변인 경우,
				updateOrderNo(dto.getGroupNum(), dto.getOrderNo());
				
				dto.setDepth(dto.getDepth()+1);
				dto.setOrderNo(dto.getOrderNo()+1);
			}
			
			sb.append("INSERT INTO question(questionNum, userId, subject ,content, questionType ");
			sb.append(",groupNum, depth, orderNo, parent, tel, saveFileName, originalFileName,pwd) ");
			sb.append("VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, dto.getQuestionNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getQuestionType());
			pstmt.setInt(6, dto.getGroupNum());
			pstmt.setInt(7, dto.getDepth());
			pstmt.setInt(8, dto.getOrderNo());
			pstmt.setInt(9, dto.getParent());
			pstmt.setString(10, dto.getTel());
			pstmt.setString(11, dto.getSaveFileName());
			pstmt.setString(12, dto.getOriginalFileName());
			pstmt.setInt(13, dto.getPwd());
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String makeviewId(String userId) {
		String star = "";
		String id = "";
		for(int i=0;i<userId.length()-3;i++)
			star+="*";
		id = userId.substring(0,3)+star;
		
		return id;
	}
	
	public int updateOrderNo(int groupNum, int orderNo) {
		int result = 0;
		try {
			sql = "UPDATE question SET orderNo = orderNo+1 WHERE groupNum=? AND orderNo > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, groupNum);
			pstmt.setInt(2, orderNo);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int dataCount() {
		int dataCount = 0;
		try {
			sql = "SELECT NVL(COUNT(*),0) cnt FROM question";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				dataCount = rs.getInt("cnt");
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}
	
	//검색모드에서 전체개수
	public int dataCount(String searchKey, String searchValue) {
		int dataCount = 0;
		StringBuffer sb = new StringBuffer();
		//작성자, 제목, 내용, 등록일, 문의유형
		try {
			sb.append("SELECT NVL(COUNT(*),0) cnt FROM question q ");
			if(searchKey.equals("userName"))
				sb.append("JOIN member m ON q.userId=m.userId WHERE userName=?");
			else if(searchKey.equals("subject")||searchKey.equals("content"))
				sb.append("WHERE INSTR("+searchKey+",?)>=1");
			else if(searchKey.equals("questionType"))
				sb.append("WHERE questionType=?");
			else if(searchKey.equals("created")) {
				sb.append("WHERE (ROUND(MOD(MOD(MONTHS_BETWEEN(SYSDATE,created)/12,1)*12,1)*(365/12),0))<=? ");
				}
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				dataCount = rs.getInt("cnt");
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}
	
	public List<BoardDTO> listBoard(int start, int end){
		List<BoardDTO> list = new ArrayList<>();
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT questionNum, q.userId, userName,");
			sb.append("               subject, content, groupNum, orderNo, depth, hitCount,");
			sb.append("				  tel, saveFileName, originalFileName, created, questionType");
			//sb.append("               TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("               FROM question q");
			sb.append("               JOIN member m ON q.userId=m.userId");
			sb.append("               ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setQuestionNum(rs.getInt("questionNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setDepth(rs.getInt("depth"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setTel(rs.getString("tel"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				dto.setCreated(rs.getString("created"));
				dto.setViewId(makeviewId(rs.getString("userId")));

				if(rs.getString("questionType")==null)
					dto.setQuestionType("");
				else if(rs.getString("questionType").equals("store"))
					dto.setQuestionType("매장문의");
				else if(rs.getString("questionType").equals("delivery"))
					dto.setQuestionType("배달문의");
				else if(rs.getString("questionType").equals("system"))
					dto.setQuestionType("시스템오류문의");
				else if(rs.getString("questionType").equals("cooperate"))
					dto.setQuestionType("제휴문의");
				else if(rs.getString("questionType").equals("and"))
					dto.setQuestionType("기타");
				else if(rs.getString("questionType").equals("reply"))
					dto.setQuestionType("답변");
				
				String vacancy = "";
				for(int a=0;a<dto.getDepth();a++)
					vacancy+="&nbsp;&nbsp;";
				
				dto.setSubject(vacancy+rs.getString("subject"));
				
				list.add(dto);
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<BoardDTO> listBoard(int start, int end, String searchKey,String searchValue){
		List<BoardDTO> list = new ArrayList<>();
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT questionNum, q.userId, userName,");
			sb.append("               subject, content, groupNum, orderNo, depth, hitCount,");
			sb.append("				  tel, saveFileName, originalFileName, created, questionType");
			//sb.append("               TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("               FROM question q");
			sb.append("               JOIN member m ON q.userId=m.userId");
			if(searchKey.equals("created")) {
				sb.append("		WHERE (ROUND(MOD(MOD(MONTHS_BETWEEN(SYSDATE,created)/12,1)*12,1)*(365/12),0))<=? ");
			}
			if(searchKey.equals("userName")||searchKey.equals("questionType")) {
				sb.append("           WHERE "+searchKey+"=? ");
			} else if(searchKey.equals("subject")||searchKey.equals("content")){
				sb.append("           WHERE INSTR("+searchKey+", ?) >= 1 ");
			}
			sb.append("               ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				
				dto.setQuestionNum(rs.getInt("questionNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setDepth(rs.getInt("depth"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setTel(rs.getString("tel"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				dto.setCreated(rs.getString("created"));
				dto.setViewId(makeviewId(rs.getString("userId")));
				
				if(rs.getString("questionType")==null)
					dto.setQuestionType("");
				else if(rs.getString("questionType").equals("store"))
					dto.setQuestionType("매장문의");
				else if(rs.getString("questionType").equals("delivery"))
					dto.setQuestionType("배달문의");
				else if(rs.getString("questionType").equals("system"))
					dto.setQuestionType("시스템오류문의");
				else if(rs.getString("questionType").equals("cooperate"))
					dto.setQuestionType("제휴문의");
				else if(rs.getString("questionType").equals("and"))
					dto.setQuestionType("기타");
				else if(rs.getString("questionType").equals("reply"))
					dto.setQuestionType("답변");
				
				String vacancy = "";
				for(int a=0;a<dto.getDepth();a++)
					vacancy+="&nbsp;&nbsp;";
				
				dto.setSubject(vacancy+rs.getString("subject"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public BoardDTO readBoard(int questionNum) {
		BoardDTO dto=null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("SELECT questionNum, q.userId, userName, ");
			sb.append("		  subject, content, groupNum, orderNo, depth, hitCount, ");
			sb.append("		  tel, saveFileName, originalFileName, created, questionType, pwd ");
			sb.append("FROM question q JOIN member m ON q.userId=m.userId ");
			sb.append("WHERE questionNum=?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, questionNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				
				dto.setQuestionNum(rs.getInt("questionNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setDepth(rs.getInt("depth"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setTel(rs.getString("tel"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				dto.setCreated(rs.getString("created"));
				dto.setQuestionType(rs.getString("questionType"));
				dto.setPwd(rs.getInt("pwd"));
				dto.setViewId(makeviewId(rs.getString("userId")));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public BoardDTO preReadBoard(int groupNum, int orderNo, String searchKey, String searchValue) {
		BoardDTO dto = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			if(searchValue!=null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT questionNum, subject  ");
    			sb.append("               FROM question q");
    			sb.append("               JOIN member m ON q.userId=m.userId");
//    			if(searchKey.equals("created")) {
//    				searchValue=searchValue.replaceAll("-", "");
//    				sb.append("           WHERE (TO_CHAR(created, 'YYYYMMDD') = ? ) AND ");}
    			if(searchKey.equals("userName")||searchKey.equals("questionType")) {
    				sb.append("           WHERE "+searchKey+"=? AND ");
    			} else if(searchKey.equals("subject")||searchKey.equals("content")){
    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) AND ");
            	}
            
                sb.append("     (( groupNum = ? AND orderNo < ?) ");
                sb.append("         OR (groupNum > ? )) ");
                sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, groupNum);
                pstmt.setInt(3, orderNo);
                pstmt.setInt(4, groupNum);
			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("     SELECT questionNum, subject FROM question q JOIN member m ON q.userId=m.userId ");                
                sb.append("  WHERE (groupNum = ? AND orderNo < ?) ");
                sb.append("         OR (groupNum > ? ) ");
                sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, groupNum);
                pstmt.setInt(2, orderNo);
                pstmt.setInt(3, groupNum);
			}
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				
				dto.setQuestionNum(rs.getInt("questionNum"));
				dto.setSubject(rs.getString("subject"));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public BoardDTO nextReadBoard(int groupNum, int orderNo, String searchKey, String searchValue) {
		BoardDTO dto = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			if(searchValue!=null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT questionNum, subject  ");
    			sb.append("               FROM question q");
    			sb.append("               JOIN member m ON q.userId=m.userId");
//    			if(searchKey.equals("created")) {
//    				searchValue=searchValue.replaceAll("-", "");
//    				sb.append("           WHERE (TO_CHAR(created, 'YYYYMMDD') = ? ) AND ");}
    			if(searchKey.equals("userName")||searchKey.equals("questionType")) {
    				sb.append("           WHERE "+searchKey+"=? AND ");
    			} else if(searchKey.equals("subject")||searchKey.equals("content")){
    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) AND ");
            	}
            
                sb.append("     (( groupNum = ? AND orderNo > ?) ");
                sb.append("         OR (groupNum < ? )) ");
                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, groupNum);
                pstmt.setInt(3, orderNo);
                pstmt.setInt(4, groupNum);
			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("     SELECT questionNum, subject FROM question q JOIN member m ON q.userId=m.userId ");                
                sb.append("  WHERE (groupNum = ? AND orderNo > ?) ");
                sb.append("         OR (groupNum < ? ) ");
                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, groupNum);
                pstmt.setInt(2, orderNo);
                pstmt.setInt(3, groupNum);
			}
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				
				dto.setQuestionNum(rs.getInt("questionNum"));
				dto.setSubject(rs.getString("subject"));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public int updateHitCount(int questionNum) {
		int result = 0;
		try {
			sql = "UPDATE question SET hitCount=hitCount+1 WHERE questionNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, questionNum);
			result = pstmt.executeUpdate();
			
			pstmt.close();				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateInquiry(BoardDTO dto) {
		int result = 0;
		try {
			sql = "UPDATE question SET subject=?, content=?, tel=?, "
					+ "questionType=?, saveFileName=?, originalFileName=?, pwd=? WHERE questionNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getQuestionType());
			pstmt.setString(5, dto.getSaveFileName());
			pstmt.setString(6, dto.getOriginalFileName());
			pstmt.setInt(7, dto.getPwd());
			pstmt.setInt(8, dto.getQuestionNum());
			
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int deleteInquiry(int groupNum, int depth) {
		int result = 0;
		try {
			sql = "DELETE question WHERE groupNum=? AND depth>=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, groupNum);
			pstmt.setInt(2, depth);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}


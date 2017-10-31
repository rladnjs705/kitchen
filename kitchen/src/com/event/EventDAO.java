package com.event;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class EventDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertEvent(EventDTO dto) {
		int result = 0;
		PreparedStatement pstmt=null;
		String sql;
		
		String fields = "eventNum, userId, eventSubject, eventContent";
		sql="INSERT INTO event (" + fields + ") VALUES (event_seq.NEXTVAL, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getEventSubject());
			pstmt.setString(3, dto.getEventContent());
			
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 전체 데이터 개수
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		sql = "SELECT NVL(COUNT(eventNum), 0) cnt FROM event";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
				result=rs.getInt(1);
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 검색모드에서 전체의 개수 구하기
	public int dataCount(String searchKey, String searchValue) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			if(searchKey.equalsIgnoreCase("eventCreated"))
				sql="SELECT NVL(COUNT(*), 0) FROM event WHERE TO_CHAR(eventCreated, 'YYYY-MM-DD')=? ";
			else if(searchKey.equalsIgnoreCase("userId"))
				sql="SELECT NVL(COUNT(*), 0) FROM event WHERE INSTR(userId, ?) = 1";
			else
				sql="SELECT NVL(COUNT(*), 0) FROM event WHERE INSTR(" + searchKey + ", ? ) >=1 ";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, searchValue);
				
				rs=pstmt.executeQuery();
				
				if(rs.next())
					result=rs.getInt(1);
				rs.close();
				pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	// 리스트
	public List<EventDTO> listEvent(int start, int end){
		List<EventDTO> list=new ArrayList<EventDTO>();
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("		SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("			SELECT eventNum, userId, eventSubject, eventHitcount");
			sb.append("				,TO_CHAR(eventCreated, 'YYYY-MM-DD') eventCreated");
			sb.append("			FROM event");
			sb.append(" 		ORDER BY eventNum DESC");
			sb.append("		) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventDTO dto = new EventDTO();
				dto.setEventNum(rs.getInt("eventNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setEventSubject(rs.getString("eventSubject"));
				dto.setEventHitcount(rs.getShort("eventHitcount"));
				dto.setEventCreated(rs.getString("eventCreated"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
	// 검색에서 리스트
	public List<EventDTO> listEvent(int start, int end, String searchKey, String searchValue) {
		List<EventDTO> list=new ArrayList<EventDTO>();
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("		SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("			SELECT eventNum, userId, eventSubject, eventHitcount");
			sb.append("				,TO_CHAR(eventCreated, 'YYYY-MM-DD') eventCreated");
			sb.append("			FROM event");
			if(searchKey.equalsIgnoreCase("eventCreated"))
				sb.append("			WHERE TO_CHAR(eventCreated, 'YYYY-MM-DD') =? ");
			else if(searchKey.equalsIgnoreCase("userId"))
				sb.append("		WHERE INSTR(userId, ?) =1 ");
			else
				sb.append("		WHERE INSTR(" + searchKey + ", ?) >=1");
			sb.append("		ORDER BY eventNum DESC");
			sb.append("	) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				EventDTO dto=new EventDTO();
				dto.setEventNum(rs.getInt("eventNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setEventSubject(rs.getString("eventSubject"));
				dto.setEventHitcount(rs.getInt("eventHitcount"));
				dto.setEventCreated(rs.getString("eventCreated"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	public EventDTO readEvent(int eventNum) {
		EventDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		sql="SELECT eventNum, userId, eventSubject, eventContent, ";
		sql+=" eventHitcount, eventCreated ";
		sql+=" FROM event WHERE eventNum=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, eventNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new EventDTO();
				dto.setEventNum(rs.getInt("eventNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setEventSubject(rs.getString("eventSubject"));
				dto.setEventContent(rs.getString("eventContent"));
				dto.setEventHitcount(rs.getShort("eventHitcount"));
				dto.setEventCreated(rs.getString("eventCreated"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	// 이전글
	public EventDTO preReadEvent(int eventNum, String searchKey, String searchValue) {
		EventDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb= new StringBuffer();
		
		try {
			if(searchValue!=null && searchValue.length()!=0) {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("		SELECT eventNum, eventSubject FROM event ");
				if(searchKey.equalsIgnoreCase("eventCreated"))
					sb.append("		WHERE (TO_CHAR(eventCreated, 'YYYY-MM-DD') = ?)");
				else if(searchKey.equalsIgnoreCase("userId"))
					sb.append("		WHERE (INSTR(userId, ?) = 1) ");
				else
					sb.append("		WHERE (INSTR(" +searchKey + ", ?) >= 1) ");
				sb.append("			AND (eventNum > ?) ");
				sb.append("			ORDER BY eventNum ASC ");
				sb.append(" ) tb WHERE ROWNUM=1 ");
				
				pstmt=conn.prepareStatement(sb.toString());
				pstmt.setString(1, searchValue);
				pstmt.setInt(2, eventNum);
			} else {
				sb.append("SELECT ROWNUM, tb.* FROM (");
				sb.append("		SELECT eventNum, eventSubject FROM event");
				sb.append("			WHERE eventNum > ?");
				sb.append("				ORDER BY eventNum ASC ");
				sb.append(" ) tb WHERE ROWNUM =1 ");
				
				pstmt=conn.prepareStatement(sb.toString());
				pstmt.setInt(1, eventNum);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new EventDTO();
				dto.setEventNum(rs.getInt("eventNum"));
				dto.setEventSubject(rs.getString("eventSubject"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	// 다음글
	public EventDTO nextReadEvent(int eventNum, String searchKey, String searchValue) {
		EventDTO dto=null;
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			if(searchValue!=null && searchValue.length() !=0) {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("		SELECT eventNum, eventSubject, FROM event ");
				if(searchKey.equalsIgnoreCase("eventCreated"))
					sb.append("		WHERE (TO_CHAR(eventCreated, 'YYYY-MM-DD') = ?) ");
				else if(searchKey.equalsIgnoreCase("userId"))
					sb.append(" 	WHERE (INSTR(userId, ?)=1)");
				else
					sb.append("		WHERE (INSTR(" + searchKey + ", ?) >=1) ");
				sb.append("			AND (eventNum < ? ) ");
				sb.append("			ORDER BY eventNum DESC ");
				sb.append("	) tb WHERE ROWNUM=1 ");
				
				pstmt=conn.prepareStatement(sb.toString());
				pstmt.setString(1, searchValue);;
				pstmt.setInt(2,  eventNum);
			} else {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("		SELECT eventNum, eventSubject FROM event ");
				sb.append(" 	WHERE eventNum < ? ");
				sb.append(" 		ORDER BY eventNum DESC ");
				sb.append(" ) tb WHERE ROWNUM =1 ");
				
				pstmt= conn.prepareStatement(sb.toString());
				pstmt.setInt(1, eventNum);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new EventDTO();
				dto.setEventNum(rs.getInt("eventNum"));
				dto.setEventSubject(rs.getString("eventSubject"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	public int updateHitcount(int eventNum) {
		int result = 0;
		PreparedStatement pstmt=null;
		String sql;
		
		sql = "UPDATE event SET eventHitcount=eventHitcount+1 WHERE eventNum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, eventNum);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int updateEvent(EventDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		
		sql="UPDATE event SET eventSubject=?, eventContent=?";
		sql+=" WHERE eventNum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEventSubject());
			pstmt.setString(2, dto.getEventContent());
			pstmt.setInt(3, dto.getEventNum());
			result=pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int deleteEvent(int eventNum) {
		int result = 0;
		PreparedStatement pstmt=null;
		String sql;
		
		sql="DELETE FROM event WHERE eventNum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, eventNum);
			result=pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
}

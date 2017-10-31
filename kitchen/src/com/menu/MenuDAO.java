package com.menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class MenuDAO {
	
	public int insertMenu(MenuDTO dto) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;
		
		sql = "INSERT INTO shopmenu(menunum, menuname, menuprice, menucontent, savefilename, originalfilename) VALUES(shopmenu_seq.NEXTVAL, ?, ?, ?, ?, ?)";

		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMenuname());
			pstmt.setInt(2, dto.getMenuprice());
			pstmt.setString(3, dto.getMenucontent());
			pstmt.setString(4, dto.getSavefilename());
			pstmt.setString(5, dto.getOrigrnalfilename());
			
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(conn != null)
				DBConn.close();
		}
		return result; 
	}
	
	public List<MenuDTO> listMenu(int start, int end){
		List<MenuDTO> list = new ArrayList<MenuDTO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			conn = DBConn.getConnection();
			sb.append("SELECT * FROM(");
			sb.append("	SELECT ROWNUM rnum, tb.* FROM(");
			sb.append("		SELECT s.shopnum, s.shopname, s.savefilename, s.originalfilename, ");
			sb.append("s.latitude, s.longitude, s.shopaddr1, s.shopaddr2, s.shoptel1, s.shoptel2");
			sb.append("m.menunum, m.menuname, m.menucontent, m.savefilename, m.originalfilename, m.menuprice");
			sb.append("FROM shopmenu m JOIN shop s ");
			sb.append("ON m.shopnum=s.shopnum ");
			sb.append("ORDER BY menunum DESC  ");
			sb.append(") tb WHERE ROWNUM <= ?  ");
			sb.append(") WHERE rnum=? ");
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	
	
	
}

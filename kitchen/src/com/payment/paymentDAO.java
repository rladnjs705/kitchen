package com.payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.util.DBConn;

public class paymentDAO {
	Connection conn=DBConn.getConnection();
	
	
	
	public int dataCount(String userId) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		try {
			sb.append("SELECT COUNT(*) cnt FROM (SELECT TO_CHAR(p.purchasedate, 'YYYY-MM-DD:hh:mm') purchasedate, ");
			sb.append("p.purchaseprice purchaseprice, p.purchasenum purchasenum, ");
			sb.append("sm.MENUNAME menuname, s.shopname shopname, s.shopnum shopnum, ");
			sb.append("s.CATEGORYNAME categoryname ");
			sb.append("FROM purchase p ");
			sb.append("RIGHT OUTER JOIN purchase_detail pd ON ");
			sb.append("p.PURCHASENUM=pd.PURCHASENUM ");
			sb.append("RIGHT OUTER JOIN shopmenu sm ON ");
			sb.append("pd.menunum=sm.menunum ");
			sb.append("RIGHT OUTER JOIN shop s ON ");
			sb.append("sm.shopnum=s.shopnum WHERE userid=? ");
			sb.append("ORDER BY p.purchasedate DESC)");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt("cnt");
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	public int dataCount(String userId, String searchDateValue1, String searchDateValue2) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		try {
			sb.append("SELECT COUNT(*) cnt FROM (SELECT TO_CHAR(p.purchasedate, 'YYYY-MM-DD:hh:mm') purchasedate, ");
			sb.append("p.purchaseprice purchaseprice, p.purchasenum purchasenum, ");
			sb.append("sm.MENUNAME menuname, s.shopname shopname, s.shopnum shopnum, ");
			sb.append("s.CATEGORYNAME categoryname ");
			sb.append("FROM purchase p ");
			sb.append("RIGHT OUTER JOIN purchase_detail pd ON ");
			sb.append("p.PURCHASENUM=pd.PURCHASENUM ");
			sb.append("RIGHT OUTER JOIN shopmenu sm ON ");
			sb.append("pd.menunum=sm.menunum ");
			sb.append("RIGHT OUTER JOIN shop s ON ");
			sb.append("sm.shopnum=s.shopnum WHERE userid=? AND TO_CHAR(p.purchasedate,'YYYY-MM-DD')>? AND TO_CHAR(p.purchasedate,'YYYY-MM-DD')<? ");
			sb.append("ORDER BY p.purchasedate DESC)");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			pstmt.setString(2, searchDateValue1);
			pstmt.setString(3, searchDateValue2);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt("cnt");
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	public List<paymentDTO> listPurchase(int start, int end, String userId) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		paymentDTO dto=new paymentDTO();
		List<paymentDTO> list=new ArrayList<>();
		try {
			sb.append("SELECT * FROM (SELECT ROWNUM rnum, tb.* FROM (SELECT TO_CHAR(p.purchasedate, 'YYYY-MM-DD:hh:mm') purchasedate, ");
			sb.append("p.purchaseprice purchaseprice, p.purchasenum purchasenum, ");
			sb.append("sm.MENUNAME menuname, s.shopname shopname, s.shopnum shopnum, ");
			sb.append("s.CATEGORYNAME categoryname ");
			sb.append("FROM purchase p ");
			sb.append("RIGHT OUTER JOIN purchase_detail pd ON ");
			sb.append("p.PURCHASENUM=pd.PURCHASENUM ");
			sb.append("RIGHT OUTER JOIN shopmenu sm ON ");
			sb.append("pd.menunum=sm.menunum ");
			sb.append("RIGHT OUTER JOIN shop s ON ");
			sb.append("sm.shopnum=s.shopnum WHERE userid=? ");
			sb.append("ORDER BY p.purchasedate DESC) tb WHERE ROWNUM<=?) WHERE rnum>=?");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				dto.setPurchasedate(rs.getString("purchasedate"));
				dto.setPurchasenum(rs.getString("purchasenum"));
				dto.setPurchaseprice(rs.getString("purchaseprice"));
				dto.setMenuname(rs.getString("menuname"));
				dto.setShopname(rs.getString("shopname"));
				dto.setCategoryname(rs.getString("categoryname"));
				dto.setShopnum(rs.getString("shopnum"));
				list.add(dto);
			}
			pstmt.close();
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<paymentDTO> listPurchase(int start, int end, String userId, String searchDateValue1, String searchDateValue2) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		paymentDTO dto=new paymentDTO();
		List<paymentDTO> list=new ArrayList<>();
		try {
			sb.append("SELECT * FROM (SELECT ROWNUM rnum, tb.* FROM (SELECT TO_CHAR(p.purchasedate, 'YYYY-MM-DD:hh:mm') purchasedate, ");
			sb.append("p.purchaseprice purchaseprice, p.purchasenum purchasenum, ");
			sb.append("sm.MENUNAME menuname, s.shopname shopname, s.shopnum shopnum, ");
			sb.append("s.CATEGORYNAME categoryname ");
			sb.append("FROM purchase p ");
			sb.append("RIGHT OUTER JOIN purchase_detail pd ON ");
			sb.append("p.PURCHASENUM=pd.PURCHASENUM ");
			sb.append("RIGHT OUTER JOIN shopmenu sm ON ");
			sb.append("pd.menunum=sm.menunum ");
			sb.append("RIGHT OUTER JOIN shop s ON ");
			sb.append("sm.shopnum=s.shopnum WHERE userid=? AND TO_CHAR(p.purchasedate,'YYYY-MM-DD')>? AND TO_CHAR(p.purchasedate,'YYYY-MM-DD')<? ");
			sb.append("ORDER BY p.purchasedate DESC) tb WHERE ROWNUM<=? ) WHERE rnum>=?");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			pstmt.setString(2, searchDateValue1);
			pstmt.setString(3, searchDateValue2);
			pstmt.setInt(4, end);
			pstmt.setInt(5, start);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				dto.setPurchasedate(rs.getString("purchasedate"));
				dto.setPurchasenum(rs.getString("purchasenum"));
				dto.setPurchaseprice(rs.getString("purchaseprice"));
				dto.setMenuname(rs.getString("menuname"));
				dto.setShopname(rs.getString("shopname"));
				dto.setCategoryname(rs.getString("categoryname"));
				dto.setShopnum(rs.getString("shopnum"));
				list.add(dto);
			}
			pstmt.close();
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}

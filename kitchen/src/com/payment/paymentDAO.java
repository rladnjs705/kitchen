package com.payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.member.MemberDTO;
import com.util.DBConn;

public class paymentDAO {
	Connection conn=DBConn.getConnection();
	
	public List<paymentDTO> listPurchase(String userId) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		paymentDTO dto=new paymentDTO();
		List<paymentDTO> list=new ArrayList<>();
		try {
			sb.append("SELECT TO_CHAR(p.purchasedate, 'YYYY-MM-DD') purchasedate, ");
			sb.append("p.purchaseprice purchaseprice, p.purchasenum purchasenum, ");
			sb.append("sm.MENUNAME menuname, s.shopname shopname, s.shopnum shopnum, ");
			sb.append("s.CATEGORYNAME categoryname ");
			sb.append("FROM purchase p ");
			sb.append("RIGHT OUTER JOIN purchase_detail pd ON ");
			sb.append("p.PURCHASENUM=pd.PURCHASENUM ");
			sb.append("RIGHT OUTER JOIN shopmenu sm ON ");
			sb.append("pd.menunum=sm.menunum ");
			sb.append("RIGHT OUTER JOIN shop s ON ");
			sb.append("sm.shopnum=s.shopnum ORDER BY p.purchasedate DESC ");
			sb.append("WHERE userid=?");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getUserid());
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
			System.out.println(e.toString());
		}
		return list;
	}
}

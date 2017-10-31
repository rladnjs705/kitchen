package com.menu;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shop.ShopDTO;
import com.util.DBConn;

public class MenuDAO {
	Connection conn = DBConn.getConnection();
	public int insertMenu(MenuDTO dto) {
		int result = 0;
		
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
			pstmt.setString(5, dto.getOriginalfilename());
			
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return result; 
	}
	
	public List<MenuDTO> listMenu(int start, int end){
		List<MenuDTO> list = new ArrayList<MenuDTO>();
		List<ShopDTO> slist = new ArrayList<ShopDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT * FROM shopmenu m JOIN shop s ON m.shopnum=s.shopnum;";
			
			pstmt = conn.prepareStatement(sql);

			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MenuDTO dto = new MenuDTO();
				ShopDTO sdto = new ShopDTO();
						
				dto.setMenuname(rs.getString("menuname"));
				dto.setMenucountent(rs.getString("menucontent"));
				dto.setMenuprice(rs.getInt("menuprice"));
				dto.setOriginalfilename(rs.getString("originalfilename"));
				sdto.setShopName(rs.getString("shopName"));
				sdto.setShopTel1(rs.getString("shopTel1"));
				sdto.setShopTel2(rs.getString("shopTel2"));
				sdto.setShopAddr1(rs.getString("shopAddr1"));
				sdto.setShopAddr2(rs.getString("shopAddr2"));
				sdto.setShopPrice(rs.getInt("shopPrice"));
				sdto.setShopTime(rs.getInt("shopTime"));
				sdto.setShopStart(rs.getString("shopStart"));
				sdto.setShopEnd(rs.getString("shopEnd"));
				sdto.setLatitude(rs.getInt("latitude"));
				sdto.setLongitude(rs.getInt("longitude"));
				sdto.setContent(rs.getString("Content"));
				sdto.setShopZip1(rs.getString("shopZip1"));
				sdto.setOriginalFilename(rs.getString("originalFilename"));
				
				list.add(dto);
				slist.add(sdto);
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return list;
	}

	
	
	
}

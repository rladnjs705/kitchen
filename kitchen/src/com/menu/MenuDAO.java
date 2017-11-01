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
		
		sql = "INSERT INTO shopmenu(menunum, menuname, menuprice, menucontent, savefilename, shopnum) VALUES(shopmenu_seq.NEXTVAL, ?, ?, ?, ?, ?)";

		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMenuname());
			pstmt.setInt(2, dto.getMenuprice());
			pstmt.setString(3, dto.getMenucontent());
			pstmt.setString(4, dto.getSavefilename());
			pstmt.setInt(5, dto.getShopnum());
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return result; 
	}
	
	public List<MenuDTO> listMenu(int shopNum){
		List<MenuDTO> list = new ArrayList<MenuDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT s.shopnum, m.menuname, m.menucontent, m.menuprice, m.savefilename FROM shopmenu m JOIN shop s ON m.shopnum=s.shopNum WHERE m.shopNum=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shopNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MenuDTO dto = new MenuDTO();

				dto.setMenuname(rs.getString("menuname"));
				dto.setMenucontent(rs.getString("menucontent"));
				dto.setMenuprice(rs.getInt("menuprice"));
				dto.setSavefilename(rs.getString("savefilename"));
				
				list.add(dto);

			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} 
		return list;
	}
	
	public ShopDTO readMenu(int shopNum) {
		ShopDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		sql="SELECT shopNum, shopName, shopTel1, shopTel2, shopAddr1, shopAddr2, shopPrice, latitude, longitude, savefilename FROM shop WHERE shopNum=? ";
		
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, shopNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ShopDTO();
				dto.setShopNum(rs.getInt("shopNum"));
				dto.setShopName(rs.getString("shopName"));
				dto.setShopTel1(rs.getString("shopTel1"));
				dto.setShopTel2(rs.getString("shopTel2"));
				dto.setShopAddr1(rs.getString("shopAddr1"));
				dto.setShopAddr2(rs.getString("shopAddr2"));
				dto.setShopPrice(rs.getInt("shopPrice"));
				dto.setLatitude(rs.getString("latitude"));
				dto.setLongitude(rs.getString("longitude"));
				dto.setSaveFilename(rs.getString("saveFilename"));
			}
				rs.close();
				pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	public int deleteMenu(int shopNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql = "DELETE FROM shop WHERE shopNum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shopNum);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
}

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
		
		sql = "INSERT INTO shopmenu(menunum, menuname, menuprice, menucontent, savefilename, shopNum) VALUES(shopmenu_seq.NEXTVAL, ?, ?, ?, ?, ?)";

		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMenuname());
			pstmt.setInt(2, dto.getMenuprice());
			pstmt.setString(3, dto.getMenucontent());
			pstmt.setString(4, dto.getSavefilename());
			pstmt.setInt(5, dto.getShopNum());
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
			sql = "SELECT s.shopnum, m.menuname, m.menunum, m.menucontent, m.menuprice, m.savefilename FROM shopmenu m JOIN shop s ON m.shopnum=s.shopNum WHERE m.shopNum=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shopNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MenuDTO dto = new MenuDTO();
				
				dto.setShopnum(rs.getInt("shopNum"));
				dto.setMenuname(rs.getString("menuname"));
				dto.setMenunum(rs.getInt("menunum"));
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
	
	public MenuDTO readMenu2(int menunum) {
		MenuDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		sql="SELECT shopNum, menunum, menuname, menuprice, menucontent, savefilename FROM shopmenu WHERE menuNum=?";
		
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, menunum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MenuDTO();
				dto.setShopnum(rs.getInt("shopNum"));
				dto.setMenunum(rs.getInt("manunum"));
				dto.setMenuname(rs.getString("menuname"));
				dto.setMenuprice(rs.getInt("menuprice"));
				dto.setMenucontent(rs.getString("menucontent"));
				dto.setSavefilename(rs.getString("savefilename"));
			}
				rs.close();
				pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	public int deleteMenu(int shopNum,int menuNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql = "DELETE shopmenu WHERE shopnum=? AND menunum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shopNum);
			pstmt.setInt(2, menuNum);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int deletemenu(String[] menunum) {
	      int result=0;
	      String sql;
	      PreparedStatement pstmt =null;
	      Connection conn =null;
	      try {
	         conn=DBConn.getConnection();
	         sql="DELETE FROM shopmenu WHERE menunum IN ( ";
	         
	         for(int i=0;i<menunum.length;i++) {
	            sql+="?,";
	         }
	         sql=sql.substring(0, sql.length()-1);
	         sql+=")";
	         pstmt=conn.prepareStatement(sql);
	         
	         for(int i=0;i<menunum.length;i++) {
	            pstmt.setInt(i+1, Integer.parseInt(menunum[i]));
	         }
	         result=pstmt.executeUpdate();
	      
	         
	      } catch (Exception e) {
	         System.out.println(e.toString());
	      }
	      return result;
	   }
	
	public int updateMenu(MenuDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql = "UPDATE shopmenu SET menuname=?, menucontent=?, menuprice=?, savefilename=? WHERE menunum=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMenuname());
			pstmt.setString(2, dto.getMenucontent());
			pstmt.setInt(3, dto.getMenuprice());
			pstmt.setString(4, dto.getSavefilename());
			pstmt.setInt(5, dto.getMenunum());
			pstmt.setInt(6, dto.getShopNum());
			
			result = pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
				
		return result;
	}
	
}

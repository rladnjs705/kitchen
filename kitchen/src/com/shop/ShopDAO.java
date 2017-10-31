package com.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBConn;

public class ShopDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertShop (ShopDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		sql="INSERT INTO shop (shopNum, shopName, shopZip1, shopZip2, shopTel1, shopTel2, shopAddr1, shopAddr2, shopPrice, shopTime, shopStart, shopEnd, latitude, longitude, content, saveFilename, originalFilename) VALUES (shop_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getShopName());
			pstmt.setString(2, dto.getShopZip1());
			pstmt.setString(3, dto.getShopZip2());
			pstmt.setString(4, dto.getShopTel1());
			pstmt.setString(5, dto.getShopTel2());
			pstmt.setString(6, dto.getShopAddr1());
			pstmt.setString(7, dto.getShopAddr2());
			pstmt.setInt(8, dto.getShopPrice());
			pstmt.setInt(9, dto.getShopTime());
			pstmt.setString(10, dto.getShopStart());
			pstmt.setString(11, dto.getShopEnd());
			pstmt.setInt(12, dto.getLatitude());
			pstmt.setInt(13, dto.getLongitude());
			pstmt.setString(14, dto.getContent());
			pstmt.setString(15, dto.getSaveFilename());
			pstmt.setString(16, dto.getOriginalFilename());
			
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
		
	}
	
	public int updateHitCount(int shopnum){
			PreparedStatement pstmt=null;
			String sql;
			int result=0;
			try{
				sql="UPDATE shop SET hitCount=hitCount+1 WHERE shopnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, shopnum);
				result=pstmt.executeUpdate();
				pstmt.close();
				
			} catch(Exception e){
				System.out.println(e.toString());
			}
			return result;
			
	}
	
	public int dataCount() {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			String sql="SELECT NVL(COUNT (shopNum), 0) cnt FROM shop";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
				rs.close();
				pstmt.close();
				
				rs=null;
				pstmt=null;
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
}

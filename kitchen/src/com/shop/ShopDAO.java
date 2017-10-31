package com.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ShopDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertShop (ShopDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		sql="INSERT INTO shop (shopNum, shopName, shopZip1, shopZip2, shopTel1, shopTel2, shopAddr1, shopAddr2, shopPrice, shopTime, shopStart, shopEnd, latitude, longitude, content, saveFilename, originalFilename) VALUES (shop_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,?)";
		
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
	
	public int updateHitCount(int shopNum){
			PreparedStatement pstmt=null;
			String sql;
			int result=0;
			try{
				sql="UPDATE shop SET hitCount=hitCount+1 WHERE shopNum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, shopNum);
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
	
	public ShopDTO readShop(int ShopNum) {
		ShopDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		sql="SELECT shopNum, shopName, shopTel1, shopTel2, shopAddr1, shopAddr2, shopPrice, shopTime, shopStart, shopEnd, latitude, longitude, content, TO_CHAR(created,'YYYY-MM-DD')created, hitCount FROM shop WHERE shopNum=? ";
		
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, ShopNum);
			
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
				dto.setShopTime(rs.getInt("shopTime"));
				dto.setShopStart(rs.getString("shopStart"));
				dto.setShopEnd(rs.getString("shopEnd"));
				dto.setLatitude(rs.getInt("latitude"));
				dto.setLongitude(rs.getInt("longitude"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
			}
				rs.close();
				pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	public List<ShopDTO> listShop(int start, int end){
		List<ShopDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT * FROM ( SELECT ROWNUM rnum, tb.*FROM ( SELECT shopNum, shopName, shopTel1, shopTel2, shopAddr1, shopAddr2, shopZip1, shopZip2, shopPrice, shopTime, shopStart, shopEnd, latitude, longitude, content, hitCount, TO_CHAR(created, 'YYYY-MM-DD') created, saveFilename FROM shop ORDER BY shopNum DESC)tb WHERE ROWNUM <= ? ) WHERE rnum >=?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ShopDTO dto=new ShopDTO();
				dto.setShopNum(rs.getInt("shopNum"));
				dto.setShopName(rs.getString("shopName"));
				dto.setShopTel1(rs.getString("shopTel1"));
				dto.setShopTel2(rs.getString("shopTel2"));
				dto.setShopAddr1(rs.getString("shopAddr1"));
				dto.setShopAddr2(rs.getString("shopAddr2"));
				dto.setShopZip1(rs.getString("shopZip1"));
				dto.setShopZip2(rs.getString("shopZip2"));
				dto.setShopPrice(rs.getInt("shopPrice"));
				dto.setShopTime(rs.getInt("shopTime"));
				dto.setShopStart(rs.getString("shopStart"));
				dto.setShopEnd(rs.getString("shopEnd"));
				dto.setLatitude(rs.getInt("latitude"));
				dto.setLongitude(rs.getInt("longitude"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				
				list.add(dto);
				
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
}

package com.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ShopDAO {
	private Connection conn = DBConn.getConnection();

	public int insertShop(ShopDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		sql = "INSERT INTO shop (shopNum, shopName, shopZip1, shopTel1, shopTel2, shopAddr1, shopAddr2, shopPrice, shopTime, shopStart, shopEnd, latitude, longitude, content, saveFilename, categoryName) VALUES (shop_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,?)";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getShopName());
			pstmt.setString(2, dto.getShopZip1());
			pstmt.setString(3, dto.getShopTel1());
			pstmt.setString(4, dto.getShopTel2());
			pstmt.setString(5, dto.getShopAddr1());
			pstmt.setString(6, dto.getShopAddr2());
			pstmt.setInt(7, dto.getShopPrice());
			pstmt.setInt(8, dto.getShopTime());
			pstmt.setString(9, dto.getShopStart());
			pstmt.setString(10, dto.getShopEnd());
			pstmt.setString(11, dto.getLatitude());
			pstmt.setString(12, dto.getLongitude());
			pstmt.setString(13, dto.getContent());
			pstmt.setString(14, dto.getSaveFilename());
			pstmt.setString(15, dto.getCategoryname());

			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.toString());
		}

		return result;

	}

	public int updateHitCount(int shopNum) {
		PreparedStatement pstmt = null;
		String sql;
		int result = 0;
		try {
			sql = "UPDATE shop SET hitCount=hitCount+1 WHERE shopNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, shopNum);
			result = pstmt.executeUpdate();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;

	}

	public int dataCount(String state) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT NVL(COUNT (shopNum), 0) cnt FROM shop ";
			if (state.equals("한식")) {
				sql += "WHERE categoryName='한식'";
			} else if (state.equals("일식")) {
				sql += "WHERE categoryName='일식'";
			} else if (state.equals("양식")) {
				sql += "WHERE categoryName='양식'";
			} else if (state.equals("중식")) {
				sql += "WHERE categoryName='중식'";
			} else if (state.equals("피자")) {
				sql += "WHERE categoryName='피자'";
			} else if (state.equals("치킨")) {
				sql += "WHERE categoryName='치킨'";
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
				rs.close();
				pstmt.close();

				rs = null;
				pstmt = null;
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
		sql = "SELECT shopNum, shopName, shopTel1, shopTel2, shopAddr1, shopAddr2, shopPrice, shopTime, shopStart, shopEnd, latitude, longitude, content, TO_CHAR(created,'YYYY-MM-DD')created, hitCount FROM shop WHERE shopNum=? ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ShopNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
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
				dto.setLatitude(rs.getString("latitude"));
				dto.setLongitude(rs.getString("longitude"));
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

	public List<ShopDTO> listShop(int start, int end, String state) {
		List<ShopDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT * FROM ( SELECT ROWNUM rnum, tb.*FROM ( SELECT shopNum, shopName, shopTel1, shopTel2, shopAddr1, shopAddr2, shopZip1, shopPrice, shopTime, shopStart, shopEnd, latitude, longitude, content, hitCount, TO_CHAR(created, 'YYYY-MM-DD') created, saveFilename FROM shop ";
			if (state.equals("한식")) {
				sql += "WHERE categoryName='한식'";
			} else if (state.equals("일식")) {
				sql += "WHERE categoryName='일식'";
			} else if (state.equals("양식")) {
				sql += "WHERE categoryName='양식'";
			} else if (state.equals("중식")) {
				sql += "WHERE categoryName='중식'";
			} else if (state.equals("피자")) {
				sql += "WHERE categoryName='피자'";
			} else if (state.equals("치킨")) {
				sql += "WHERE categoryName='치킨'";
			}
			sql += " ORDER BY shopNum DESC)tb WHERE ROWNUM <= ? ) WHERE rnum >=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ShopDTO dto = new ShopDTO();
				dto.setShopNum(rs.getInt("shopNum"));
				dto.setShopName(rs.getString("shopName"));
				dto.setShopTel1(rs.getString("shopTel1"));
				dto.setShopTel2(rs.getString("shopTel2"));
				dto.setShopAddr1(rs.getString("shopAddr1"));
				dto.setShopAddr2(rs.getString("shopAddr2"));
				dto.setShopZip1(rs.getString("shopZip1"));
				dto.setShopPrice(rs.getInt("shopPrice"));
				dto.setShopTime(rs.getInt("shopTime"));
				dto.setShopStart(rs.getString("shopStart"));
				dto.setShopEnd(rs.getString("shopEnd"));
				dto.setLatitude(rs.getString("latitude"));
				dto.setLongitude(rs.getString("longitude"));
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

	public int updateShop(ShopDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "UPDATE shop SET categoryName=?, shopName=?, content=?, saveFilename=?, shopZip1=?,  shopAddr1=?, shopAddr2=?, shopTel1=?, shopTel2=?, shopPrice=?, shopTime=?, shopStart=?, shopEnd=?, latitude=?, longitude=? WHERE shopNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCategoryname());
			pstmt.setString(2, dto.getShopName());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSaveFilename());
			pstmt.setString(5, dto.getShopZip1());
			pstmt.setString(6, dto.getShopAddr1());
			pstmt.setString(7, dto.getShopAddr2());
			pstmt.setString(8, dto.getShopTel1());
			pstmt.setString(9, dto.getShopTel2());
			pstmt.setInt(10, dto.getShopPrice());
			pstmt.setInt(11, dto.getShopTime());
			pstmt.setString(12, dto.getShopStart());
			pstmt.setString(13, dto.getShopEnd());
			
			pstmt.setString(14, dto.getLatitude());
			pstmt.setString(15, dto.getLongitude());

			result = pstmt.executeUpdate();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}

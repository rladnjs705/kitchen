package com.payment;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.member.MemberDTO;
import com.util.DBConn;

public class paymentDAO {
	Connection conn=DBConn.getConnection();
	
	public void insertPay(paymentDTO paymentDTO, MemberDTO MemberDTO) {
		int result=0;
		
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("INSERT INTO ");
			sb.append("");
			sb.append("");
			sb.append("");
			sb.append("");
			sb.append("");
			sb.append("");
			
			pstmt=conn.prepareStatement(sb.toString());
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
	}
}

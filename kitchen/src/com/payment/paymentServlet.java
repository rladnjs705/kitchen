package com.payment;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.MemberDAO;
import com.member.MemberDTO;
import com.util.MyServlet;
@WebServlet("/plist/*")
public class paymentServlet extends MyServlet{
		private static final long serialVersionUID = 1L;
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String uri=req.getRequestURI();
		
		if(uri.indexOf("list.do")!=-1) {
			list(req,resp);
		}
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userId=req.getParameter("userId");
		paymentDAO paymentDAO=new paymentDAO();
		MemberDAO MemberDAO=new MemberDAO();
		MemberDTO MemberDTO=new MemberDTO();
		paymentDTO paymentDTO=new paymentDTO();
		MemberDTO=MemberDAO.readMember(userId);
		paymentDAO.insertPay(paymentDTO,MemberDTO);
		
		
		forward(req, resp, "/WEB-INF/views/plist/list.jsp");
	}
	
}

package com.payment;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
		req.setCharacterEncoding("UTF-8");
		String userId=req.getParameter("userId");
		paymentDAO paymentDAO=new paymentDAO();
		List<paymentDTO> list=new ArrayList<>();
		list=paymentDAO.listPurchase(userId);
		
		
		req.setAttribute("list", list);
		req.setAttribute("userId", userId);
		forward(req, resp, "/WEB-INF/views/plist/list.jsp");
	}
	
}

package com.menu;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;

@WebServlet("/menu/*")
public class MenuServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}
	
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		
		if(uri.indexOf("article.do") != -1) {
			forward(req, resp, "/WEB-INF/views/menu/article.jsp");
		} else if(uri.indexOf("payment.do") != -1) {
			forward(req, resp, "/WEB-INF/views/menu/payment.jsp");
		} else if(uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		} else if(uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp);
		} 
	}
	
	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/menu/created.jsp");
	}
	
	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		MenuDAO dao = new MenuDAO();
		String cp = req.getContextPath();
		MenuDTO dto = new MenuDTO();
		
		dto.setMenuname(req.getParameter("subject"));
		dto.setMenuprice(Integer.parseInt(req.getParameter("price")));
		dto.setMenucountent(req.getParameter("content"));
		dto.setSavefilename(req.getParameter("savefilename"));
		dto.setOrigrnalfilename(req.getParameter("originalfilename"));
		System.out.println(req.getParameter("subject"));
		System.out.println(Integer.parseInt(req.getParameter("price")));
		System.out.println(req.getParameter("content"));
		System.out.println(req.getParameter("savefilename"));
		System.out.println(req.getParameter("originalfilename"));
		dao.insertMenu(dto);
		
		resp.sendRedirect(cp + "/menu/article.do");
	}

}


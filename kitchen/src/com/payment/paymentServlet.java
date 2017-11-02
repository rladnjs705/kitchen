package com.payment;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

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
		paymentDAO paymentDAO=new paymentDAO();
		List<paymentDTO> list=new ArrayList<>();
		String searchDateValue1 = req.getParameter("searchDateValue1");
		String searchDateValue2 = req.getParameter("searchDateValue2");
		MyUtil util = new MyUtil();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		
		int currentPage = 1;
		if(page!=null) {
			currentPage = Integer.parseInt(page);
		}
		
		int dataCount = paymentDAO.dataCount(info.getUserId());
		
		int numPerPage = 10;
		int totalPage = util.pageCount(numPerPage, dataCount);
		if(currentPage>totalPage) {
			currentPage = totalPage;
		}
		
		int rows=5;
		int start = (currentPage-1)*rows+1;
		int end = currentPage*rows;
		
		if(searchDateValue1==null&&searchDateValue2==null) {
			list=paymentDAO.listPurchase(start, end, info.getUserId());			
		}
		
		else if(searchDateValue1.length()!=0&&searchDateValue2.length()!=0) {
			dataCount = paymentDAO.dataCount(info.getUserId(),searchDateValue1, searchDateValue2);
			list = paymentDAO.listPurchase(start, end, info.getUserId(), searchDateValue1, searchDateValue2);
		}

		String cp = req.getContextPath();
		String listUrl = cp+"/plist/list.do";
		String query = "";
		
		if(searchDateValue1!=null) {
			query = "searchDateValue1="+searchDateValue1+"&searchDateValue2="+searchDateValue2;
		}
		
		if(query.length()!=0) {
			listUrl+="?"+query;
		}

		String paging = util.paging(currentPage, totalPage, listUrl);
		req.setAttribute("page", currentPage);
		req.setAttribute("query", query);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("paging", paging);
		req.setAttribute("listUrl", listUrl);
		req.setAttribute("list", list);
		req.setAttribute("userId", info.getUserId());
		forward(req, resp, "/WEB-INF/views/plist/list.jsp");
	}
}

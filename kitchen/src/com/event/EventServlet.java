package com.event;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/event/*")
public class EventServlet extends HttpServlet{
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
		RequestDispatcher rd=req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri=req.getRequestURI();
		
		
		if(uri.indexOf("eventList.do")!=-1) {
			list(req, resp);
		}
		else if(uri.indexOf("eventCreated.do")!=-1) {
			createdForm(req, resp);
		}
		else if(uri.indexOf("eventCreated_ok.do")!=-1) {
			createdSubmit(req, resp);
		}
		else if(uri.indexOf("eventArticle.do")!=-1) {
			article(req, resp);
		}
		else if(uri.indexOf("eventUpdate.do")!=-1) {
			updateForm(req, resp);
		}
		else if(uri.indexOf("eventUpdate_ok.do")!=-1) {
			updateSubmit(req, resp);
		}
		else if(uri.indexOf("delete.do")!=-1) {
			delete(req, resp);
		}else if(uri.indexOf("event.do")!=-1) {
			event(req, resp);
		}
	}

	private void event(HttpServletRequest req, HttpServletResponse resp)  throws ServletException, IOException {
		
		forward(req, resp, "/WEB-INF/views/event/event.jsp");
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp)  throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		
	}

	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		
	}

	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		
	}

	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
		// TODO Auto-generated method stub
		
	}

	private void createdForm(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		
	}
	
}

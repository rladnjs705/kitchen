package com.menu;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;

@WebServlet("/menu/*")
public class MenuServlet extends MyServlet{
	private static final long serialVersionUID = 1L;
	
	private String pathname;

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
		
		String cp=req.getContextPath();
		
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info!=null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		// 이미지를 저장할 경로(pathname)
		pathname="C:\\web\\work\\kitchen\\kitchen\\WebContent\\WEB-INF\\views\\menu\\image";
		File f=new File(pathname);
		if(! f.exists()) { // 폴더가 존재하지 않으면
			f.mkdirs();
		}
		
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

		String encType="utf-8";
		int maxSize=5*1024*1024;
		
		MultipartRequest mreq=new MultipartRequest(req, pathname, maxSize, encType,new DefaultFileRenamePolicy());
		
		dto.setMenuname(mreq.getParameter("subject"));
		dto.setMenuprice(Integer.parseInt(mreq.getParameter("price")));
		dto.setMenucountent(mreq.getParameter("content"));
		
		if(mreq.getFile("upload")!=null) {
		dto.setSavefilename(mreq.getParameter("savefilename"));
		dto.setOriginalfilename(mreq.getParameter("originalfilename"));

		String saveFilename=mreq.getFilesystemName("upload");
			
		saveFilename = FileManager.doFilerename(pathname, saveFilename);
					
		dto.setSavefilename(saveFilename);

	}
		dao.insertMenu(dto);
		
		resp.sendRedirect(cp + "/menu/article.do");
	}
	
	

}


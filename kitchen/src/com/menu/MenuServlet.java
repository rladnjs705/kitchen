package com.menu;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bbs.BoardDTO;
import com.member.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.shop.ShopDTO;
import com.util.FileManager;
import com.util.MyServlet;

@WebServlet("/menu/*")
public class MenuServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri=req.getRequestURI();
		
		HttpSession session=req.getSession();
		String root=session.getServletContext().getRealPath("/");
		String pathname="C:\\web\\work\\kitchen\\kitchen\\WebContent\\resource\\images";
		File f=new File(pathname);

		if(! f.exists()) {
			f.mkdirs();
		}
		
		if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if(uri.indexOf("payment.do") != -1) {
			forward(req, resp, "/WEB-INF/views/menu/payment.jsp");
		} else if(uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		} else if(uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp, pathname);
		} 
	}
	
	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();
		MenuDAO dao = new MenuDAO();
		
		int shopNum = Integer.parseInt(req.getParameter("shopNum"));
		String page = req.getParameter("page");
		
		List<MenuDTO> list = dao.listMenu(shopNum);
		ShopDTO dto = dao.readMenu(shopNum);
		String state = req.getParameter("state");
		if(list==null) {
			resp.sendRedirect(cp+"/menu/list.do?page="+page+"&state="+state+"&shopNum="+shopNum);
			return;
		}
		req.setAttribute("state", state);
		req.setAttribute("dto", dto);
		req.setAttribute("list", list);
		req.setAttribute("page", page);
		req.setAttribute("shopNum", shopNum);
		
		forward(req, resp, "/WEB-INF/views/menu/article.jsp");
		
	}
	
	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/menu/created.jsp");
	}
	
	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException{
		MenuDAO dao = new MenuDAO();
		String cp = req.getContextPath();
		MenuDTO dto = new MenuDTO();
		
		String encType="utf-8";
		int maxSize=5*1024*1024;
		
		MultipartRequest mreq=new MultipartRequest(req, pathname, maxSize, encType,new DefaultFileRenamePolicy());
		
		dto.setMenuname(mreq.getParameter("menuname"));
		dto.setMenuprice(Integer.parseInt(mreq.getParameter("menuprice")));
		dto.setMenucontent(mreq.getParameter("menucontent"));
		
//		int shopNum = Integer.parseInt(req.getParameter("shopNum"));
//		String page = req.getParameter("page");
//		String state = req.getParameter("state");
		if(mreq.getFile("upload")!=null) {
		String savefilename=mreq.getFilesystemName("upload");
			
		savefilename = FileManager.doFilerename(pathname, savefilename);
					
		dto.setSavefilename(savefilename);

		}
		
//		req.setAttribute("state", state);
//		req.setAttribute("page", page);
//		req.setAttribute("shopNum", shopNum);
		dao.insertMenu(dto);
		resp.sendRedirect(cp+"/menu/article.do");
		
	}
	

}


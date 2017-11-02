package com.menu;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.shop.ShopDTO;
import com.util.MyServlet;

@WebServlet("/menu/*")
public class MenuServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri=req.getRequestURI();
	
		String pathname="C:\\web\\work\\kitchen\\kitchen\\WebContent\\resource\\images";
		File f=new File(pathname);

		if(! f.exists()) {
			f.mkdirs();
		}
		
		if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if(uri.indexOf("payment.do") != -1) {
			payment(req,resp);
		} else if(uri.indexOf("created.do") != -1) {
			createdForm(req, resp);
		} else if(uri.indexOf("created_ok.do") != -1) {
			createdSubmit(req, resp, pathname);
		} else if(uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if(uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if(uri.indexOf("delete.do") != -1) {
			deleteList(req, resp);
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
		req.setAttribute("state", state);
		req.setAttribute("shopNum", shopNum);
		
		forward(req, resp, "/WEB-INF/views/menu/article.jsp");
		
	}
	
	private void createdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		int shopNum = Integer.parseInt(req.getParameter("shopNum"));
		String page = req.getParameter("page");
		String state = req.getParameter("state");
		
		req.setAttribute("shopNum", shopNum);
		req.setAttribute("page", page);
		req.setAttribute("state", state);
		
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
		dto.setShopnum(Integer.parseInt(mreq.getParameter("shopNum")));
		
		int shopNum = Integer.parseInt(mreq.getParameter("shopNum"));
		String page = mreq.getParameter("page");
		String state = mreq.getParameter("state");
		if(mreq.getFile("upload")!=null) {
		String savefilename=mreq.getFilesystemName("upload");
					
		dto.setSavefilename(savefilename);

		}
		
		req.setAttribute("state", state);
		req.setAttribute("page", page);
		req.setAttribute("shopNum", shopNum);
		
		dao.insertMenu(dto);
		resp.sendRedirect(cp+"/main.do");
		
	}
	
	private void payment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String[] menuname = req.getParameterValues("menuname");
		
		String[] menuprice = req.getParameterValues("menuprice");
		
		List<MenuDTO> list=new ArrayList<>();
		MenuDTO dto=new MenuDTO();
		for (int i = 0; i < menuprice.length; i++) {
			dto.setMenuname(menuname[i]);
			dto.setMenuprice(Integer.parseInt(menuprice[i]));
			list.add(dto);
		}
		
		
		
		req.setAttribute("list", list);
		forward(req, resp, "/WEB-INF/views/menu/payment.jsp");
	}

	private void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MenuDAO dao = new MenuDAO();
		
		int Menunum = Integer.parseInt(req.getParameter("menunum"));
		List<MenuDTO> dto = dao.listMenu(Menunum);
		
		req.setAttribute("dto", dto);
		req.setAttribute("mode", "update");
		
		forward(req, resp, "/WEB-INF/views/menu/created.jsp");
		
	}
	
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MenuDAO dao = new MenuDAO();
		String cp = req.getContextPath();
		MenuDTO dto = new MenuDTO();
		
		dto.setMenunum(Integer.parseInt(req.getParameter("menunum")));
		dto.setMenuname(req.getParameter("menuname"));
		dto.setMenucontent(req.getParameter("menucontent"));
		
		dao.updateMenu(dto);
		
		resp.sendRedirect(cp+"/main.do");
	}
	
	protected void deleteList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String shopNum = req.getParameter("shopnum");
		String[] chkObject = req.getParameterValues("chkObject");
	
		MenuDAO dao = new MenuDAO();
		
		for(String val : chkObject){
			dao.deleteMenu(Integer.parseInt(shopNum),Integer.parseInt(val));
		}   
		
		forward(req, resp, "/WEB-INF/views/main/main.jsp");
	}
}


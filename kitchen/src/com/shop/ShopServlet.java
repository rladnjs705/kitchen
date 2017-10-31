package com.shop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.MyServlet;

public class ShopServlet extends MyServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req,resp);
	}

	@Override
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String path)
			throws ServletException, IOException {
		RequestDispatcher rd=req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {	
		req.setCharacterEncoding("utf-8");
		
		String uri=req.getRequestURI();
		
		if(uri.indexOf("list.do")!=-1) {
		}else if(uri.indexOf("created.do")!=-1) {
			//글쓰기 폼
			createdForm(req, resp);
		}else if(uri.indexOf("created_ok.do")!=-1) {
			
			//글 저장
			createdSubmit(req, resp, pathname);
		}else if(uri.indexOf("article.do")!=-1) {
			//글 보기
			article(req, resp);
		}else if(uri.indexOf("update.do")!=-1) {
			//글 수정 폼
			updateForm(req, resp);
		}else if(uri.indexOf("update_ok.do")!=-1) {
			//글 수정 완료
			updateSubmit(req, resp);
		}else if(uri.indexOf("delete.do")!=-1) {
			//글 삭제
			delete(req, resp);
		}
	}
	private void createdForm(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		req.setAttribute("mode", "created");
		
		forward(req, resp, "/WEB-INF/views/menu/created.jsp");
	}
	
	private void createdSubmit(HttpServletRequest req, HttpServletResponse resp, String pathname) throws ServletException, IOException {
		ShopDAO dao =new ShopDAO();
		ShopDTO dto =new ShopDTO();
		String encType="utf-8";
		int maxFilesize=20*1024*1024;
		MultipartRequest mreq=null;
		
		mreq=new MultipartRequest(req, pathname, maxFilesize, encType, new DefaultFileRenamePolicy());
		
		dto.setShopName(req.getParameter("shopname"));
		dto.setCategoryname(req.getParameter("categoryname"));
		dto.setContent(req.getParameter("content"));
		dto.setShopZip1(req.getParameter("shopzip1"));
		dto.setShopZip2(req.getParameter("shopzip2"));
		dto.setShopAddr1(req.getParameter("shopAddr1"));
		dto.setShopAddr2(req.getParameter("shopAddr2"));
		dto.setShopTel1(req.getParameter("shoptel1"));
		dto.setShopTel2(req.getParameter("shoptel2"));
		dto.setShopStart(req.getParameter("shopstart"));
		dto.setShopEnd(req.getParameter("shopend"));
		dto.setShopPrice(Integer.parseInt(req.getParameter("shopprice")));
		dto.setShopTime(Integer.parseInt(req.getParameter("shoptime")));
		dto.setLatitude(Integer.parseInt(req.getParameter("latitude")));
		dto.setLongitude(Integer.parseInt(req.getParameter("longitude")));
		
		if(mreq.getFile("upload")!=null) { //첨부파일이 존재하면
			dto.setSaveFilename(mreq.getFilesystemName("upload"));
			dto.setOriginalFilename(mreq.getOriginalFileName("upload"));
		}

		dao.insertShop(dto);
		
		String cp=req.getContextPath();
		resp.sendRedirect(cp+"/menu/list.do");
		
	}
	
	private void article(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		
	}
	
	private void updateForm(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		
	}
	
	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		
	}
	
	private void delete(HttpServletRequest req, HttpServletResponse resp)throws ServletException , IOException{
		
	}
}
